// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var door1locked = true ;
var door2locked = true ;
var tryOpenCnt = 0 ;

event enter {

  enableEgoTalk ;
  scrollX = 0 ;

  if (currentAct == 4) {
   door1locked = false ;
   door2locked = false ;
  }

  if (lastScene == VorHotel) {
   TuerA.setField(0, 0) ;
   TuerB.setField(0, 0) ;
  }

  TuerA.visible = TuerA.getField(0) ;
  TuerB.visible = TuerB.getField(0) ;
  
  if (previousScene == Securitygang) {
   scrollX = 0 ;
   nightVisionOff ;
   Jack.enabled = false ;
   John.enabled = false ;
   TuerA.visible = false ;
   TuerB.visible = false ;
  }
  
  Ego:
   pathAutoScale = true ;

  if (TuerA.visible) {
   backgroundImage = hotelgang2_image ;
   backgroundZBuffer = hotelgang2_zbuffer ;
   path = hotelgang2_path ;	  
  } else {
   backgroundImage = hotelgang_image ;
   backgroundZBuffer = hotelgang_zbuffer ;
   path = hotelgang_path ;   
  }
  
  Ego:
  if ((PreviousScene == hotelrezeption) || (previousScene == Securitygang)) {
   setPosition(528,269) ;
   delay(4) ;
   var tep = priority ;
   priority = 1 ;
   walk(350,260) ;
   priority = tep ;
   if (OutsideChefCount == 1 and TalkedToWonciek == false) {    // Zwischensequenz: Julian geht direkt in Peters Zimmer
    forceHideInventory ;
     walk(212,166) ;	   
     turn(DIR_EAST) ;
    if (! TuerA.visible) {
     EgoStartUse ;
     TuerA.visible = true ;  
     TuerA.setField(0, true) ;
     backgroundZBuffer = hotelgang2_zbuffer ;
     backgroundImage = hotelgang2_image ;
      path = hotelgang2_path ;    
     EgoStopUse ;
    }
     walk(245,176) ;
    doEnter(hotelzimmerl) ;    
   }
   if (previousScene == Securitygang) {
    delay 30 ;
    Ego.walk(212,166) ;
    delay 2 ;
    turn(DIR_EAST) ;
    delay 5 ;
    Ego.say("Eine Nachricht?") ;
    delay 10 ;
    Ego.say("Lieber Julian!") ;
    delay 3 ;
    Ego.say("Kurzfristig habe ich erfahren, dass meine Anwesenheit auf einer Pressekonferenz in Monte Carlo...") ;
    delay 3 ;
    Ego.say("...ben[tigt wird. Ich werde dort im 'Princess Grace'-Theater technische Fragen beantworten...") ;
    delay 3 ;
    Ego.say("...sowie m[gliche Anwendungsgebiete der neuen SamTec-Technologie diskutieren.") ;
    delay 3 ;
    Ego.say("Ich werde aber bald wieder hier zugegen sein, und bin gespannt was Du mir zu berichten hast.") ;
    delay 3 ;
    Ego.say("Du solltest solange unbedingt mal das @gyptische Antiquit#ten-Musem besuchen.") ;
    delay 3 ;
    Ego.say("Sch[nen Aufenthalt noch und bis dann, Peter") ;
    delay 12 ;
    turn(DIR_SOUTH) ;
    Ego.say("Eine SamTec-Pressekonferenz in Monte Carlo?") ;
    delay 3 ;
    Ego.say("Auf nach Monaco.") ;
    delay 30 ;
    doEnter(Intrologo) ;
   }
  } else if (PreviousScene == hotelzimmerr) {   
   setPosition(524,357) ;
   face(DIR_WEST) ;
  } else {
   setPosition(212,166) ;
   face(DIR_WEST) ; 	  
  }
  
  clearAction ;
}

/* ************************************************************* */

object Nachricht {
 setAnim(Nachricht_image) ;
 setPosition(234,98) ;
 enabled = (previousScene==Securitygang) ;
 visible = true ;
 absolute = false ;
 clickable = false ;
}

/* ************************************************************* */

object TuerA {
 setAnim(Door1open_image) ; 
 setPosition(210,78) ;
 setClickArea(0,0,63,121) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
 class = StdEventObject ; 
 StdEvent= Use ;  
}

event MasterKey -> TuerA {
 Ego:
  walk(212,166) ;
  turn(DIR_EAST) ;  
 if (door1locked) {
  if (hasRoom) {
    EgoStartUse ;
    door1locked = false ;
    soundBoxPlay(Music::Aufschliessen_wav) ;
    EgoStopUse ;  
    "Und offen ist sie. Auch eine schwere T]r hat nur einen kleinen Schl]ssel n[tig."
    
  } else Ego.say("Ich sollte mir hier erstmal f]r meinen weiteren Aufenthalt ein Zimmer mieten, bevor das jemand anderes tut.") ;
 } else {
  "Die T]r ist schon aufgeschlossen."
 }
  clearAction ;  
}

event Screw -> TuerA {
 Ego:
  walk(212,166) ;
  turn(DIR_EAST) ;
  "Ich f]rchte, die Schraube passt nicht ins Schloss."	
 clearAction ;
}

event LookAt -> TuerA {
 Ego:
  walk(212,166) ;
  turn(DIR_EAST) ;
  "Diese T]r f]hrt in Peters Zimmer."
 clearAction ;
}

event Use -> TuerA {
 if (TuerA.visible) TriggerObjectOnObjectEvent(Close, TuerA) ;
  else TriggerObjectOnObjectEvent(Open, TuerA) ;
}

event PickLock -> TuerA {
 Ego:
  walk(212,166) ;
  turn(DIR_EAST) ;
  "Das ist das Zimmer von Peter."
  "Bevor ich den Dietrich hier besch#dige..."
  "...versuche ich doch lieber in Gonzales' Zimmer zu kommen..."
  "...um mir erstmal ein eigenes Zimmer zu besorgen."
 clearAction ;  
}

event Hotelkey -> TuerA {
 Ego:
  walk(212,166) ;
  turn(DIR_EAST) ;
 if (door1locked) {
    "Mal sehen, ob der Schl]ssel auch hier passt..."
   EgoUse ;
    "Nein."
    "Schade."   
 } else {
   EgoUse ;
   "Der Schl]ssel passt nicht."
 }
 clearAction ;
}

event Open -> TuerA {
 Ego:
  walk(212,166) ;
  turn(DIR_EAST) ;
 if (TuerA.visible) {
   "Die T]r ist schon offen."   
 } else if (! door1locked) {
  EgoStartUse ;
  TuerA.visible = true ;  
  TuerA.setField(0, true) ;
  start soundBoxPlay(Music::Tuerauf_wav) ;
  backgroundZBuffer = hotelgang2_zbuffer ;
  backgroundImage = hotelgang2_image ;
  Ego.path = hotelgang2_path ;
  EgoStopUse ;
 } else {
  if HasRoom {
   if (tryOpenCnt == 0) {
    tryOpenCnt++ ;
    Ego:
     "Ich klopfe einfach mal an."
    start { delay(3); soundBoxPlay(Music::doorknock_wav) ; }	
    EgoUse ;
    delay 15 ;
     "Seltsam..."
    start { delay(3); soundBoxPlay(Music::doorknock_wav) ; }	
    EgoUse ;
    delay 12 ;
     "Peter scheint immer noch nicht da zu sein."
     "Dabei wei} er doch, dass ich etwa um diese Zeit hier ankomme."
    NeedPickLock2 = true ;
   } else {
    Ego:
     "Vielleicht finde ich in seinem Zimmer einen Hinweis..."
     "...wo er sich aufhalten k[nnte."
    delay 5 ;
    EgoStartUse ;
    soundBoxPlay(Music::Opendoor_wav) ;
    EgoStopUse ;
    delay 5 ;
     "Wie zu erwarten ist die T]r abgeschlossen."     
   }
  } else {
    Ego: "Ich sollte mir erst mal ein Zimmer besorgen."
         "Mit Peter kann ich auch noch sp#ter reden..." 
         "...wenn er zur]ck kommt."	 
  } 
 }
 clearAction ;
}

event Close -> TuerA {
 Ego:
  walk(212,166) ;
  turn(DIR_EAST) ;
 EgoStartUse ;
 if (TuerA.visible) {
  TuerA.visible = false ;
  TuerA.setField(0, false) ;
  start soundBoxPlay(Music::Closedoor_wav) ;
  backgroundImage = hotelgang_image ;
  backgroundZBuffer = hotelgang_zbuffer ;
  Ego.path = hotelgang_path ;
 } else {
  Ego.say("Die T]r ist schon geschlossen.") ;
 }
 EgoStopUse ;
 clearAction ;
}

event WalkTo -> TuerA {
 clearAction ;	
 Ego:
  if (TuerA.visible) {
   walk(245,176) ;
   doEnter(hotelzimmerl) ;
  } else {
   walk(212,166) ;
   turn(DIR_EAST) ; 
  }
}

/* ************************************************************* */

object TuerB { 
 setAnim(Door2open_image) ; 
 setPosition(578,50) ;
 priority = 40 ;
 setClickArea(0,0,62,310) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
 class = StdEventObject ; 
 StdEvent= Use ;  
}

event LookAt -> TuerB {
 Ego:
  walk(550,390) ;
  turn(DIR_EAST) ;
  if (hasRoom) say("Diese T]r f]hrt in mein Zimmer.") ;
   else say("Diese T]r f]hrt in Gonzales' Zimmer.") ;
 clearAction ;
}

event Use -> TuerB {
 if (TuerB.visible) TriggerObjectOnObjectEvent(Close, TuerB) ;
  else TriggerObjectOnObjectEvent(Open, TuerB) ;
}

event WalkTo -> TuerB {
 clearAction ;
 Ego:
  walk(550,390) ;  
  turn(DIR_EAST) ;
 if (door2locked) return ;
  suspend ;  
  walk(602,395) ;
//  walk(700,378) ;
 doEnter(Hotelzimmerr) ;  
}

event Open -> TuerB {
 clearAction ;
 Ego:
  walk(550,390) ;  
  turn(DIR_EAST) ;  
 if (TuerB.visible)  {
  "Die T]r ist schon offen."
 } else
 if (!door2locked) {
  EgoStartUse ;
  start soundBoxPlay(Music::Tuerauf_wav) ;
  TuerB.visible = true ;  
  TuerB.setField(0, true) ;	 
  EgoStopUse ;
 } else {
   EgoStartUse ;
   soundBoxPlay(Music::Opendoor_wav) ;
   EgoStopUse ;
   "Die T]r ist abgeschlossen."	 
 }
}

event Screw -> TuerB {
 Ego:
  walk(550,390) ;  
  turn(DIR_EAST) ;
  "Ich f]rchte, die Schraube passt nicht ins Schloss."	
 clearAction ;
}

event Close -> TuerB {
 Ego:
  walk(550,390) ;  
  turn(DIR_EAST) ;
 EgoStartUse ;
 if (TuerB.visible) {
  soundBoxPlay(Music::Closedoor_wav) ;	 
  TuerB.visible = false ;
  TuerB.setField(0, false) ;
 } else {
  "Die T]r ist schon geschlossen."
  if (! Door2locked) {
    "Aber von mir aus..."
    TriggerObjectOnObjectEvent(open, TuerB) ;
    TriggerObjectOnObjectEvent(close, TuerB) ;
  }
  clearAction ;    
  return 0 ;
 }
 EgoStopUse ;
 clearAction ;
}

event PickLock -> TuerB {
 Ego:
  walk(550,390) ;
  turn(DIR_EAST) ;
 EgoStartUse ;
 soundBoxPlay(Music::Picklock_wav) ;
 dropItem(Ego, PickLock) ; 
 door2locked = false ;
 EgoStopUse ;
  "Hoppla!"
 delay 3 ;
  "Der Dietrich ist kaputt gegangen!" 
  "Aber die T]r sollte jetzt offen sein."
 clearAction ; 
} 

event MasterKey -> TuerB {
 Ego:
  walk(550,390) ;
  turn(DIR_EAST) ;  
 if (door2locked) {
  EgoStartUse ;
  door2locked = false ;  
  soundBoxPlay(Music::Aufschliessen_wav) ;
  EgoStopUse ;  
  "Die T]r ist jetzt aufgeschlossen."
 } else {
  "Die T]r ist schon aufgeschlossen."
 }
  clearAction ;  
}

event Hotelkey -> TuerB {
 Ego:
  walk(550,390) ;
  turn(DIR_EAST) ; 
 if (door2locked) {
   EgoStartUse ;
   soundBoxPlay(Music::Aufschliessen_wav) ;
   door2locked = false ;   
   EgoStopUse ;    
 } else {
   "Ich schlie}e die T]r wieder ab."
   if (TuerB.visible) TriggerObjectOnObjectEvent(close, TuerB) ;
   EgoStartUse ;
   soundBoxPlay(Music::Aufschliessen_wav) ;
   EgoStopUse ;
   door2locked = true ;   
 }
 clearAction ;
}


/* ************************************************************* */

object Schild {
 setClickArea(62,205,194,316);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
 class = StdEventObject ; 
 StdEvent= LookAt ;   
}

event WalkTo -> Schild {
 clearAction ;
 Ego:
  walk(166,335) ;
  turn(DIR_SOUTH) ;
}

event LookAt -> Schild {
 Ego:
  walk(166,335) ;
  turn(DIR_SOUTH) ;
  "Auf dem Schild steht in mehreren Sprachen, dass ab 21 Uhr Nachtruhe ist."	
 clearAction ;  
}

/* ************************************************************* */

object Alarmanlage {
 setClickArea(280,57,300,73);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Feuermelder" ;
}

event WalkTo -> Alarmanlage {
 clearAction ;
 Ego:
  walk(233,197) ;
  turn(DIR_EAST) ;
}

event LookAt -> Alarmanlage {
 clearAction ;
 Ego:
  walk(233,197) ;
  turn(DIR_EAST) ;
  "Das ist ein Teil des Feuermeldsystems."	
  "Brennt es, leuchtet diese Lampe."
}

/* ************************************************************* */

object Baum {
 setClickArea(268,121,310,169);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Bonsaibaum" ;
}

event WalkTo -> Baum {
 clearAction ;
 Ego:
  walk(239,203) ;
  turn(DIR_EAST) ;
}

event LookAt -> Baum {
 clearAction ;	
 Ego:
  walk(239,203) ;
  turn(DIR_EAST) ;
  "Das ist einer dieser unglaublich anspruchsvollen japanischen Miniaturb#ume."	
}

/* ************************************************************* */

object Kalender {
 setClickArea(35,122,81,183);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kalender" ;
}

event WalkTo -> Kalender {
 clearAction ;
 Ego:
  walk(111,291) ;
  turn(DIR_WEST) ;
}

event LookAt -> Kalender {
 clearAction ;	
 Ego:
  walk(111,291) ;
  turn(DIR_WEST) ;
  "Der Kalender ist mit Bildern bekannter K]nstler illustriert."	 
}

/* ************************************************************* */

object Kiste2 {
 setClickArea(38,66,99,86);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kiste" ;
}

event WalkTo -> Kiste2 {
 clearAction ;
 Ego:
  walk(128,139) ;
  turn(DIR_WEST) ;
}

event LookAt -> Kiste2 {
 Ego:
  walk(128,139) ;
  turn(DIR_WEST) ;
  "Die Kiste steht auf dem Schrank."
  "Mehr kann ich nicht erkennen."
 clearAction ;  
}

event Shoe -> Kiste2 {
 Ego:
  walk(128,139) ;
  turn(DIR_WEST) ;
  "Das lasse ich zum Wohle aller Hotelg#ste lieber bleiben."
 clearAction ;
}

event Take -> Kiste2 {
 triggerObjectOnObjectEvent(Open, Kiste2) ;
}

event Open -> Kiste2 {
 Ego:
  walk(128,139) ;
  turn(DIR_WEST) ;
  "Ich komme nicht ran!"
 clearAction ;
}

/* ************************************************************* */

object Toilette {
 setClickArea(99,70,112,94);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Toilettent]r" ;
 class = StdEventObject ; 
 StdEvent= Use ;   
}

event WalkTo -> Toilette {
 clearAction ;
 Ego:
  walk(108,183) ;
  turn(DIR_WEST) ;
}

event MasterKey -> Toilette {
 Ego:
  walk(108,183) ;
  turn(DIR_WEST) ;
 EgoStartUse ;
 soundBoxPlay(Music::Aufschliessen2_wav) ;
 EgoStopUse ;
  "Der Schl]ssel passt nicht."
  "Mysteri[s."
 if (askAboutToilets == 0) AskAboutToilets = 1 ;
 clearAction ;
}

event PickLock -> Toilette {
 Ego:
  walk(108,183) ;
  turn(DIR_WEST) ;
  "Ich will die Toilette nicht aufschlie}en."
  clearAction ;
}

event Use -> Toilette {
 triggerObjectOnObjectEvent(Open, Toilette) ;
}

event Open -> Toilette {
 Ego:
  walk(108,183) ;
  turn(DIR_WEST) ;
  EgoStartUse ;
 soundBoxPlay(Music::Opendoor_wav) ;
  EgoStopUse ;
  "Verschlossen."
 clearAction ;
}

event Close -> Toilette {
 Ego:
  walk(108,183) ;
  turn(DIR_WEST) ;  
  "Die T]r ist schon zu."
 clearAction ;	
}

/* ************************************************************* */

object Pflanze {
 setClickArea(135,109,176,159);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pflanze" ;
}

event WalkTo -> Pflanze {
 clearAction ;
 Ego:
  walk(157,170) ;
  turn(DIR_NORTH) ;
}

event Take -> Pflanze {
 Ego:
  walk(157,170) ;
  turn(DIR_NORTH) ;
  "Ganz bestimmt nicht."	
 clearAction ;
}

event LookAt -> Pflanze {
 Ego:
  walk(157,170) ;
  turn(DIR_NORTH) ;
  "Ein Photosynthese-betreibender Eukaryot."	
 clearAction ;
}

/* ************************************************************* */

object Fenster {
 setClickArea(133,89,188,120);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fenster" ;
}

event WalkTo -> Fenster {
 clearAction ;
 Ego:
  walk(157,170) ;
  turn(DIR_NORTH) ;	
}

event Use -> Fenster {
 triggerObjectOnObjectEvent(Open, Fenster) ;
}

event Open -> Fenster {
 Ego:
  walk(157,170) ;
  turn(DIR_NORTH) ;	
  "Es l#sst sich nicht [ffnen."
 clearAction ;	
}

event Close -> Fenster {
 Ego:
  walk(157,170) ;
  turn(DIR_NORTH) ;	
  "Das Fenster ist schon geschlossen."	
 clearAction ;
}

event LookAt -> Fenster {
 Ego:
  walk(157,170) ;
  turn(DIR_NORTH) ;	
  "Von hier aus kann ich das Taxi sehen, mit dem ich kam."
 clearAction ;	
}

/* ************************************************************* */

object Unten {
 setClickArea(419,80,544,275);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "nach unten" ;
}

event WalkTo -> Unten {
 clearAction ;
 Ego:
  walk(363,234) ;
  turn(DIR_EAST) ;
 var tep = priority ;
  priority = 1 ;
 suspend ;
  walk(525,272) ; 
  priority = tep ;
 doEnter(hotelrezeption) ;
}

event LookAt -> Unten { 
 Ego:
  walk(363,234) ;
  turn(DIR_EAST) ;
  "Diese Treppe f]hrt hinunter zur Hotelrezeption."
 clearAction ;   
}

/* ************************************************************* */

object Schild3 {
 setClickArea(143,57,185,80);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event WalkTo -> Schild3 {
 clearAction ;
 Ego:
  walk(167,208) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Schild3 {
 Ego:
  walk(167,208) ;
  turn(DIR_NORTH) ;
  "Dieses Schild zeigt den Weg zur Toilette."
 clearAction ;	
}

/* ************************************************************* */

object Schild2 {
 setClickArea(360,7,427,41);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event WalkTo -> Schild2 {
 clearAction ;
 Ego:
  walk(308,244) ;
  turn(DIR_EAST) ;
}

event LookAt -> Schild2 {
 Ego:
  walk(308,244) ;
  turn(DIR_EAST) ;
  "Auf dem Schild steht, dass die Treppen nach unten f]hren."
 clearAction ; 
}

/* ************************************************************* */

object Auszeichnung {
 setClickArea(272,92,309,126);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Auszeichnung" ;
}

event WalkTo -> Auszeichnung {
 clearAction ;
 Ego:
  walk(239,203) ;
  turn(DIR_EAST) ;	
}

event LookAt -> Auszeichnung {
 Ego:
  walk(239,203) ;
  turn(DIR_EAST) ;	
  "Hier h#ngt eine Auszeichnung: 'kinder- und familienfreundliches l'Hotel.'"	
 clearAction ;
}
