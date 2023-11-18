
int lineNum = 1;

MetroLine lines [] = new MetroLine[lineNum];

enum TrainState { LOADING, ACCELERATING, RIDING, BREAKING, UNLOADING }
  
void setup(){
  
  size(1400, 300);
  pixelDensity(2);
  frameRate(30);
  
  //draw grid
  /*
  stroke(0, 0, 255);
   for(int i = 0; i <= width; i+=50)
    line(i, 0, i, height);
    
  stroke(0, 255, 0);
  for(int i = 0; i <= height; i+=50)
    line(0, i, width, i);*/
      
  
  lines[0] = new MetroLine("Fleksovaya", 1, color(169, 186, 157));
  
}






void draw(){
  
  background(150);
  
  for(MetroLine l : lines){
    
    l.update();
    l.show();
  }
  
  
  
}


void mousePressed(){
  
  for(MetroLine l : lines){
    
    l.checkMousePressed(mouseX, mouseY);
  }  
}
