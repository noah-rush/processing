float x1 = 200;
float x2 = 100;
float x3 = 300;
float y1 = 200;
float y2 = 200;
float y3 = 300;
FloatList newxs;
FloatList newys;
float [][] inits = {{x1,y1}, {x2,y2}, {x3, y3}};

void setup(){
  size(500,500);
  background(255);
  newxs = new FloatList();
  newys = new FloatList();
}

void addvertex(){
  int rand = (int)random(3);
  
  newxs.append(inits[rand][0]);
  newys.append(inits[rand][1]);
}


void draw(){
  fill(255);
  alpha(100);
  rect(0,0,width,height);
  beginShape();
  for(int i =0; i < newxs.size(); i++){
   vertex(newxs.get(i),newys.get(i));
   newxs.set(i, newxs.get(i)));
   newys.set(i, newys.get(i)));
  } 
  endShape();
}

void keyPressed(){
  if(key ==' '){
    addvertex();
  }
}
