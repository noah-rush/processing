void setup() {
  size(500, 500);
  noStroke();
  smooth();
}
 
void draw() {
  fill(255, 10); // semi-transparent white
  rect(0, 0, width, height);
 
  fill(random(255));
  ellipse(mouseX, mouseY, 100, 100);
}
