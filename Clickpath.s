// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// ClickPath.s - Use path as clickarea
//   adapted from AGAST sample game    
// ----------------------------------   

const CLICKLISTBASE = 40 ;

script SetupClickList {
 SetField(CLICKLISTBASE+0, -1) ;
 SetField(CLICKLISTBASE+1, -1) ;
 SetField(CLICKLISTBASE+2, -1) ;
 SetField(CLICKLISTBASE+3, -1) ;
} 

script ClickList_Handler(x,y) {
 if (x < 200) {
	  return 33 ;
  if (Priority == PRIORITY_AUTO) 
  { return PositionY / 8 ; } 
  else
  { return Priority ; }
 } else { return -1 ; } 
}

script AddClickRect(X1,Y1,X2,Y2) {
 int i = CLICKLISTBASE ;
 var f = GetField(i) ;
 while (f != -1) { 
  i = i + 4; 
  f = GetField(i) ; 
 } 
 
 SetField(i+0,X1) ;
 SetField(i+1,Y1) ;
 SetField(i+2,X2) ;
 SetField(i+3,Y2) ;
 SetField(i+4,-1) ;
 return true ;
} 

script PointInClickList(x,y) {
 int i = CLICKLISTBASE - 4;
 int f = -1 ;
 while (f != -1) { 
  i = i + 4 ; 
  f = GetField(i) ; 
  if ((x >= f) and (y >= GetField(i+1)) and (x <= GetField(i+2)) and (y <= GetField(i+3)) ) return true ;  
 } 
 return false ;
} 