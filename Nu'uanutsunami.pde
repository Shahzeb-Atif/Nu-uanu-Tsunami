//Cellular Automaton//
//Nu’uanu Tsunami//
//ICS4UI//
//Shahzeb Atif//

//Rate/speed that water travels, change variable for different speed//
float WaterProgressionRate = 5000/200; //200

//Initial value and arrays//
int n = 200;
float cellSize;
color[][] CurrentCell; 
color[][] NextCell;
boolean[][] RandCell;

//Island + 3 different water shades, colour is interchangeable//
color Island = color(136,69,19);
color Water = color(0,0,200);
color Water2 = color(0,0,255);
color Water3 = color(0,0,150);

//Island size, can change (15)//
int IslandSize = 15;

//Starting frame and Tsunami for upcoming statement, dont change these//
int frameOfStimulation = 10;
int Tsunami = 1;

//First Generation//
void firstGeneration(){
  int k = int((n-((float(IslandSize)/100.0)*n))/2);
  int m = int(n-((n-((float(IslandSize)/100.0)*n))/2));
  
  for(int j=0; j<n; j++){
    for(int i=0; i<n; i++){
      if(((j >= k && j <= m) && (i >= k && i <= m)))
        CurrentCell[j][i] = Island;
      
      else if(i == 0 || i == n-1 || j == 0 || j == n-1)
        CurrentCell[j][i] = Water;
        
      else
        CurrentCell[j][i] = Water2;
    }
  }
}

//Setup//
void setup(){
  //ScreenSize, changeable (550,450)//
  size(550,450);
  cellSize = (height-frameOfStimulation)/n;
  CurrentCell = new color[n][n];
  NextCell = new color[n][n];
  RandCell = new boolean[n][n];
  frameRate(frameRate);
  firstGeneration();
}

//Cell probability//
boolean CellProbability(int j,int i, float die){
  int a = int(random(0,die));
  if(a == 0)
    return true;
  
  else
    return false;
}

//Drawing//
void draw(){
  //Background colour, changeable (0,0,200)//
  background(0,0,200);
  
  //On screen text//
  fill(255);
  textSize(20);
  text("Nu’uanu Tsunami", 200, 20);

//Cells//  
  for(int j = 0; j < n; j++){
    for(int i = 0; i < n; i++) {
      float y = 2*frameOfStimulation + j*cellSize; //Dont change (2)//
      float x = 7*frameOfStimulation + i*cellSize; //Dont change (7)//
      
      fill(CurrentCell[j][i]);
      
      if(Tsunami == 1){ 
        for (int a = -1; a <= 1;a++){
          
          for (int b = -1; b <= 1; b++){
            
              try{
                
                if((CurrentCell[j+a][i+b] == Water) && (b!=0 || a!=0))
                  RandCell[j][i] = CellProbability(j,i, WaterProgressionRate);
              }
              catch(Exception e){
              }
          }
        }
        
        if (CurrentCell[j][i] == Water2){ 
          if(RandCell[j][i] == true)
            NextCell[j][i] = Water;
          
          else 
            NextCell[j][i] = CurrentCell[j][i];
        }
        
        else if (CurrentCell[j][i] == Island){ 
          
          if(RandCell[j][i] == true)
            NextCell[j][i] = Water3;
            
          else 
            NextCell[j][i] = CurrentCell[j][i];
        }
        
        else if(CurrentCell[j][i] == Water3)
          NextCell[j][i] = Water2;
          
        else
          NextCell[j][i] = CurrentCell[j][i];
          
      }
      noStroke();
      rect(x, y, cellSize, cellSize);
      CurrentCell[j][i] = NextCell[j][i];
    }
  }
}
