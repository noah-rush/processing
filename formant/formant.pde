import oscP5.*;
import netP5.*;
float a = 60;
float b = 60;
float c = 60;
int rate = 0;
float back = 0;

OscP5 oscP5;
float centroid;
float perc;

void setup(){
  OscP5 oscP5 = new OscP5(this, 12000);
  size(500, 500);
}

void draw(){
  
  background(back);
    for(int i = 0; i < rate; i++){
      fill(255);
      ellipse(random(width), random(height), 10, 10);
    }
 fill(color(a,b,c));
 bezier(a, 250, 200,centroid, a, 200, perc, 400);
 rect(a, a,a,a);
}
 
 void oscEvent(OscMessage theOscMessage){
   println(theOscMessage.get(0).floatValue());
   a = map(theOscMessage.get(0).floatValue(), 200, 1400,0,255);
   rate = int(map(theOscMessage.get(1).floatValue(), 0,10, 1, 400));
   back = map(theOscMessage.get(2).floatValue(), 800, 3000, 0, 255);
   centroid = map(theOscMessage.get(3).floatValue(), 200, 4000, height, 0);
   perc= map(theOscMessage.get(4).floatValue(), 200, 4000, height, 0);
 }

