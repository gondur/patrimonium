// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
  backgroundImage = 0 ;
  backgroundZBuffer = 0 ;
  path = 0 ;
  switch intro_phase {
    case 1 : DoIntroPhaseOne ;
    default : doEnter(GameMenu) ;
  }
}

script DoIntroPhaseOne {
  MarkResource(smash_wav) ;
  delay(30) ;
  Narrator:	
  start PlaySound(smash_wav) ;		
  delay(3) ;
  "*KRACKS* !!!"
  delay(20) ;	
  UnMarkResource(smash_wav) ;
  doEnter(Introwohnzimmer) ;
}

object Narrator {
 setPosition(320,240) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 captionColor = COLOR_JOHNJACKSON ;
}