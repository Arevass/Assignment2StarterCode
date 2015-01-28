class Bullet extends Object
{
  float lifespan = 3;
  float timer = 0;
  float tick = 0.05;
  int kills;
  
  Bullet(PVector forward, color colour)
  {
    this.forward = forward;
    this.colour = colour;
    kills = 0;
  }
  
  void update()
  {
    timer += tick;
    
    if(timer > lifespan)
    {
      if(kills == 2)
      {
        score++;
      }
      else if(kills == 3)
      {
        score += 3;
      }
      else if(kills > 3)
      {
        score += 5;
      }
      alive = false;
    }
    
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
