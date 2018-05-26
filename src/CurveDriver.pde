class CurveDriver implements Driver
{
 Vec3D[] corners;
 int currCorner;
 int numCorners;
  
 CurveDriver(String curveFile)
 {
   println(curveFile);
   String[] lines = loadStrings(curveFile);
   
    this.numCorners = lines.length;    
    corners = new Vec3D[numCorners];
    
    for ( int i = 0; i < numCorners; i++) {
     String[] line = split(lines[i], ",");
     corners[i] = new Vec3D(float(line[0]), float(line[1]), float(line[2]));
   }
 
    currCorner = 0;
 }
 Vec3D getTipPoint()
 {
    return corners[(currCorner++ % numCorners)];
 }
}