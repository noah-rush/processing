class Ball{
  PVector position;
  
  float size;
  boolean negX = false;
  ArrayList<PVector> velocities;
  int numvelo;
  int counter = 0;
  PVector velocity;
  
  public Ball(PVector _loc, float _r, ArrayList<PVector> _velocities){
    position = _loc;
    size = _r;
    velocities = _velocities; 
    numvelo = velocities.size();
  }

  void move(){
     velocity = velocities.get(counter);
     this.checkBoundaryCollision();
   position.add(velocity);
   counter++;
   if(counter==numvelo){
     counter = 0;
   }
  }
  
  void display(){
    noFill();
    stroke(255);
    strokeWeight(1);
    pushMatrix();
    lights();
    translate(position.x, position.y, position.z);
sphere(size);
popMatrix();
  }
   void checkBoundaryCollision() {
     float r = size/2;
    if (position.x > width-r) {
      position.x = width-r;
      for(int i = 0; i<numvelo; i++){
      velocities.get(i).x *= -1;
      }
      fill(255,0,0);
      ellipse(position.x, position.y, r, r);
    } 
    else if (position.x < r) {
      position.x = r;
      for(int i = 0; i<numvelo; i++){
      velocities.get(i).x *= -1;
      }
       fill(255,0,0);
      ellipse(position.x, position.y, r, r);
    } 
    else if (position.y > height-r) {
      position.y = height-r;
      for(int i = 0; i<numvelo; i++){
      velocities.get(i).y *= -1;
      }
       fill(255,0,0);
      ellipse(position.x, position.y, r, r);
    } 
    else if (position.y < r) {
      position.y = r;
      for(int i = 0; i<numvelo; i++){
      velocities.get(i).y *= -1;
      }
       fill(255,0,0);
      ellipse(position.x, position.y, r, r);
    }
      else if (position.z > 500-r) {
      position.z = r;
      for(int i = 0; i<numvelo; i++){
      velocities.get(i).z *= -1;
      }
       fill(255,0,0);
      ellipse(position.x, position.y, r, r);
      }
      else if (position.z < r) {
      position.z = r;
      for(int i = 0; i<numvelo; i++){
      velocities.get(i).z *= -1;
      }
       fill(255,0,0);
      ellipse(position.x, position.y, r, r);
    }
  }
  
  void checkCollision(Ball other){
  PVector bVect = PVector.sub(other.position, position);
  float bVectMag = bVect.mag();
  float r = size/2;
  float rOther = (other.size)/2;
  
//  if(r +rOther > abs(this.x - other.x) && r +rOther> abs(this.y -other.y) && vertical){
//    other.speak();
//    if(other.usercreated){
//      other.userspeak();
//    }
//  }
  
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
      vFinal[0].x = ((velocity.mag() - other.velocity.mag()) * vTemp[0].x + 2 * other.velocity.mag() * vTemp[1].x) / (velocity.mag()+ other.velocity.mag());
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((other.velocity.mag() - velocity.mag()) * vTemp[1].x + 2 * velocity.mag() * vTemp[0].x) / (velocity.mag() + other.velocity.mag());
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
      for(int i = 0; i<numvelo; i++){
     velocities.get(i).x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocities.get(i).y = cosine * vFinal[0].y + sine * vFinal[0].x;
      }
      for(int i = 0; i<other.numvelo; i++){
      other.velocities.get(i).x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocities.get(i).y = cosine * vFinal[1].y + sine * vFinal[1].x;
      }
    }
  }
    
}
