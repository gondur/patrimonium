// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter { 
 HideInventory ;
      jukeBox_Shuffle(false) ;
      jukeBox_Stop ;
    //  jukeBox_Enqueue(Music::BG_Action_mp3) ;

      jukeBox_Start ;   
 
 John:
  enabled = false ;
  visible = false ;
 Jack:
  enabled = false ;
  visible = false ;
 Ego:
  enabled = true ;
  DisableEgoTalk ;
  captionY = 0 ;
  setPosition(480,160) ;
  visible = false ;
 backgroundImage  = auto_image ;
 backgroundZBuffer = 0 ;
 jukeBox_stop ;
 delay transitionTime ;
 delay 23 ; 
 Ego:
  delay(3) ; 
  "Das habt ihr davon, wenn ihr euch mit einem JULIAN HOBLER anlegt..."
  delay(20) ;
 soundBoxStart(explode_wav) ;
 delay 20 ;
 StartExplosion ;
  delay(75) ;
  " Verflucht!  "
  "Was war das denn?"
  delay 10 ;
  " Ich h#tte doch meine Versicherungsbeitr#ge zahlen sollen... "
  delay 60 ;
  captionY = -150 ;
 enableEgoTalk ;
 doEnter(Flughafen) ;
}


script StartExplosion {
 start {
   explorani:
   frame = 0 ;
   visible = true ;	 
   explorani2:
   frame = 0 ;
   visible = true ;
   delay 1 ;
   explorani.frame = 1 ;
   explorani2.frame = 1 ;
   delay 2 ;
   explorani.frame = 2 ;
   explorani2.frame = 2 ;
   delay 2 ;
   explorani.frame = 3 ;
   explorani2.frame = 3 ;
   delay 3 ;
   explorani.frame = 4 ;
   explorani2.frame = 4 ;
   delay 3 ;
   explorani.frame = 5 ;
   explorani2.frame = 5 ;
   delay 2 ;
   explorani.frame = 6 ;
   explorani2.frame = 6 ;
   delay 3 ;
   explorani.frame = 7 ;
   explorani2.frame = 7 ;
   delay 3 ;
   explorani.frame = 8 ;
   explorani2.frame = 8 ;
 }   
}

object explorani {
 setPosition(82,197) ;
 autoAnimate = false ;
 setAnim(exploranim_sprite) ;
 visible = false ;
 enabled = true ;
 clickable = false ;
 absolute = false ;
}

object explorani2 {
 setPosition(432,17) ;
 autoAnimate = false ;
 setAnim(exploranim2_sprite) ;
 visible = false ;
 enabled = true ;
 clickable = false ;
 absolute = false ;
}