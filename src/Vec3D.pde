class Vec3D
{
 float x,y,z;
  
 Vec3D(float[] xyz)
 {
    this.x = xyz[0];
    this.y = xyz[1];
    this.z = xyz[2];
 }
 Vec3D(float x, float y, float z)
 {
   this.x = x;
   this.y = y;
   this.z = z;    
 }
 
 void drawSphere(float radius, color c)
 {
   pushMatrix();
   stroke(c);
   noFill();
   translate(this.x, this.y, this.z);
   sphere(radius);
   popMatrix();
 }
 void print()
 {
   println("Vec3D: " + x + "," + y + "," + z ); 
 }
 void print(String name)
 {
   println("Vec3D: " + name + " " + x + "," + y + "," + z); 
 }
 void draw()
 {
   draw(new Vec3D(0,0,0),color(255)); 
 }
 void draw(Vec3D other)
 {
   draw(other, color(255));
 }
 void draw(color c)
 {
   draw(new Vec3D(0,0,0),c);  
 }
 void draw(Vec3D other,color c)
  {
      int npoints = 12;
      int coneSize = int(norm() * 0.1);
      coneSize = constrain(coneSize,10,15); 
      
      pushMatrix();
      translate(other.x, other.y, other.z);
      strokeWeight(2);
      stroke(c);
      line(0,0,0,x,y,z);
      strokeWeight(1);
      //stroke(0);
      fill(c);

      translate(x,y,z);
      rotateZ(atan2(y,x));
      //axes(25);
      rotateY(-atan2(z,sqrt(sq(x)+sq(y))));
      
      beginShape(TRIANGLE_FAN);
      vertex(0,0,0);
      for(int i = 0; i <= npoints; i ++)
      {
        float coneX = -coneSize;
        float coneY = coneSize/4 * sin(radians(360 / npoints * i));
        float coneZ = coneSize/4 * cos(radians(360 / npoints * i));
        vertex(coneX, coneY, coneZ); 
      }
      endShape(CLOSE);
      beginShape(TRIANGLE_FAN);
      vertex(-coneSize,0,0);
      for(int i = 0; i <= npoints; i ++)
      {
        float coneX = -coneSize;
        float coneY = coneSize/4 * sin(radians(360 / npoints * i));
        float coneZ = coneSize/4 * cos(radians(360 / npoints * i));
        vertex(coneX, coneY, coneZ); 
      }
      endShape(CLOSE);
      
      popMatrix();
  } 
 float norm()
 {
  return sqrt(sq(this.x) + sq(this.y) + sq(this.z));
 }
  
 void normalize()
 {
   float norm = this.norm();
   this.x /= norm;
   this.y /= norm;
   this.z /= norm;
 }

 Vec3D copy()
 {
    return new Vec3D(x,y,z); 
 }
 
 Vec3D normalized()
 {
   float norm = this.norm();
   Vec3D temp = this.copy();
   return temp.div(norm);
 }
  
 float dot(Vec3D other)
 {
   return  this.x * other.x + this.y * other.y + this.z + other.z;
 }
    
 Vec3D cross(Vec3D other)
 {
   return new Vec3D(this.y * other.z - this.z * other.y,
                this.z * other.x - this.x * other.z,
                this.x * other.y - this.y * other.x);
 }
  
 Vec3D add(Vec3D other)
 {
   return new Vec3D(this.x + other.x, this.y + other.y, this.z + other.z);
 }
 
 Vec3D sub(Vec3D other)
 {
   return new Vec3D(this.x - other.x, this.y - other.y, this.z - other.z);
 }
   
 Vec3D mult(float scalar)
 {
   return new Vec3D(this.x * scalar, this.y * scalar, this.z * scalar);
 }
  
 Vec3D div(float scalar)
 {
   return new Vec3D(this.x / scalar, this.y / scalar, this.z / scalar);
 }
  
 Vec3D square()
 {
   return new Vec3D(sq(this.x), sq(this.y), sq(this.z));
 }
 
 Vec3D absVec()
 {
   return new Vec3D(abs(this.x), abs(this.y), abs(this.z));
 }
 float maxVec()
 {
   return max(max(this.x,this.y),this.z); 
 }
 float minVec()
 {
   return min(min(this.x, this.y), this.z); 
 }
 
 Vec3D[] orthvec()
 {
    float i = 0;
    if (this.x > this.y) i = 1;
    if (this.y > this.z) i = 2;
    Vec3D ei;
    
    if (i == 0) ei = new Vec3D(1,0,0);
    else if (i == 1) ei = new Vec3D(0,1,0);
    else ei = new Vec3D(0,0,1);

    Vec3D b1 = cross(ei);
    b1.normalize();
    
    Vec3D b2 = cross(b1);
    b2.normalize();
  
    Vec3D[] result = {b1,b2};
    return result;  
 }
 Vec3D rotatedAboutZ(float angle)
 {
   
   angle = radians(angle);
   float rx = x * cos(angle) - y * sin(angle); // rotated x
   float ry = x * sin(angle) + y * cos(angle); // rotated y
   return new Vec3D(rx,ry,z);
 }
 
}