import oscP5.*;
import netP5.*;
OscP5 oscP5;
float alpha;
float fill;
import java.util.HashMap;
import java.lang.Number;

HashMap hm = new HashMap(); 



void setup(){
  frameRate(60);
  oscP5 = new OscP5(this,12000);
  
  size(displayWidth, displayHeight, P2D);
  background(255);
  xs = new FloatList();
  ys = new FloatList();
   xcenters = new FloatList();
  ycenters = new FloatList();
  shapes = new ArrayList<PShape>();
  fill = color(255);
  alpha = 255;
  
 
}
boolean boing;
FloatList xs; 
FloatList ys;
int count =0;
ArrayList <PShape> shapes;
FloatList xcenters;
FloatList ycenters;
void draw(){
  if(boing){
    boing();
    boing = false;
  }
  fill(0);
  if(mousePressed){
    xs.append(mouseX);
    ys.append(mouseY);
  }
  count = xs.size();
  if(count>1){
    stroke(0);
    line(xs.get(count-1), ys.get(count-1), xs.get(count-2), ys.get(count-2));
  }
  for (int j = 0; j<xcenters.size(); j++){
    pushMatrix();
  translate(xcenters.get(j), ycenters.get(j));
  for(int i =0; i < shapes.size(); i++){
     noStroke();
fill(random(255),random(255), random(255));
  shapes.get(i).rotate(random(1.0) - random(1.0));
  shape(shapes.get(i));
  }
  popMatrix();
  }
}
  
void mouseReleased(){
  count = 0;
  makeShape(xs, ys);
   xs = new FloatList();
  ys = new FloatList();
}
void keyPressed(){
  if(key == 'r'){
    shapes.remove(0);
  }
    if(key == 'c'){
    xcenters.append(mouseX);
    ycenters.append(mouseY);
  }
   if(key == ' '){
    boing();
  }
  if(key == 'p'){
     xcenters.remove(xcenters.size()-1);
    ycenters.remove(xcenters.size()-1);
  }
  if(key =='s'){
    for(int i = 0; i <shapes.size(); i++){
      shapes.get(i).scale(1.1);
    }
  }
    if(key =='d'){
    for(int i = 0; i <shapes.size(); i++){
      shapes.get(i).scale(0.9);
    }
    }
    
}
void makeShape(FloatList exes,FloatList eyes){
  PShape s = createShape();
  s.beginShape();
 
  for(int i =0; i<exes.size(); i++){
    s.vertex(exes.get(i), eyes.get(i));
  }
  s.endShape();
  color a = color(random(255), random(255), random(255));
  shapes.add(s);

}
public void boing() {
  
  print("wiped");
    fill(color(0));
  rect(0,0,width,height);
  print("finished");
}

void oscEvent(OscMessage theOscMessage){
print(theOscMessage);
  boing = true;
  alpha = theOscMessage.get(0).floatValue();
  alpha = map(alpha, 0.15, 0.5, 180, 255);
  fill = theOscMessage.get(1).intValue();
  fill = map(fill, 48, 100, 255, 150);
  print(fill);

}
  
  
