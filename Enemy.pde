class Enemy extends Object
{
  
  int type;
  float speedUp = 20;
  float timeAlive = 0;
  float tick = 0.05;
  float speed;
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
    
    speed = 3;
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
      timeAlive += tick;
      
      if(timeAlive > speedUp)
      {
        speed++;
        timeAlive = 0;
      }
      
      PVector aim = new PVector();
      aim = players.get(0).pos;
      
      PVector tar = PVector.sub(aim, pos);
      tar.normalize();
      
      PVector chase = PVector.mult(tar, speed);
      pos.add(chase);
    }
    
  }
  
  void display()
  {
    if(type == 0)
    {
      imageMode(CORNER);
      image(enemy1, pos.x, pos.y);
    }
    
    if(type == 1)
    {
      imageMode(CORNER);
      image(enemy2, pos.x, pos.y);
    }
    
    if(type == 2)
    {
      imageMode(CORNER);
      image(enemy3, pos.x, pos.y);
    }
  }  
}
