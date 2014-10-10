
PImage photo;

void setup(){
  size(500, 500);
  updatesizes();
  background(0);
  photo = loadImage("philadelphia-skyline.jpeg");
  photo.resize(500,500);
}
IntList vals;
void draw(){
  background(0);
  for ( int i = 0; i <150; i++){
    PImage temp = photo.get(i * height/150, vals.get(i),height/150, height-vals.get(i));
    image(temp, i * height/150, vals.get(i));
 
  }
  if(frameCount%1 ==0){
    updatesizes();
  }
}
    
    
    void updatesizes(){
      vals = new IntList();
      for ( int i = 0; i <150; i++){
        vals.append(int(random(100)+100));
      }
    }
        
      
