class Bullet extends Object
{
  float lifespan = 3;
  float timer = 0;
  float tick = 0.05;
  
  Bullet()
  {
    
  }
  
  void update()
  {
    timer += tick;
    
    if(timer > lifespan)
    {
      alive = false;
    }
    
    forward.x = sin(theta);
    forward.y = -cos(theta);
    float speed = 10;
    
    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);
  }
  
  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    line(0, -5, 0, 5);
    popMatrix();
  }
}
