PFont font1, font2;
float rotX, rotY;

void moveUsingMouse()
{
  translate(width / 2, height / 3);
  rotX = radians(-mouseY);
  rotateX(rotX);
  rotY = radians(mouseX);
  rotateY(rotY);  
}

void drawTipPoint()
{
  pushMatrix();
  translate( tipPoint.x, tipPoint.y, tipPoint.z);
  stroke(255);
  sphere(10);
  popMatrix();
}

void displayInfo()
{
  //float[] t = randomDriver.getAngles();
  fill(0, 255, 0);
  textFont(font1);
  text("DeltaRobot", 10, 20); 
  fill(0, 0, 255);
  textFont(font2);
  text("Theta1: " + nf(theta[0], 2, 2), 10, 40);
  text("Theta2: " + nf(theta[1], 2, 2), 10, 60);
  text("Theta3: " + nf(theta[2], 2, 2), 10, 80);
  text("Tip X: " + nf(tipPoint.x, 3, 2), 10, 120);
  text("Tip Y: " + nf(tipPoint.y, 3, 2), 10, 140);
  text("Tip Z: " + nf(tipPoint.z, 3, 2), 10, 160);
  text("Rot X: " + nf(degrees(rotX), 3, 2), 10, 200);
  text("Rot Y: " + nf(degrees(rotY), 3, 2), 10, 220);
}