int LOADING_TIME = 5000;
int UNLOADING_TIME = 5000;
int BREAKING_DISTANCE = 200;

class Train{
  
  Station originStation, destStation, termStation, previousOrigin;
  Tonnel currentTonnel, nextTonnel;
  
  int id;
  float maxSpeed, maxAcc;
  float speed, axel = 1.3, x, y, prog, relevantLoc;
  boolean showInfo = false, headingChanged = false;
  
  TrainState state = TrainState.LOADING;
  
  
  Train(int id, Station oSt, Station dSt, Station tSt, Tonnel ct, float maxSpeed, float maxAcc){
    
    this.id = id;
    
    originStation = oSt;
    destStation = dSt;
    termStation = tSt;
    previousOrigin = oSt;
    currentTonnel = ct;
    
    this.maxSpeed = maxSpeed;
    this.maxAcc = maxAcc;
  }
  
  
  long loadStT = 0;
  long unloadStT = 0;
  
  void update(){
    
    switch (state){
      
      case LOADING :
        if(loadStT == 0){
          
          x = currentTonnel.getXmov(prog);
          y = currentTonnel.getYmov(prog);
          loadStT = millis();
          
            if(termStation.name.equals("Октябрьская"))
              originStation.setTrainEasbound(this);
              
            else
              originStation.setTrainWestbound(this);

        }
          
        else if(millis() - loadStT >= LOADING_TIME){
          
          loadStT = 0;
          state = TrainState.ACCELERATING;
          
          if(termStation.name.equals("Октябрьская"))
            originStation.resetTrainEastbound();  
            
          else
            originStation.resetTrainWestbound();  
            
            
          println("Train #" + id + " departuring from " + originStation.name + " to " +  destStation.name);
        }
      break;
      
      case ACCELERATING:
        if(speed + axel / 30 < maxSpeed)
          speed += axel / 30;
        
        else{
          
          state = TrainState.RIDING;
          speed = maxSpeed;
        }
      
        relevantLoc += speed / 30;
        prog = currentTonnel.getProg(relevantLoc);
    
        x = currentTonnel.getXmov(prog);
        y = currentTonnel.getYmov(prog);
      break;
      
      case RIDING: 
        relevantLoc += speed / 30;
        prog = currentTonnel.getProg(relevantLoc);
    
        x = currentTonnel.getXmov(prog);
        y = currentTonnel.getYmov(prog);
        
        if(currentTonnel.getRemainingDist(prog) <= BREAKING_DISTANCE)
          state = TrainState.BREAKING;

      break;
      
      case BREAKING:
        
        if(speed >= 8)
          speed -= (float) maxAcc / (float) 30;
          
        else if(currentTonnel.getRemainingDist(prog) <= 64 && (speed - (float) 0.5 / (float) 30) > 0.1)
          speed -= (float) 0.5 / (float) 30;
          
        
        relevantLoc += speed / 30;
        prog = currentTonnel.getProg(relevantLoc);
    
        x = currentTonnel.getXmov(prog);
        y = currentTonnel.getYmov(prog);      
        
        if(prog >= 1 || speed <= 0){
          
          state = TrainState.UNLOADING;
          speed = 0;
          
          println("Train #" + id + " arrived at " + destStation.name);
        }
        
      break;
      
      case UNLOADING:
      
        if(unloadStT == 0){
            
            unloadStT = millis();
            
            //println(termStation.name.equals("Октябрьская"));
                       
            if(!destStation.endLine){
              
              if(termStation.name.equals("Октябрьская"))
                destStation.setTrainEasbound(this);
                
              else
                destStation.setTrainWestbound(this);
            }
          }
            
          else if(millis() - unloadStT >= UNLOADING_TIME){
            
            unloadStT = 0;
            
            updateVars();
            
            state = TrainState.LOADING;
          }
      break;
      
    }
    
   
    
    
  }
  
  
  void show(){
    
    stroke(currentTonnel.col);
    strokeWeight(6);
    point(x, y);
    
    //train info
    if(showInfo){
      
      float textX = x + 5;
      
      if(textWidth(originStation.name + "->" + destStation.name) + textX > width)
        textX -= textWidth(originStation.name + "->" + destStation.name) - 50;
        
      fill(0, 255, 0);
      textSize(12);
      text("Speed : " + nf(speed * 3.6, 2, 1) + "km/h", textX, y + 5);
      text("State : " + state.toString(), textX, y + 20);
      text("Tonnel progress : " + nf(prog * 100, 3, 1) + "%", textX, y + 35);
      text("Heading : " + termStation.name, textX, y + 50);
      text(originStation.name + "->" + destStation.name, textX, y + 65);
    }
    
    
  }
  
  void updateVars(){
   
    currentTonnel = currentTonnel.nextTonnel;
    previousOrigin = originStation;
    originStation = destStation;
    //add null check
    destStation = currentTonnel.endStation;
    
    if(previousOrigin == destStation)
      headingChanged = true;
    
    prog = 0;
    relevantLoc = 0;    
  }
  
  void toggleInfo(){
    
    showInfo = !showInfo;
  }
  
  
}
