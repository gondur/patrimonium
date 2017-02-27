// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------


event enter {
 static var firstABBenter = true ;
 Ego:
  enabled = false ;
  visible = false ;
  path = 0 ;
 forceHideInventory ;
 
 backgroundZBuffer = 0 ;
 
 if (firstABBenter) {
   backgroundImage = 0 ;
   delay transitionTime ;
   delay 10 ;
   Narrator:
    "W#hrenddessen, in einem SamTec-Konferenzraum..."
   delay 30 ;
   firstABBenter = false ;
   doEnter(ABBuero) ;
   finish ;
 }
 
 backgroundImage = ABbuero_image;
 
 delay(44) ; 
 
 soundBoxPlay(Music::Phone_Wav) ;
 delay(20) ;
 soundBoxPlay(Music::Phone_Wav) ;
 delay(5) ;
 soundBoxPlay(Music::Beep_Wav) ;
 delay(15) ;
 
 ABeantworter.enabled = true ; 
 JackVoiceAB:
  "Hallo Chef?"
  delay(15) ;
  "Bist du sicher, dass das die richtige Durchwahlnummer ist?"
  delay(5) ;
  
 JohnVoiceAB:
  "Nat]rlich."
  "B R A N D E R"
  "Steht doch dran."
  delay(10) ;
 
 JackVoiceAB:
  "Hallo Chef?"
  delay(20) ;
  "Hier ist Jack."
  "John ist auch hier."
 JohnVoiceAB:
 delay 5 ;
  "Hallo Chef."
  
 JackVoiceAB: 
  delay(15) ;
  "Wir haben Hobler unter die Erde gebracht."
  delay(5) ;
  
 JohnVoiceAB:
  "HEHEHEHEHEHE!"
 JackVoiceAB:
  "HAHAHAHAHAHA!"
 JohnVoiceAB:
  delay(5) ;
  "|hmm..."
  "Ist da jemand?"
  delay(14) ;
  
 JackVoiceAB:
  "Er ist in der Grabkammer eingesperrt."
  "Das wird ihm eine Lehre sein."
  delay(20) ;
 
 JohnVoiceAB:
  "Ist das eine 1 oder eine 7?"
  delay(15) ;
 JackVoiceAB:
  "Sieht eher aus wie eine 3..."
  "Verdammt."
  delay(10) ;
  "Diesmal darf ich w#hlen!"
 ABeantworter.enabled = false ;
 soundBoxPlay(Music::besetzt_Wav) ;
 delay(10) ;
 soundBoxPlay(Music::Beep_Wav) ;
 delay(35) ;
 
 doEnter(ChefBuero) ;
}


object JohnVoiceAB {
 positionX = 124 ;
 positionY = 193 ;
 captionY = -60 ;
 captionX = 60 ;
 clickable = false ;
 captionWidth = 400 ;	
 captionColor = COLOR_JOHNJACKSON ;
}

object JackVoiceAB {
 positionX = 124 ;
 positionY = 193 ;
 captionY = -60 ;
 captionX = 60 ;
 clickable = false ;
 captionWidth = 400 ;	
 captionColor = COLOR_JACKJOHNSON ;
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

object ABeantworter {
 enabled = false ;
 visible = true ;
 priority = 255 ;
 PositionX = 124 ;
 PositionY = 193 ;
 CaptionWidth = 400 ;
 CaptionColor = COLOR_ABPHONE ;
 captionY = -60 ;
 captionX = 100 ;
} 
/*
event paint ABeantworter {
 static int blink = 0 ;
  if (blink <= 10) {
   drawingColor = RGBA(255,00,00,130) ;
   drawingPriority = 255 ;
   drawRectangle(124,193,126,195) ;
  } 
  blink = blink + 1 ;
  if (blink >= 20) blink = 0 ;
} 
*/