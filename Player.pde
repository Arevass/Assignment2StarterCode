class Player extends Object
{
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  
  //float pSpeed;
  float cooldown = 200;
  float currentTime = millis();
    
  Player()
  {
    pos = new PVector(width / 2, height / 2);
    
  }
  
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
  }
  
  Player(int index, color colour, XML xml)
  {
    this(index
        , colour
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void update()
  {
    PVector aim = new PVector();
    aim = players.get(1).pos;
    
    theta = atan2(aim.y - pos.y, aim.x - pos.x);
    
    if (checkKey(up) && pos.y > 0)
    {
      pos.y -= speed.y;
    }
    
    if (checkKey(down) && pos.y < height)
    {
      pos.y += speed.y;
    }
    if (checkKey(left) && pos.x > 0)
    {
      pos.x -= speed.x;
    }    
    if (checkKey(right) && pos.x < width)
    {
      pos.x += speed.x;
    }
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      if(index == 0)
      {
        
        //PVector ship = new PVector();
        //ship = players.get(0).pos;
        
        if(millis() - currentTime >= cooldown)
        {
          PVector tar = PVector.sub(aim, pos);
          tar.normalize();
          Bullet bullet = new Bullet(tar, colour);
          bullet.pos = pos.get();
          bullet.theta = theta;
          bullet.colour = color(random(0,255), random(0,255), random(0,255));
          bullets.add(bullet);
          currentTime = millis();
        }
      }      
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
    }    
  }
  
  void display()
  {    
    if(index == 0)
    {
      stroke(colour);
      fill(colour);
      /*
      ellipse(pos.x, pos.y, 20, 20);
      fill(255);
      ellipse(pos.x, pos.y, 10, 10);
      */
      imageMode(CENTER);
      image(player, pos.x, pos.y);
    }
    
    if(index == 1)
    {
      stroke(colour);
      noFill();
      ellipse(pos.x, pos.y, 5, 5);
      ellipse(pos.x, pos.y, 15, 15);
      line(pos.x - 10, pos.y, pos.x + 10, pos.y);
      line(pos.x, pos.y + 10, pos.x, pos.y - 10);
    }
  }
  
  boolean collisionCheck(Enemy e)
  {
    if(pos.x - 10 < e.pos.x + e.w && pos.x + 10 > e.pos.x && pos.y - 10 < e.pos.y + e.h && pos.y + 10 > e.pos.y)
    {
      return true;
    }
    
    return false;
    
  }
}
