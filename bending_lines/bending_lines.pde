void setup(){
  size(500,500);
  background(0);
  frameRate(40);
}
float xmove = 251;
float ymove =251;
int iterations = 1;
void lines(int iterations, float angle, float x, float y, float startLength){
  float x2 = x + startLength*cos(angle);
  float y2 = y + startLength*sin(angle);
  stroke(255);
  line(x,y, x2, y2);
  if(iterations>0){
   float offset = map(mouseY, 0,width, 0.2, 2*PI);
  lines(iterations-1, angle+offset, x2,y2,startLength/1.5);
  }
}

float mag = 1;
float angle2 = 0;
float angle3 = 0;
float angle4 = 0;
void draw(){
  fill(0, 100 );
  rect(0,0,width, height);
  
  
      float angle = atan2(ymove-250, xmove-250);
  lines(iterations, angle, 250, 250,200);
  xmove = 251 + mag * cos(angle2);
  ymove = 251+ mag *sin(angle2);
  iterations++;
  mag+=0.1;
  angle2+=map(mouseX, 0,width, 0, 2*PI);
  angle3+=0.3;
  angle4+=0.2;
  }
  
  


