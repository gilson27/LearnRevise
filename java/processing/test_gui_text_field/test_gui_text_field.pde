/**
* ControlP5 Textfield
*
*
* find a list of public methods available for the Textfield Controller
* at the bottom of this sketch.
*
* by Andreas Schlegel, 2012
* www.sojamo.de/libraries/controlp5
*
*/


import controlP5.*;

ControlP5 cp5;

String textValue = "";
Textlabel myTextlabelA;
Textlabel myTextlabelB;
void setup() {
  size(700,400);
  
  PFont font = createFont("arial",20);
  
  cp5 = new ControlP5(this);
  
  myTextlabelA = cp5.addTextlabel("lb1")
                    .setText("test.")
                    .setPosition(100,50)
                    .setColorValue(0xff4fff00)
                    .setFont(createFont("Georgia",15))
                    ;
                 
  myTextlabelB = cp5.addTextlabel("lb2")
                    .setText("this.")
                    .setPosition(200,50)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",15))
                    ;   
     
  textFont(font);
}

void draw() {
  background(0);
  fill(255);
}



