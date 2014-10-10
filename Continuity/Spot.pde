



class Spot{
  color s;
  color f;
  float x;
  float y;
  final float XX;
  final float YY; 
  float size;
  float angleOfMotion;
   float speed;  
   String typeMotion;
   float gravity = 4.0; 
   float towardIncrement = 100; 
   float curvaceous1, curvaceous2, curvaceous3, curvaceous4;
   String drawType = "dots";
   float changerate = 100; 
   float pinwheel = 0;
   float pinwheel1 = PI/2;
   float pinwheel2 = PI;
   float pinwheel3 = 3*PI/2;
   float highy;
   float counter = 0; 
   ArrayList<Spot> covers;
    int translateCounter = 0;
    int id; 
    boolean xhitwall = false; 
    boolean yhitwall = false;
    boolean ceilinghit = false;
    boolean inline = false;
    boolean immunity = false;
    int immunityCounter =0;
    PVector position;
    PVector velocity;
    int line; 
     boolean vertical = false;
     boolean selfdestruct = false;
     boolean usercreated = false;
     boolean lastinline = false;
     boolean gotThere1 = true;
     boolean firsttime = true;
     int clientID; 
     String name;

   
   
   
   
   
  Spot(float tempx, float tempy, color temps, color tempf, float tempsize, int tempid){
    x = tempx;
    y=tempy;
    XX = x;
    YY = y;
    s = temps;
    f = tempf; 
    size = tempsize; 
    angleOfMotion = random(2*PI);
    speed = 50 + random(10);
    typeMotion = "linear";
    curvaceous1 = random(100)-50;
    curvaceous2 = random(100)-50;
    curvaceous3 = random(100)-50;
    curvaceous4 = random(100)-50;
    covers = new ArrayList<Spot>();
    id = tempid;
    position = new PVector(x,y);
    velocity = new PVector(speed*sin(angleOfMotion), speed*cos(angleOfMotion));
    line = int(random(7));
  }
  void usercreated(int client, String tempName){
    usercreated = true;
    clientID = client;
    name = tempName;
  }
  void immune(){
    immunity = !immunity;
  }
  void immunecount(){
    immunityCounter++;
    if(immunityCounter>10){
      immunity = !immunity;
    }
  }
 
  
  void gotThere(){
    if(gotThere1){
      this.setAngle(PI/2);
    }
    gotThere1=false;
  }
  void wallhit(){
  xhitwall = false; 
   yhitwall = false;
  }
  void changeType(String s) {
    drawType = s;
  }
  void colorchange(color c){
    s = c;
  }
    void setVertical(){
    vertical = !vertical;
  }
  void grow(float f){
    float sizechange = f-size;
    size = size + sizechange/changerate;
  }
  
  void moveup(float y){
    if(!ceilinghit){
    highy = y/counter;
    counter = counter + 0.053; 
    }else{
        highy = y*counter;
    counter = counter + 0.053; 
    }
    if(y<50){
      ceilinghit = true;
    }
    if(y>800){
      ceilinghit = false;
    }
  }
  
  void display(){
    strokeWeight(0.25);
    if(drawType.equals("dots")){
      stroke(s);
    fill(f);
    ellipse(x,y,size,size);
    }else if(drawType.equals( "growToCeiling")){
    stroke(s);
    spin();
    moveup(y);
    line(x+(size/2*cos(pinwheel)), y+(size/2*sin(pinwheel)), x-(size/2*cos(pinwheel)), y-(size/2*sin(pinwheel)));
     line(x+(size/2*cos(pinwheel)), y+(size/2*sin(pinwheel)), x+(size/2*cos(pinwheel)), highy + (size/2*sin(pinwheel)));
    line(x, y+size/2, x, y-size/2);
   line(x-size/2, y +size/2, x+size/2, y-size/2);
  }else if (drawType.equals( "Zstars")){
    stroke(s);
    spin();
    line(x+(size/2*cos(pinwheel)), y+(size/2*sin(pinwheel)), x-(size/2*cos(pinwheel)), y-(size/2*sin(pinwheel)));
     line(x+(size/2*cos(pinwheel)), y+(size/2*sin(pinwheel)), x+(size/2*sin(pinwheel)), y+(size/2*cos(pinwheel)));
    line(x, y+size/2, x, y-size/2);
   line(x-size/2, y +size/2, x+size/2, y-size/2);
  }else if (drawType.equals( "stars")){
    stroke(s);
    spin();
    line(x+(size/2*cos(pinwheel)), y+(size/2*sin(pinwheel)), x-(size/2*cos(pinwheel)), y-(size/2*sin(pinwheel)));
     line(x+(size/2*sin(pinwheel1)), y+(size/2*cos(pinwheel1)), x-(size/2*sin(pinwheel1)), y-(size/2*cos(pinwheel1)));
       line(x+(size/2*sin(pinwheel2)), y+(size/2*cos(pinwheel2)), x-(size/2*sin(pinwheel2)), y-(size/2*cos(pinwheel2)));
     line(x+(size/2*sin(pinwheel3)), y+(size/2*cos(pinwheel3)), x-(size/2*sin(pinwheel3)), y-(size/2*cos(pinwheel3)));

  }
  
  
  }
  
  void speak(){
    
    OscMessage speak = new OscMessage("/speak");
    float freq = map(x, 0,width, 0,1);
    speak.add(freq);
    speak.add(id);
    speak.add(line);
    oscP5.send(speak, supercollider);
    
  }
  
   void userspeak(){
    
    OscMessage myname = new OscMessage("/myname");
    float freq = map(x, 0,width, 0,1);
    myname.add(freq);
    myname.add(id);
    myname.add(line);
    myname.add(clientID);
    myname.add(name);
    oscP5.send(myname, supercollider);
    
  }
  
  
  
  
  void collisionSpeak(){
    OscMessage collisionSpeak = new OscMessage("/specSpeak");
    float freq = map(x, 0,width, 0,1);
    collisionSpeak.add(freq);
    oscP5.send(collisionSpeak, supercollider);
  }
    
  void spin(){
    
    pinwheel +=0.2;
    pinwheel1 +=0.2;
    pinwheel2 +=0.2;
    pinwheel3 +=0.2;
  }
  
  
  
  
  
  
  void checkSpecs(int id, boolean [] trues){
   
  if(trues[1]){
      if(id != 0){
     this.createLines(writing.get(id-1)); 
      }
  }
  if(trues[0]){
   if(id != 0){
     this.createCurves(writing.get(id-1), true, 0.5); 
   }
  }
  if(trues[2]){ 
    this.grow(100);
   }
  if(trues[3]){
    
     this.grow(10);
}
  }
    void setLine(int liNE){
    line = liNE;
  }
  
  void moveToward(float xdest, float ydest, boolean random, boolean reset){
    
    float xdist = xdest-x;
    float ydist = ydest-y;




    if(random){
    float tempx = x +xdist/(random(200) +100);
    float tempy = y + ydist/(random(200) + 100);
    position.set(tempx,tempy);
    }else{
    float tempx = x+xdist/80;
    float tempy = y + ydist/80;
    position.set(tempx,tempy);
    
    }
    if(reset){
      float tempx = xdest;
      float tempy = ydest;
       position.set(tempx,tempy);
    }
  
  
   
    
  }


    
  
void move( boolean onoff){
    if(x>(width -size) && rightwall || x<(size) &&leftwall){
    this.checkBoundaryCollision();
    }else if(x>width && !rightwall &&!vertical){
      OscMessage transfer = new OscMessage("/transfer");
        transfer.add(x);
        transfer.add(y);
        transfer.add(line);
        transfer.add(size);
        transfer.add(red(f));
         transfer.add(green(f));
          transfer.add(blue(f));
          transfer.add(speed);
          transfer.add(angleOfMotion);
          if(usercreated){
            transfer.add(clientID);
            transfer.add(name);
          }
         oscP5.send(transfer, rightCOMP);
         selfdestruct = true;
    }else if(x<0 && !leftwall && !vertical){
        OscMessage transfer = new OscMessage("/transfer");
        transfer.add(x);
        transfer.add(y);
        transfer.add(line);
         transfer.add(size);
        transfer.add(red(f));
        transfer.add(green(f));
          transfer.add(blue(f));
          transfer.add(speed);
          transfer.add(angleOfMotion);
           if(usercreated){
            transfer.add(clientID);
            transfer.add(name);
          }
         oscP5.send(transfer, leftCOMP);
         println("sent");
         selfdestruct = true;
        
      }
    position.add(velocity);
    x = position.x;
    y = position.y;
  }
    
      void setAngle(float angle){
    velocity.set(speed*sin(angle), speed*cos(angle));
    angleOfMotion = angle;
  }
    
    
  
   void checkBoundaryCollision() {
     float r = size/2;
    if (position.x > width-r) {
      position.x = width-r;
      velocity.x *= -1;
    } 
    else if (position.x < r) {
      position.x = r;
      velocity.x *= -1;
    } 
    else if (position.y > height-r) {
      position.y = height-r;
      velocity.y *= -1;
    } 
    else if (position.y < r) {
      position.y = r;
      velocity.y *= -1;
    }
  }
  
 void createLines(Spot b){
   line(this.x,this.y, b.x, b.y);
 }
 void createCurves(Spot b, boolean crazyCurves, float weight){
   if(crazyCurves){
     beginShape();
     noFill();
     strokeWeight(weight);
     stroke(s);
   bezier(this.x, this.y, this.x+random(100)-50, this.y+random(100)-50, b.x+random(100)-50, b.y + random(100)-50, b.x, b.y);
   }else{
     beginShape();
     noFill();
     strokeWeight(weight);
     stroke(s);
        bezier(this.x, this.y, this.x+curvaceous1, this.y+curvaceous2, b.x+curvaceous3, b.y + curvaceous4, b.x, b.y);

 }
 }
  
  void translate(int noise){
    if (translateCounter>noise){
      covers = new ArrayList<Spot>();
      translateCounter = 0;
    }else{
    float z = x+ random(10);
    float j = y + random(10);
    Spot now = new Spot(z,j, s,f, size, covers.size());
    covers.add(now);
    this.display();
    for(int i = 0; i<covers.size(); i++){
      covers.get(i).display();
    }
    translateCounter++;
    
  }
  }
  void turnblue(){
    if(!usercreated){
      switch(line){
        case 0: f = color(255, 0, 0);
        break;
        case 1: f = color(0, 255, 0);
        break;
        case 2: f = color(0, 0, 255);
       break;
        case 3: f = color(120, 120, 120);
        break;
        case 4: f = color(40, 200, 200);
        break;
        case 5: f = color(10, 90, 160);
        break;
        case 6: f = color(255);
        break;
      }
    }
        
  }
  void turnred(){
    s = color(255,0,0);
    f = color(255,0,0);
  }
void turnwhite(){
  s = color(255);
  f = color(255);
}  
 void setspeed(float sp){
  speed = sp;
  
}
 void speedset(){
      switch(line){
        case 0: speed = 1;
        break;
        case 1: speed = 10; 
        break;
        case 2: speed = 5;
       break;
        case 3: speed = 2;
        break;
        case 4: speed = 0.5;
        break;
        case 5: speed = random(4);
        break;
        case 6: speed = 8;
        break;
      }
        
  }

void changex(){
  xhitwall = !xhitwall;
}
void changey(){
  velocity.y*=-1;
  
}


boolean inline(){
  boolean a;
  if( abs((y - map(line*height/7 , 0, height, 100, height-100 )))<50){
        
        a = true;
      }else{
  a = false;
      }
      if(!lastinline){
        if(a){
          int choix = int(random(2));
          switch (choix){
          case 0: this.setAngle(PI/2);
          break;
          case 1: this.setAngle(3*PI/2);
          break;
          }
          
        }
      }
//      if(lastinline){
//        if(!a){
//          velocity.y*=-1;
//          a = true;
//        }
//      }
//      
      
      
   lastinline = a;   
  return a;
    }
  
  void moveToLines(int stripes, int orientation, float stroke, float speed, int totalpoints){
    
    
    if(orientation == 0){
      if( y - map(height/stripes * line, 0, height, 100, height-100 )<15){
        this.move(false);
        if(firsttime){
        this.setAngle(PI/2);
        firsttime = false;
        }
        inline = true;
      }
    position.set(x, y);
     if(this.y > map(this.line*height/7 , 0, height, 100, height-100 )){        
         this.setAngle(PI);
        this.move(false);       
      }else{         
        this.setAngle(0);
       this.move(false);
      }
       this.move(false);
      
      }
    
    
   
    
       else if(orientation ==1){
      if( x -  map(width/stripes * line, 0, width, 100, width-100)<1){
       
      
      this.moveToward(map(width/stripes * line, 0, width, 100, width-100), y, false, reset);
    }
  }
  }
    
    

    
   void ylines(float loc, float speed1, float min, float max){
       x=loc;
       position.set(x, y);
       speed = speed1;
       if(y > max || y< min){
         changey();
       }
      this.move(false);
    }
    
  void colorshift(){
    int rand = int(random(3));
     s = s-10;
    f = f-10;
    if(rand ==0){
      s = color(s,255,255);
      f= color(f,255,255);
    }
    if(rand ==1){
       s = color(255,s, 255);
      f= color(255,f, 255);
    }
    if(rand ==2){
        s = color(255, 255, s);
      f= color(255, 255, f);
    }
    
}

void checkCollision(Spot other){
  PVector bVect = PVector.sub(other.position, position);
  float bVectMag = bVect.mag();
  float r = size/2;
  float rOther = (other.size)/2;
  
  if(r +rOther > abs(this.x - other.x) && r +rOther> abs(this.y -other.y) && vertical){
    other.speak();
    if(other.usercreated){
      other.userspeak();
    }
  }
  
  if(bVectMag<(r + rOther)){
    
    float theta = bVect.heading();
    float sine = sin(theta);
    float cosine = cos(theta);


PVector [] bTemp = {
  new PVector(), new PVector()
};

bTemp[1].x = cosine*bVect.x+sine *bVect.y;
bTemp[1].y = cosine*bVect.y - sine *bVect.x;

PVector[] vTemp = {
  new PVector(), new PVector()
};

vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;

 PVector[] vFinal = {  
        new PVector(), new PVector()
        };

      // final rotated velocity for b[0]
      vFinal[0].x = ((speed - other.speed) * vTemp[0].x + 2 * other.speed * vTemp[1].x) / (speed + other.speed);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((other.speed - speed) * vTemp[1].x + 2 * speed * vTemp[0].x) / (speed + other.speed);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
        };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      //update balls to screen position
      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      //update velocities
     velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }
     }
