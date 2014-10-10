String rightIP = "129.133.127.433";
String leftIP = "129.133.125.219";

import java.util.*; 

float initX = 50;
int [] initY = {50, 150, 250, 350, 450, 550, 650, 750, 850};
float initSize = 50;
boolean [] mouseOver = new boolean[9];
boolean [] locked = new boolean[9];
FloatList grows;

boolean start = false;
float interfaceX = 0;
float interfaceY = 0;
int colorChoice = 0; 

int leftWall = 100;
int rightWall; 
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress supercollider;
NetAddress rightCOMP;
NetAddress leftCOMP;
ArrayList<Spot> writing;
boolean reset = false;
final int xlines = 7;
boolean linesmovment = false;
float [] speeds = {2, 0.5, 0.25, 0.1, 4};
   boolean rightwall = true;
    boolean leftwall = true;
    
    final float roadWidth = 50;
    
    
      void walltypeL(){
    leftwall = !leftwall;

  }
    
    void walltypeR(){
      rightwall = !rightwall;
    }
    
    
    void setup(){
  size(displayWidth, 700);
  background(0);
  frameRate(60);
  writing = new ArrayList<Spot>();
     oscP5 = new OscP5(this,12000);
    supercollider = new NetAddress("127.0.0.1",57120);
    rightCOMP = new NetAddress(rightIP, 12000);
    leftCOMP = new NetAddress(leftIP, 12000);
    rightWall = width;
 Arrays.fill(mouseOver, false);
 Arrays.fill(locked, false);
}

void keyPressed(){
  if(key == 'a'){
      walltypeL();
  }
  if(key == 'd'){
  walltypeR();
  }
   if(key =='i'){
    grows = new FloatList();
    for(int i = 0; i<writing.size(); i++){
      grows.append(random(10));
    }
  }
   if(key =='q'){
   for(int i = 0; i<25; i++){
       color c = color(255);
  color z = color(255);
     Spot now = new Spot(random(width), random(height),c,z,random(30) + 5, writing.size());
 now.turnblue();
 now.speedset();
now.setAngle(PI/2);

  writing.add(now);
   }
   }
   if(key == 'g'){
  linesmovment=!linesmovment;
}
   }
   
   
   
   void draw(){
     fill(color(0), 50);
  rect(0, 0, width, height);
  
  try{
   for(int i = 0; i<grows.size() && i <writing.size(); i++){
 writing.get(i).grow(grows.get(i));
}
  }catch(NullPointerException e){
    print("boo");
  }

  
  if(leftwall){ 
         stroke(255);
         strokeWeight(4);
         line(leftWall,0,leftWall,height);
  }
   
  if(rightwall){ 
          stroke(255);
          strokeWeight(4);
          line(rightWall,0,rightWall,height);
   }
   
 for(int i =0; i<writing.size();i++){
          writing.get(i).display();
          if(writing.get(i).selfdestruct){
                writing.remove(i);
          }
   }
   
if(linesmovment){
     for(int i = 0; i<writing.size();i++){
 
  if(writing.get(i).inline()){
   
     
    writing.get(i).move(false, leftWall, rightWall);
   
  }else{
      if(writing.get(i).y > map(writing.get(i).line*height/7 , 0, height, 100, height-100 )){        
         writing.get(i).setAngle(PI);
        writing.get(i).move(false, leftWall, rightWall);       
      }else{         
        writing.get(i).setAngle(0);
       writing.get(i).move(false, leftWall, rightWall);
      }
       writing.get(i).move(false, leftWall, rightWall);
      
      }
    
    
    

      
    
      for(int j = i+1; j<writing.size(); j++){
        if(writing.get(i).line == writing.get(j).line){
       writing.get(i).checkCollision(writing.get(j));
        
        }
          }
        
        }
}

////Control Panel
for(int i = 0; i <initY.length; i++){
float distance = sqrt(sq(mouseX-initX) +sq(mouseY-initY[i]));
color filler = color(244, 250, 88) ; 
color fAlpha = color(244, 250, 88);

switch(i){
  case 0: filler = color(244, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 1: filler = color(20, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 2:filler = color(244, 10, 8);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 3: filler = color(244, 50, 200);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 4: filler = color(100, 250, 250);
          ///fAlpha = color(244, 250, 88, 150);
          break;
  case 5: filler = color(100, 0, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 6: filler = color(244, 250, 250);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 7: filler = color(244, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 8: filler = color(244, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 9: filler = color(244, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
}
if(distance<initSize/2){
  fill(filler);
  strokeWeight(4);
stroke(255);
ellipse(initX, initY[i], initSize, initSize);
mouseOver[i] = true;
println(mouseOver);


}else{
  noStroke();
  strokeWeight(4);
   fill(filler);
ellipse(initX, initY[i], initSize, initSize);
mouseOver[i] = false;

}

if(mousePressed && locked[i]){
     fill(filler, 150);
stroke(255);
ellipse(mouseX, mouseY, initSize, initSize);
     }

}


if(start){
  color filler = color(0);
  switch(colorChoice){
  case 0: filler = color(244, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 1: filler = color(20, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 2:filler = color(244, 10, 8);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 3: filler = color(244, 50, 200);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 4: filler = color(100, 250, 250);
          ///fAlpha = color(244, 250, 88, 150);
          break;
  case 5: filler = color(100, 0, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 6: filler = color(244, 250, 250);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 7: filler = color(244, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  case 8: filler = color(244, 250, 88);
          //fAlpha = color(244, 250, 88, 150);
          break;
  }
  fill(filler, 150);
  stroke(255);
  ellipse(interfaceX, interfaceY, initSize, initSize);
}
   }

   int contains(boolean [] a, boolean obj) {
    for (int i = 0; i < a.length; i++) {
        if (a[i] == obj) {
            return i;
        }
    }
    return -1;
}
   
   void mousePressed(){
     if(contains(mouseOver, true) != -1){
       int where = contains(mouseOver, true);
       locked[where] = true;
      println("lockcheck");
     }else{
      Arrays.fill(locked, false);
        
     }
     
   }
   void mouseReleased() {

  
  if(contains(locked, true) != -1){
    int where = contains(locked, true);
  ArrayList <Spot> merges = findSpots(mouseX, mouseY);
    for(int i = 0; i<merges.size(); i++){
      merges.get(i).merge(where);
    }
  }
    Arrays.fill(locked, false);
  

}

ArrayList <Spot> findSpots(float x, float y){
  ArrayList <Spot> merges = new ArrayList();
  for(int i = 0; i < writing.size(); i++){
    Spot temp = writing.get(i);
    float dist = sqrt(sq(x-temp.position.x) +sq(y-temp.position.y));
    if(dist < temp.size/2 + initSize/2){
      merges.add(temp);
    }
  }
  return merges;
}
  
       
 void oscEvent(OscMessage theOscMessage){    
       if(theOscMessage.addrPattern().equals("/loc")){
         interfaceX = map(theOscMessage.get(0).floatValue(), 0, 1, 0, width);
         interfaceY = map(theOscMessage.get(1).floatValue(), 0, 1, 0, height);
       }
       if(theOscMessage.addrPattern().equals("/start")){
         start = true;
       }
       if(theOscMessage.addrPattern().equals("/end")){
         start = false;
         ArrayList <Spot> merges = findSpots(interfaceX, interfaceY);
    for(int i = 0; i<merges.size(); i++){
      merges.get(i).merge(colorChoice);
    }
  }
    if(theOscMessage.addrPattern().equals("/colorchoice")){
      colorChoice = int(theOscMessage.get(0).floatValue());
  
       }

     
 
      
   
 }
