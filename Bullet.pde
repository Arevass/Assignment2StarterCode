class Bullet extends Object
{
  float lifespan = 3;
  float timer = 0;
  float tick = 0.05;
  
  Bullet(PVector forward)
  {
    this.forward = forward;
  }
  
  void update()
  {
    timer += tick;
    
    if(timer > lifespan)
    {
      alive = false;
    }
    
    //forward.x = sin(theta);
    //forward.y = -cos(theta);
    float speed = 20;
    
    PVector velocity = PVector.mult(forward, speed);
    pos.add(velocity);
  }
  
  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    fill(colour);
    line(-5, 0, 5, 0);
    popMatrix();
  }
  
  boolean collisionCheck(Enemy e)
  {
    if(e.pos.x + e.w < pos.x)
    {
      return false;
    }
    
    if (e.pos.x > pos.x + 10)
    {
      return false;
    }
    
    if (e.pos.y > pos.y + 10)
    {
      return false;
    }
    
    if (e.pos.y + e.h < pos.y)
    {
      return false;
    } 
    
    return true;
  }
}
