public interface Driver {
  public Vec3D getTipPoint();
}

class SquareDriver implements Driver
{
  Vec3D corner1, corner2, corner3, corner4;
  float speed, alpha, tween;
  int currCorner;
  
  SquareDriver()
  {
     float side = 100;
     float depth = -200;
     corner1 = new Vec3D(side,side,depth);
     corner2 = new Vec3D(side,-side,depth);
     corner3 = new Vec3D(-side,-side,depth);
     corner4 = new Vec3D(-side,side,depth);
     speed = 0.025;
     alpha = 0;
     currCorner = 0;
  }
  
  SquareDriver(float side, float depth)
  {
     corner1 = new Vec3D(side,side,depth);
     corner2 = new Vec3D(side,-side,depth);
     corner3 = new Vec3D(-side,-side,depth);
     corner4 = new Vec3D(-side,side,depth);
     speed = 0.01;
     alpha = 0;
     currCorner = 0;
  }
  private void updateLocation()
  {
     if (alpha >= 1) {
       alpha = 0;
       currCorner = (currCorner + 1 ) % 4;
     }
     
     alpha += speed;
     tween = easeInOutSine(alpha);
  }
  
  Vec3D getTipPoint()
  {
     Vec3D tipPoint = new Vec3D(0,0,0);
     

     println(alpha);
     switch (currCorner){
       case 0: tipPoint = corner4.mult(1 - tween).add(corner1.mult(tween)); break; 
       case 1: tipPoint = corner1.mult(1 - tween).add(corner2.mult(tween)); break;  
       case 2: tipPoint = corner2.mult(1 - tween).add(corner3.mult(tween)); break; 
       case 3: tipPoint = corner3.mult(1 - tween).add(corner4.mult(tween)); break; 
     }
     updateLocation();
     
     return tipPoint; 
  }
}