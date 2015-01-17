class Object
{
  PVector pos;
  PVector forward;
  PVector speed;
  //float theta;
  color colour;
  boolean alive;
  
  Object()
  {
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
