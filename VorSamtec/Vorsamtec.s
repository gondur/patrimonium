// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {

 backgroundImage = Vorsamtec_image ;
 backgroundZBuffer = Vorsamtec_zbuffer ;
 
 SamTecOutsideCount++ ;
 
 if (OutsideChefCount > 0) jukeBox_Stop ;
 
 if (ladyDistracted != 1) ladyDistracted = 0 ;
 Ego:
 visible = false ;
 
 // cutscene: John & Jack enter SamTec headquarters
 
 if (SamTecOutsideCount == 1) {  
  John:
   path = 0 ;
   pathAutoScale = false ;
   scale = 340 ;
   walkingSpeed = 5 ;
   WalkAnimDelay = 6 ;
   setPosition(269-90,297) ;
   enabled = true ;
   visible = true ;
   face(DIR_EAST) ;
  Jack:
   path = 0 ;
   pathAutoScale = false ;
   scale = 340 ;
   walkingSpeed = 4 ;
   WalkAnimDelay = 6 ;
   setPosition(225-90,303) ;
   enabled = true ;
   visible = true ;   
   face(DIR_EAST) ;
  start {
    John:
     walk(460,290) ;  
     visible = false ;
     enabled = false ;
     walkingSpeed  = 8 ;
     walkAnimDelay = 3 ;
  }
  Jack:
   walk(460,290) ;
   visible = false ;
   enabled = false ;
   walkingSpeed  = 8 ;
   walkAnimDelay = 3 ;
  delay 23 ;
 }
 
 Ego:
 
 
 if (previousScene == Samtecempfang) {
  setPosition(490,300) ;
  pathAutoScale = false ;
  scale = 337 ;
  walk(460,290) ;
  path = Vorsamtec_path ;
  pathAutoScale = true ;
  visible = true ;
  
  if (OutsideChefCount == 1  and TalkedToWonciek == false) {
   walk(584,352) ;
   path = 0 ;
   pathAutoScale = false ;
   scale = 577 ;
   walk(700,380) ;
   pathAutoScale = true ;
   doEnter(Hotelrezeption) ;
  }	 
 } else {
  setPosition(700,380) ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 577 ;
  walk(584,352) ;
  path = Vorsamtec_path ;  
  pathAutoScale = true ;
  visible = true ;
 }
 
 forceShowInventory ;
 clearAction ;
 
} 

/* ************************************************************* */

object Glaswand {
 setPosition(388,206) ;
 priority = 37 ;
 setAnim(Glaswand_image) ;
 visible = true ;
 enabled = true ; 
}

/* ************************************************************* */

object Empfang {
 setClickArea(512,236,593,304) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Empfangsh#uschen" ;
}

event WalkTo -> Empfang {	
 clearAction ;
 Ego:
  walk(533,341) ;
  turn(DIR_EAST) ;
}

event LookAt -> Empfang {
 Ego:
  walk(533,341) ;
  turn(DIR_EAST) ;
  "Das Empfangsh#uschen ist nicht besetzt."
 clearAction ;	
}

/* ************************************************************* */

object Eingang {
 setClickArea(426,213,461,295) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Eingang" ;
 priority = 255 ;
}

event WalkTo -> Eingang {
 clearAction ;
 Ego:
  walk(460,290) ;
 suspend ;
  pathAutoScale = false ;
  path = 0 ;
  walk(490,300) ;  
  pathAutoScale = true ;
 doEnter(SamTecEmpfang) ;
}

event LookAt -> Eingang {
 Ego:
  walk(460,290) ;
  "Das ist der Eingang das Geb#udes."
 clearAction ;
}

/* ************************************************************* */

object Laterne {
 setClickArea(353,172,372,366) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Laterne" ;
}

event WalkTo -> Laterne {
 clearAction ;
 Ego:
  walk(373,348) ;
  turn(DIR_SOUTH) ;
}

event LookAt -> Laterne {
 Ego:
  walk(373,348) ;
  turn(DIR_SOUTH) ;
  "H]bsch."
 clearAction ;	
}

/* ************************************************************* */

object ZumFlughafen {
 setClickArea(0,195,38,243) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Taxi" ;
}

event WalkTo -> ZumFlughafen {
 clearAction ;
 Ego:
  walk(1,232) ;
  suspend ;
 doEnter(Taxikarte) ;
}

/* ************************************************************* */

object ZumHotel {
 setClickArea(597,233,641,361) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Taxi" ;
}

event WalkTo -> ZumHotel {
 clearAction ;
 Ego:
  walk(584,352) ;
  suspend ;
  path = 0 ;
  pathAutoScale = false ;
  walk(700,380) ;
  pathAutoScale = true ;
 doEnter(taxiKarte) ;	
}
