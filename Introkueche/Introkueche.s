// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
  backgroundZBuffer = Introkueche_zbuffer ;
  backgroundImage   = Introkueche_image ;
//  path              = Introkueche_path ;
  
  switch Intro_phase {
    case 1 : DoIntroPhaseOne ;
    case 2 : DoIntroPhaseTwo ;
    default : doEnter(GameMenu) ;
  }
}

script DoIntroPhaseOne {
  TuerLinksOffen:
   visible = true ;
  TuerRechtsOffen:
   visible = true ;
  John:
   pathAutoScale = false ;
   scale = 700 ;
   setPosition(638,305) ;
   visible = true ;
   walk(555,317) ;
   walk(230,300) ;
   face(DIR_WEST) ;
   delay(10) ;
   face(DIR_NORTH) ;
   delay(13) ;
   walk(308,268) ;
   face(DIR_NORTH) ;
   delay(15) ;
   walk(207,284) ;
   doEnter(Introschlafzimmer) ;
}

script DoIntroPhaseTwo {  
  John:
   visible = true ;
   path = 0 ;
   pathAutoScale = false ;
   scale = 700 ;
   setPosition(207,284) ;
   walk(308,268) ;
   face(DIR_NORTH) ;
  delay(23) ;
  StartHerdAnimation ;
  John:
   face(DIR_SOUTH) ;
   switch (random(2)) {
     case 0 : "HAHAHAHAHA!"
     case 1 : "HEHEHEHEHE!"
   }   
   "Das sollte dieses l#stige Problem beseitigen!"
  delay(5) ;
   walk(555,317) ;
   walk(638,305) ;
   visible = false ; 
  TuerRechtsOffen:
  soundBoxStart(Music::closedoor_wav) ;
   visible = false ;
  delay(66) ;
  doEnter(Introvorhaus) ; 
}

object TuerLinksOffen {
  if (intro_phase == 1) { visible   = true ; }
   else { visible = false ; }
  enabled   = true ;
  absolute  = true ;
  clickable = false ;
  setPosition(44,132) ;
  setAnim(tuerlinksoffen_image) ;
}

object HerdAnimation {
  visible   = false ;
  enabled   = true ;
  absolute  = false ;
  clickable = false ;
  setPosition(257,64) ;
  autoAnimate = false ;
  setAnim(herd_sprite) ;  
  setAnimFrameDelay(ANIM_STOP, 2) ;
}


script StartHerdAnimation {
  start {
    soundBoxStart(IntroKueche::Gas_wav) ; 
    killOnExit = true ;
    Herdanimation:
     visible = true ;
    delay 2 ;
     frame = 0 ;
    delay 2 ;
     frame = 1 ;
    delay 2 ;
     frame = 2 ;
    delay 2 ;
     frame = 3 ;
    delay 2 ;
    loop {
      frame = 4 ;
      delay 1 ;
      frame = 5 ;
      delay 1 ;
      frame = 6 ;
      delay 1 ;
      frame = 7 ;
      delay 1 ;
      frame = 6 ;
      delay 1 ;
      frame = 5 ;
      delay 1 ;
    }
  }
}

object TuerRechtsOffen {
  setPosition(547,128) ;	
  visible = true ;
  enabled   = true ;
  absolute  = true ;
  clickable = false ;
  setAnim(tuerrechtsoffen_image) ;
}
