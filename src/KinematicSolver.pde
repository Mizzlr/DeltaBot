class KinematicSolver
{
  float lA, lB, R;
  float threshold;
 
  float cos120;
  float sin120;
  float cos240;
  float sin240;

  KinematicSolver(float rA, float rB, float lA, float lB)
  {
    this.lA = lA;
    this.lB = lB;
    this.R = (rA - rB)/(2 * sqrt(3));
    threshold = 1e-1;

    cos120 = cos(radians(120));
    cos240 = cos(radians(240));
    sin120 = sin(radians(120));
    sin240 = sin(radians(240));
  }
  Vec3D[] getKneePoints(float theta1, float theta2, float theta3)
  {
      float alpha1 = 0;
      float alpha2 = radians(120);
      float alpha3 = radians(240);

      theta1 = radians(theta1);
      theta2 = radians(theta2);
      theta3 = radians(theta3);

      float x1 = cos(alpha1) * (lA * cos(theta1) + R);
      float x2 = cos(alpha2) * (lA * cos(theta2) + R);
      float x3 = cos(alpha3) * (lA * cos(theta3) + R);

      float y1 = (R + lA * cos(theta1)) * sin(alpha1);
      float y2 = (R + lA * cos(theta2)) * sin(alpha2);
      float y3 = (R + lA * cos(theta3)) * sin(alpha3);

      float z1 = lA * sin(theta1);
      float z2 = lA * sin(theta2);
      float z3 = lA * sin(theta3);
    

    Vec3D[] result = {new Vec3D(x1, y1, z1),
                      new Vec3D(x2, y2, z2), 
                      new Vec3D(x3, y3, z3)};
                      
    return result;
  }


  Vec3D solveFK(float theta1, float theta2, float theta3)
  {
    // http://www.gamedev.net/topic/504470-calculate-triangle-circumcircle-and-inscribed_circleincircle/

    Vec3D[] knees = getKneePoints(theta1, theta2, theta3);

    // centers of the three spheres
    Vec3D A = knees[0];
    Vec3D B = knees[1];
    Vec3D C = knees[2];

    Vec3D AB = B.sub(A);
    Vec3D AC = C.sub(A);

    Vec3D N = AB.cross(AC).normalized();

    Vec3D halfAB = A.add(AB.mult(0.5));
    Vec3D halfAC = A.add(AC.mult(0.5));

    Vec3D perpAB = AB.cross(N);
    Vec3D perpAC = AC.cross(N);

    Vec3D center = lineLineIntersection(halfAB, perpAB, halfAC, perpAC);

    float rC = center.sub(A).norm();
    float L1 = center.norm();
    float L2 = sqrt(sq(lB) - sq(rC));

    center.draw(color(127, 0, 127));
    N.normalized().mult(-L2).draw(center);
    Vec3D tip = center.add(N.normalized().mult(-L2));
  
    return tip;
  }  
  Vec3D lineLineIntersection(Vec3D originD, Vec3D directionD, Vec3D originE, Vec3D directionE) 
  {
    directionD.normalize();
    directionE.normalize();
    Vec3D N = directionD.cross(directionE);
    Vec3D SR = originD.sub(originE);
    float absX = abs(N.x);
    float absY = abs(N.y);
    float absZ = abs(N.z);
    float t;

    if (absZ > absX && absZ > absY) {
      t = (SR.x*directionE.y - SR.y*directionE.x)/N.z;
    } else if (absX > absY) {
      t = (SR.y*directionE.z - SR.z*directionE.y)/N.x;
    } else {
      t = (SR.z*directionE.x - SR.x*directionE.z)/N.y;
    }
    return originD.sub(directionD.mult(t));
  }

  float[]solveIK(Vec3D tip)
  {
    //http://forums.trossenrobotics.com/tutorials/introduction-129/delta-robot-kinematics-3276/
    
    float theta1 = 0;
    float theta2 = 0;
    float theta3 = 0;


    float[] result = calcAngleXZ(tip);
    float status = result[1];
    theta1 = result[0];


    if (status == 0) result = calcAngleXZ(tip.rotatedAboutZ(240.0));  // rotate coords to +120 deg
    theta2 = result[0];

    if (status == 0) result = calcAngleXZ(tip.rotatedAboutZ(120.0));  // rotate coords to -120 deg
    theta3 = result [0];

    float[] ret = {theta1, theta2, theta3, status};

    return ret;
  }

  float[] calcAngleXZ( Vec3D rotatedTip)
  {
    float x0 = rotatedTip.x;
    float y0 = rotatedTip.y;
    float z0 = rotatedTip.z;
  
    float[] result = new float[2];
    float theta = 0;
    float status = 0;

    float a = (sq(x0) + sq(y0) + sq(z0) + sq(lA) - sq(lB) - sq(R)) / ( 2 * z0);
    float b = (R - x0) / z0;
    // zj = a + b * xj ; a and b will be used to find zj from xj, now find xj
    float xj = 0;
    float zj = 0;

    float d = -(a+b*R)*(a+b*R)+lA*(b*b*lA+lA); 
    if (d < 0) status = -1; // non-existing point
    else {
      xj = (R - a*b + sqrt(d))/(b*b + 1); // choosing outer point
      zj = a + b*xj;
      theta = degrees(atan(-zj/(R - xj))); //+ ((xj>R)?180.0:0.0);
    }

    float lAtested = sqrt(sq(xj - R) + sq(zj));
    float lBtested = sqrt(sq(xj - x0) + sq(y0) + sq(zj - z0));

    //println("   radii: lA " + lA + ", " + lAtested + ", lB " + lB + ", " + lBtested + " theta: " + theta);

    result[0] = theta;
    result[1] = status;
    return result;
  }
  
  boolean isValidConfig(Vec3D[] knees, Vec3D tip)
  {

    float test1 = (sq(knees[0].x - tip.x) + sq(knees[0].y - tip.y) + sq(knees[0].z - tip.z) - sq(lB));
    float test2 = (sq(knees[1].x - tip.x) + sq(knees[1].y - tip.y) + sq(knees[1].z - tip.z) - sq(lB));
    float test3 = (sq(knees[2].x - tip.x) + sq(knees[2].y - tip.y) + sq(knees[2].z - tip.z) - sq(lB));

    boolean valid =  abs(test1) <= threshold && abs(test2) <= threshold && abs(test3) <= threshold;
    //println("test1: " + sqrt(test1 + sq(lB)) + " test2: " + sqrt(test2 + sq(lB)) + " test3: " + sqrt(test3 + sq(lB)) + " valid: " + valid);
    return valid;
  }
}