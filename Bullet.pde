class Bullet extends Object
{
  float lifespan = 3;
  float timer = 0;
  float tick = 0.05;
  
  Bullet(PVector forward, color colour)
  {
    this.forward = forward;
    this.colour = colour;
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
    stroke(colour);
    line(-5, 0, 5, 0);
    popMatrix();
  }
  
  boolean collisionCheck(Enemy e)
  {
    if(pos.x < e.pos.x + e.w && pos.x > e.pos.x && pos.y < e.pos.y + e.h && pos.y > e.pos.y)
    {
      return true;
    }
    
    return false;
    
  }
}
