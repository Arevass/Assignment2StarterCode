class Power extends Object
{
  float lifespan = 30;
  float timer = 0;
  float tick = 0.05;
  
  PVector movement;
  int type;
  
  Power(int type)
  {
    this.type = type;
    movement = new PVector(2, 2);
  }
  
  void update()
  {
    timer += tick;
    
    if(timer > lifespan)
    {
      alive = false;
    }
    
    if(pos.x + w > width || pos.x < 0)
    {
      movement.x *= -1;
    }
    
    if(pos.y + h > height || pos.y < 0)
    {
      movement.y *= -1;
    }
    pos.add(movement);    
  }
  
  void display()
  {
    if(type == 0)
    {
      imageMode(CORNER);
      image(health, pos.x, pos.y);
    }
    
    if(type == 1)
    {
      imageMode(CORNER);
      image(scoreP, pos.x, pos.y);
    }
  }
}
  
