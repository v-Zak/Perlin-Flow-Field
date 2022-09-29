PVector[] flowField;
Particle[] particles = new Particle[10000];

boolean debug = false;

float scale = 0.1;
float magnitude = 0.01;

float zOffset = 0;
float zStep = 0.000001;

int spacing = 50;
int rows;
int columns;

int time, pTime, dTime;

void setup(){
  //colorMode(HSB);
  background(255); 
  size(1200,800, P2D);
  rows = height / spacing + 1;
  columns = width / spacing + 1;
  flowField = new PVector[rows * columns];
  
  for (int i = 0; i < particles.length; i++){
    particles[i] = new Particle();
  }
}

void draw(){   
  
  for (int y = 0; y < rows; y++){
    for (int x = 0; x < columns; x++){
      int index = x + y * columns;
      float angle = noise(x * scale, y * scale, zOffset) * TWO_PI;
      flowField[index] = PVector.fromAngle(angle).setMag(magnitude);
      zOffset += zStep;
    }
  }
  
  for (Particle p : particles){
    p.applyFlow(flowField);
    p.update();
    p.show();
  }
  
  if(debug){
    background(255); 
    for (int y = 0; y < rows; y++){
      for (int x = 0; x < columns; x++){
        int index = x + y * columns;
        strokeWeight(3);
        stroke(100,100,100,100);
        push();
        translate(x * spacing + spacing / 2, y * spacing + spacing / 2);
        rotate(flowField[index].heading());
        line(0, 0, spacing * 0.9, 0);
        pop();
      }
    }
    displayFrameRate();
  }
}

void displayFrameRate(){
  time = millis();
  dTime = time - pTime;
  int fps = floor(1000 / dTime);
  fill(255,0,0);
  textSize(25);
  text(fps, 10,30);
  pTime = time;
}

void mousePressed(){
  background(255);
}
