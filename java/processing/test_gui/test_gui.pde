import controlP5.*;

ControlP5 cp5;
int bgColor = color(0,0,0);

void setup() {
  size(450, 400);
  cp5 = new ControlP5(this);
  cp5.addSlider("T1",0,512,16,100,50,10,100)
    .setNumberOfTickMarks(513)
    .showTickMarks(false)
    .snapToTickMarks(true);
  cp5.addSlider("T2",0,8,0,200,50,10,100)
    .setNumberOfTickMarks(9)
    .showTickMarks(false)
    .snapToTickMarks(true);
  cp5.addSlider("T3",0,10,1,300,50,10,100)
    .setNumberOfTickMarks(11)
    .showTickMarks(false)
    .snapToTickMarks(true);
}

void draw() {
  background(bgColor);
}