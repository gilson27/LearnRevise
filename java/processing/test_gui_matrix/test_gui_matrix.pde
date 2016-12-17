/**
 * ControlP5 Matrix
 *
 * A matrix can be used for example as a sequencer, a drum machine.
 *
 * find a list of public methods available for the Matrix Controller
 * at the bottom of this sketch.
 *
 * by Andreas Schlegel, 2012
 * www.sojamo.de/libraries/controlp5
 *
 */

import controlP5.*;

ControlP5 cp5;

Dong[][] d;
int nx = 10;
int ny = 10;

void setup() {
  size(700, 400);

  cp5 = new ControlP5(this);
  cp5.printPublicMethodsFor(Matrix.class);

  cp5.addMatrix("myMatrix")
     .setPosition(50, 100)
     .setSize(200, 200)
     .setGrid(nx, ny)
     .setGap(10, 1)
     .setInterval(200)
     .setMode(ControlP5.MULTIPLES)
     .setColorBackground(color(120))
     .setBackground(color(40))
     ;
  
  cp5.getController("myMatrix").getCaptionLabel().alignX(CENTER);
  
  // use setMode to change the cell-activation which by 
  // default is ControlP5.SINGLE_ROW, 1 active cell per row, 
  // but can be changed to ControlP5.SINGLE_COLUMN or 
  // ControlP5.MULTIPLES

    d = new Dong[nx][ny];
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y] = new Dong();
    }
  }  
  noStroke();
  smooth();
}


void draw() {
  background(0);
  fill(255, 100);
  pushMatrix();
  translate(width/2 + 150, height/2);
  rotate(frameCount*0.001);
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y].display();
    }
  }
  popMatrix();
}


void myMatrix(int theX, int theY) {
  println("got it: "+theX+", "+theY);
  d[theX][theY].update();
}


void keyPressed() {
  if (key=='1') {
    cp5.get(Matrix.class, "myMatrix").set(0, 0, true);
  } 
  else if (key=='2') {
    cp5.get(Matrix.class, "myMatrix").set(0, 1, true);
  }  
  else if (key=='3') {
    cp5.get(Matrix.class, "myMatrix").trigger(0);
  }
  else if (key=='p') {
    if (cp5.get(Matrix.class, "myMatrix").isPlaying()) {
      cp5.get(Matrix.class, "myMatrix").pause();
    } 
    else {
      cp5.get(Matrix.class, "myMatrix").play();
    }
  }  
  else if (key=='0') {
    cp5.get(Matrix.class, "myMatrix").clear();
  }
}

void controlEvent(ControlEvent theEvent) {
}


class Dong {
  float x, y;
  float s0, s1;

  Dong() {
    float f= random(-PI, PI);
    x = cos(f)*random(100, 150);
    y = sin(f)*random(100, 150);
    s0 = random(2, 10);
  }

  void display() {
    s1 += (s0-s1)*0.1;
    ellipse(x, y, s1, s1);
  }

  void update() {
    s1 = 50;
  }
}
