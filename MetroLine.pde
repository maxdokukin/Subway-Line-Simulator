  class MetroLine{
  
  int stationNum = 10;
  int tonnelNum = (stationNum - 1) * 2;
  int trainNum = 18;
  
  String name;
  int lineNum;
  color col;
  Station stations [] = new Station[stationNum];
  Tonnel tonnels[] = new Tonnel[tonnelNum];
  Train trains[] = new Train[trainNum];
  
  MetroLine(String name, int lineNum, color col){
    
    this.name = name;
    this.lineNum = lineNum;
    this.col = col;
    //name // x //y //id //line num // color //text placement 
    stations[0] = new Station("Бауманская", 50, 50, 0, lineNum, col, 0);
    stations[1] = new Station("Менделеевская", 200, 200, 0, lineNum, col, 3);
    stations[2] = new Station("Ленинский проспект", 350, 200, 0, lineNum, col, 0);
    stations[3] = new Station("Маяковская", 550, 250, 0, lineNum, col, 3);
    stations[4] = new Station("Тёплый Стан", 650, 200, 0, lineNum, col, 1);
    stations[5] = new Station("Профсоюзная", 750, 100, 0, lineNum, col, 0);
    stations[6] = new Station("Университет", 950, 100, 0, lineNum, col, 0);
    stations[7] = new Station("Кунцевская", 1100, 150, 0, lineNum, col, 0);
    stations[8] = new Station("Студенческая", 1200, 200, 0, lineNum, col, 3);
    stations[9] = new Station("Октябрьская", 1350, 100, 0, lineNum, col, 2);
    
    
    stations[0].markAsEndLine();
    stations[stationNum - 1].markAsEndLine();
    
    
    //assign prev and next stations
    for(int i = 0; i < stationNum - 1; i++){
      
      stations[stationNum - i - 1].assignPrevStation(stations[stationNum - i - 2]); //prev station
      stations[i].assignNextStation(stations[i + 1]); //next station
    }
    
    //generate tonnels
    //  Tonnel(Station startStation, Station endStation, float length, float startX, float startY, float endX, float endY, color col){

      for(int i = 0; i < stationNum - 1; i++){
        tonnels[i] = new Tonnel(i,
                                stations[i], 
                                stations[i].nextStation, 
                                calculateDistBtw(stations[i], stations[i].nextStation), 
                                stations[i].x, stations[i].y + 6, 
                                stations[i].nextStation.x, 
                                stations[i].nextStation.y + 6, 
                                color(255, 0, 0));
      }
      
      //back tonnels generation
      for(int i = stationNum - 1; i > 0; i--){
        tonnels[tonnelNum - i] = new Tonnel(tonnelNum - i, //<>//
                                stations[i], 
                                stations[i].prevStation, 
                                calculateDistBtw(stations[i], stations[i].prevStation), 
                                stations[i].x, stations[i].y - 6, 
                                stations[i].prevStation.x, 
                                stations[i].prevStation.y - 6, 
                                color(0, 0, 255));
      }
      
      //asign next tonnels
      for(int i = 0; i < tonnelNum - 1; i++)
        tonnels[i].assignNextTonnel(tonnels[i + 1]);
        
      tonnels[tonnelNum - 1].assignNextTonnel(tonnels[0]);
      
      
      
      //generate trains
      //Train(int id, Station oSt, Station dSt, Station tSt, Tonnel ct, float maxSpeed, float maxAcc){

      trains[0] = new Train(0, stations[0], stations[1], stations[stationNum - 1], tonnels[0], 20, 1.3);
      trains[1] = new Train(1, stations[1], stations[2], stations[stationNum - 1], tonnels[1], 20, 1.3);
      trains[2] = new Train(2, stations[2], stations[3], stations[stationNum - 1], tonnels[2], 20, 1.3);
      trains[3] = new Train(3, stations[3], stations[4], stations[stationNum - 1], tonnels[3], 20, 1.3);
      trains[4] = new Train(4, stations[4], stations[5], stations[stationNum - 1], tonnels[4], 20, 1.3);
      trains[5] = new Train(5, stations[5], stations[6], stations[stationNum - 1], tonnels[5], 20, 1.3);
      trains[6] = new Train(6, stations[6], stations[7], stations[stationNum - 1], tonnels[6], 20, 1.3);
      trains[7] = new Train(7, stations[7], stations[8], stations[stationNum - 1], tonnels[7], 20, 1.3);
      trains[8] = new Train(8, stations[8], stations[9], stations[stationNum - 1], tonnels[8], 20, 1.3);
      
      trains[9] = new Train(9, stations[9], stations[8], stations[0], tonnels[9], 20, 1.3);
      trains[10] = new Train(10, stations[8], stations[7], stations[0], tonnels[10], 20, 1.3);
      trains[11] = new Train(11, stations[7], stations[6], stations[0], tonnels[11], 20, 1.3);
      trains[12] = new Train(12, stations[6], stations[5], stations[0], tonnels[12], 20, 1.3);
      trains[13] = new Train(13, stations[5], stations[4], stations[0], tonnels[13], 20, 1.3);
      trains[14] = new Train(14, stations[4], stations[3], stations[0], tonnels[14], 20, 1.3);
      trains[15] = new Train(15, stations[3], stations[2], stations[0], tonnels[15], 20, 1.3);
      trains[16] = new Train(16, stations[2], stations[1], stations[0], tonnels[16], 20, 1.3);
      trains[17] = new Train(17, stations[1], stations[0], stations[0], tonnels[17], 20, 1.3);
    
    
    println("generated stations:");
    for(Station st : stations){
      
      if(st.prevStation == null)
        println("null   " + st.name + "   " + st.nextStation.name);
        
      else if(st.nextStation == null)
        println(st.prevStation.name + "   " + st.name + "   null");
        
      else
        println(st.prevStation.name + "   " + st.name + "   " + st.nextStation.name); 
    }
    
    println("\ngenerated tonnels:");
    float totalMilage = 0;
    for(Tonnel t : tonnels){
      
      println("Tonnel id " + t.id + ". From " + t.startStation.name + " to " + t.endStation.name + ".  Length : " + t.length + "m");
      totalMilage += t.length;
    }
    println("Total milage : " + totalMilage/1000 + "km");
    
    //trains
    println("gerenated trains");
    for(Train t : trains){
      
      println("Train #" + t.id + ". Heading " + t.termStation.name + ". From " + t.originStation.name + " to " + t.destStation.name + ". Current tonnel " + t.currentTonnel.id);
    }
    
  }
  
  float progress = 0;
  int currentTonnel = 0;
  
  void show(){
     
    //draw tonnels
    for(Tonnel t : tonnels){
      t.show();
    }
    
    //draw stations and connecting line
    stroke(col);
    strokeWeight(2);
    for(int i = 0; i < stationNum; i++){
     
      if(i < stationNum - 1){
        
        //schematic line
        stroke(col);
        strokeWeight(8);
        line(stations[i].x, stations[i].y, stations[i + 1].x, stations[i + 1].y); 
      }
           
      stations[i].show();
    }
    
    for(Train t : trains)
      t.show();
  }
  
  void update(){
    
    for(Train t : trains){
      
      t.update();
      
      if(t.headingChanged){
        
        if(t.termStation.name.equals(stations[0].name))
          t.termStation = stations[stationNum - 1];
        
        else
          t.termStation = stations[0];
          
        t.headingChanged = false;
          
      }
    }
  }
  
  
  float calculateDistBtw(Station a, Station b){
    
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2)) * 10;
  }
  
  
  void checkMousePressed(float mx, float my){
    
    for(Train t : trains)
      if(dist(t.x, t.y, mx, my) <= 6)
        t.toggleInfo();
  }
  
  
  
  
  
  
}
