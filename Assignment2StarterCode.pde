/*
    DIT OOP Assignment 2 Starter Code
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
boolean[] keys = new boolean[526];

void setup()
{
  size(1000, 500);
  noStroke();
  smooth();
  setUpPlayerControllers();
  spawnEnemy();
}

void draw()
{
  background(0);
  
  for(Player player:players)
  {
    player.update();
    player.display();
  }
  
  for(Enemy enemy:enemies)
  {
    enemy.update();
    enemy.display();
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
      println("detect");
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
            , color(random(0, 255), random(0, 255), random(0, 255))
            , playerXML);
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = 300;
   players.add(p);         
  }
}

void spawnEnemy()
{
  for(int i = 0; i < 3; i++)
  {
    //Enemy e = new Enemy((int) random(0,3));
    Enemy e = new Enemy(0);
    e.pos.x = (int) random(0, width);
    e.pos.y = (int) random(0, height);
    enemies.add(e);
  }
}
