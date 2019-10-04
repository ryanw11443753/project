float _width = 800;
float _height = 800;
Player p = new Player(_width/2, 50);
cart c1 = new cart(50,50);
Objs obj1 = new Objs(75,250,75,175);
Objs obj2 = new Objs((_width/2)-(75/2),250,75,175);
Objs obj3 = new Objs(_width-150,250,75,175);
Objs obj4 = new Objs(75,500,75,250);
Objs obj5 = new Objs((_width/2)-(75/2),500,75,250);
Objs obj6 = new Objs(_width-150,500,75,250);

void setup(){
  size(800,800);
}

void draw(){
  background(0);
  classUpdates();
}

class Player {
  float ypos, xpos, cxpos, cypos;
  int cpos = 0;
  boolean grabbing;
  boolean grab = false;
  Player(float a, float b) {
    ypos = b;
    xpos = a;
  }
  int checkCpos(int cpos, int tCpos) {
    if (cpos != 0) {
      cpos = tCpos;
    }
    return cpos;
  }
  void _update(){
    if (pubCollision(xpos,ypos) == 0) {
      if (keyPressed == true) {
        if (key == 'w'){
          ypos -= 3;
          cpos = checkCpos(cpos,4);
        }
        if (key == 's'){
           ypos += 3;
           cpos = checkCpos(cpos,2);
        }
        if (key == 'a'){
          xpos -= 3;
          cpos = checkCpos(cpos,1);
        }
        if (key == 'd'){
          xpos += 3;
          cpos = checkCpos(cpos,3);
        }
        if (key == ' ') {
          if (grab == true) {
            grab = false;
            grabbing = false;
          } else if (grab == false) {
            grab = true;
            grabbing = true;
            if (cpos == 0) {
              cpos = 2;
            }
          }
        }
      }
    }
    ellipse(xpos,ypos,25,25);
  }
}

class cart {
  float xpos, ypos;
  String[] contents;
  cart(float a, float b) {
    xpos = a;
    ypos = b;
  }
  int pos = 1;
  void grabbed(boolean grab, int b) {
    int pos = b;
    if (grab == true) {
      if (pos == 1) {
        rect(p.xpos-55, p.ypos-10,35,20);
      } else if (pos == 2) {
        rect(p.xpos-12, p.ypos+25,25,35);
      } else if (pos == 3) {
        rect(p.xpos+20, p.ypos-10,35,20);
      } else if (pos == 4) {
        rect(p.xpos-12,p.ypos-60,25,35);
      }
    } else {
      checkGrab(grab, p.xpos, p.ypos, b);
    }
  }
  void checkGrab(boolean grab, float x, float y, float pos) {
    if (grab == false) {
      if (pos == 1) {
        rect(x-55, y-10,35,20);
      } else if (pos == 2) {
        rect(x-12, y+25,25,35);
      } else if (pos == 3) {
        rect(x+20, y-10,35,20);
      } else if (pos == 4) {
        rect(x-12, y-60,25,35);
      } else {
        rect(50,50,35,20);
      }
    }
  }
}

class Objs {
  float x,y,l,h;
  Objs(float tx, float ty, float tl, float th) {
    x = tx;
    y = ty;
    l = tl;
    h = th;
  }
  void _update() {
    rect(x,y,l,h);
  }
  void _lines() {
    //stroke(255);
    noStroke();
    line(x,y,x+l,y);
    line(x,y,x,y+h);
    line(x+l,y,x+l,y+h);
    line(x,y+h,x+l,y+h);
  }
  int checkCollision(float px, float py) {
    int a = int(25/2); //a is radius of player
    // playerX = right                    playerY closer to top than y + height
    //                    playerY further down than y
    if ((px-a == x+l) && ((py+a >= y) && (py+a <= y+h))) { //checks if the player's X is equal to the right side of the object, and if the player's Y is within the height of the object.
      p.xpos += a;
      return 1;
    } else if (((px+a >= x) && (px+a <= x+l) && (py+a == y))) { //checks if the player's X is within the length of the object and if the player's Y is equal to the height of the top of the object.
      p.ypos -= a;
      return 1;
    } else if ((px+a == x) && ((py+a >= y) && (py+a <= y+h))) { //checks if the player's X is equal to the left side of the object, and if the player's Y is within the height of the object.
      p.xpos -= a;
      return 1;
    } else if (((px+a >= x) && (px+a <= x+l) && (y-a == y+h))) { //checks if the player's X is within the length of the object and if the player's Y is equal to the height of the bottom of the object.
      p.ypos += a;
      return 1;
    } else {
      return 0;
    }
  }
}

void classUpdates() {
  
  obj1._lines();
  obj2._lines();
  obj3._lines();
  obj4._lines();
  obj5._lines();
  obj6._lines();
  
  obj1._update();
  obj2._update();
  obj3._update();
  obj4._update();
  obj5._update();
  obj6._update();
  
  p._update();
  c1.grabbed(p.grab,p.cpos);
  
}

int pubCollision(float px, float py) {
  
  if (obj1.checkCollision(px,py) == 1) {
    return 1;
  }
  if (obj2.checkCollision(px,py) == 1) {
    return 1;
  }
  if (obj3.checkCollision(px,py) == 1) {
    return 1;
  }
  if (obj4.checkCollision(px,py) == 1) {
    return 1;
  }
  if (obj5.checkCollision(px,py) == 1) {
    return 1;
  }
  if (obj6.checkCollision(px,py) == 1) {
    return 1;
  }
  return 0;
}
