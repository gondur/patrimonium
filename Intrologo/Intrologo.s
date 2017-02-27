// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter { 
 InstallSystemInputHandler(&SystemInput_Handler) ;	
 
 Ego.visible = false ;
 backgroundImage = Logo_image ;
 backgroundZBuffer = 0 ;

 currentAct++ ;
 
 if (currentAct==1) InstallSystemInputHandler(&IntroPartOne_Handler) ;	
 
 Darkbar.enabled = false ;
 
 switch currentAct {
  case 2: AktSchriftzug.setAnim(Akt2_image) ;
  case 3: AktSchriftzug.setAnim(Akt3_image) ;
  case 4: AktSchriftzug.setAnim(Akt4_image) ;
  case 5: AktSchriftzug.setAnim(Akt5_image) ;
 } 
 
 jukeBox_Stop ;
 delay transitionTime ;
 jukeBox.shuffle = true ;
 jukeBox_Enqueue(Music::BG_Short8_mp3) ;
 jukeBox_Start ;
 jukeBox.shuffle = false ;
 
 delay 60 ;
 delay while (GetMusicPosition(jukeBox.CurRes) < GetDuration(jukeBox.CurRes)) ;
 delay 10 ;
 
 switch currentAct {
  case 1: doEnter(Introvorhaus) ;
  case 2: doEnter(Vorflughafen) ;
  case 3: doEnter(Ausgrabungsstelle) ;
  case 4: doEnter(Ausgrabungsstelle) ; 
  case 5: doEnter(Map) ;
 }
 
}

object AktSchriftzug {
 setPosition(212,225) ;
 setAnim(Akt2_image) ;
 visible = true ;
 enabled = (currentAct!=0) ;
}

