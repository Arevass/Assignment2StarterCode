class Object
{
  PVector pos;
  PVector forward;
  PVector speed;
  float theta;
  float w, h;
  color colour;
  boolean alive;
  
  Object()
  {
    w = 25;
    h = 25;
    alive = true;
    pos = new PVector(width / 2, height / 2);
    speed = new PVector(5, 5);
    forward = new PVector(0, -1);
  }
  
  void update()
  {
    
  }
  
  void display()
  {
    
  }
}
