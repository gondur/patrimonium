// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var rezeptionist_talk = true ;
var wentUpstairs = false ;
var GuestInvCnt = 0 ;
var isDistracted = false ;
var napoleon = 0 ;
var WomanDrive = 0 ;

event enter {  
	
  backgroundImage   = hotelrezeption_image ;
  backgroundZBuffer = hotelrezeption_zbuffer ;
  path              = Hotelrezeption_path ; 
  
  womanDrive = 0 ;
  
  Rezeptionist.caption = null ;
  
  start AnimateRezeptionist ;
  start AnimateGuest ;

  HotelCount++ ;      
  
  Ego:
   visible = true ;  
  if (PreviousScene == Hotelgang) {
   positionX = 796 ;
   positionY = 182 ;
   scrollX = 160 ;
   delay transitionTime ;
   walk (729,280) ;
  } else {   	  
   positionX = 115 ;
   positionY = 294 ;  
   scrollX = 0 ;
   face(DIR_SOUTH) ;
   if (HotelCount == 1) IntroTalk ; else 	  
   if (lastScene == Vorhotel) {
     jukeBox_Stop ;
     jukeBox_Enqueue(Music::BG_Hotel_ogg) ;
     jukeBox_Shuffle(true) ;
     jukeBox_Start ;
   }	   
  } 
    
  start RezeptionistTalk ;  
  
  if (previousScene == VorSamTec and OutsideChefCount == 1 and TalkedToWonciek == false) {
   forceHideInventory ;
   Ego:
    walk(797,181) ;
   doEnter(Hotelgang) ;
   return ;
  }
  
  clearAction ; 
  
  forceShowInventory ;
  
}

script GastSmoke {
 forceHideInventory ; 
 Ego:
  "Gern geschehen."
 delay 20 ;
  "Ich gehe dann mal."
 Gast:
  "Man sieht sich!"
 Ego:
 
 if (Tuerzu.visible) {
  walk(150,310) ;
  turn(DIR_NORTH) ;
  EgoStartUse ;    
  start soundBoxPlay(Music::Tuerauf_wav) ;
  tuer.visible = true ;
  tuer.clickable = true ;    
  tuerzu.visible = false ;   
  if (MasterKeyAtWall.getField(0) != 2) MasterKeyAtWall.enabled = false ;    
  draussen.StdEvent = 0 ; 
  EgoStopUse ;	 
 }
	 
 walk(111,294) ;	 
 delay 5 ;
 GuestEvicted = 2 ;
 doEnter(VorHotel) ;
}

script IntroTalk {
 rezeptionist_talk = false ;
 forceHideInventory ;
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;
  delay 5 ;
  visible = false ;
 Julsitzt:
  backgroundZBuffer = 0 ;
  visible = true ;
  delay 5 ;
  "Hi!"
  delay 2 ;
 if (phonedHotel) {
  "Ich hatte angerufen."
  delay 2 ;
  "Ist Herr Wonciek gerade hier?"
 Rezeptionist:
  delay 4 ;
  "Wer?"
 Julsitzt:
  delay 4 ;
  "Peter Wonciek."
 } else {
  Julsitzt:
   "Sie haben doch einen Gast namens Peter Wonciek, oder?"
  Rezeptionist:
   "Ja, das ist richtig."
  delay 2 ;
  Julsitzt:
  "Ist Herr Wonciek gerade hier?"
 } 
 jukeBox_Stop ;
 jukeBox_Enqueue(Music::BG_Hotel_ogg) ;
 jukeBox_Shuffle(true) ;
 jukeBox_Start ; 
 Rezeptionist:
  delay 4 ;
  "Nein."
  "Er hat das Hotel eben verlassen."
 Julsitzt:
  delay 2 ;
  "Wissen Sie, wann er wieder kommt?"
 Rezeptionist:
  delay 2 ;
  "Nein, keine Ahnung."
 Julsitzt:
  delay 2 ;
  "Schade. Jedenfalls br#uchte ich dann noch ein Zimmer."
 Rezeptionist:
  delay 4 ;
  "Es tut mir Leid, aber alle Zimmer sind momentan belegt."
  delay 2 ;
 Ego:
  "Verdammt."
  delay 4 ;
 Julsitzt:  
  visible = false ;
  backgroundZBuffer = hotelrezeption_zbuffer ;  
 Ego:  
  visible = true ;
  delay 10 ;
  turn(DIR_EAST) ;
 delay 20 ;
  start turn(DIR_NORTH) ;
  "Wer ist dieser Mann dort dr]ben?"
  delay 4 ;
 Rezeptionist:
  "Das ist Rafael Gonzales."
  delay 4 ;
 Ego:
  "Ein Deutscher?"
  delay 4 ;
 Rezeptionist:
  "Ja, er hat das Zimmer neben Ihrem Freund."
  delay 4 ;
 Ego:
  "Verstehe."
  "Ich komme wieder."
 Rezeptionist:
 delay 10 ;
  "Falls Sie Herrn Wonciek besuchen wollen..."
  "...wenn er wieder da ist..."
  "...die Treppe hoch und dann rechts."
 delay 5 ; 
 
 start {  Rezeptionist.say("Bis bald.") ;  }
 
 Ego: 
  walk(469,330) ;
  face(DIR_SOUTH) ;
  delay 23 ;
  "Ich ben[tige auf jeden Fall ein Zimmer hier im Hotel f]r meinen weiteren Aufenthalt."
  "Vielleicht schaffe ich es irgendwie, den Mann dort zur Abreis zu ]berreden."
  
 rezeptionist_talk = true ;
 forceShowInventory ;
 clearAction ;
}


/* ************************************************************* */

object Zeitung {
 setAnim(Zeitung_image) ;	
 setPosition(598,248) ;
 class = StdEventObject ; 
 StdEvent = LookAt ; 
 setClickArea(2,2,37,22) ;
 absolute = false ;
 clickable = true ;
 enabled = (GuestEvicted == 1) and (! zeitung.getField(0)) ;
 visible = (GuestEvicted == 1) and (! zeitung.getField(0)) ;
 name = "Zeitung" ;
}

event WalkTo -> Zeitung {
 clearAction ;
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  	
}

event Take -> Zeitung {
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 Zeitung.visible = false ;
 Zeitung.enabled = false ;
 Zeitung.setField(0, true) ;
 takeItem(Ego, Newspaper) ;
 EgoStopUse ; 
 takeItem(Ego, Pinupkalender) ;
 "In der Zeitung war ein Pinup-Kalender."
 clearAction ; 
}

event LookAt -> Zeitung {
 clearAction ;
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  	
  "Die Zeitung, die Gonzales las." 
}


/* ************************************************************* */

object Rezeptionist {
 setAnim(rezeptionist_sprite) ;	
 setPosition(344,67) ;
 class = StdEventObject ; 
 StdEvent = TalkTo ; 
 setClickArea(6,7,50,112) ;
 animMode = ANIM_STOP ; 
 autoAnimate = false ; 
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 captionwidth = 520 ;
 captionX = GetSpriteFrameWidth(rezeptionist_sprite,0) / 2 + 60 ;
 captionX = 25 ;
 captionY = 5 ;
 captionColor = COLOR_CONCIERGE ;
 captionBase = BASE_ABOVE ;
 name = "Rezeptionist" ;
}

script AnimateRezeptionist {
 activeObject = Rezeptionist ;
 killOnExit = true ;
 int i = 0 ;
 frame = 1 ;

 loop {
  if animMode == ANIM_STOP {
   if isdistracted { 
    frame = Random(2) ;
    delay(Random(30)) ;
   } else {   
    if (Ego.positionX <= 400) { frame = 3 ; } else { frame = 1 ; }
   }
   delay(1) ;
  } else if animMode == ANIM_TALK {
    if (Ego.positionX > 400) {
     if (frame != 0 and frame != 1) frame = 0 ;
     if (random(3)==1)
      if (frame == 0) frame = 1 ;
       else frame = 0 ;	    
    } else {
     if (frame != 3 and frame != 2) frame = 2 ;
     if (random(3)==1)
      if (frame == 3) frame = 2 ;
       else frame = 3 ;
     if (isdistracted) { frame=Random(2); delay(Random(30)) ;}
    }
    delay 1 + random(3) ;
  }
 } 
}

event WalkTo -> Rezeptionist {
 clearAction ;
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;  
}

static var sawNoseglasses = false ;

event LookAt -> Rezeptionist {
 clearAction ;
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;
 suspend ;
  say("Das ist der Hotelrezeptionist.") ;
 switch upCounter(2) {
   case 0:
     say("Er sieht irgendwie merkw]rdig aus, seine Nase wirkt etwas unecht.") ;
     delay 4 ;
     say("Moment mal...") ;
     delay 5 ;
     say("Ich glaube, er tr#gt eine dieser Nasenbrillen!") ;
   default: say("Er tr#gt eine Nasenbrille.") ;
 }
 if (sawDrStrangelove) say("H#tte ich auch so eine, w]rde ich diesem Dr. Seltsam #hnlicher sehen.") ;
 sawNoseglasses = true ;
 clearAction ;
}

event Cigarettes -> Rezeptionist {
 clearAction ;
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;
 suspend ;
 rezeptionist_talk = false ;  
  say("M[chten Sie eine Zigarette?") ;
 Rezeptionist.say("Nein, ich rauche nicht.") ;
 Rezeptionist.say("Au}erdem ist hier im Hotel das Rauchen strengstens untersagt!") ;
 rezeptionist_talk = true ;  
 clearAction ;
}

event Klappspaten -> Rezeptionist {
 rezeptionist_talk = false ; 	
 Ego: walk(432,267) ;
      turn(DIR_NORTH) ;
 Ego.say("Haben Sie schon von 'Operation Klappspaten' geh[rt?") ;
 EgoStartUse ;
 dropItem(Ego, Klappspaten) ;
 delay 19 ;
 takeItem(Ego, Klappspaten) ;
 EgoStopUse ;
 Rezeptionist.say("Guter Mann, ich schlie}e mich Ihrem Plan an.") ;
 Rezeptionist.say("Wann soll es losgehen?") ;
 delay 2 ;
 Ego.say("Wenn die Zeit reif ist.") ;
 rezeptionist_talk = true ;  
 clearAction ;
}

event optionContract -> Rezeptionist {
 clearAction ;
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;  
 suspend ;
 rezeptionist_talk = false ;  
  say("Haben Sie Interesse an #gyptischen Kulturg]tern?") ;
 delay 2 ;
 Rezeptionist.say("Nein, danke.") ;
 rezeptionist_talk = true ; 
 clearAction ;
}

event Use -> Rezeptionist {
 clearAction ;
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;  
  "Ganz sicher nicht."  
}

event Coins -> Rezeptionist {
 
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;
  "K[nnte ich Sie mit diesen M]nzen hier bestechen, mir ein Zimmer zu ]berlassen?"
 Rezeptionist.say("Nein. Die besten Dinge im Leben sind nicht die, die man für Geld bekommt.") ;
 clearAction ;
}

event TalkTo -> Rezeptionist {
 rezeptionist_talk = false ; 
 Ego:
  walk(432,267) ;
  turn(DIR_NORTH) ;
  delay 5 ;
  visible = false ;
 Julsitzt:
  backgroundZBuffer = 0 ;
  visible = true ;
		
 RezeptionistdialogEx ;
 
 Julsitzt:
  visible = false ;
 Ego:
  visible = true ;
  backgroundZBuffer = hotelrezeption_zbuffer ;
 rezeptionist_talk = true ;  
}

script RezeptionistTalk {	
  killOnExit = true ;
  rezeptionist_talk = true ;
  loop {     
   if (rezeptionist_talk) {
     delay (random(7)+3) * 23 + 43 ;
     if (rezeptionist_talk) 
      if (isdistracted) and (random(3) != 0) {
	if (Random(2) == 0) Rezeptionist.say("Eieieieiei...") ;
         else Rezeptionist.say("Fein fein fein...") ;
      } else Rezeptionist.say("Dumdidum...") ;
   } else delay 1 ;
  }  
} 

script RezeptionistdialogEx {
	
 Ego:	
 switch random(3) {
  case 0 : "Hallo!" 
  case 1 : "Guten Tag." 
  case 2 : "Hi." 
 } 

 if (currentAct == 2) {

  if ((GuestEvicted == 0) and (HasRoom == 0)) RD1 ;
   else if ((GuestEvicted == 1) and (HasRoom == 0)) RD2 ;
    else if ((GuestEvicted == 1) and (HasRoom == 1)) RD3 ;
	   
 } else RD4 ;
	
 clearAction ;		
}

/* ************************************************************* */

object tuerzu {
 setAnim(doorclosed_image) ; 
 setPosition(31,96) ;
 setClickArea(-1,-1,-1,-1) ;
 absolute = false ;
 clickable = true ;
 visible = false ;
 name = "Tuerzu" ;
}

/* ************************************************************* */

object MasterKeyAtWall {
 setAnim(MasterKeyAtWall_image) ;
 setPosition(156,153) ; 
 visible = true ;
 if (getField(0) == 2) enabled = tuerzu.visible ;
  else enabled = false ;
 clickable = true ;
 absolute = false ;
 if (getField(0) == 1) name = "Generalschl]ssel" ;
  else name = "Schl]ssel" ;
 setClickArea(0,0,14,19) ;
 if (getField(0) == 2) enabled = false ;
}

event WalkTo -> MasterKeyAtWall {
 clearAction ;
 Ego:
  walk(154,285) ;
  face(DIR_NORTH) ;
}

event LookAt -> MasterKeyAtWall {
 Ego:
  walk(154,285) ;
  face(DIR_NORTH) ;
 if (MasterKeyAtWall.getField(0) == 1) Ego.say("Hier h#ngt der Generalschl]ssel des Hotels.") ;
  else {
   say("Hier h#ngt ein kleiner Metallschl]ssel an der Wand.") ;
   say("Ich frage mich, f]r was er gut ist...") ;
  }
 clearAction ;	 
}

event Take -> MasterKeyAtWall {
 Ego:
 Walk (154,285) ;
 Face(DIR_NORTH) ;
 if (isdistracted) {
  MasterKeyAtWall.setField(0,2) ;	 
  EgoStartUse ; 
  MasterKeyAtWall.enabled = false ;
  takeItem(Ego,MasterKey) ;
  EgoStopUse ;
 } else {
  rezeptionist_talk = false ;
  EgoStartUse ;
  delay 1 ;
  Rezeptionist: "He! Finger weg!"
                "Der Generalschl]ssel geht Sie gar nichts an." 
  EgoStopUse ;
  MasterKeyAtWall:
   setField(0,1) ;
   name = "Generalschl]ssel" ;
  Face(DIR_EAST) ;
  
  switch upcounter(3) {
   case 2: "Ich muss versuchen den Kerl irgendwie abzulenken." // Puja
  } 
  rezeptionist_talk = true ;  
} 
 clearAction ;
} 

/* ************************************************************* */

object Tuer {
 setClickArea(135,112 ,218,284) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ; 
 name = "T]r" ; 
 class = StdEventObject ; 
 StdEvent = Use ; 
}

event Use -> tuer {
  if (tuerzu.visible == false) 
    TriggerObjectOnObjectEvent(close, tuer) ;
  else triggerDefaultEvents ;
}

event WalkTo -> tuer {
 clearAction ;
 Ego:
  walk (150,310) ;
  turn(DIR_NORTH) ; 
}

event LookAt -> tuer {
 clearAction ;
 Ego:
  walk (150,310) ;
  turn(DIR_NORTH) ;
  "Das ist die Eingangst]r des Hotels." 
  if (tuerzu.visible) say("Sie ist geschlossen.") ;
   else say("Sie ist ge[ffnet.") ;
}

event Close -> tuer {
  Ego:
  if (tuerzu.visible == true) 
    "Sie ist schon geschlossen." 
  else {  
    Walk (150,310) ;
    turn(DIR_NORTH) ;
    EgoStartUse ;
    start soundBoxPlay(Music::Tuerzu_wav) ;
    delay 6 ;
    tuer.visible = false ;
    tuer.clickable = false ;
    draussen.name = "T]r" ;    
    tuerzu.visible = true ;    
    if (MasterKeyAtWall.getField(0) != 2) MasterKeyAtWall.enabled = true ;
    draussen:
    class = StdEventObject ; 
    StdEvent= Use ; 
    EgoStopUse ;
  }
  clearAction ;
}

event Open -> tuer {
  Ego:
  if (tuerzu.visible == false)
    "Sie ist schon offen."
  clearAction ;
}

event Picklock -> Tuer {
 clearAction ;
 Ego:
  walk(150, 310) ;
  turn(DIR_NORTH) ;
  say("Diese T]r ist nicht abgeschlossen.") ;
}

/* ************************************************************* */

object draussen {
 setClickArea(48,119 ,127,281);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "vor dem Hotel" ; 
}

event Use -> draussen {
 triggerObjectOnObjectEvent(WalkTo, draussen) ;
}

event LookAt -> draussen {
 triggerObjectOnObjectEvent(LookAt, tuer) ;
}

event Open -> draussen {
  Ego:
  if (tuerzu.visible == false) 
    "Ruhe bitte." 
  else {
    walk(150,310) ;
    turn(DIR_NORTH) ;
    EgoStartUse ;    
    start soundBoxPlay(Music::Tuerauf_wav) ;
    tuer.visible = true ;
    tuer.clickable = true ;    
    tuerzu.visible = false ;   
    if (MasterKeyAtWall.getField(0) != 2) MasterKeyAtWall.enabled = false ;    
    draussen.StdEvent= 0 ; 
    EgoStopUse ;
  }
  clearAction ;
}

event Close -> draussen {
  Ego:
  if (tuerzu.visible == true) 
    "Sie ist schon zu."
  else
    "Ruhe bitte."  
  clearAction ;
}

event WalkTo -> draussen {
  clearAction ;
  Ego:
   walk(103,292) ;
  if (tuerzu.visible == false) {
    suspend ;
    if (HotelCount % 2 == 0 and ! isDistracted) { rezeptionist_talk = false ; Rezeptionist.say("Bis bald.") ; }
    doEnter(vorhotel) ;
  }
}

event Picklock -> draussen {
 triggerObjectOnObjectEvent(Picklock, Tuer) ;
}

/* ************************************************************* */

object ZimmerPflanze {
 setClickArea(0,159,43,314) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pflanze" ;
}

event WalkTo -> Zimmerpflanze {
 clearAction ;
 Ego:
  walk(75,320) ;
  turn(DIR_WEST) ;
}

event Take -> ZimmerPflanze {
 clearAction ;	
 Ego: 
  walk(75,320) ;
  turn(DIR_WEST) ;
  "Sie ist zwar h]bsch, ich mag sie aber nicht mit mir rumtragen." ;
} 

event LookAt -> ZimmerPflanze {
 clearAction ;	
 Ego:
  walk(75,320) ;
  turn(DIR_WEST) ;
  "Eine h]bsche Zimmerpflanze."
}

/* ************************************************************* */

object Fussabstreifer {
 setClickArea(66,282 ,177,318);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Matte" ;
}

event WalkTo -> Fussabstreifer {
 clearAction ;
 Ego:
  walk(190,300) ;
  turn(DIR_WEST) ;
}

event LookAt -> Fussabstreifer {
 clearAction ;
 Ego:
  walk(190,300) ;
  turn(DIR_WEST) ;
  "Auf dem Fu}abstreifer steht auf Englisch 'Willkommen'."
}

/* ************************************************************* */

object Pflanze {
 setClickArea(264,187 ,301,232);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pflanze" ;
}

event WalkTo -> Pflanze {
 clearAction ;
 Ego:
  walk(215,297) ;
  turn(DIR_EAST) ;
}

event Use -> Pflanze {
 Ego:
  walk(215,297) ;
  turn(DIR_EAST) ;
  EgoUse ;
  "Na, wie gef#llt dir das?"   
 clearAction ;
}

event Take -> Pflanze {
 clearAction ;	
 Ego:
  walk(215,297) ;
  turn(DIR_EAST) ;
  "Ich m[chte sie nicht mit mir rumtragen."
}

event LookAt -> Pflanze {
 Ego:
  walk(215,297) ;
  turn(DIR_EAST) ;
  "Ein kleines Gew#chs."  
 clearAction ;
}

/* ************************************************************* */

object Stuhl {
 setClickArea(397,213,462,314) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Stuhl" ;
}

event WalkTo -> Stuhl {
 clearAction ;
 Ego:
  walk(432,267) ;
  turn(DIR_SOUTH) ;	
}

event Use -> Stuhl {
 clearAction ;  	
 Ego:
  walk(432,267) ;
  turn(DIR_SOUTH) ;
  switch random(3) {
   case 0 : "Jetzt nicht." ;
   case 1 : "Nein, ich habe zu tun." ;
   case 2 : "Momentan nicht." ;   
  }   
}

event Take -> Stuhl {
 clearAction ;
 Ego:
  walk(432,267) ;
  turn(DIR_SOUTH) ;
  "Ich m[chte ihn nicht mit mir herumtragen." 
}

event Push -> Stuhl {
 triggerObjectOnObjectEvent(Pull, Stuhl) ;
}

event Pull -> Stuhl {
 Ego:
  walk(432,267) ;
  turn(DIR_SOUTH) ;
  "Ich m[chte ihn nicht durch die Gegend schieben." 
 clearAction ;
}

/* ************************************************************* */

object Julsitzt {
 setAnim(Julstuhl_image) ;	
 setPosition(403,146) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = false ;
 captionwidth = 620 ;
 captionX = GetSpriteFrameWidth(Julstuhl_image,0) / 2 + 60 ;
 captionX = 25 ;
 captionY = -40 ;
 captionColor = COLOR_PLAYER ;
 name = "Julian" ;
}

/* ************************************************************* */

object Monitor {
 setClickArea(311,163 ,364,218);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Monitor" ;
}

event WalkTo -> Monitor {
 clearAction ;	
 Ego: 
  walk(344,292) ;
  turn(DIR_NORTH) ; 
}

event LookAt -> Monitor {
 clearAction ;	
 Ego: 
  walk(344,292) ;
  turn(DIR_NORTH) ;
  "Ein 17 Zoll Computermonitor mit einem kleinen Pl]sch-Marienk#fer."   
}

event Use -> Monitor {
 clearAction ;	
 Ego: 
  walk(344,292) ;
  turn(DIR_SOUTH) ;
  "Nicht wenn der Rezeptionist zusieht!"	
}

event Take -> Monitor {
 clearAction ;	
 Ego: 
  walk(344,292) ;
  turn(DIR_SOUTH) ;
  "Eigentlich m[chte ich keinen Monitor mit mir herumschleppen."		
  "Au}erdem h#tte der Rezeptionist wohl etwas dagegen."
}

event Push -> Monitor {
 triggerObjectOnObjectEvent(Pull, Monitor) ;
}

event Pull -> Monitor {
 Ego: 
  walk(344,292) ;
  turn(DIR_NORTH) ;
  "Das w#re bestimmt nicht so klug."
  "Wahrscheinlich m]sste ich den Schaden ersetzen."
 clearAction ;	
}

/* ************************************************************* */

object Lampe {
 setClickArea(426,153,468,192);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Lampe" ;
}

event WalkTo -> Lampe {
 clearAction ;
 Ego:
  walk(463,255) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Lampe {
 clearAction ;
 Ego:
  walk(463,255) ;
  turn(DIR_NORTH) ;
  "Interessantes Design."	
}

event Use -> Lampe { 
 clearAction ;  	
 Ego:
  walk(463,255) ;
  turn(DIR_NORTH) ;
  switch random(3) {
   case 0 : "Der Rezeptionist wird schon seinen Grund haben, warum er die Lampe angeschalten hat." ;
   case 1 : "Ich habe geh[rt, dass man in luziden Tr#umen..."
	     "...das Licht weder ein- noch ausschalten kann."
   case 2 : "Das bringt mich auch nicht weiter." ;
  }   
}


/* ************************************************************* */

object Zettel {
 setClickArea(398,176 ,426,190);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Notiz" ;
 class = StdEventObject ; 
 StdEvent= LookAt ; 
}

event WalkTo -> Zettel {
 clearAction ;	
 Ego:
  walk(440,257) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Zettel {
 clearAction ;	
 Ego:
  walk(440,257) ;
  turn(DIR_NORTH) ;
  "Arabisches Gekritzel."  
  "Kann ich nicht lesen."
}

event Take -> Zettel {
 Ego:
  walk(440,257) ;
  turn(DIR_NORTH) ;
  "Ich brauche ihn nicht."
 clearAction ;	
}

/* ************************************************************* */

object Broschuere {
 setClickArea(519,180 ,540,194);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Brosch]re" ;
}

event WalkTo -> Broschuere {
 clearAction ;	
 Ego: 
  walk(520,260) ;
  turn(DIR_NORTH) ;	
}

event LookAt -> Broschuere {
 Ego: 
  walk(520,260) ;
  turn(DIR_NORTH) ;
 if (napoleon == 0) {
  "Eine Brosch]re mit einigen Informationen ]ber das Hotel."
  "Es heisst, dass Napoleon Bonaparte hier gen#chtigt haben soll!"
  napoleon = 1 ;
 } else say("In der Brosch]re steht unter anderem, dass hier Napoleon Bonaparte ]bernachtet haben soll.") ;
 clearAction ;	  
}

event Take -> Broschuere {
 clearAction ;	
 Ego: 
  walk(520,260) ;
  turn(DIR_NORTH) ;	
  "Ich brauche sie nicht."
}

/* ************************************************************* */

object Statue {
 setClickArea(365,76 ,385,101);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Statue" ;
 class = StdEventObject ; 
 StdEvent= Take ; 
}

event WalkTo -> Statue {
 clearAction ;
 Ego:
  walk(378,276) ;
  turn(DIR_NORTH) ;  	
}

event LookAt -> Statue {
 Ego:
  walk(378,276) ;
  turn(DIR_NORTH) ;  
 delay 10 ;
  "Wenn das kein billiges Imitat ist, handelt es sich hier um eine etruskische Plastik aus Bronze." 
 clearAction ;
}

event Take -> Statue { 
 clearAction ;	
 Ego:
  walk(378,276) ;
  turn(DIR_NORTH) ;
  "Nein, das ist Hoteleigentum..." 
  "Zudem m]sste ich die Statue direkt vor den Augen des Rezeptionisten stehlen."
}

/* ************************************************************* */

object Topf {
 setClickArea(262,91 ,288,116);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "antiker Tontopf" ;
}

event WalkTo -> Topf {
 clearAction ;
 Ego:
  walk(260,310) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Topf {
 Ego:
  walk(260,310) ;
  turn(DIR_NORTH) ;
  "Ich w]rde sagen, 16. Jahrhundert." ;
 clearAction ;
}

event Take -> Topf {
 Ego:
  walk(260,310) ;
  turn(DIR_NORTH) ;
  "Nein, das ist Hoteleigentum..." 
  "Zudem m]sste ich den Topf direkt vor den Augen des Rezeptionisten stehlen."
 clearAction ;
}

/* ************************************************************* */

object Urkunde {
 setClickArea(191,127 ,243,175);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Urkunde" ;
 class = StdEventObject ; 
 StdEvent= LookAt ; 
}

event WalkTo -> Urkunde {
 clearAction ;
 Ego:
  walk(215,300) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Urkunde {
 Ego: 
  walk(215,300) ;
  turn(DIR_NORTH) ;  
  "Ein Qualit#tszertifikat nach DIN Standard, mit dem dieses Hotel ausgezeichnet wurde." 
 clearAction ;
}

event Push -> Urkunde {
 Ego: 
  walk(215,300) ;
  turn(DIR_NORTH) ; 
  "Da ist nichts dahinter." 
 clearAction ;
}

event Pull -> Urkunde {
 triggerObjectOnObjectEvent(Push, Urkunde) ;
}

/* ************************************************************* */

object Uhr {
 setClickArea(430,75 ,473,114);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Uhr" ;
}

event WalkTo -> Uhr {
 clearAction ;
 Ego:
  walk(463,255) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Uhr {
 clearAction ;	
 Ego:
  walk(463,255) ;
  turn(DIR_NORTH) ; 
  "Sie ist kaputt." 
}

/* ************************************************************* */

var floatAngleInc = FloatDiv(IntToFloat(1), IntToFloat(30*6)) ;

object Uhrzeiger {
  member Tick = 0 ;  
  member flipping = false ;
  member fliptick = 0 ;
  member Duration = 40 ;  
  member angle = IntToFloat(0) ;
  member Omega = FloatDiv(FloatMul(2.0,FLOAT_PI),inttofloat(Duration)) ;
  member PhiMax = FloatDiv(FLOAT_PI, 2.0) ;   
}

event animate Uhrzeiger {
 angle = FloatAdd(FloatMul(PhiMax,FloatSine(FloatMul(inttofloat(Tick),Omega))),FloatMul(Float_Pi,0.25)) ;
 Tick += 1 ;
 if (!flipping) and (Random(10) == 0) and (Tick % 20 == 0) { PhiMax = FloatMul(2.0,Float_Pi) ; fliptick = tick; flipping = true ; } else
 if (flipping) and ((Tick-fliptick) == 8) { PhiMax = FloatMul(FLOAT_PI, floatdiv(inttofloat(Random(4)+5), 10.0)) ; Tick = fliptick ; flipping = false ; }
}

event paint Uhrzeiger {
 drawRotatedFrame(Uhrzeiger_image, 0, 452-scrollX, 94-scrollY, 1000, 256, angle, 0, 0) ;		 
}

/* ************************************************************* */

object Bild {
 setClickArea(606,100 ,699,163);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Bild" ;
}

event LookAt -> Bild {
 Ego:
  walk(695,296) ;
  turn(DIR_NORTH) ;
 delay 10 ;
  "Vincent Van Gogh: 'Notte stellata', 1889."
  "Hervorragender K]nstler. Hervorragendes Werk." 
 clearAction ;
}

event Take -> Bild {
 Ego:
  walk(695,296) ;
  turn(DIR_NORTH) ; 
  "Ich glaube kaum, dass ich daf]r Verwendung finden w]rde."
 clearAction ;
}

/* ************************************************************* */

object KalenderWand {
 setPosition(563,147) ;
 setAnim(Pinupatwall_image) ;
 setClickArea(0,0,37,55) ;
 name = "Kalender" ;
 visible = true ;
 enabled = getField(0) ;
 absolute = false ;
 clickable = true ;
}

event LookAt -> Kalenderwand {
 Ego:
  walk(520,260) ;
  turn(DIR_EAST) ;
 "Ein Pinup-Kalender mit dem Playmate aus dem Monat Mai."
 clearAction ;
}

event Take -> KalenderWand {
 rezeptionist_talk = false ;	
 Ego:
  walk(520,260) ;
  turn(DIR_EAST) ;
 EgoStartUse ;
 Rezeptionist: "Das lassen Sie mal lieber bleiben!"
 EgoStopUse ;
 Ego: 
  turn(DIR_WEST) ;
  delay 4 ;
  "Aber das ist MEIN Kalender."
  "Ich habe ihn gefunden!"
 Rezeptionist: "Nein."
 Ego: "Doch!"
 Rezeptionist: 
  "Sie irren sich."
  delay 4;
  "Der Kalender liegt ja auf MEINEM Schreibtisch."
  "Also ist es meiner!"
  delay 4 ;
  "St[ren sie mich jetzt bitte nicht weiter beim Arbeiten."
 clearAction ;
 rezeptionist_talk = true ;
} 

event PinupKalender -> Rezeptionist {
 TriggerObjectOnObjectEvent(PinupKalender, Kaktus) ;
}

event PinUpKalender -> Kaktus {
 Ego:
 if (MasterKeyAtWall.getField(0) == 1) {
  turn(DIR_SOUTH) ;
  "Gute Idee."
  delay 4 ;
  "Das wird ihn sicherlich ablenken..."
  delay 4 ;
  walk(520,260) ;
  turn(DIR_EAST) ;
  
  EgoStartUse ;
  KalenderWand.visible = true ;
  KalenderWand.enabled = true ;
  KalenderWand.setField(0,1) ;
  dropItem(Ego, PinupKalender) ;
  isDistracted = true ;
  EgoStopUse ;
  clearAction ; 
 } else {
  "Ich w]sste nicht, wozu..."
  clearAction ;
 }
} 

/* ************************************************************* */

object Tuer2 {
 setClickArea(501,73,569,180);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Personalt]r" ;
 class = StdEventObject ; 
 StdEvent= Open ; 
}

event WalkTo -> Tuer2 {
 clearAction ;
 Ego:
  walk(520,236) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Tuer2 {
 Ego:
  walk(520,236) ;
  turn(DIR_NORTH) ;
  "Nur f]r das Personal." 
 delay 10 ;  
 clearAction ;
}

event Open -> Tuer2 {
  Ego:
   walk(520,236) ;
   turn(DIR_NORTH) ;
   "Ich komme nicht hinter den Thresen." 
  clearAction ;
}

/* ************************************************************* */

object Schluesselablage {
 setClickArea(260,112,406,158);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schl]sselablage" ;
}

event LookAt -> Schluesselablage {
 Ego: 
  walk(420,260) ;
  turn(DIR_NORTH) ;
  "Hier werden die Schl]ssel f]r die einzelnen Zimmer, die nicht belegt sind, aufbewahrt."
  if (guestEvicted == 1 and ! hasRoom) say("Ein Schl]ssel h#ngt dort.") ;  
   else say("Es h#ngt kein einziger Schl]ssel darin.") ;
 clearAction ;
}

event Take -> Schluesselablage {
 Ego:
  walk(420,260) ;
  turn(DIR_NORTH) ;
  "Ich kann mich doch nicht einfach selbst bedienen!"
  "Zumindest nicht vor den Augen des Rezeptionisten."
 clearAction ;
}

/* ************************************************************* */

object oben {
 setClickArea(722,82,800,270);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Treppenhaus" ;
}

event LookAt -> oben {
  Ego:
  "Hier geht es nach oben in den ersten Stock des Hotels." ;
  clearAction ;
}

event WalkTo -> Oben {
  clearAction ;
  Ego:
   walk(797,181) ; 
  if (wentupstairs == false) {
    rezeptionist_talk = false ;
    suspend ;
    Rezeptionist:
     "Halt!"
     delay 10 ;
    Ego:
     walk(762,269) ;
     turn(DIR_WEST) ;
    Rezeptionist:
     "Was glauben Sie dort oben zu tun?"
    Ego:     
     "Ich sehe mich nur ein bi}chen um..."
    Rezeptionist:
     "Alles klar."
    Ego:
     walk(797,181) ; 
    wentupstairs = true ;	  
    rezeptionist_talk = true ;
  }
  enter hotelgang ;
}

/* ************************************************************* */

object Lampen {
 setClickArea(183,9,605,25);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Lampen" ;
}

event LookAt -> Lampen {
 Ego:
  "Die Lampen erhellen das Zimmer und erzeugen durch das diffuse Licht eine angenehme Atmosph#re."
 clearAction ;
}

event Use -> Lampen {
 Ego:
  "Ich komme nicht ran."
 clearAction ;
}

/* ************************************************************* */

object Kaktus {
 setClickArea(586,150,604,194);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "stechende Pflanze" ;
}

event WalkTo -> Kaktus {
 clearAction ;
 Ego:
  walk(496,256) ;
  turn(DIR_EAST) ;
}

event LookAt -> Kaktus {
 Ego:
  walk(496,256) ;
  turn(DIR_EAST) ;
  "Das ist Louigi 'HaKa' IV."
 delay 5 ;
  "Bekannt aus dem ber]hmten Chuckwiser Werbespot." 
  "'Chuckwiser, das Bier, das auch Ihrem Kaktus schmeckt!'"
 clearAction ; 
}

event Take -> Kaktus {
 Ego:
  walk(496,256) ;
  turn(DIR_EAST) ;  
  "Nein."
  delay 10 ;
  "Er w]rde mich stechen." 
  clearAction ;
}

/* ************************************************************* */

object Gast {
 setAnim(Trump_sprite) ;	
 setPosition(618,165) ; 
 setClickArea(0,0,68,127) ; 
 absolute = false ;
 autoAnimate = false ;
 frame = 0 ;
 clickable = true ;
 enabled = (!GuestEvicted) ; 
 captionwidth = 400 ;
 captionX = GetSpriteFrameWidth(Trump_sprite,0) / 2 - 60 ;
 captionY = -40 ;
 captionColor = COLOR_HOTELGAST ;
 class = stdEventObject ; 
 stdEvent = talkTo ;   
 name = "Gast" ;
}

script AnimateGuest {
 activeObject = Gast ;
 killOnExit = true ;
 loop {
  if animMode == ANIM_STOP {
   if (frame > 3) frame = 0 ;
   if (random(15) == 0) {
    if (frame == 0) frame = 2 ;
     else frame = 0 ;
    if (animMode == ANIM_STOP) delay 5 ;
   } 
   if (animMode == ANIM_STOP) delay random(10)+5 ;
   if (random(4) == 0) {
    frame++ ;
    delay 2 ;
    frame-- ;
   }
   if (animMode == ANIM_STOP) delay random(10)+5 ;
  } else if (animMode == ANIM_TALK) {
   if (frame < 4)  frame = 4 ; 
   if (frame == 4 || frame == 9) {
    if (random(4) == 0) frame = 5 ;
    } else if (random(10) == 0) frame = 4 ;
   if (frame == 4) frame = 9 ;
    else if (frame == 9) frame = 4 ;
    else frame = random(4)+5 ;   
   delay (random(3))+1 ;
  }
  delay ;
  
 }
}

event Push -> Gast {
 clearAction ;
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  
 suspend ;
  say("Es w#re nat]rlich eine M[glichkeit, den Gast durch unaufh[rliches Dr]cken aus dem Hotel zu ekeln.") ;
  say("Aber vermutlich werde ich dann als erster herausgeworfen.") ;
 clearAction ;
}

event optionContract -> Gast {
 clearAction ;
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  
 suspend ;
  say("Haben Sie Interesse an #gyptischen Kulturg]tern?") ;
 delay 2 ;
 Gast.say("Nein, danke.") ;
 clearAction ;
}

event Shoe -> Gast {
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  
  if (did(give)) {
   "Er hat bestimmt kein Interesse an einem alten Schuh..."
  } else {
   "Nein."
  }
 clearAction ;
}

event Matches -> Gast {
 if did(give) {
   Ego:
    walk(706,295) ;
    turn(DIR_WEST) ;  
   EgoStartUse ;	 
   dropItem(Ego, Matches) ;
   GuestInvCnt++ ;
   EgoStopUse ;
   Gast:
    "Das sind aber nicht meine Streichh[lzer?"
   Ego:
    "Nein."
   Gast:
    "Gut. Danke."
   if (GuestInvCnt == 2) { GastSmoke ; return ; }
    else Gast.say("Jetzt fehlen mir nur noch Zigaretten.") ;
 } else triggerDefaultEvents ;
 clearAction ;
}

event Cigarettes -> Gast {
 if did(give) {
   Ego:
    walk(706,295) ;
    turn(DIR_WEST) ;  
   EgoStartUse ;	 
   dropItem(Ego, Cigarettes) ;
   GuestInvCnt++ ;
   EgoStopUse ;
   Gast:
    "Danke."   
   if (GuestInvCnt == 2) { GastSmoke ; return ; }
    else Gast.say("Jetzt fehlt mir nur noch Feuer.") ;
 } else triggerDefaultEvents ;
 clearAction ;
}

event LookAt -> Gast {
 Ego:
  "Das ist der andere Hotelgast, den der Rezeptionist erw#hnte."
  if (random(3) == 1) say("Er kommt mir irgendwie bekannt vor.") ;
 clearAction ;
}

event TalkTo -> Gast {
 static var talkFirst = true ;
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  
 rezeptionist_talk = false ;  
 
 if (talkFirst) {
   Ego: 
    "Hallo!"
    "Darf ich Sie kurz st[ren?"
   delay ;
   Gast:
    "Sie d]rfen. Wer sind Sie denn?"
   Ego:
    "Mein Name ist Hobler."
   delay ;
   Gast:
    "Gonzales. Rafael Gonzales." 
    "Nett Ihre Bekanntschaft zu machen."
   talkFirst = false ;
 } else switch random(4) {
   case 0: "Ich bin's wieder."
   case 1: "Da bin ich nochmal."
   case 2: "Hier bin ich wieder."
   default: "Ich bin zur]ck."
 }
 
 GD ;
 rezeptionist_talk = true ;
 clearAction ;
}

event WalkTo -> Gast {
 clearAction ;
 Ego:
  walk(706,295) ;
  turn(DIR_WEST) ;  	
}

/* ************************************************************* */

object Sessel {
 setClickArea(636,195 ,708,272);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Sessel" ;
}

event WalkTo -> Sessel {
 clearAction ;
 Ego:
  walk(741,270) ; 
  turn(DIR_WEST) ;
}

event Use -> Sessel {
 Ego:
  walk(741,270) ; 
  turn(DIR_WEST) ;
 if (!GuestEvicted) say("Besetzt.") ;
  else say("Jetzt nicht, ich habe zu tun.") ;
 clearAction ;  
}

event Pull -> Sessel {
 triggerObjectOnObjectEvent(Push, Sessel) ;
}

event Push -> Sessel {
 Ego:
  walk(741,270) ; 
  turn(DIR_WEST) ;
 EgoUse ;
  say("Er ist ganz sch[n schwer.") ; 
 clearAction ;
}

event LookAt -> Sessel {
 Ego:
  walk(741,270) ; 
  turn(DIR_WEST) ;
  "Darin k[nnen sich die G#ste entspannen."
  "Sieht gem]tlich aus."
 clearAction ;
}

/* ************************************************************* */

object Feuermelder {  
  priority = 255 ;
  setPosition(674,4) ; 
  setAnim(Feuer_sprite) ;
  stopAnimDelay = 10 ;
  setClickArea(0,0,25,25) ;
  autoAnimate = true ;
  frame = 1 ;
  visible = true ;
  enabled = true ;
  clickable = true ;
  absolute = false ;
  name = "Feuermelder" ;
}

event WalkTo -> Feuermelder {
 clearAction ;
 Ego: 
  walk(523,268) ;
  turn(DIR_EAST) ;	
}

event LookAt -> Feuermelder {
 Ego: 
  walk(523,268) ;
  turn(DIR_EAST) ;
  "Ein Feuermelder."
  if (GuestEvicted != 1) {
   delay 5 ;
   "Damit l#sst sich bestimmt was anstellen..."
  } 
 clearAction ;
}

event Matches -> Feuermelder {
 Ego:
  walk(523,268) ;
  turn(DIR_EAST) ;
  say("Der Rezeptionist w]rde doch sofort merken, dass ich das war.") ;
 clearAction ;
}

/* ************************************************************* */

script RD1 {
		
 loop {
  Ego:
  AddChoiceEchoEx(1, "Ist jetzt vielleicht ein Zimmer frei?", false) ;
  AddChoiceEchoEx(2, "Haben Sie Feuer?", false) if NeedPickLock ;
  AddChoiceEchoEx(3, "Was k[nnen Sie mir ]ber Gonzales erz#hlen?", false) ;
  AddChoiceEchoEx(4, "Stimmt es, dass Napoleon in diesem Hotel ]bernachtet hat?", false) if (napoleon == 1) ;
  AddChoiceEchoEx(5, "Man sieht sich.",false) ;
   
  var c = dialogEx () ;
  static var b = false ;
  
  switch c {
   case 1: 
    Ego: "Ist jetzt vielleicht ein Zimmer frei?"
    Rezeptionist: "Nein, tut mir Leid."    
   case 2:
    Ego: "Haben Sie Feuer?"
    Rezeptionist: "Ja. Jeder Gast erh#lt eine Gratis-Packung Streichh[lzer."
    Ego: "K[nnte ich so eine bekommen?"
    Rezeptionist: "Nein. Erst, wenn Sie sich hier ein Zimmer gemietet haben."
		  "So sind die Regeln."
   case 3:
    Ego: "Was k[nnen Sie mir ]ber Gonzales erz#hlen?"
    Rezeptionist: "Er kam vor drei Tagen hier an."
                  "Ich glaube, dass er in seinem Zimmer raucht, obwohl das verboten ist."
		  knowsSmoking = true ;
		  "Zu schade, dass wir dort oben keine Feuermelder installiert haben."
		  "Er ist mir wegen seiner Raucherei ein Dorn im Auge."
    delay 3 ;
    Ego: "Verstehe."
   case 4:
    napoleon = 2 ;
    RM ;
    return ;
   case 5:
    Ego: "Man sieht sich."    
    return ;
  }
 }
	
}

script RD2 {
	
 loop {
  Ego:
  AddChoiceEchoEx(1, "Ist jetzt vielleicht ein Zimmer frei?", false) ;
  AddChoiceEchoEx(2, "Stimmt es, dass Napoleon in diesem Hotel ]bernachtet hat?", false) if (napoleon == 1) ;
  AddChoiceEchoEx(3, "Warum sind die Toiletten oben geschlossen?", false) if (askAboutToilets == 1) ;
  AddChoiceEchoEx(4, "Man sieht sich.", false) ;
  var c = dialogEx () ;  
  
  switch c {
   case 1: 
    Ego: "Ist jetzt vielleicht ein Zimmer frei?"
    Rezeptionist: "Wie es der Zufall will..."
                  "...ist gerade eben ein Zimmer frei geworden."    
    Ego: "Das nehme ich."
    Rezeptionist: "F]llen Sie bitte dieses Formular aus."		
    delay 30 ;
    Ego: "Hier, bitte sehr."
    delay 2 ;
    Rezeptionist: "Bezahlt wird bei Abreise."    
                  "Allerdings m]ssen Sie mir Ihren Personalausweis abgeben."
    Ego: "Hier haben Sie ihn."		  
    delay 2 ;
    Rezeptionist: "Ich bedanke mich recht herzlich..."
                  "... und w]nsche Ihnen einen sch[nen Aufenthalt im ""L'Hotel"""
		  "Ihr Zimmer ist gleich links..."
		  "...wenn Sie die Treppe hochkommen."
		  "Hier ist Ihr Schl]ssel."
    takeItem(Ego, Hotelkey) ;
    Ego: "Okay. Danke sch[n."
    delay 2 ;
    Rezeptionist: "M[chten Sie noch eine Gratispackung Streichh[lzer?"    
    delay 2 ;
    Ego: "Immer her damit."    
    takeItem(Ego, Matches) ;
    HasRoom = true ;
    return ;
   case 2:
    napoleon = 2 ;
    RM ;
    return ;
   case 3:
    RM2 ;
   case 4:
    Ego: "Man sieht sich."    
    return ;
  }
 }


}

script RM2 {
 AskAboutToilets = 2 ;
 Ego:
  "Warum sind die Toiletten oben geschlossen?"
 Rezeptionist:
  "Toiletten? Oben?"
  "Wir haben keine Toiletten."  
 Ego:
  "Aber warum h#ngt oben ein Schild..."
 Rezeptionist:
  "H[ren Sie auf mich zu bel#stigen, oder ich rufe die Polizei."
  "Wir haben keine Toiletten."
 Ego: 
  "Schon verstanden."
}

script RM {
    Ego: "Stimmt es, dass Napoleon in diesem Hotel ]bernachtet hat?"
    Rezeptionist: "Haben Sie das in der Brosch]re gelesen?"
    Ego: "Ja, habe ich."
    Rezeptionist: "Was da drin steht, ist gelogen."
                  "Und das bemerken die meisten Menschen gar nicht."
		  "Sie verlieren einfach den Fokus auf die wichtigen Dinge im Leben."
		  delay 10 ;
		  "Zum einen m]ssen wir der Apartheid ein Ende setzen."
		  "Und das nukleare Wettr]sten stoppen, dem Terrorismus..."
                  "...und dem Hunger auf der Welt Einhalt gebieten."
		  "Eine starke nationale Verteidigung sicherstellen..."
                  "...die Ausbreitung des Kommunismus in Mittelamerika verhindern..."
		  "...auf eine L[sung des Nahostkonflikts hinarbeiten..."
		  "...millit#rische Eins#tze der USA in {bersee verhindern."
		  delay 10 ;
		  "Dabei darf man allerdings nicht unsere Probleme im eigenen Land aus den Augen verlieren."
		  "Bessere und erschwinglichere Pflegebetreuung f]r unsere #lteren Mitb]rger..."
		  "...Eind#mmung der Aids-Epidemie und Forschung nach einem Heilmittel..."
		  "...Kampf gegen die Umweltverschmutzung..."
		  "...entscheidende Verbesserung der Ausbildung an unseren Grundschulen und weiterf]hrenden Schulen..."
		  "...sch#rfere Gesetze, um gegen das organisierte Verbrechen und Drogenh#ndler durchgreifen zu k[nnen."
		  delay 10 ;
		  "Auch die Wirtschaftslage ist immer noch katastrofal."
		  "Es muss ein Weg gefunden werden, die Inflationsrate zu senken..."
		  "...und die Staatsverschuldung abzubauen."
		  "Zugleich m]ssen wir Wirtschaftswachstum und Unternehmensexpansionen f[rdern..."
		  "...UND energisch gegen die ]berh[hte Einkommenssteuer zu Felde ziehen..."
		  "...und die Zinsen niedrig halten, w#hrend wir mittelst#ndische Unternehmen f[rdern..."
		  "...und eine sch#rfere Kontrolle bei Fusionen und gro}en Firmen]bernahmen aus]ben."
		  delay 10 ;
		  "Aber wir d]rfen auch nicht unsere sozialen Probleme vernachl#ssigen."
		  "Wir m]ssen den Obdachlosen Nahrung und Obdach gew#hren, sowohl dem Rassenha}..."
		  "...entgegentreten und die B]rgerrechte verteidigen als auch..."
		  "...die Gleichberechtigung f]r Frauen durchsetzen."
		  "Zudem m]ssen wir den Zustrom illegaler Einwanderer kontrollieren."
		  "Wir m]ssen eine R]ckkehr zu den traditionellen moralischen Werten propagieren..."
		  "...und Drogen, Sex und Gewalt in Fernsehen, Film und Musik aufs entschiedenste entgegentreten."
		  "Vordringlichstes Ziel aber ist..."
		  "...in den jungen Menschen gesellschaftliches Verantwortungsbewu}stsein zu wecken..."
		  "...anstatt schn[des Anspruchsdenken zu f[rdern."
		  
    delay 23+5*3 ;
    Ego: "Hat jetzt Napoleon hier ]bernachtet oder nicht?"		
         "Das w#re ja sensationell!"
    delay 23*2+5*3 ;
    Rezeptionist: "Sie haben gar nicht zugeh[rt, stimmt's?"
    delay 2 ;
    Rezeptionist: "Bitte gehen Sie jetzt."
}

script RD3 {
 loop {
  Ego:
  AddChoiceEchoEx(1, "Kennen Sie die Nummer der Auskunft?", false) ;
  AddChoiceEchoEx(2, "Stimmt es, dass Napoleon in diesem Hotel ]bernachtet hat?", false) if (napoleon == 1) ;   
  AddChoiceEchoEx(3, "Warum sind die Toiletten oben geschlossen?", false) if (askAboutToilets == 1) ;
  AddChoiceEchoEx(4, "Man sieht sich.", false) ;
  var c = dialogEx () ;  	
  
  switch c {
   case 1:
    Ego: "Kennen Sie die Nummer der Auskunft?"
    Rezeptionist: "Aber nat]rlich."
    SaySlow(TelToStr(TelNums[5],MaxTelLen), 9) ;
    Ego: "Danke."
    return ;
   case 2:
    napoleon = 2 ;
    RM ;
    return ;	
   case 3:
    RM2 ;
   case 4:    
    Ego: "Man sieht sich."
    return ;
  }	
 }
 
}

script RD4 {
 loop {
  Ego:
  
  addChoiceEchoEx(1, "Hat sich hier irgendwas getan als ich weg war?", false) ;
  addChoiceEchoEx(2, "Stimmt es, dass Napoleon in diesem Hotel ]bernachtet hat?", false) if (napoleon == 1) ;   
  addChoiceEchoEx(3, "Warum sind die Toiletten oben geschlossen?", false) if (askAboutToilets == 1) ;
  addChoiceEchoEx(4, "Wissen sie etwas ]ber ein stillgelegtes SamTec-Labor in der N#he vom Nil?", false) if (knowsMutated and not knowsDOTT) ;
  addChoiceEchoEx(5, "Kennen Sie die Nummer der Auskunft?", false) ;
  addChoiceEchoEx(6, "Haben Sie nicht zuf#llig so etwas wie eine Nasenbrille f]r mich?", false) if ((not hasItem(Ego, Nasenbrille)) and (sawDrStrangelove)) ;
  addChoiceEchoEx(7, "Man sieht sich.", false) ;
  var c = dialogEx () ;  	
  
  switch c {
   case 1:
    Ego: "Hat sich hier irgendwas getan als ich weg war?"
    delay 40 ;
    Rezeptionist: "Wie bitte?"
    delay 4 ;
    Ego: "OB SICH HIER IRGENDWAS GETAN HAT, ALS ICH WEG WAR?"
    delay 10 ;
    Rezeptionist: "Oh."
    delay 10 ;
    Rezeptionist: "Ich habe die Uhr an der Wand repariert."
    delay 5 ;
    Ego: "Gute Arbeit, das war dringend n[tig."
    delay 40 ;    
    Ego: "Ich geh dann mal."
    start {
     rezeptionist_talk = false ;
     delay 150 ;
     suspend ;
     delay 20 ;
     Rezeptionist.say("Was?") ;
     delay 40 ;
     Rezeptionist.say("Notiz an mich selbst:") ;
     delay 5 ;
     Rezeptionist.say("Ich sollte weniger in der Verdummungsmaschine abh#ngen...") ;
     delay 10 ;
     rezeptionist_talk = true ;
     clearAction ;
    }
    
    return ;
   case 2:
    napoleon = 2 ;
    RM ;
    return ;	
   case 3:
    RM2 ;
   case 4: 
    Ego: "Wissen sie etwas ]ber ein stillgelegtes SamTec-Labor in der N#he vom Nil?"
    Rezeptionist: "Ich bef]rchte, ich kann ihnen da nicht weiterhelfen."
   case 5:
    Ego: "Kennen Sie die Nummer der Auskunft?"
    Rezeptionist: "Aber nat]rlich."
    SaySlow(TelToStr(TelNums[5],MaxTelLen), 9) ;
    Ego: "Danke."
    return ;
   case 6:
    Ego: "Haben Sie nicht zuf#llig so etwas wie eine Nasenbrille f]r mich?"
    delay 2 ;
    Rezeptionist: "Ich sehe schon, mein Ruf eilt mir vorraus."
    delay 3 ;
    Rezeptionist: "Mit oder ohne Bart?"
    Ego: "Ohne."
    delay 3 ;
    Rezeptionist: "Mit oder ohne Augenbrauen?"
    Ego: "Ohne."
    delay 3 ;
    Rezeptionist: "Vollrand oder Teilrand?"
    Ego: "Teilrand."
    delay 3 ;
    Rezeptionist: "Metall oder Kunststoff?"
    Ego: "Kunststoff."
    delay 3 ;
    Rezeptionist: "Anti-Fog-System?"
    Ego: "Nicht n[tig."
    delay 3 ;
    Rezeptionist: "Antiallergene Gesichtsauflage?"
    Ego: "Bitte."
    delay 3 ;
    Rezeptionist: "UV-Filter?"
    Ego: "Gerne."
    delay 8 ;
    Rezeptionist: "Bitte sehr. Den Preis verrechne ich mit ihren Zimmerkosten."
    takeItem(Ego, Nasenbrille) ;
    Ego: "Vielen Dank!"
   case 7:    
    Ego: "Man sieht sich."
    return ;
  }	
 }
 
}


/* ************************************************************* */

static var knowsSmoking = false ;

script GD {
 static var GD1 = false ;	
 static var GD2 = false ;
 static var GD3 = 0 ;
 static var GD4 = false ;
 static var GD5 = false ;
 static var GD6 = false ;
 static var gaveMoney = false ;


  loop {
    addChoiceEchoEx(1, "Was machen Sie hier?", true) if (!GD1) ;
    addChoiceEchoEx(1, "Was machen Sie hier nochmal?", true) if (GD1) ;
    addChoiceEchoEx(2, "Erz#hlen Sie mir von der Zigarren-Konferenz.", true) if (GD2) ;
    addChoiceEchoEx(3, "F]r wieviele Tage haben Sie ihr Zimmer hier gebucht?", true) if (GD3==0) ;
    addChoiceEchoEx(3, "K[nnen Sie sich nicht ein anderes Hotel nehmen?", true) if (GD3==1) ;	    
    addChoiceEchoEx(3, "Kann ich etwas tun, damit Sie das Hotel verlassen?", true) if (GD3==2) ;
    addChoiceEchoEx(3, "Es gibt also nichts, das ich tun kann, damit Sie das Hotel verlassen?", true) if (GD3==3) ;	    	    
    addChoiceEchoEx(4, "Ich muss Ihnen leider mitteilen, dass die diesj#hrige 'Zig Kon' leider ausf#llt.", true) if ((GD3==3) and (!GD4)) ;	    	    	    
    addChoiceEchoEx(4, "Die 'Zig Con' f#llt aber wirklich aus!.", true) if ((GD3==3) and (GD4)) ;	    	    	    	    
    addChoiceEchoEx(5, "Was lesen Sie da?", true) if (!GD5) ;
    addChoiceEchoEx(6, "Kennen Sie zuf#llig einen etwas #lteren, kleinen Mann aus dem Hotel?", true) if (!GD6) ;
    addChoiceEchoEx(7, "Darf ich Ihnen eine Zigarette anbieten?", true) if (knowsSmoking and (!gaveMoney)) ;
    addChoiceEchoEx(8, "Woher kann ich Feuer bekommen?", true) if (needPickLock) ;	
    addChoiceEchoEx(11, "Ich muss weiter.", true) ;
    
    var c = dialogEx ;
    
    
    switch c {
      case 1:
        Gast.say("Ich vertreibe mir die Zeit bis morgen die 'Zig Kon' startet.") ;
	if (!GD1) {
	  if (!GD2) {
            Ego.say("Die 'Zig Kon'?") ;
            Gast.say("Ja, die Zigarren-Konferenz.") ;
	    GD2 = true ;
          }
	  Gast.say("Ich bin schon ganz aufgeregt.") ;
	  GD1 = true ;
        } 
      case 2:
        Gast.say("Die internationale Zigarren-Konferenz wird j#hrlich jedesmal in einem anderen Land veranstaltet.") ;
        Gast.say("Sie ist eine Zusammenkunft von Zigarren-Liebhabern aus aller Welt.") ;
        Gast.say("Dieses Jahr treffen wir uns hier in Kairo.") ;
	GDZ ;
      case 3:
	switch GD3 {
	  case 0:
	    Gast.say("F]r sieben Tage.") ;
            Gast.say("Zun#chst habe ich mir etwas die Stadt angesehen, heute ruhe ich mich etwas aus...") ;
	    if (GD2) Gast.say("...und morgen geht es auf die Konferenz.") ;
	     else {
	       Gast.say("...und morgen geht es auf die 'Zig Kon'.") ;
	       Ego.say("Die 'Zig Kon'?") ;
               Gast.say("Ja, die Zigarren-Konferenz.") ;
	       GD2 = true ;
	     }
	    GD3 = 1 ;
	  case 1:
            Gast.say("Warum denn das?") ;
            Ego.say("Weil hier ein Bekannter von mir wohnt und sonst keine Zimmer mehr frei sind.") ;
            Gast.say("Nein, tut mir leid. Ich bin sehr zufrieden mit dem 'L'Hotel'.") ;
	    GD3 = 2 ;
	  case 2:
	    Gast.say("Da g#be es durchaus etwas!") ;
	    markResource(Music::Franzmann_wav);	
            Ego.say("Ja? Was?") ;
            Gast.say("Tanzen Sie als dreik[pfiger Affe verkleidet auf dem Rezeptionstisch...") ;
            soundMasterVolume = VOLUME_MUTE ;
            soundBox.StartSound(Music::Franzmann_wav);	
            Gast.say("...und pfeifen Sie die franz[sische Nationalhymne.") ;
	    delay while soundBox.SoundIsPlaying ;
	    delay 1 ; 	    
	    soundMasterVolume = VOLUME_FULL ;
	    Rezeptionist.say("Wenn Sie DAS ernsthaft in Erw#gung ziehen...") ;
	    Rezeptionist.say("...bekommen Sie ein lebenslanges Hausverbot.") ;
	    unmarkResource(Music::Franzmann_wav);	
	    delay 12 ;
	    Ego.say("Schon gut.") ;
	    delay 5 ;
	    Ego.say("Ich passe sowieso nicht mehr in mein altes Kost]m.") ;
	    GD3 = 3 ;
	  default:
	    Gast.say("Nein.") ;
	}
      case 4:
	if (!GD4) {
	  Gast.say("Sie sind mir ja mal einer! Sie lassen wohl nicht locker, oder?") ;
	  GD4 = true ;
        } else {
	  Gast.say("Nietzsche sagte einst: 'Viele sind hartn#ckig in Bezug auf den einmal eingeschlagenen Weg, wenige in Bezug auf das Ziel.'") ;
	  Gast.say("Denken Sie dar]ber nach. Vielleicht bei einer guten Zigarre, denn dann haben Sie Ihren Kopf frei.") ;
        }
      case 5:
        Gast.say("Eine Tageszeitung.") ;
	Ego.say("Irgendetwas Interessantes?") ;
        Gast.say("Nicht mehr als das {bliche. Aber das Wetter soll sch[n bleiben.") ;
	GD5 = true ;
      case 6:
        Gast.say("Hmmmm... Ich glaube dass ich hier im Hotel hin und wieder jemanden gesehen habe auf den Ihre Beschreibung zutrifft.") ;
        Ego.say("Wann haben Sie ihn das letzte mal gesehen?") ;
        Gast.say("Vielleicht vor f]nf Minuten? Sie m]ssten ihn knapp verpasst haben.") ;
        Ego.say("So ein Pech aber auch! Wissen Sie, wann er wieder kommt?") ;
        Gast.say("Nein, keine Ahnung.") ;
	GD6 = true ;
      case 7:
	Gast.say("Aber gerne! Versuchungen sollte man nachgeben. Wer wei}, ob sie wiederkommen?") ;
	Gast.say("Nett, dass Sie fragen, ich bef]rchte der Rezeptionist hat das nicht gerne...") ;
	Gast.say("...wenn hier geraucht wird.") ;
	Gast.say("Aber eine Zigarette angeboten zu bekommen ist ja was anderes, oder?") ;
	delay 1 ;	
	Ego.say("Ich habe leider keine.") ;
	Gast.say("Na dann holen Sie uns doch schnell eine Packung.") ;
	Gast.say("Hier haben Sie etwas Kleingeld.") ;
	EgoStartUse ;
        takeItem(Ego, Coins) ;
	EgoStopUse ;
	Gast.say("Feuer br#uchte ich auch.") ;
	delay 5 ;
	NeedPickLock = true ;
	gaveMoney = true ;
        Ego.say("Ich gehe dann mal.") ;	
	Gast.say("Bis gleich!") ;
	return ;
      case 8:
	Gast.say("Jeder Hotelgast erh#lt eine Gratispackung Streichh[lzer beim Einchecken.") ;
	Gast.say("Deswegen ist mir dieses Hotel auch so sympathisch!") ;
	Gast.say("Meine Packung liegt leider oben in meinem Zimmer, und ich sitze gerade so bequem...") ;
	Gast.say("Fragen Sie doch mal den Rezeptionisten.") ;
      default:
	Gast:
	  "Auf wiedersehen."
	  if ((!needPicklock) and GD2) say("Vielleicht ja auf der Zig Kon!") ;
	return ;
    }
  }
}

script GDZ {
	
  loop {
  Ego:
  addChoiceEchoEx(1, "Was bietet diese Veranstaltung?", true) ;
  addChoiceEchoEx(2, "Sie sind also ein Zigarren-Liebhaber?", true)  ;
  addChoiceEchoEx(3, "Besuchen Sie die 'Zig Con' aus einem bestimmten Grund?", true)  ;
  addChoiceEchoEx(4, "Wie lange geht die Veranstaltung?", true)  ;
  addChoiceEchoEx(5, "Genug dar]ber.", true) ;
 
  var d = dialogEx ;  

  switch d {
    case 1: 
      Gast.say("Die Besucher erhalten kostenlose Zigarren und Accessoires, es finden Demonstrationen...") ;
      Gast.say("...im Zigarren-Drehen statt, es gibt Seminare, Live Entertainment, gutes Essen und Trinken.") ;
    case 2: 
      knowsSmoking = true ;
      Gast.say("Richtig kombiniert.") ;
      Gast.say("Offensichtlich sind Sie kein Kenner, denn sonst w#re Ihnen mein Name bestimmt ein Begriff.") ;
      Gast.say("Ich ver[ffentliche hin und wieder Artikel in angesehenen Zigarren-Zeitschriften wie 'Smokers Lounge' oder 'World of Cigars'.") ;
    case 3: 
      Gast.say("Ich referiere dort ]ber die den Einfluss von Lage, Boden und Mikroklima der Tabak-Anbaugebiete auf den Charakter der Zigarren.") ;
    case 4:
      Gast.say("Vier Tage.") ;
    default : return ;
  }
 }
}
