
Point point1 = new Point(0.3);
Point point2 = new Point(0.5);
Point point3 = new Point(0.2);
Point point4 = new Point(0.4);


void setup() {

  background(255);
  size(500, 500);
  stroke(0);
  ellipse(width/2, height/2, width/1, width/1);
}

void draw() {
  background(255);
  fill(255);
  ellipse(width/2, height/2, width/1, width/1);
  point1.orbit(0.01);
  point2.orbit(0.01);
  point3.orbit(0.02);
  point4.orbit(0.02);
  
  if(point1.angle > point3.angle){
   // ellipse(20,20,250+250*sin(point1.angle),250+250*cos(point1.angle));
    ellipse(250+250*sin(point1.angle),250+250*cos(point1.angle), 20, 20);
  }
  
//  float angle1 = point1.angle;
//  float x1 = width/2 + width/2 * sin(angle1);
//  float y1 = width/2 + width/2 * cos(angle1);
//  
//  float angle2 = point2.angle;
//  float x2 = width/2 + width/2 * sin(angle2);
//  float y2 = width/2 + width/2 * cos(angle2);
  //line(x1, y1, x2, y2);
  
  point1.fillArc(color(185, 168, 168, 40), point2);
  point3.fillArc(color(0, 29, 243,40), point4);
  
  
  
}

