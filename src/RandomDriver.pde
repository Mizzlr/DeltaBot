class RandomDriver implements Driver
{
  float t1, t2, t3;
  float d1, d2, d3;
  
  RandomDriver()
  {
    t1 = 0;    t2 = 0;    t3 = 0;
    d1 = 1;    d2 = 1.2;  d3 = -1.4;
  }
  
  Vec3D getTipPoint()
  {
     return new Vec3D(random(-300,300), random(-300,300), random(0,500)); 
  }
  
  float changeDirection(float angle, float increment)
  {
    if (angle > 0)
      increment = -abs(increment);
    else if (angle < -90)
      increment = abs(increment);
    return increment;
  }
  
  void updateAngles()
  {
    d1 = changeDirection(t1, d1);
    d2 = changeDirection(t2, d2);
    d3 = changeDirection(t3, d3);
    t1 += d1;
    t2 += d2;
    t3 += d3;
  }
  
  float[] getAngles()
  {
    float[] result = {t1,t2,t3};
    return result;
  }
}