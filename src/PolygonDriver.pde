class PolygonDriver implements Driver
{
 Vec3D[] corners;
 float speed, alpha, tween;
 int currCorner;
 int prevCorner;
 int numCorners;
  
 PolygonDriver(String polygonFile, float speed)
 {
   println(polygonFile);
   String[] lines = loadStrings(polygonFile);
   
    this.numCorners = lines.length;
    
    corners = new Vec3D[numCorners];
    
    for ( int i = 0; i < numCorners; i++) {
     String[] line = split(lines[i], ",");
     corners[i] = new Vec3D(float(line[0]), float(line[1]), float(line[2]));
   }
 
    this.speed = speed;
    alpha = 0;
    currCorner = 0;
    prevCorner = numCorners - 1;
 }
  
 private void updateLocation()
 {
    if (alpha >= 1) {
      alpha = 0;
      prevCorner = currCorner;
      currCorner = (currCorner + 1 ) % numCorners;
    }
     
    alpha += speed;
    tween = easeInOutSine(alpha);
 }
  
 Vec3D getTipPoint()
 {
    Vec3D tipPoint = new Vec3D(0,0,0);
     
   // println(alpha);
 
    tipPoint = corners[prevCorner].mult(1 - tween).add(corners[currCorner].mult(tween));

    updateLocation();
     
    return tipPoint; 
 }
}