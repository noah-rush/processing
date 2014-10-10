void setup(){
  size(500, 500, P3D);
  vectors = new ArrayList();
  motions = new ArrayList();
  balls = new ArrayList();
  go = false;
  
}
ArrayList<PVector> vectors;
ArrayList<PVector> motions; 
ArrayList<Ball> balls;
Ball a;
int counter = 0;
boolean go =false;
float noise = 10;
float z = 0.5;
float x = 1;
float y = 1;
float z_ =  (height/2.0) / tan(PI*30.0 / 180.0);
boolean reverseX = false;
boolean reverseY = false;
float angle2= 1; 
float angle=1 ;
float angle3 = 1;

void draw(){
  lights();
  if(x == 600){
    reverseX = true;
  }
  if(x== 0){
    reverseX = false;
  }
  if(y == 800){
    reverseY = true;
  }
  if(y== 0){
    reverseY = false;
  }
  pushMatrix();
translate(250, 250, 250);
//fill(222, 38);
noFill();
background(0);
stroke(253);
box(500);
popMatrix();

  if(mousePressed){
    PVector temp = new PVector(mouseX, mouseY, 22);
    vectors.add(temp);
  }

for(int i = 0; i < balls.size(); i++){
     balls.get(i).move();
     balls.get(i).display();
    for(int j = i+1; j<balls.size(); j++){
      balls.get(i).checkCollision(balls.get(j));
    }
}
  
camera(767*sin(angle), 527*sin(angle2),508*sin(angle3), // eyeX, eyeY, eyeZ
      width/2.0, height/2.0, 2, // centerX, centerY, centerZ
     -1.4, 1.2, -2.3); // upX, upY, upZ
         
         angle += 0.000;
         angle2+= 0.015;
         angle3+= 0.000;
         
 
  
}



void mouseReleased() {
for(int i = 0; i < vectors.size(); i++){
  if(i+1<vectors.size()){
    PVector temp = PVector.sub(vectors.get(i+1),vectors.get(i));
    motions.add(temp);
}
}
a = new Ball(vectors.get(vectors.size()-1), 10, motions);
balls.add(a);

}

void mousePressed(){
  motions = new ArrayList();
  vectors = new ArrayList();

}

float moveCameraX(float a){
  if(!reverseX){
  a++;
  x = a ;
  }else{
    a--;
    x = a;
  }
  return x;
  
  
}
float moveCameraZ(float c){
  if(!reverseX){
  c+=3;
  z = c ;
  }else{
    c-=3;
    z = c;
  }
  return z;
  
}
float moveCameraY(float b){
  if(!reverseY){
  b+=2;
  y = b;
  }else{
    b-=2;
    y=b;
  }
  return y;
}


