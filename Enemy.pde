class Enemy extends Object
{
  
  int type;
  float speedStage = 0;
  PVector movement;
  
  Enemy(int type)
  {
    this.type = type;
    if(type == 0)
    {
      movement = new PVector(1, 1);
    }
    
    if(type == 2)
    {
      movement = new PVector(3, 3);
    }
  }
  
  void update()
  {
    if(type == 0 || type == 2)
    { 
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
    
    if(type == 1)
    {
      PVector aim = new PVector();
      aim = players.get(0).pos;
      
      PVector tar = PVector.sub(aim, pos);
      tar.normalize();
      
      float speed = 3;
      PVector chase = PVector.mult(tar, speed);
      pos.add(chase);
    }
    
  }
  
  void display()
  {
    if(type == 0)
    {
      image(enemy1, pos.x, pos.y);
    }
    
    if(type == 1)
    {
      image(enemy2, pos.x, pos.y);
    }
    
    if(type == 2)
    {
      image(enemy3, pos.x, pos.y);
    }
  }  
}
