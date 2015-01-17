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
    //pSpeed = 3;
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
        if(millis() - currentTime >= cooldown)
        {
          PVector tar = PVector.sub(aim, pos);
          tar.normalize();
          Bullet bullet = new Bullet(tar);
          bullet.pos = pos.get();
          //bullet.theta = theta;
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
      ellipse(pos.x, pos.y, 20, 20);
      fill(255);
      ellipse(pos.x, pos.y, 10, 10);
    }
    
    if(index == 1)
    {
      stroke(colour);
      fill(colour);
      line(pos.x - 5, pos.y - 5, pos.x + 5, pos.y + 5);
      line(pos.x - 5, pos.y + 5, pos.x + 5, pos.y - 5);
    }
  }
}
