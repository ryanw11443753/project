Player p = new Player(2*750/3-25,750/2,26,1,0);
Player p2 = new Player(750/3,750/4,26,0,-1);
Player p3 = new Player(750/4,750/2,26,-1,0);
Player p4 = new Player(730/3,2*750/3,26,0,1);
Box b = new Box(750/3-25,750/2-25,50,50);

void setup() {
  size(750,750);
}

int px = 2*750/3-25;
int py = 750/2;

void draw() {
  background(0);
  p._update();
  p2._update();
  p3._update();
  p4._update();
  b._update();
  b._lines();
}

class Player {
  float x,y,r,xspeed,yspeed;
  Player(float tx, float ty, float tr, float txspeed, float tyspeed) {
    x = tx;
    y = ty;
    r = tr;
    xspeed = txspeed;
    yspeed = tyspeed;
  }
  void _update() {
    ellipse(x,y,r,r);
    if (checkCollision() != 1) {
      y -= yspeed;
      x -= xspeed;
    }
  }
  int checkCollision() {
    int a = int(r/2);
    if ((x-a == b.x+b.l) && ((y+a >= b.y) && (y+a <= b.y+b.h))) { //right
      return 1;
    } else if(((x+a >= b.x) && (x+a <= b.x+b.l) && (y+a == b.y))) { //top
      return 1;
    } else if ((x+a == b.x) && ((y+a >= b.y) && (y+a <= b.y+b.h))) { //left
      return 1;
    } else if (((x+a >= b.x) && (x+a <= b.x+b.l) && (y-a == b.y+b.l))){ //bottom
      return 1;
    } else {
      return 0;
    }
  }
}

//void player() {
//  ellipse(px,py,25,25);
//  px -= 1;
//}

class Box {
  float x,y,l,h;
  Box (float tx, float ty, float tl, float th) {
    x = tx;
    y = ty;
    l = tl;
    h = th;
  }
  void _update() {
    rect(x,y,l,h);
  }
  void _lines() {
    noStroke();
    line(x,y,x+l,y);
    line(x,y,x,y+h);
    line(x+l,y,x+l,y+l);
    line(x,y+l,x+l,y+l);
    stroke(0);
  }
}
/*
//void box() {
//  rect(width/3-25,height/2-25,50,50);
//}
*/
