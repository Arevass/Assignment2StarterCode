/*
           DIT OOP Assignment 2
    =================================
    
          Glenn Derwin; C13536273
*/

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
boolean[] keys = new boolean[526];
int k = 0;
int spawnRate;
PImage enemy1, enemy2, enemy3;

void setup()
{
  size(1000, 500);
  noStroke();
  smooth();
  spawnRate = 60;
  setUpPlayerControllers();
  enemy3 = loadImage("enemy3.png");
}

void draw()
{
  background(0);
  
  if(frameCount % spawnRate == 0)
  {
    spawnEnemy();
  }
  
  for(Player player:players)
  {
    player.update();
    player.display();
  }
  
  for(int i = 0; i < enemies.size(); i++)
  {
    enemies.get(i).update();
    enemies.get(i).display();
    
    if(!enemies.get(i).alive)
    {
      enemies.remove(i);
    }
  }

  for(int i = 0; i < bullets.size(); i++)
  {
    bullets.get(i).update();
    bullets.get(i).display();
    
    if(!bullets.get(i).alive)
    {
      bullets.remove(i);
    }
  }
  
  Player p = players.get(0);
  
  for(int i = 0; i < enemies.size(); i++)
  {
    Enemy e = enemies.get(i);
    if(p.collisionCheck(e))
    {
      enemies.remove(i);
      println(k);
      k++;
    }
  }
  
  if(bullets.size() > 0)
  {
    
    for(int j = 0; j < bullets.size(); j++)
    {
      
      Bullet b = bullets.get(j);
      
      for(int i = 0; i < enemies.size(); i++)
      {
        Enemy e = enemies.get(i);
        if(b.collisionCheck(e))
        {
          enemies.remove(i);
        }
      }
    }
  }
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);  
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  
  for(int i = 0 ; i < children.length ; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(
            i
            , color(0, 0, 255)
            , playerXML);
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = 300;
   players.add(p);         
  }
}

void spawnEnemy()
{
  Enemy e = new Enemy((int) random(0,3));
  Player p = players.get(0);
  
  e.pos.x = (int) random(25, width - 25);
  e.pos.y = (int) random(25, height - 25);
  
  while(p.pos.dist(e.pos) < 50)
  {
    e.pos.x = (int) random(25, width - 25);
    e.pos.y = (int) random(25, height - 25);
  }
    
  enemies.add(e);
}
