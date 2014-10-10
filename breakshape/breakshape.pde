void setup() {
  size(400, 400);
  smooth();
}
 
void draw() {
  background(255);
  fill(255, 0, 0);
  ellipse(width/2, height/2, 200, 200);
  fill(255, 255, 0);
  beginShape();
  vertex(0, 0);
  vertex(width, 0);
  vertex(width, height);
  vertex(0, height);
  vertex(0, 0);
  breakShape();
  vertex(mouseX-100, mouseY-100);
  vertex(mouseX-100, mouseY+100);
  vertex(mouseX+100, mouseY+100);
  vertex(mouseX+100, mouseY-100);
  endShape(CLOSE);
}
