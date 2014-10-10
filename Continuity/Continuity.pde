String rightIP = "129.133.127.433";
String leftIP = "129.133.125.219";

import controlP5.*;
ControlP5 cp5;
import java.awt.Frame;
import java.awt.BorderLayout;
ArrayList<Spot> writing;
ArrayList<Spot> receive;

boolean reset = false;
boolean linesmovment = false;
final int xlines = 7;
int ylines = 4;
import oscP5.*;
import netP5.*;
float loc = 0;
FloatList locs; 
int clients = 0;
int id = 0;
ControlFrame cf;
Range range;
FloatList mins;
FloatList maxs;
float [] speeds = {2, 0.5, 0.25, 0.1, 4};
ArrayList<ArrayList<Spot>> clientSpots; 
ArrayList<Spot> cars; 
int startingDensity = 10; 
   boolean rightwall = true;
    boolean leftwall = true;
   
IntList clientele;
final float roadWidth = 50;

OscP5 oscP5;
NetAddress supercollider;
NetAddress rightCOMP;
NetAddress leftCOMP;
ArrayList <Boolean>  onOFF;
boolean translate = false;
HashMap<String,Integer> switches;

FloatList grows;


boolean sketchFullScreen(){
  return false;
}
  void walltypeL(){
    leftwall = !leftwall;

  }
    
    void walltypeR(){
      rightwall = !rightwall;
    }

void setup(){
  size(displayWidth , displayHeight);
  background(0);
  frameRate(60);
  writing = new ArrayList<Spot>();
  receive = new ArrayList<Spot>();
  grows = new FloatList();
  cars =  new ArrayList<Spot>();
  onOFF = new ArrayList<Boolean>();
   oscP5 = new OscP5(this,12000);
    supercollider = new NetAddress("127.0.0.1",57120);
    rightCOMP = new NetAddress(rightIP, 12000);
    leftCOMP = new NetAddress(leftIP, 12000);
clientele = new IntList();
    locs = new FloatList();
     mins = new FloatList();
 maxs = new FloatList();
  clientSpots = new ArrayList<ArrayList<Spot>>();
    // cp5 = new ControlP5(this);
 // cf = addControlFrame("extra", 500,500);


}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}
public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  
  public void setup() {
    size(w, h);
    frameRate(60);
    cp5 = new ControlP5(this);
  
  cp5.addSlider("xlines").plugTo(parent, "xlines").setRange(1, 20).setPosition(100, 410);
             
      cp5.addButton("add")
     .setValue(0)
     .setPosition(100,430)
     .setSize(200,19);
  
  cp5.addButton("delete")
     .setValue(100)
     .setPosition(100,450)
     .setSize(200,19)
     ;
             

  }

  public void draw() {
      background(abc);
     
  }
  private ControlFrame() {
  }
  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;

  }
  
  
  ControlP5 cp5;

  Object parent;

void controlEvent(ControlEvent theEvent) {
  String name = theEvent.getName();
  if(name.charAt(0) == 'l'){
    int address = Integer.parseInt(name.substring(3));
    locs.set(address-1, theEvent.getValue());
  }
  
  if(name.charAt(0) == 'r'){
   int address = Integer.parseInt(name.substring(5));
   print(address);
  float min = theEvent.getController().getArrayValue(0);
  float max = theEvent.getController().getArrayValue(1);
  print(min);
  print(max);
//    println(min);
   mins.set(address-1, min);
    maxs.set(address-1,max);
// 
  }
    
    
  if(theEvent.isFrom("add")){
    clients++;
    println(clients);
    cp5.addSlider("loc" + clients).setRange(1,height).setPosition(10,10 + clients*20);
    cp5.addRange("range" +clients)
              .setBroadcast(false) 
             .setPosition(150, clients*20)
             .setSize(200,10)
             .setHandleSize(20)
             .setRange(1,height)
             .setRangeValues(50,100)
             .setBroadcast(true);
             
             
  for(int i = 0; i<startingDensity; i++){
         Spot now = new Spot(random(width), random(height),255,255,10, cars.size());
         now.setspeed(2);
         cars.add(now);
             
  }
  clientSpots.add(cars);
  cars =  new ArrayList<Spot>();

  
}
}
}
void keyPressed(){
  if(key == 'a'){
      walltypeL();
  }
  if(key == 'd'){
  walltypeR();
  }
  if(key == 'p'){
    translate = !translate;
  }
  if(key =='o'){
    grows = new FloatList();
    for(int i = 0; i<writing.size(); i++){
      grows.append(random(100));
    }
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
if(key == 'w'){
  float min = random(width);
   mins.append(min);


}
if(key == 'u'){
 for(int i = 0; i <30; i++){
   if(i<writing.size()){
   writing.remove(i);
   }
 }

}

}
  
  



void draw(){
  background(0);
  for(int i = 0; i < xlines; i ++){
    float window = height-200;
    float rectcenters = window/xlines;
    fill(20*i);
   
    stroke(0);
    rectMode(RADIUS);
    rect(width/2, map(i*height/7 , 0, height, 100, height-100 ), width, roadWidth);
    
    }
    
    
       if(leftwall){ 
         stroke(255);
      strokeWeight(4);
    line(0,0,0,height);
   }
   
    if(rightwall){ 
      stroke(255);
      strokeWeight(4);
    line(width,0,width,height);
   }


    
   
    
  for(int i =0; i<writing.size();i++){
    writing.get(i).display();
    if(writing.get(i).selfdestruct){
      writing.remove(i);
  }
  }
    if(linesmovment){
     
      try{
    for(int i = 0; i<writing.size();i++){
 
  if(writing.get(i).inline()){
   
     
    writing.get(i).move(false);
   
  }else{
      if(writing.get(i).y > map(writing.get(i).line*height/7 , 0, height, 100, height-100 )){        
         writing.get(i).setAngle(PI);
        writing.get(i).move(false);       
      }else{         
        writing.get(i).setAngle(0);
       writing.get(i).move(false);
      }
       writing.get(i).move(false);
      
      }
    
    
    

      
    
      for(int j = i+1; j<writing.size(); j++){
        if(writing.get(i).line == writing.get(j).line){
       writing.get(i).checkCollision(writing.get(j));
        
        }
          }
        
        }
      
    
    
    

    try{
    for(int i = 0; i < clientele.size(); i++){
      ArrayList<Spot> temp = clientSpots.get(i);
      int density = clientSpots.get(i).size();
      if(onOFF.get(i)){
      for(int j = 0; j<density; j++){
        Spot now = temp.get(j);
         if(now.y>(maxs.get(i) + 2) || now.y<(mins.get(i)-2)){
          now.y = random(maxs.get(i) - mins.get(i)) + mins.get(i);
          now.position.set(now.x, now.y);
         }
        now.ylines(locs.get(i), 1.0, mins.get(i),maxs.get(i));

        now.display();
        
        for(int m = 0; m<writing.size(); m++){
          Spot now1 = writing.get(m);
          now.checkCollision(now1);
            
          
        }          
        
        
      }
      }
        
      
    }
    }catch(IndexOutOfBoundsException e){
      println("out of bounds");
    }
      }catch(NullPointerException e){
        println("nullpoint");
      }
    }
    
    if(translate){
      for(int i = 0; i<writing.size(); i++){
        writing.get(i).translate(int(random(200)));
      }
    }
     
     
     for(int i = 0; i<grows.size() && i <writing.size(); i++){
 writing.get(i).grow(grows.get(i));
}


}


int find(int item, IntList query){
  
  boolean found = false;
  int i = 0;
  int index = 0;
  while(!found && i < query.size()){
    if(query.get(i) == item){
       index = i;
       found =true;
    }
    i++;
  }
  return index;
}

void oscEvent(OscMessage theOscMessage){
  
  
  
  if(theOscMessage.addrPattern().equals("/ylinelocation")){
    float value = theOscMessage.get(0).floatValue();
      int client = theOscMessage.get(1).intValue();
      if(clientele.hasValue(client)){
        int index = find(client, clientele);
        locs.set(index, map(value, 0, 1, 0, width));
        println("index: " + index + "client: " + client + value);
    
      
  }
  }
   
  
  if(theOscMessage.addrPattern().equals("/dot")){
    int clientID = theOscMessage.get(0).intValue();
    float r = theOscMessage.get(1).floatValue();
    float g = theOscMessage.get(2).floatValue();
    float b = theOscMessage.get(3).floatValue();
    String name = theOscMessage.get(4).stringValue();
  
    Spot now = new Spot(random(width), random(height),255,color(r,g,b),random(40), receive.size());
    now.speedset();
now.setAngle(PI/2);
now.usercreated(clientID, name);
    writing.add(now);
    
     int index = find(clientID, clientele);
     Spot nother = new Spot(random(width), random(height),255,color(r,g,b),10, receive.size());
     nother.setspeed(2);
     nother.setVertical();
     nother.setAngle(PI);
     int choix = int(random(2));
//     switch(choix){
//     case 0: for(int i = 0; i<int(random(50));i++){
//     
//       clientSpots.get(index).add(nother);
//     }
//     break;
//     case 1: for(int i = 0; i<int(random(50));i++){
//      if(clientSpots.get(index).size()>i){
//       clientSpots.get(index).remove(i);
//     }
//     }
//     break;
//     }
        println(clientID,r,g,b,name);
   }
  
   if(theOscMessage.addrPattern().equals("/master_pan")){
      float value = theOscMessage.get(1).floatValue();
      int client = theOscMessage.get(0).intValue();
      if(clientele.hasValue(client)){
        int index = find(client, clientele);
        locs.set(index, map(value, 0.01, 0.098, 0, width));
        println("index: " + index + "client: " + client);
      }

  }
   
    
    if(theOscMessage.addrPattern().equals("/amIonU?")){
    
    println("receivepan");
      int client = theOscMessage.get(0).intValue();
      String x = theOscMessage.get(1).stringValue();
     float minvalue = theOscMessage.get(2).floatValue();
    float maxvalue = theOscMessage.get(3).floatValue();
     float r = theOscMessage.get(4).floatValue();
     float g =  theOscMessage.get(5).floatValue();
     float b =  theOscMessage.get(6).floatValue();
      
       
      
      
        if(clientele.hasValue(client)){
           int index = find(client, clientele);
           mins.set(index, map(minvalue, 0, 1, 0, height));
          maxs.set(index,map(maxvalue, 0, 1, 0, height));
         
             if(x.charAt(0) == 't'){
               boolean test = true;
               if(!onOFF.get(index)){
               onOFF.set(index, true);
               println(onOFF);
               }
             }
             else if(x.charAt(0) == 'f'){
               boolean test = false;
               if(onOFF.get(index)){
               onOFF.set(index, false);
               println(onOFF);
               }
               
             }
               
      }else{
         clientele.append(client);
         onOFF.add(true);
         println(clientele);
         println(onOFF);
           for(int i = 0; i<startingDensity; i++){
         Spot now = new Spot(random(width), random(height),255,color(r,g,b),10, cars.size());
         now.setspeed(2);
         now.setVertical();
         now.setAngle(PI);
         cars.add(now);
         
             
  }
  clientSpots.add(cars);
  cars =  new ArrayList<Spot>();
    
             
  }
        
    }
    
  if(theOscMessage.addrPattern().equals("/transfer")){
  float y = theOscMessage.get(1).floatValue();
  float inversex = theOscMessage.get(0).floatValue();
 int line = theOscMessage.get(2).intValue();
 float size = theOscMessage.get(3).floatValue();
 float r = theOscMessage.get(4).floatValue();
 float g = theOscMessage.get(5).floatValue();
 float b = theOscMessage.get(6).floatValue();
 float speed = theOscMessage.get(7).floatValue();
 float angle = theOscMessage.get(8).floatValue();
 Spot now;
  if(inversex >2000){
  now = new Spot(0, y,255,color(r,g,b),size, receive.size());
  now.setspeed(speed);
  now.setLine(line);
  now.setAngle(angle);
  writing.add(now);
  }else{
    now = new Spot(width, y, 255, color(r,g,b), size, receive.size());
    now.setLine(line);
    now.setspeed(speed);
    now.setAngle(angle);
  writing.add(now);
  
  }
if(theOscMessage.typetag().length()>9){
  int clientID = theOscMessage.get(9).intValue();
  String name = theOscMessage.get(10).stringValue();
  now.usercreated(clientID, name);
}

 
 
    
}
  
}
   
 

  
