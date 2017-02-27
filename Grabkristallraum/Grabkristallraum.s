// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var minPos = 1 ;
static var hourPos = 1 ;

event enter {
Ego:	
 backgroundImage = Grabkristallraum_image ;
 backgroundZBuffer = Grabkristallraum_zbuffer ;
 path = Grabkristallraum_path ; 
 setPosition(785,254) ;
 delay transitionTime ;
 walk(681,272) ;
 forceShowInventory ; 
 clearAction ;
} 

/* ************************************************************* */
 
script pujaTipp {
 Ego:
  switch upcounter(10) {
    case 0: ;
    case 1: "Hmmmm. Es ist nichts passiert."  
    case 2: "Nichts."
    case 3: "Ich denke, ich muss eine bestimmte Kombination einstellen."
    case 4,5,6: "Immer noch nichts." 
	        "M[glicherweise hilft mir Peters Notizbuch weiter."
    case 9,7,8: "Ich sollte mir den Eintrag ]ber die Sonnenuhr Achet-Atons mal genauer ansehen."
    default : "Ich vermute, die Karte des Tempelbezirks Achet-Atons hilft mir bei diesem Problem weiter."
   }  		
}

/* ************************************************************* */

object StabBild {
 setPosition(316,288) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = false ;
 setAnim(Stab_sprite) ;
}

object MinutenBild {
 setupAsStdEventObject(MinutenBild,LookAt,436,300,DIR_WEST) ;
 setPosition(346,203) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 setAnim(Minuten_sprite) ;
 setClickArea(6,7,49,21) ;
 autoAnimate = false ;
 frame = minPos ;
 frame = 1 ;
 name = "Minutenscheibe" ;
 priority = 38 ;  
}

event LookAt -> MinutenBild { 
 Ego:
  WalkToStdEventObject(MinutenBild) ;	
  "Diese Scheibe ist drehbar gelagert."
  "Der spitze Fortsatz der Scheibe zeigt auf..."
 saySymbol(minPos) ;
}

script saySymbol(sym) {
 Ego:
 switch sym {
  case 1: "ein Symbol, das eine Hand darstellt." 
  case 2: "ein Symbol, das den Sonnenaufgang beschreibt." 
  case 3: "ein Symbol, das einen Hof zeigt."
  case 4: "den Eingang."
  case 5: "ein Symbol, das einen Brotlaib abbildet."
  case 6: "ein Symbol, das ein Schachbrett repr#sentiert."
  case 7: "ein Symbol, das einem Hausgrundriss #hnelt."
  case 8: "ein Symbol, das wie ein Auge aussieht."
  case 9: "ein Symbol, das eine Sonnenscheibe zeigt."
  case 10: "ein Symbol, das einen Akarab#us darstellt."
  case 11: "ein Symbol, das einen Korb beschreibt."
  case 0: "ein Symbol, das einen Stern abbildet."
 }
}
 
event Push -> MinutenBild {
 triggerObjectOnObjectEvent(Use, MinutenBild) ;
}	

event Pull -> MinutenBild {
 triggerObjectOnObjectEvent(Use, MinutenBild) ;
}

event Use -> MinutenBild {
 Ego:
  WalkToStdEventObject(MinutenBild) ;
 if Klappe.enabled {Ego.say("Hier muss ich nichts mehr verstellen.") ; return ; }
 suspend ;
  "Auf welches Symbol soll ich die Scheibe ausrichten?"  
  if (!stellScheibe(true)) pujaTipp ;
 clearAction ;
}

object Loch {
 setupAsStdEventObject(Loch,LookAt,-1,-1,-1) ;
 rotateLoch(hourPos) ; 
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 setAnim(Loch_image) ;
 setClickArea(-5,-5,5,5) ;
 name = "Loch" ;
}

event ScrewDriver -> Loch {
 Ego:
 if ((hourPos >= 10) or (hourpos <= 3)) { 
  walk(Loch.positionX, Loch.positionY+20) ;
  turn(DIR_NORTH) ;
 } else { 
  walk(Loch.positionX, Loch.positionY-10) ;
  turn(DIR_SOUTH) ;
 }	 
  "Der Schraubenzieher leistet nicht gen]gend Hebelwirkung, um die Scheibe im Boden zu drehen."
 clearAction ;
}

event Screw -> Loch {
 Ego:
 if ((hourPos >= 10) or (hourpos <= 3)) { 
  walk(Loch.positionX, Loch.positionY+20) ;
  turn(DIR_NORTH) ;
 } else { 
  walk(Loch.positionX, Loch.positionY-10) ;
  turn(DIR_SOUTH) ;
 }		
  "Der Schraube ist VIEL zu klein, um gen]gend Hebelwirkung aufzuwenden, damit sich die Scheibe im Boden dreht."
 clearAction ;
}
		
event WalkTo -> Loch {
 Ego:
  clearAction ;
 if ((hourPos >= 10) or (hourpos <= 3)) { 
  walk(Loch.positionX, Loch.positionY+20) ;
  turn(DIR_NORTH) ;
 } else { 
  walk(Loch.positionX, Loch.positionY-10) ;
  turn(DIR_SOUTH) ;
 }	
}

event Use -> Loch {
 Ego:
 if ((hourPos >= 10) or (hourpos <= 3)) { 
  walk(Loch.positionX, Loch.positionY+20) ;
  turn(DIR_NORTH) ;
 } else { 
  walk(Loch.positionX, Loch.positionY-10) ;
  turn(DIR_SOUTH) ;
 }	
 "Was soll ich mit dem Loch machen?"
 "Mit der Hand kann ich es nicht bewegen."
 clearAction ;
}

event Push -> Loch {
 Ego:
 if ((hourPos >= 10) or (hourpos <= 3)) { 
  walk(Loch.positionX, Loch.positionY+20) ;
  turn(DIR_NORTH) ;
 } else { 
  walk(Loch.positionX, Loch.positionY-10) ;
  turn(DIR_SOUTH) ;
 }	
 "Mit blo}en H#nden geht das nicht. Ich brauche etwas Stabileres."	
 clearAction ;
}	

event Pull -> Loch {
 triggerObjectOnObjectEvent(Push, Loch) ;
}

event Absperrstange -> Loch {
 Ego:
 if ((hourPos >= 10) or (hourpos <= 3)) { 
  walk(Loch.positionX, Loch.positionY+20) ;
  turn(DIR_NORTH) ;
 } else { 
  walk(Loch.positionX, Loch.positionY-10) ;
  turn(DIR_SOUTH) ;
 }	
 "Zu d]nn, ich rutsche st#ndig ab"	
 clearAction ;	
}

event LookAt -> Loch {
 Ego:
 if ((hourPos >= 10) or (hourpos <= 3)) { 
  walk(Loch.positionX, Loch.positionY+20) ;
  turn(DIR_NORTH) ;
 } else { 
  walk(Loch.positionX, Loch.positionY-10) ;
  turn(DIR_SOUTH) ;
 }	
 switch upcounter(1) {
    case 0: "Auf dieser runden Scheibe im Boden befindet sich ein kleines Loch."  
	    "Wahrscheinlich ist das Loch eine Art Zeiger und gleichzeitig eine Vorrichtung, mit der sich die Scheibe drehen l#sst."
 }
 "Das Loch zeigt auf..."
 saySymbol(hourPos) ;
 clearAction ;
}

event Rod -> Loch {
 Ego:
  if ((hourPos >= 10) or (hourpos <= 3)) { 
   walk(Loch.positionX, Loch.positionY+20) ;
   turn(DIR_NORTH) ;
  } else { 
   walk(Loch.positionX, Loch.positionY-10) ;
   turn(DIR_SOUTH) ;
  }
  if Klappe.enabled { Ego.say("Hier muss ich nichts mehr verstellen.") ; clearAction ; return ; }
  EgoStartUse ;
  StabBild:
   setPosition(Loch.positionX, Loch.positionY) ;
   visible = true ;
  dropItem(Ego,Rod) ;
  EgoStopUse ;
  Ego:
  "Auf welches Symbol soll ich die Scheibe ausrichten?"
  if (!stellScheibe(false)) pujaTipp ;
  if ((hourPos >= 10) or (hourpos <= 3)) { 
   walk(Loch.positionX, Loch.positionY+20) ;
   turn(DIR_NORTH) ;
  } else { 
   walk(Loch.positionX, Loch.positionY-20) ;
   turn(DIR_SOUTH) ;
  }
  
  EgoStartUse ;
   StabBild.visible = false ;
  
  EgoStopUse ;
  takeItem(Ego, Rod) ;
  
 clearAction ;
}

script rotateLoch(pos) {
 Loch:
 switch pos {
  case 1:  setPosition(398,312) ; 
  case 2:  setPosition(427,305) ; 
  case 3:  setPosition(441,296) ; 
  case 4:  setPosition(436,287) ; 
  case 5:  setPosition(420,280) ; 
  case 6:  setPosition(400,275) ; 
  case 7:  setPosition(350,275) ; 
  case 8:  setPosition(331,280) ; 
  case 9:  setPosition(317,287) ; 
  case 10: setPosition(313,297) ; 
  case 11: setPosition(327,305) ; 
  default: setPosition(354,312) ; 
 } 
}

script CheckKombi {
 if ((hourPos == 9) and (minPos == 8)) {
  EgoStopUse ;	 
  forceHideInventory ;
  soundBoxPlay(Music::Abdeckung_wav) ;
  delay 12 ;
  Ego.turn(DIR_EAST) ;
  delay 10 ;
  Ego.turn(DIR_WEST) ;
  delay 3 ;
  soundBoxPlay(Music::Openklappe_wav) ;
  Klappe.enabled = true ;
  Schein.enabled = true ;
  Klappe.setField(0,true) ;
  AtonTrapDoorOpen = true ;
  delay 20 ;
  Ego:
   face(DIR_SOUTH) ;   
   "Bingo!"
   "Daf]r braucht es kein @gyptologie-Studium."
   "Sondern einen JULIAN HOBLER!"
  forceShowInventory ;   
  return true ;
 } else {
  EgoStopUse ;	 
  Klappe.enabled = false ;
  Schein.enabled = false ;
  Klappe.setField(0,false) ;	 
  return false ;
 }
}

script stellScheibe(minut) {	
 loop {
  Ego:
   addChoiceEchoEx(1, "Hand", false) ;
   addChoiceEchoEx(2, "Sonnenaufgang", false) ;
   addChoiceEchoEx(3, "Hof", false) ;
   addChoiceEchoEx(4, "Auf den Eingang", false) ;
   addChoiceEchoEx(5, "Brotlaib", false) ;
   addChoiceEchoEx(6, "Schachbrett", false) ;
   addChoiceEchoEx(7, "Hausgrundriss", false) ;
   addChoiceEchoEx(8, "Auge", false) ;
   addChoiceEchoEx(9, "Sonnenscheibe", false) ;
   addChoiceEchoEx(10, "Skarab#us", false) ;
   addChoiceEchoEx(11, "Korb", false) ;
   addChoiceEchoEx(12, "Stern", false) ;
   addChoiceEchoEx(13, "Nicht ver#ndern", false) ;
      
  var c = dialogEx ;
  var res = false ;
  switch c {
   case 13:
    return ;
   default:
    if (c == 12) c = 0 ;
    if (minut) {
     EgoStartUse ;    
     soundBoxPlay(Music::Minuten_wav) ;
     MinutenBild.frame = c ;
     minPos = c ;
     res = CheckKombi ;
    } else {
     EgoStartUse ;
     soundBoxStart(Music::Stunden_wav) ;
     rotateLoch(c) ;	
     StabBild:
      setPosition(Loch.positionX, Loch.positionY) ;
      visible = true ;
     hourpos = c ;
     res = CheckKombi ;
    }
    return res ;
  }
 }
}

/* ************************************************************* */

object Topf {
 setupAsStdEventObject(Topf,LookAt,695,312,DIR_EAST) ;
 setClickArea(719,223,790,314) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Topf"  ;
}

event LookAt -> Topf {
 Ego:  
  WalkToStdEventObject(Topf) ;
 suspend ;
  "Ein gro}er, antiker Tontopf."
  EgoUse ;
  "Er ist leer."
 clearAction ;
}

event Take -> Topf {
 Ego:  
  WalkToStdEventObject(Topf) ;
 suspend ;
  "Ich m[chte ihn nicht mit mir herumtragen."
 clearAction ;	
}

/* ************************************************************* */

object Gang {
 setupAsStdEventObject(Gang,LookAt,681,272,DIR_EAST) ;
 setClickArea(679,155 ,749,252) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Gang" ;
}

event LookAt -> Gang {
 Ego:
  WalkToStdEventObject(Gang) ;
  "Dieser Gang f]hrt in den Raum mit der gro}en Anubisstatue."	
}

event Use -> Gang {
 triggerObjectOnObjectEvent(WalkTo, Gang) ;
}

event Take -> Gang {
 triggerObjectOnObjectEvent(WalkTo, Gang) ;
}

event WalkTo -> Gang {
 clearAction ;
 Ego:
  walk(681,272) ;
 suspend ;
  walk(785,254) ;
 doEnter(GrabSonnenraum) ;
}	

/* ************************************************************* */

object Vase {
 setupAsStdEventObject(Vase,LookAt,179,265,DIR_WEST) ;
 setClickArea(114,185,146,262) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Vase" ;
}

event LookAt -> Vase {
 Ego: 
  WalkToStdEventObject(Vase) ;
  suspend ;
  "Eine gro}e, antike Vase." 
  EgoUse ;
  "Sie ist leer."
  clearAction ;
}

event Take -> Vase {
 Ego:  
  WalkToStdEventObject(Vase) ;
 suspend ;
  "Ich m[chte sie nicht mit mir herumtragen."
 clearAction ;	
}

/* ************************************************************* */

object Saeule {
 setupAsStdEventObject(Saeule,LookAt,426,300,DIR_WEST) ;
 setClickArea(351,216,399,299) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "S#ule" ;
}

event LookAt -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  "Hierauf muss der Kristall gelegen haben." 
}

event Push -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  "Hierauf muss der Kristall gelegen haben." 
 suspend ;
 EgoUse ;
 "Nichts." 
 clearAction ;
}

event Pull -> Saeule {
 triggerObjectOnObjectEvent(Push, Saeule) ;
}

event Use -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
 if (!Klappe.enabled) {
  "Selbst wenn ich auf die S#ule klettere, komme ich nichtmal ann#hernd an die |ffnung."
  "Ich muss mir etwas anderes ]berlegen."
  return ;
 } 
 "Das funktioniert so nicht."
}

/* ************************************************************* */

object Stab {
 setupAsStdEventObject(Stab,LookAt,103,296,DIR_WEST) ;
 setClickArea(47,173,59,229) ;
 absolute = false ;
 clickable = true ;
 enabled = !OhneStab.getField(0) ;
 visible = false ;
 name = "Stab" ;
}

event WalkTo -> Stab {
 triggerObjectOnObjectEvent(WalkTo, Echnaton) ;
}

event LookAt -> Stab {
 Ego:
  WalkToStdEventObject(Stab) ;
  "Ein wei}er Stab, fest umgriffen von der Hand der Statue."
}

event Take -> Stab {
 Ego:
  WalkToStdEventObject(Stab) ;
  "Keine Chance. Er sitzt zu fest."
}

event Push -> Stab {
 triggerObjectOnObjectEvent(Take, Stab) ;
}

event Pull -> Stab {
 triggerObjectOnObjectEvent(Take, Stab) ;
}


/* ************************************************************* */

object Armband {
 setupAsStdEventObject(Armband,LookAt,103,296,DIR_WEST) ;
 setClickArea(38,188,48,206) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Armband" ;
}

event WalkTo -> Armband {
 triggerObjectOnObjectEvent(WalkTo, Echnaton) ;
}

event Push -> Armband {
 triggerObjectOnObjectEvent(WalkTo, Echnaton) ;	
 Ego:
  "Es gibt nicht nach."
 clearAction ;
}

event LookAt -> Armband {
 Ego:
  WalkToStdEventObject(Armband) ;
  if (Ohnestab.getField(0)) say("Ein golden funkelndes Armband. Ein Schl]ssel steckt in einer |ffnung auf der Vorderseite.") ;
   else say("Auf der Frontseite des golden funkelnden Armbands befindet sich ein kleines Loch.") ;
}

event Take -> Armband {
 Ego:
  WalkToStdEventObject(Armband) ;
  EgoUse ;
  "Keine Chance. Es sitzt zu fest."	
}

event HotelKey -> Armband {
 Ego:
  walkToStdEventObject(Armband) ;
  "Der Schl]ssel passt nicht."
}

event MasterKey -> Armband {
 triggerObjectOnObjectEvent(Hotelkey, Armband) ;
}

event ScrewDriver -> Armband {
 Ego:
  walkToStdEventObject(Armband) ;
  suspend ;
 say("Ich versuche, die Spitze des Schraubenziehers in das Loch zu stecken.") ;
  delay 2 ;
  EgoUse ;
  delay 6 ;
  "Es scheint nichts passiert zu sein."
 clearAction ;
}

event EchKey -> Armband {
 Ego:
  WalkToStdEventObject(Armband) ;
  
 suspend ;
 EgoStartUse ;
 takeItem(Ego, Rod) ;
 dropItem(Ego, EchKey) ;
 Ohnestab:
  enabled = true ;
  setField(0, true) ;
 Stab.enabled = false ;
 EgoStopUse ;
 clearAction ;		
}

/* ************************************************************* */

object Echnaton {
 setupAsStdEventObject(Echnaton,LookAt,103,296,DIR_WEST) ;
 setClickArea(8,92,66,306) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Statue" ;
}

event LookAt -> Echnaton {
 Ego:
  WalkToStdEventObject(Echnaton) ;
 suspend ;
  "Eine gro}e Statue." 
  "Sehr fein ausgearbeitet."
  "Vielleicht bildet sie Echnaton ab."
 clearAction ;
}

object Ohnestab {
 class = NonInteractiveClass ;
 setPosition(39,170) ;
 setAnim(Ohnestab_image) ;
 clickable = false ;
 visible = true ;
 enabled = getField(0) ;
 absolute = false ;
}

/* ************************************************************* */

object Klappe {  
 setupAsStdEventObject(Klappe,LookAt,445,300,DIR_WEST) ;
 setPosition(330,26) ;
 priority = 20 ;
 setAnim(Klappeoffen_image) ;
 setClickArea(0,0,105,19) ;
 visible = true ;
 enabled = getField(0) ;
 name = "|ffnung" ;
}

event LookAt -> Klappe {
 Ego:
  walk(426,300) ;
  turn(DIR_WEST) ;
 suspend ;
  say("Ich kann den blauen Himmel erkennen!") ;
  say("Wie habe ich ihn vermisst!") ;
 clearAction ; 
}

event Use -> Klappe {
 Ego:
  turn(DIR_SOUTH) ;
  "Ich komme nicht hoch!"
 clearAction ;
}

event TalkTo -> Klappe {
 Ego:
  walk(426,300) ;
  turn(DIR_WEST) ;
  "Hallo?"
  delay(20) ;
  "Keine Antwort."
 clearAction ;	
}

event Rope -> Klappe {
 Ego:
  WalkToStdEventObject(Klappe) ;
 suspend ;
 Ego:
  switch upcounter(2) {
    case 0: "Ich kann das Seil nicht einfach hochwerfen."
            "Es w]rde keinen richtigen Halt finden."
    default : "Es bringt nichts, das Seil so einfach hochzuwerfen."
	      "Ich sollte das Seil mit etwas kombinieren, das seine Wurfeigenschaften verbessert, und gleichzeitig als Widerhaken fungiert."
  } 
 clearAction ;
}

event RodRope -> Klappe {
 Ego:
  walk(277,318) ;
  turn(DIR_EAST) ;
  
  suspend ;
  "Mit dem Stab als Widerhaken m]sste es klappen."
  delay(20) ;
  EgoStartUse ;
  dropItem(Ego, RodRope) ;
  RopeCeiling.enabled = true ;
  RopeCeiling.Frame = 0 ; delay(3) ; 
  RopeCeiling.Frame = 1 ; delay(3) ;
  RopeCeiling.Frame = 2 ; delay(3) ; 
  start EgoStopUse ;
  RopeCeiling.Frame = 3 ; delay(3) ; 
  RopeCeiling.Frame = 4 ; delay(3) ; 
  RopeCeiling.Frame = 5 ; delay(3) ;
  RopeCeiling.Frame = 6 ; delay(3) ; 
  RopeCeiling.Frame = 7 ; delay(3) ;
  RopeCeiling.Frame = 8 ; delay(3) ;
  RopeCeiling.SetField(0,true) ;
 clearAction ;
} 

object RopeCeiling {
 setupAsStdEventObject(RopeCeiling,LookAt,455,298,DIR_WEST) ;
 enabled = getField(0) ;
 visible = true ;
 clickable = true ;
 priority = 35 ;
 name = "Seil" ;
 setPosition(297,29) ;
 setAnim(Grabkristallraum::SeilWurf_sprite) ;
 setClickArea(109,0,109+49,271) ;
 autoAnimate = false ;
 Frame = 8 ; 
}

event Use -> RopeCeiling {
 Ego:
  WalkToStdEventObject(RopeCeiling) ;
  suspend ;
  EgoStartUse ;  
  "Dann wollen wir mal..."
  delay(20) ;
  Ego.visible = false ;
  forceHideInventory ;
  doEnter(Intrologo) ;  
} 

event LookAt -> RopeCeiling {
 Ego:
  WalkToStdEventObject(RopeCeiling) ;
  "Mein Weg in die Freiheit."	
}

event Pull -> RopeCeiling {
 Ego:
  WalkToStdEventObject(RopeCeiling) ;
  "Nein."	
  "Das ist mein Weg in die Freiheit."
}

event Take -> RopeCeiling {
 triggerObjectOnObjectEvent(Use, RopeCeiling) ;
}

/* ************************************************************* */

object Schein { 
 class = NonInteractiveClass ;
 setPosition(307,26) ;
 priority = 255 ;
 setAnim(Schein_image) ;
 visible = true ;
 enabled = Klappe.getField(0) ;
 clickable = false ;
}
