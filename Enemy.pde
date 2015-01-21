class Enemy extends Object
{
  
  int type;
  int speedStage = 0;
  PVector movement;
  
  Enemy(int type)
  {
    this.type = type;
    movement = new PVector(1, 1);
  }
  
  void update()
  {
    if(pos.x > width || pos.x < 0)
    {
      movement.x *= -1;
    }
    
    if(pos.y > height || pos.y < 0)
    {
      movement.y *= -1;
    }
    
    pos.add(movement);
  }
  
  void display()
  {
    if(type == 0)
    {
      rect(pos.x, pos.y, 25, 25);
    }
    
    if(type == 1)
    {
      ellipse(pos.x, pos.y, 25, 25);
    }
    
    if(type == 2)
    {
      ellipse(pos.x, pos.y, 5, 40);
    }
  }
  
}
