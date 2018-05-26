
float rA = 300;
float rB = 100;
float lA = 200;
float lB = 300;
String whichFile = "spiralWave.csv";


DeltaBotDrawer deltaBotDrawer = new DeltaBotDrawer(rA, rB, lA, lB);
KinematicSolver ks = new KinematicSolver(rA, rB, lA, lB);
Trajectory trajectory = new Trajectory(1000);
RandomDriver randomDriver = new RandomDriver();
SquareDriver squareDriver = new SquareDriver();
PolygonDriver polygonDriver; 
CurveDriver curveDriver;

Vec3D tipPoint = new Vec3D(0,0,100); // home poisition
float[] theta = {0,0,0,0}; // keep theta global. 
// theta has following format --> {theta1, theta2, theta3, status} 

void setup()
{
  size(960, 540, P3D);
  background(51);
  polygonDriver = new PolygonDriver("square.csv",0.025);
  curveDriver = new CurveDriver(whichFile);
  //frameRate(5);
  //noLoop()
  font1 = createFont("256bytes.ttf", 20);
  font2 = createFont("FreeMonoBold.ttf", 12);
}

void draw()
{
  background(0);
  displayInfo();
  moveUsingMouse();
  //randomDriver.updateAngles();
  
  //tipPoint = randomDriver.getTipPoint();
  //tipPoint = squareDriver.getTipPoint();
  //tipPoint = polygonDriver.getTipPoint();
  tipPoint = curveDriver.getTipPoint();
  
  //float[] theta  = randomDriver.getAngles();   

  
  theta = ks.solveIK(tipPoint);
  //ks.solveFK(theta[0], theta[1], theta[2]); 
  Vec3D[] knees = ks.getKneePoints(theta[0], theta[1], theta[2]);
  boolean valid = ks.isValidConfig(knees, tipPoint);

  // some console output
  //print("Actual angles t1: " + theta[0] + " t2: " + theta[1]);
  //println(" t3: " + theta[2] + " status:" + (theta[3] == 0? "OK": "Failed"));
  
  deltaBotDrawer.draw(theta, knees, tipPoint, valid);
  drawTipPoint();
  trajectory.draw(tipPoint, valid);
}