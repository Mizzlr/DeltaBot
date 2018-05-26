class DeltaBotDrawer
{
  float x, y, z; // co-ordinates of the base reference frame
  float rA; // side length of base plate
  //float rB; // side length of travelling plate

  float r2; // side length of cutting triangle
  float thickness; // thickness of upper plate
  float R; // radius from base frame center to motor center

  float lA; // upper arm length
  float lB; // lower arm length

  float upperArmThickness;
  color chassisColor;
  color motorColor;
  color armColor;
  color lowerArmColor;
  color upperArmColor;

  DeltaBotDrawer(float rA, float rB, float lA, float lB)
  {

    this.rA = rA - rB;
    //this.rB = rB;
    this.lA = lA;
    this.lB = lB;

    this.r2 = this.rA * 0.2;
    this.R = this.rA/ 2 /sqrt(3);
    this.thickness = this.rA * 0.1;

    this.x = 0;
    this.y = 0;
    this.z = 0;

    chassisColor = color(0, 255, 255);
    motorColor = color(255, 0, 0);
    armColor = color(255, 255, 0);
    lowerArmColor = color(0, 255, 255);
    upperArmColor = color(255, 255, 0);
    upperArmThickness = rA * 0.1;
  }

  void parallelogram(Vec3D knee, Vec3D tip, float angle)
  {
    float[] p1 = {knee.x, knee.y, knee.z};
    float[] p2 = {tip.x, tip.y, tip.z};

    int barWidth = 60;
    int ballJointSize = 3;
    color pink = color(255, 0, 255);
    color cyan = color(0, 255, 255);
    angle = radians(angle);
    float dangle = degrees(angle);
    float[] p1left = new float[3];
    float[] p1right = new float[3];
    float[] p2left = new float[3];
    float[] p2right = new float[3];
    
    float dx, dy;
    if (dangle == 0.0) {
      dx = 0;
      dy = 1;
    } else if (dangle == 120.0) {
      dx = -sqrt(3) / 2;
      dy = 0.5;
    } else {//240;
      dx = -sqrt(3) / 2;
      dy = -0.5;
    }
    //println("dx: " + dx + " dy: " +dy);
    p1left[0] = p1[0] + barWidth / 2 * dx;
    p1left[1] = p1[1] + barWidth / 2 * dy;
    p1left[2] = p1[2];

    p1right[0] = p1[0] - barWidth / 2 * dx;
    p1right[1] = p1[1] - barWidth / 2 * dy;
    p1right[2] = p1[2];

    p2left[0] = p2[0] + barWidth / 2 * dx;
    p2left[1] = p2[1] + barWidth / 2 * dy;
    p2left[2] = p2[2];

    p2right[0] = p2[0] - barWidth / 2 * dx;
    p2right[1] = p2[1] - barWidth / 2 * dy;
    p2right[2] = p2[2];


    pushMatrix();
    axes();
    beginShape();

    stroke(lowerArmColor);
    vertex(p1left[0], p1left[1], p1left[2]);
    vertex(p1right[0], p1right[1], p1right[2]);
    vertex(p2right[0], p2right[1], p2right[2]);
    vertex(p2left[0], p2left[1], p2left[2]);
    endShape(CLOSE);

    stroke(pink);
    pushMatrix();
    translate(p1left[0], p1left[1], p1left[2]);
    sphere(ballJointSize);
    popMatrix();

    pushMatrix();
    translate(p1right[0], p1right[1], p1right[2]);
    sphere(ballJointSize);
    popMatrix();

    pushMatrix();
    translate(p2right[0], p2right[1], p2right[2]);
    sphere(ballJointSize/2);
    popMatrix();

    pushMatrix();
    translate(p2left[0], p2left[1], p2left[2]);
    sphere(ballJointSize/2);
    popMatrix();

    popMatrix();
  }

  void drawLowerArms(Vec3D[] knees, Vec3D tip, boolean valid)
  {   
    pushMatrix();
    if (true) { //FIXME
      pushMatrix();
      translate(tip.x, tip.y, tip.z);
      axes(50);
      stroke(255, 255, 255);
      box(10); //draw the tip
      popMatrix();
      
      //draw shins
      parallelogram(knees[0], tip, 0);
      parallelogram(knees[1], tip, -120);
      parallelogram(knees[2], tip, 120);
    }
    popMatrix();
  }
  void drawUpperArms(float theta1, float theta2, float theta3)
  {
    stroke(upperArmColor);
    pushMatrix();
    translate(R, 0, 0);
    rotateZ(radians(theta1));
    translate(lA / 2, 0, 0);
    box(lA, upperArmThickness/2, upperArmThickness);
    popMatrix();

    rotateY(radians(120));
    pushMatrix();
    translate(R, 0, 0);
    rotateZ(radians(theta2));
    translate(lA / 2, 0, 0);
    box(lA, upperArmThickness/2, upperArmThickness);
    popMatrix();

    rotateY(radians(120));
    pushMatrix();
    translate(R, 0, 0);
    rotateZ(radians(theta3));
    translate(lA/ 2, 0, 0);
    box(lA, upperArmThickness/2, upperArmThickness);
    popMatrix();
  }
  void drawCylinder(float radius, float side, float npoints)
  {
    float angle = TWO_PI / npoints;
    beginShape(QUAD_STRIP);
    for (float a = 0; a < TWO_PI + angle; a += angle) {
      float sx = cos(a) * radius;
      float sy = sin(a) * radius;
      vertex(sx, sy, side / 2);
      vertex(sx, sy, -side / 2);
    }
    endShape(CLOSE);
  }

  void drawServos()
  {
    float radius = thickness * 0.8;
    float side = (rA - r2) * 0.3;

    rotateX(PI/2);
    pushMatrix();
    for (int i = 0; i < 3; i++) {
      pushMatrix();
      translate(R, 0, 0);
      drawCylinder(radius, side, 12);
      drawCylinder(radius / 2, side, 8);
      popMatrix();
      rotateY(2 * PI / 3);
    }
    popMatrix();
  }
  void axes()
  {
    stroke(255, 0, 0);
    line(-100, 0, 0, 100, 0, 0); //x - axis
    stroke(0, 255, 0);
    line(0, -100, 0, 0, 100, 0); //y - axis
    stroke(0, 0, 255);
    line(0, 0, -100, 0, 0, 100); //z -axis
  }
  void axes(float len)
  {
    stroke(255, 0, 0);
    line(-len, 0, 0, len, 0, 0); //x - axis
    stroke(0, 255, 0);
    line(0, -len, 0, 0, len, 0); //y - axis
    stroke(0, 0, 255);
    line(0, 0, -len, 0, 0, len); //z -axis
  }
  void draw(float[] thetas, Vec3D[] knees, Vec3D tip, boolean valid) {
    
    float theta1 = thetas[0];
    float theta2 = thetas[1];
    float theta3 = thetas[2];
    
    //needed as computer graphics follows left hand co-ordinate system
    
    drawHexoid();
    stroke(motorColor);
    drawServos();
    drawUpperArms(theta1, theta2, theta3);
    popMatrix();
    drawLowerArms(knees , tip, valid);
    popMatrix();
  }
  
  void drawHexoid()
  {
    float hx1, hy1, hx2, hy2, hx3, hy3;
    float hx4, hy4, hx5, hy5, hx6, hy6;

    float rA_sqrt_3 = rA / sqrt(3);

    hx1 = -rA_sqrt_3 + r2 * cos(PI/6);
    hy1 = -r2 * sin(PI/6);

    hx2 = hx1;
    hy2 = -hy1;

    hx3 = rA_sqrt_3 / 2 - r2 * cos(30 * PI / 180); 
    hy3 = (rA - r2 ) / 2;

    hx4 = rA_sqrt_3 / 2; 
    hy4 = rA / 2  - r2;

    hx5 = hx4;
    hy5 = -hy4;

    hx6 = hx3;
    hy6 = -hy3;

    pushMatrix();
    translate(x, y, z);
    pushMatrix();

    noFill();
    axes();

    // draw the chassi
    stroke(0, 255, 255);
    beginShape(QUAD_STRIP);

    vertex(hx1, hy1, thickness / 2);
    vertex(hx1, hy1, -thickness / 2);
    vertex(hx2, hy2, thickness / 2);
    vertex(hx2, hy2, -thickness / 2);
    vertex(hx3, hy3, thickness / 2);  
    vertex(hx3, hy3, -thickness / 2);
    vertex(hx4, hy4, thickness / 2);
    vertex(hx4, hy4, -thickness / 2);
    vertex(hx5, hy5, thickness / 2);
    vertex(hx5, hy5, -thickness / 2);
    vertex(hx6, hy6, thickness / 2);
    vertex(hx6, hy6, -thickness / 2);
    vertex(hx1, hy1, thickness / 2);
    vertex(hx1, hy1, -thickness / 2);
    endShape(CLOSE);
  }
}