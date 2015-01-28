/*
           DIT OOP Assignment 2
    =================================
    
          Glenn Derwin; C13536273
*/

import ddf.minim.*;

AudioPlayer PlayerShot;
Minim minim;

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Power> powers = new ArrayList<Power>();
boolean[] keys = new boolean[526];
int lives, score, spawnRate;
float scoreTimer, scoreDelay, scoreRate;
PImage enemy1, enemy2, enemy3, player, health, scoreP, startScreen, endScreen;
boolean begin, end;

boolean devMode = true;

boolean sketchFullScreen() 
{
  return ! devMode;
}

void setup()
{
  if(devMode)
  {
    size(1000, 500);
  }
  else
  {
    size(displayWidth, displayHeight);
  }

  noStroke();
  smooth();
  spawnRate = 120;
  scoreRate = 120;
  lives = 10;
  score = 0;
  setUpPlayerControllers();
  begin = true;
  end = false;
  
  enemy1 = loadImage("enemy1.png");
  enemy2 = loadImage("enemy2.png");
  enemy3 = loadImage("enemy3.png");
  player = loadImage("player.png");
  health = loadImage("health.png");
  scoreP = loadImage("score.png");
  startScreen = loadImage("startscreen.png");
  endScreen = loadImage("endscreen.png");
  
  minim = new Minim(this);
  PlayerShot = minim.loadFile("PlayerShot.wav");
}

void draw()
{
  background(0);
  
  if(checkKey(players.get(0).start)) 
  { 
    begin = false;
    
    if(end)
    {
      end = false;
      
      players.clear();
      bullets.clear();
      powers.clear();
      enemies.clear();
      
      setUpPlayerControllers();
      
      spawnRate = 120;
      scoreRate = 120;
      lives = 10;
      score = 0;
      
    }
  }
  
  if(begin)
  {
    image(startScreen, 0, 0, width, height);
  }
  else if(end)
  {
    image(endScreen, 0, 0, width, height - 100);
    text("Score: " + score, (width / 2) - 40, height - 10);
  }
  else
  {
    text("Score: " + score, (width / 2) + 50, height - 10);
    text("Lives: " + lives, (width / 2) - 50, height - 10);
    
    if(frameCount % scoreRate == 0)
    {
      score++;
    }
    
    if(frameCount % 600 == 0)
    {
      if(spawnRate >= 30)
      {
        spawnRate -= 10;
      }
    }
    
    if(frameCount % spawnRate == 0)
    {
      spawnEnemy();
    }
    
    if(frameCount % 300 == 0)
    {
      spawnPower();
    }
    
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
    
    for(int i = 0; i < powers.size(); i++)
    {
      powers.get(i).update();
      powers.get(i).display();
      
      if(!powers.get(i).alive)
      {
        powers.remove(i);
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
        lives--;
        if(lives <= 0)
        {
          end = true;
        }
      }
    }
    
    for(int i = 0; i < powers.size(); i++)
    {
      Power pow = powers.get(i);
      if(p.collisionCheck(pow))
      {
        if(powers.get(i).type == 0)
        {
          lives++;
        }
        else
        {
          score += 10;
        }
        
        powers.remove(i);

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
            b.kills++;
          }
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
            , color(255)
            , playerXML);
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = (height / 2);
   players.add(p);         
  }
}

void spawnEnemy()
{
  Enemy e = new Enemy((int) random(0,3));
  Player p = players.get(0);
  
  e.pos.x = (int) random(25, width - 25);
  e.pos.y = (int) random(25, height - 25);
  
  while(p.pos.dist(e.pos) < 100)
  {
    e.pos.x = (int) random(25, width - 25);
    e.pos.y = (int) random(25, height - 25);
  }
    
  enemies.add(e);
}

void spawnPower()
{
  Power pow = new Power((int) random(0,2));
  Player p = players.get(0);
  
  pow.pos.x = (int) random(25, width - 25);
  pow.pos.y = (int) random(25, height - 25);
  
  while(p.pos.dist(pow.pos) < 150)
  {
    pow.pos.x = (int) random(25, width - 25);
    pow.pos.y = (int) random(25, height - 25);
  }
  
  powers.add(pow);
}
