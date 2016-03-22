MrSmiley smiley1;
MrSmiley smiley2;

void setup() {
  size(600, 400);
  background(0);
  smiley1 = new MrSmiley(200, 200, 100, 255);
  smiley2 = new MrSmiley(350, 350, 20, 200);
}

void draw() {
  smiley1.display();  
  smiley2.display();
}


class MrSmiley {
  Body body;
  Hat hat;
  Stick stick;

  MrSmiley(int xpos, int ypos, int radius, color colour) {
    body = new Body(xpos, ypos, radius, colour);
    hat = new Hat(xpos, ypos, radius, colour); 
    stick = new Stick(xpos, ypos, radius, colour);
  }

  void display() {
    body.display();
    hat.display();
    stick.display();
    body.eyeRoll();
    delay(200);
  }
}


class Body {
  int x;
  int y;
  int r;
  int s;
  color c;

  Body(int xpos, int ypos, int radius, color colour) {
    c = colour;
    x = xpos;
    y = ypos;
    r = radius;
    s = r/50; // stroke weight
  }

  void display() {
    stroke(c);
    noFill();
    strokeWeight(s);
    smooth();
    ellipse(x, y, r, r);
    strokeWeight(s/2);
    ellipse(x-(r/15), y-(r/10), r/7, r/5);
    ellipse(x+(r/15), y-(r/10), r/7, r/5);
  } 

  void eyeRoll() {
    smooth();
    stroke(0);
    fill(0);
    ellipse(x-(r/15), y-(r/10), r/10, r/6);
    ellipse(x+(r/15), y-(r/10), r/10, r/6);   
    stroke(c); 
    fill(c);
    ellipse(x-(r/15), y-(r/10)-3 + random(6), r/20, r/20);
    ellipse(x+(r/15), y-(r/10)-3 + random(6), r/20, r/20);
  }
}

class Hat {
  int x;
  int y;
  int r;
  int s;
  color c;

  Hat(int xpos, int ypos, int radius, color colour) {
    c = colour;
    r = radius;
    x = xpos;
    y = ypos - r + (r/8);
    s = r/50;
  }

  void display() {
    stroke(c);
    noFill();
    smooth();
    strokeWeight(s);
    beginShape();
    vertex(x, y + (r/4)); // middle
    vertex(x + (r/2), y + (r/4)); // bottom R
    vertex(x + (r/2), y); // up from bottom R
    vertex(x + (r/6), y); // inside R corner
    vertex(x + (r/6), y - (r/4)); // top R
    vertex(x - (r/6), y - (r/4)); // top L 
    vertex(x - (r/6), y); // inside L corner 
    vertex(x - (r/2), y); // up from bottom L
    vertex(x - (r/2), y + (r/4)); // bottom L
    vertex(x, y + (r/4)); // back home
    endShape();
  }
}


class Stick {
  int x;
  int y;
  int r;
  int s;
  color c;

  Stick(int xpos, int ypos, int radius, color colour) {
    c = colour;
    r = radius;
    x = xpos - r + (r/4);
    y = ypos + (r/2);
    s = r/50;
  }

  void display() {
    stroke(c);
    noFill();
    smooth();
    strokeWeight(s);
    beginShape();
    vertex(x, y); // bottom of stick
    vertex(x, y - r); // bottom R
    endShape();
    arc(x - (r/10), y-r, r/5, r/5, PI, TWO_PI);
  }
}