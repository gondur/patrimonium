// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
  backgroundImage = Introschlafzimmer_image ;
  backgroundZBuffer = Introschlafzimmer_zbuffer ;

  switch intro_phase {
    case 1 : DoIntroPhaseOne ;
    default : doEnter(GameMenu) ;
  }                        
}

script DoIntroPhaseOne {  
  John:
   pathAutoScale = true ;
   path = Introschlafzimmer_path ;
   setPosition(394,146) ;
   face(DIR_SOUTH) ;
   visible = true ;
  John:
   walk(300,250) ;
   face(DIR_SOUTH) ;
   delay(13) ;
   face(DIR_EAST) ;
   delay(13) ;
   face(DIR_NORTH) ;
   delay(13) ;
   face(DIR_WEST) ;
   delay(13) ;
   face(DIR_SOUTH) ;
   delay(13) ;
   captionY = -160 ;
   "Er ist wirklich nicht da."
   "Daf]r wird er sich ]ber mein Willkommensgeschenk freuen!"
   delay(13) ;
   walk(410,110) ;
   face(DIR_SOUTH) ;
   delay(5) ;
   soundBoxStart(Music::closedoor_wav) ;
   TuerOffen:
    visible = false ;
   John:
    visible = false ;
   delay(13) ;
   intro_phase = 2 ;   
   doEnter(Introkueche) ;
}

object Anrufbeantworter {
  setPosition(300,80) ;
  absolute = false ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  captionColor = COLOR_WHITE ;
  name = "Anrufbeantworter" ;
}

object AnrufBeantworterAnimation {
  priority = 255 ;
  setPosition(472,278) ; 
  setAnim(anrufani_sprite) ;
  StopAnimDelay = 4 ;
  autoAnimate = true ;
  frame = 1 ;
  visible = true ;
  enabled = true ;
  clickable = false ;
  absolute = false ;
}

object TuerOffen {
  setPosition(375,39) ;	
  visible = true ;
  enabled = true ;
  absolute = true ;
  clickable = false ;  
  setAnim(tueroffen_image) ;
}

object FensterOffen {
  setPosition(90,68) ;
  enabled = true ;
  visible = true ;
  clickable = false ;
  setAnim(fensteroffen_image) ;
} 