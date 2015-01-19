class Enemy extends Object
{
  
  int type;
  PVector movement;
  
  Enemy(int type)
  {
    this.type = type;
    movement = new PVector();
  }
  
  void update()
  {
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
