int bars1;
int bars2;

void setup(){
  size(500,500);
  bars1 = 1000;
  bars2 = 1000;
  
}
float angle1 = 0.2;
float angle2 = 0.2;

void draw(){
  background(0);
  fill(255);
  rect(0,0,width/2, height);
  stroke(0);
  strokeWeight(0.5);
  noFill();
  float x = mouseX; 
  float y = mouseY;
  int bar = 0;
  if(mouseX < width/4){
  rect(mouseX, mouseY, (width/4 -mouseX)*2, (height/2 -mouseY)*2);
  }
  
  bars1 = int(100 +  50 * sin(angle1));
  bars2 = int(100 +  50 * sin(angle2));
  if(mouseX<250){
    bar = int(map(mouseX, 0, width/2, 0,bars1));
  }
  for(int i = 0; i<bars1; i++){
    if(i == bar){
      fill(0);
    }
    rect(i*(width/4)/bars1, i*(height/2)/bars1, (width/2)-i*(width/2)/bars1,height - i*(height)/bars1);
  
    }
 if(mouseX>250){
    bar = int(map(mouseX, 0, width/2, 0,bars1));
  }
  for(int i = 0; i<bars2; i++){
    if(i == bar){
      fill(255);
    }
    stroke(255);
    rect(i*(width/4)/bars2+250, i*(height/2)/bars2, (width/2)-i*(width/2)/bars2,height - i*(height)/bars2);
  
    }
    angle1+=0.1;
    angle2+=0.4;

}
  

