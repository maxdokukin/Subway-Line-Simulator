class Tonnel{
  
  Station startStation = null, endStation = null;
  
  float length;
  float startX, startY, endX, endY;
  int id;
  color col;
  
  Tonnel nextTonnel = null;
  
  Tonnel(int tonnelId, Station startStation, Station endStation, float length, float startX, float startY, float endX, float endY, color col){
    
    this.id = tonnelId;
    this.startStation = startStation;
    this.endStation = endStation;
    this.length = length;
    
    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;
    
    this.col = col;
  }
  
  
  
  void show(){
    
    strokeWeight(1);
    stroke(col);
    
    line(startX, startY, endX, endY);
  }
  
  void assignNextTonnel(Tonnel t){
    
    nextTonnel = t;
  }
  
  float getXmov(float progress){
    
    return startX  + ((endX - startX) * progress);
  }
  
  float getYmov(float progress){
    
    return startY + ((endY - startY) * progress);
  }
  
  float getProg(float dist){
    
    return dist/length;
  }
  
  float getRemainingDist(float prog){
   
    return length * (1 - prog);
  }
  
  
}
