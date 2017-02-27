// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
  HideInventory ;
  Ego.visible = false ;
  backgroundImage = 0 ;
  backgroundZBuffer = 0 ;
  Jack.enabled = false ;
  path = 0 ;
  delay transitionTime ;
  
  delay 10 ;
  
  if (previousScene == VorHotel) {
    Narrator:
    "Einige Minuten sp#ter..."
    delay 30 ;
    doEnter(VorHotel) ;
  } else if (previousScene == Securitygang) {
    if (nextScene != 0) {  // Julian enters lab 1 or lab 2 for the first time	    
      Narrator:
      "W#hrenddessen..."
      delay 30 ;
      doEnter(Chefbuero) ;	    
    } else {               // Julian gets knocked down by Johnson
      Narrator:
      "Etwa eine halbe Stunde sp#ter..."
      delay 30 ;
      doEnter(Securitygef2) ;
    }
  } else if (previousScene == Dottrohre) {
    Narrator:
    "Einige Minuten sp#ter..."
    delay 30 ;
    doEnter(Dottrohre) ;	  
  } else {
    soundBoxStart(Music::Truck_wav) ;
    delay 15 ;
    Narrator.caption = "Eine kurze, unbequeme Reise sp#ter..." ;
    delay until(! soundBox.soundIsPlaying) ;
    Narrator.caption = null ;
    delay 10 ;
    if (previousScene == Truck) doEnter(Ausgrabungsstelle) ;
     else doEnter(Truck) ;
  }
}

object Narrator {
 setPosition(320,240) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 captionClick = false ;
 captionColor = COLOR_WHITE ;
}