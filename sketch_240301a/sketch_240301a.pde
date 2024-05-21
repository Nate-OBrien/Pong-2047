import ddf.minim.*;
Paddle r;
Paddle l;
Ball b;
PImage img;
Minim minim;
AudioPlayer player;


int scoreP1 = 0;
int scoreP2 = 0;

boolean leftup = false;
boolean leftdown = false;
boolean righttup = false;
boolean rightdown = false;

boolean gameStart = false;
boolean creds = false;
boolean gameEnd = false;
boolean menus = true;

void setup(){
  size (1000,1000);
  frameRate(120);
  r = new Paddle(50,500);
  l = new Paddle(950,500);
  b = new Ball(500,500);
  img = loadImage("IMG_3011.jpg");


minim = new Minim(this);
player = minim.loadFile("beta/betaSound6.mp3");


}

void draw(){
player.play();

  if(!gameStart && !creds && !gameEnd && menus){
    menu();
  }

  else if(gameStart){
    game();
  }

  else if(creds){
    credits();
  }
  else if(gameEnd){
    endScreen();
  }
}

void menu(){
  background(0);
  fill(255);
  textSize(90);
  text("PONG",385,150);
  fill(0);
  stroke(105);
  strokeWeight(12.5);
  rectMode(CENTER);
  rect(500,350,300,150);
  rect(500,600,300,150);
  fill(255);
  text("PLAY",400,380);
  textSize(75);
  text("CREDITS",365,620); 
  if(mousePressed && ((mouseX > 350 && mouseX < 650) && (mouseY > 275 && mouseY < 425))){
    menus = false;
    gameStart = true;
  }
  if(mousePressed && ((mouseX > 350 && mouseX < 650) && (mouseY > 525 && mouseY < 675))){
    menus = false;
    creds = true;
  }
}

void credits(){
  background(0);
  fill(255);
  textSize(75);
  text("CREDITS",350,150);
  textSize(45);
  text("PROJECT CREATED BY:\n\nMANO, JAKE, AND NATE",275,350);
  text("CLICK THE X TO GO BACK", 250, 50);
  fill(255,0,0);
  textSize(50);
  text(" X",5,45);
  if((mouseX > 0 && mouseX < 50) && (mouseY > 0 && mouseY <  50)){
    noStroke();
    rectMode(CENTER);
    rect(25,25,40,50);
    fill(255);
    text(" X",5,45);
  }
  if(mousePressed == true && ((mouseX > 0 && mouseX < 50) && (mouseY > 0 && mouseY <  50))){
    menus = true;
    creds = false;
  }
}


void endScreen(){
  menus = false;
  gameEnd = true;
  gameStart = false;
  creds = false;
 background(0);
 textSize(75);
 if(scoreP1 >=5){
 fill(255);
 text("Player 1 wins",285,150);
 textSize(10);
 text("Good luck next time Player 2",430,650);
 }
if(scoreP2 >=5)
{
 fill(255);
  text("Player 2 wins",285,150);
  textSize(10);
  text("Good luck next time Player 1",430,650);
}
    textSize(45);
  text("Good job",395,250);
   textSize(25);
  text("I'm proud of you",395,450);
     textSize(15);
  text("Pranav's dad has a nice mustache",385,550);
  textSize(90);
  fill(255,0,0);
  text("PLAY AGAIN",285,380);

  textSize(10);
  text(mouseX + ", " + mouseY, mouseX, mouseY);
  if(mousePressed){
    if( (mouseX > 280 && mouseX < 720) && (mouseY > 335 && mouseY < 415)){
      println("WORKS");
      scoreP1 = 0;
      scoreP2 = 0;
      menus = true;
      creds = false;
      gameStart = false;
      gameEnd = false;
    }
  }
}


void game(){
  background(0);
  l.render();
  r.render();
  l.mover();
  r.mover();
  b.update();
  b.render();
  collisionCheck();

  //text
  textSize(60);
  text(scoreP1, 300, 300);
  text(scoreP2, 600, 300);

  // Mid line
  rect(500,500,10,1000);
  
   if(scoreP1 >=5 || scoreP2 >= 5)
  {
    gameEnd = true;
    gameStart = false;
    creds = false;
     
  }
}

void collisionCheck()
{
  if(b.y < 17.5 || b.y > 972.5)
  {
    b.yRate *=-1;
    b.xRate *= 1.05;
  }
  if((b.x > l.x-40 && b.x < l.x + 12.5) && (b.y > l.y - 100 && b.y < l.y + 100))
  {
    b.x = 910;
    angles1();
    b.xRate *= 1.1;
  }
  if((b.x < r.x+40 && b.x < l.x - 12.5) && (b.y > r.y - 100 && b.y < r.y + 100))
  {
    b.x = 90;
    angles2();
    b.xRate *= 1.1;
  }
  if(b.x > width)
  {
    scoreP1 +=1;
    b.x = 500;
    b.x = 500;
    b.xRate = 2.25;
    b.yRate = 4;
  }
  if(b.x < 0)
  {
    scoreP2 +=1;
    b.x = 500;
    b.x = 500;
    b.xRate = 2.25;
    b.yRate = 4;
  }
}

void angles1()
{
  b.xRate*=-1;
  b.yRate = random(-3,3); 
}

void angles2()
{
   b.xRate*=-1;
   b.yRate = random(-3,3); 
}

void keyPressed(){
  // left paddle
  if(keyCode == UP){
    leftup = true;
   }
  if(keyCode == DOWN){
    leftdown = true;
  } 
 // right paddle
  if(key == 'w'){
    righttup = true;
  }
  if(key == 's'){
   rightdown = true;
  }  
}

void keyReleased(){
  if(keyCode == UP){
    leftup = false;
}
if(keyCode == DOWN){

    leftdown = false;
  } 
  if(key == 'w'){
    righttup = false;
  }
  if(key == 's'){
   rightdown = false;
  }
}


class Paddle{
  float x;
  float y;

  public Paddle(float x, float y){
    this.x = x;
    this.y = y;
  }

  public void render(){
    rectMode(CENTER);
    fill(255);
    noStroke();
    rect(x,y,25,200);
  }

  public void mover(){
    if (leftup){
      l.y += -7;
    }
    if (leftdown){
      l.y += +7; 
    }
    if (righttup){
      r.y += -7; 
    }
    if (rightdown){
      r.y += 7; 
    }
    
    if(r.y>900)
    r.y=900;
    if(l.y>900)
    l.y=900;
    
     if(r.y<100)
    r.y=100;
    if(l.y<100)
    l.y=100;
  }

}

class Ball{
  float x;
  float y;
  float r = 35;
  float xRate = 2.25;
  float yRate = 4;

  public Ball(float x, float y){
    this.x = x;
    this.y = y;
  }

  public void update(){
    x += xRate;
    y += yRate;
  }

  public void render(){
  noStroke();
  fill(255);
  circle(x,y,r);
  image(img,x-17.5,y-17.5,r,r);
  }
}
