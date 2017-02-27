// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 backgroundImage   = Introwohnzimmer_image ;
 backgroundZBuffer = Introwohnzimmer_zbuffer ;
 path              = Introwohnzimmer_path ;
 
 switch Intro_Phase {
   case 1 : DoIntroPhaseOne ;
   default : doEnter(GameMenu) ;   
 }
} 

script DoIntroPhaseOne {   
  Jack:
   visible = false ;
   enabled = false ;  
  John:
   pathAutoScale = true ;
   path = Introwohnzimmer_path ;
   setPosition(520,284) ;   
   visible = true ;
   enabled = true ;
   face(DIR_SOUTH) ;	
  delay(3) ;
   walk(340,300) ;
   walk(105, 350) ;
  delay(5) ;
  soundBoxStart(Music::opendoor_wav) ;
  TueroffenLinks:
  visible = true ;
  delay(6) ;
  doEnter(Introkueche) ;
}

object TueroffenLinks {  
  visible  = false ;
  enabled  = true ;
  setPosition(23,116) ;
  setAnim(TuerlinksOffen_sprite) ;
}

object Tueroffenrechts {
  visible = true ;
  enabled = true ;
  setPosition(488,112) ;
  setAnim(TuerRechtsOffen_image) ;
}