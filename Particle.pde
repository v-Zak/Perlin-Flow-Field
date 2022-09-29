class Particle{
  int diameter = 1;
  PVector acc, vel, pos, ppos;
  float maxSpeed = 1;
  
  Particle(){
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    pos = new PVector(random(width), random(height));
    ppos = pos;
  }
  void update(){
    vel.add(acc);
    if (vel.magSq() > maxSpeed * maxSpeed){
      vel.setMag(maxSpeed);
    }    
    pos.add(vel);
    acc.mult(0);
    
    wrap();
    
    ppos = pos;
  }
  
  void show(){
  noStroke();
  fill((frameCount * 0.1) % 255,0,0,5);
  ellipse(pos.x, pos.y, diameter, diameter);
  }
  
  void applyFlow(PVector[] flowField){
    int x = floor(pos.x / spacing);
    int y = floor(pos.y / spacing);
    int index = x + y * columns;
    PVector f = flowField[index];
    addForce(f);
  }
  
  void addForce(PVector f){
    acc.add(f);
  }
  
  void wrap(){
    if (pos.x < 0){
      pos.x = width;
    } else if (pos.x > width){
      pos.x = 0;
    } 
    if (pos.y < 0){
      pos.y = height;
    } else if (pos.y > height){
      pos.y = 0;
    }
  }
}
