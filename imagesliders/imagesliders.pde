import processing.video.*;
PImage photo;
Movie movie;


void setup(){
  size(500, 500);
  updatesizes();
  background(0);
  photo = loadImage("philadelphia-skyline.jpeg");
  photo.resize(500,500);
  movie = new Movie(this, "Wunder Cams Video  Weather Underground (83).mp4");
  movie.loop();
}
IntList vals;
void draw(){
  background(0);
  for ( int i = 0; i <150; i++){
    image(movie, i * height/150, vals.get(i));
 
  }
  if(frameCount%8 ==0){
    updatesizes();
  }
}
    
    
    void updatesizes(){
      vals = new IntList();
      for ( int i = 0; i <150; i++){
        vals.append(int(random(377)+100));
      }
    }
        
      
