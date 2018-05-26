class Trajectory
{
    int qsize;
    float[][] queue;
    int front;
  Trajectory(int qsize)
  {
      this.qsize = qsize;
      queue = new float[qsize][4];
      front = -1;
  }
  void draw(Vec3D frontData, boolean valid)
  {
    front = (front + 1 ) % qsize;
    queue[front][0] = frontData.x;
    queue[front][1] = frontData.y;
    queue[front][2] = frontData.z;
    queue[front][3] = float(int(valid)); //FIXME
    float away;
    strokeWeight(3);
    for (int i = 0; i < qsize; i++) {
      if (i <= front)
        away = front - i;
      else
        away = qsize - i + front;
      if (queue[i][3] == 1.0)   
        stroke(0, 255 * (1-away/qsize), 0); //neon green if valid
      else
        stroke(255 * (1-away/qsize), 0, 0); //red if invalid position for arms
      point(queue[i][0], queue[i][1], queue[i][2]);
    }
    strokeWeight(1);
  }
}