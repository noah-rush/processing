class Point{
  
  float angle;
  
  public Point(float a){
    angle = a;
  }
  
  void orbit(float speed){
    angle+= speed;
  }
  float getAngle(){
    return angle;
  }
  
  void fillArc(color c, Point other){
    fill(c);
    if(angle > other.angle){
    arc(width/2, height/2, width/1, width/1, other.angle, angle, OPEN);
    }else{
    arc(width/2, height/2, width/1, width/1, angle,other.angle, OPEN);

    }
 
}
}
    
