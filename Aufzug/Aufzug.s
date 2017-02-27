// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------


event enter {
 Ego:
  enabled = false ;
  visible = false ;
  
 scrollX = 0 ;
  
 hideInventory ;
 backgroundImage = Aufzug_image;
 backgroundZBuffer = 0 ;
 path = 0 ;
 
 delay transitionTime ;
 
 delay 23 ;
 
 pushButton ;
 
 delay 23 ;
 
 Ego:
  visible = true ;
  enabled = true ;
 
 if (lastScene == Samtecempfang) doEnter(Vorchefbuero) ;
  else doEnter(Samtecempfang) ;   
 
} 

object Julian {
 setAnim(julani_sprite) ;	
 setPosition(284,99) ;
 autoAnimate = false ; 
 absolute = false ;
 enabled = true ;
 visible = false ;
 name = "Julian im Aufzug" ;
}

script pushButton {
 Julian:
  frame = 0 ;
  visible = true ;
  delay 3 ;
  frame++ ;
  delay 6 ;
  soundBoxStart(Music::Konsole_wav) ;
  delay 3 ;
  frame-- ;
  delay 3 ;
  visible = false ; 
}