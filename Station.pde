class Station{
  
  String name;
  int line, id, textPos;
  float x, y;
  color col;
  boolean endLine = false;
  
  Station nextStation = null, prevStation = null;
  Train eastBoundTrain, westBoundTrain;
  
  Station(String name, float x, float y, int line, int id, color col, int textPos){
    
    this.name = name;
    this.x = x;
    this.y = y;
    this.line = line;
    this.id = id;
    this.col = col;
    this.textPos = textPos;
  }
  
  void assignNextStation(Station st){
    
    nextStation = st;  
  }
  
  void assignPrevStation(Station st){
    
    prevStation = st;  
  }
  
  
  void markAsEndLine(){
   
    endLine = true;
  }
  
  void show(){
    
    stroke(0);
    strokeWeight(1);
    fill(col);
    ellipse(x, y, 17, 17);
    
    fill(0);
    textSize(16);
    
    float textX = x, textY = y;
    
    switch(textPos){
      //up right
      case 0:
        textY -= 13;
      break;      
      
      //down right
      case 1:
        textY += 23;
      break;
      
      //up left
      case 2:
        textY -= 13;
        textX -= textWidth(name);
      break;
      
      //down left
      case 3:
        textY += 23;
        textX -= textWidth(name);      
      break;
      
    }
    
    text(name, textX, textY);
    
    fill(50, 255, 50);
    
    if(westBoundTrain != null)
      text("<", x, y - 6);
      
    if(eastBoundTrain != null)
      text(">", x, y + 17);
  }
  
  void setTrainWestbound(Train t){
    
    westBoundTrain = t;
    println(name + " set westbound by " + t.id);
  }
  
  void setTrainEasbound(Train t){
    
    eastBoundTrain = t;
    println(name + " set eastbound by " + t.id);
  }
  
 void resetTrainWestbound(){
    
    westBoundTrain = null;
    println(name + " reset westbound");
  }
  
  void resetTrainEastbound(){
    
    eastBoundTrain = null;
    println(name + " reset eastbound");
  }
  
}
