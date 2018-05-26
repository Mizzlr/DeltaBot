  //float[] solveFK(float theta1, float theta2, float theta3)
  //{

  //  float result[] = new float[3];
  //  float knee[][] = kneePoints(theta1, theta2, theta3);
    
  //  kneePointsRecentlyComputed = false;
    
  //  float x1 = knee[0][0];
  //  float x2 = knee[1][0];
  //  float x3 = knee[2][0];
    
  //  float y1 = knee[0][1];
  //  float y2 = knee[1][1];
  //  float y3 = knee[2][1];
    
  //  float z1 = knee[0][2];
  //  float z2 = knee[1][2];
  //  float z3 = knee[2][2];
    
  //  float a1 = 2 * (x2 - x1);
  //  float a2 = 2 * (x3 - x1);

  //  float b1 = 2 * (y2 - y1);
  //  float b2 = 2 * (y3 - y1);

  //  float c1 = 2 * (z2 - z1);
  //  float c2 = 2 * (z3 - z1);

  //  float d1 = sq(x2) + sq(y2) + sq(z2) - sq(x1) - sq(y1) - sq(z1);
  //  float d2 = sq(x3) + sq(y3) + sq(z3) - sq(x1) - sq(y1) - sq(z1);

  //  float denom = a1 * b2 - b1 * a2;

  //  float ex = (d1 - d2) / denom;
  //  float ey = (d1 - d2) / (-denom);

  //  float fx = (a1 * c2 - a2 * c1) / denom;
  //  float fy = (b1 * c2 - b2 * c1) / -denom;

  //  float a = fx;
  //  float b = ex - x1;
  //  float c = fy;
  //  float d = ey - y1;
  //  float g = z1;
  //  float h = sq(lB);

  //  float z = 0;
  //  if ( sq(a) + sq(c) + 1 != 0)
  //  {
  //    denom = sq(a) + sq(c) + 1;
  //    float term1 = 4 * sq(a*b + c*d -g) - 4 * (sq(a) + sq(c) + 1) * (sq(b) + sq(d) + sq(g) - h);
  //    float term2 = -a*b -c*d +g;
  //    if (term1 > 0) {
  //      z = (sqrt(term1) * 0.5 + term2 ) / denom;
  //      //if ( z > 0)
  //      //  z = (-sqrt(term1) * 0.5 + term2) / denom;
  //    }
  //  } else if ( b * sqrt(-sq(c) - 1) + 2 * c * d != g)
  //  {
  //    float numr = sq(b) + sq(d) + sq(g) - h;
  //    denom = 2 * b *(sqrt( - sq(c) - 1)) + 2 * c * d - g;
  //    z = -numr / denom;
  //  } else if ( b * sqrt(-sq(c) - 1) - 2 * c * d != -g)
  //  {
  //    float numr = sq(b) + sq(d) + sq(g) - h;
  //    denom = 2 * b* (sqrt( - sq(c) - 1)) - 2 * c * d + g;
  //    z = numr / denom;
  //  }    

  //  //calculate x and y
  //  float x = ex + fx * z;
  //  float y = ey + fy * z;

  //  //pack it
  //  result[0] = x;
  //  result[1] = y;
  //  result[2] = z;

  //  return result;
  //}
  //float[] solveFKversion2(float theta1, float theta2, float theta3)
  //{
  //  // wikipedia circumcenter subsection: Cartesian coordinates from cross- and dot-products
  //  float result[] = new float[3];
  //  float knee[][] = kneePoints(theta1, theta2, theta3);
    
  //  kneePointsRecentlyComputed = false;
    
  //  Vec3D p1 = new Vec3D(knee[0][0], knee[0][1], knee[0][2]);
  //  Vec3D p2 = new Vec3D(knee[1][0], knee[1][1], knee[1][2]);
  //  Vec3D p3 = new Vec3D(knee[2][0], knee[2][1], knee[2][2]);
    
  //  Vec3D p12 = p1.sub(p2);
  //  Vec3D p13 = p1.sub(p3);
  //  Vec3D p21 = p2.sub(p1);
  //  Vec3D p23 = p2.sub(p3);
  //  Vec3D p31 = p3.sub(p1);
  //  Vec3D p32 = p3.sub(p2);
    
  //  float denom = 2 * sq( p12.cross(p23).norm()) ;
  //  float alpha = sq(p23.norm()) * p12.dot(p13) / denom;
  //  float  beta = sq(p13.norm()) * p21.dot(p23) / denom;
  //  float gamma = sq(p12.norm()) * p31.dot(p32) / denom;
    
  //  Vec3D kneeCircumcenter = p1.mul(alpha).add(p2.mul(beta)).add(p3.mul(gamma));
    
  //  //Vec3D vecR = new Vec3D(R,0,0);
    
  //  //knee1 = knee1.sub(vecR.rotatedAboutZ(0));
  //  //knee2 = knee2.sub(vecR.rotatedAboutZ(120));
  //  //knee3 = knee3.sub(vecR.rotatedAboutZ(-120));
    
   
  //  //Vec3D kneeCentroid = knee1.add(knee2).add(knee3).div(3);
  //  //Vec3D kneeUnitVector = kneeCentroid.normalized();
    
    
    
  //  kneeCircumcenter.draw();
  //  p1.draw(color(255,0,0));
  //  p2.draw(color(0,255,0));
  //  p3.draw(color(0,0,255));
    
  //  Vec3D p1kc = kneeCircumcenter.sub(p1);
  //  Vec3D p2kc = kneeCircumcenter.sub(p2);
  //  Vec3D p3kc = kneeCircumcenter.sub(p3);
    
  //  p1kc.draw(p1,color(255,127,127));
  //  p2kc.draw(p2,color(127,255,127));
  //  p3kc.draw(p3,color(127,127,255));
  //  print("p1kc.norm(): " + p1kc.norm());
  //  print(" p2kc.norm(): " + p2kc.norm());
  //  println(" p3kc.norm(): " + p3kc.norm());
    
  //  ////float p = kneeCentroid.norm();
  //  ////float p2 = 
    
  //  //float multiplier = 100; //(1 + sqrt(sq(lB) - sq(p2)) / p);
  //  ////float[] kneeUnitVector = {kneeCentroid[0] / p, kneeCentroid[1] / p, kneeCentroid[2] / p};
    
  //  //result[0] = multiplier * kneeUnitVector.x;
  //  //result[1] = multiplier * kneeUnitVector.y;
  //  //result[2] = multiplier * kneeUnitVector.z;
    
  //  return result;
  //}
  //float[] solveFKversion3(float theta1, float theta2, float theta3)
  //{
  //  // http://math.stackexchange.com/questions/562240/how-to-find-the-intersection-of-three-spheres-full-solutions
    
  //  float result[] = new float[3];
  //  float knee[][] = kneePoints(theta1, theta2, theta3);
  //  float r1 = lA; // radius of sphere 1
  //  float r2 = lA; // radius of sphere 2
  //  float r3 = lA; // radius of sphere 3
    
  //  kneePointsRecentlyComputed = false;
    
  //  // centers of the three spheres
  //  Vec3D c1 = new Vec3D(knee[0][0], knee[0][1], knee[0][2]);
  //  Vec3D c2 = new Vec3D(knee[1][0], knee[1][1], knee[1][2]);
  //  Vec3D c3 = new Vec3D(knee[2][0], knee[2][1], knee[2][2]);
   
  //  Vec3D c12 = c2.sub(c1);
    
  //  Vec3D e1 = c12.normalized();
  //  float n = c12.norm();
    
  //  float n1 = (sq(n) - sq(r2) + sq(r1)) / (2 * n);
  //  float n2 = (sq(n) + sq(r2) - sq(r1)) / (2 * n);
  
    
  //  float rxSquared = sq(r1) - sq(n1);
    
  //  Vec3D omega = c12.mul(n1).add(c1);  
  //  Vec3D e2 = c3.sub(omega).normalized();  
  //  Vec3D e3 = e1.cross(e2);
    
  //  float n3 = c3.sub(omega).norm();
  //  float m = n3;
    
  //  float m1 = (sq(m) - rxSquared + sq(r3)) / (2 * m);
  //  float m2 = (sq(m) + rxSquared - sq(r3)) / (2 * m);
  //  float rFsquared = rxSquared - m1;
  //  float rF = sqrt(rFsquared);
    
  //  result[0] = m * e2.x + rF * e3.x + omega.x;
  //  result[1] = m * e2.y + rF * e3.y + omega.y;
  //  result[2] = m * e2.z + rF * e3.z + omega.z;
    
  //  return result;
  //  // try http://stackoverflow.com/questions/1406375/finding-intersection-points-between-3-spheres
  //  // for the version 4 of the solution
  //  // and https://inst.eecs.berkeley.edu/~ee127a/book/login/l_lineqs_apps_trilateration.html
  //  // for the version 5 of the solution
    
  //}