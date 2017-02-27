// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 backgroundImage = Finaledavor_image ; 
 backgroundZBuffer = Finaledavor_zbuffer ; 
 forceShowInventory ;
 
 Ego:
  enableEgoTalk ;
  enabled = true ;
  visible = true ;
  path = Finaledavor_path ; 
 if (previousScene==Map) {  
   scrollX = 855-640 ;	 
   setPosition(637,291) ;
   face(DIR_WEST) ;
   delay transitionTime ;
   Ego.say("Hier muss es sein.") ;
 } else {
   scrollX = 0 ;
   setPosition(316,270) ;
   face(DIR_EAST) ;
   delay transitionTime ;
 }
 
 clearAction ; 
}

/* ************************************************************* */

object Plakat {
 setupAsStdEventObject(Plakat,LookAt,434,273,DIR_EAST) ;		
 setClickArea(443,83,537,230) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Plakat" ;
}

event LookAt -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
 suspend ;
  say("Auf dem Plakat steht: 'Indiana Jones and the Fountain of Youth - coming soon'.") ;
 clearAction ;
}

event Take -> Plakat {
 Ego: 
  walkToStdEventObject(Plakat) ;
 suspend ;
  say("Ich bin zwar ein Fan, aber es ist zu gro} zum Einstecken.") ;
 clearAction ;
}

event Pull -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
 suspend ;
  EgoUse ;
  say("Ich bekomme es nicht ab. Es ist zu gut befestigt.") ;
 clearAction ;
}

event TalkTo -> Plakat {
 Ego: 
  walkToStdEventObject(Plakat) ;
 suspend ;
  say("Hallo?") ;
 delay 10 ;
 clearAction ;
}

/* ************************************************************* */

object Bambus {
 setupAsStdEventObject(Bambus,LookAt,315,356,DIR_WEST) ;		
 setAnim(Bambus_sprite) ;
 setPosition(229,188) ;
 setClickArea(3,3,10,83) ;
 autoAnimate = false ;
 clickable = true ;
 priority = 44 ;
 enabled = !getField(0) ;
 visible = true ;
 absolute = false ;
 name = "Bambusstock" ;
}

event LookAt -> Bambus {
 Ego: 
  walkToStdEventObject(Bambus) ;
 suspend ;
  say("Dieser Bambusstock st]tzt den Kaktus, welcher mit Draht daran befestigt ist.") ;
 clearAction ;
}

event Take -> Bambus {
 Ego:
  walkToStdEventObject(Bambus) ;
 suspend ;
 EgoStartUse ;
 takeItem(Ego, Stock) ;
 Bambus.setField(0, 1) ;
 Bambus.enabled = false ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Kaktus {
 setupAsStdEventObject(Kaktus,LookAt,315,356,DIR_WEST) ;	
 setClickArea(209,188,261,324) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kaktus" ;
}

event LookAt -> Kaktus {
 Ego:
  walkToStdEventObject(Kaktus) ;
 suspend ;
  say("Ein ziemlich gro}er Kaktus.") ;
 if (random(3)==0) say("Es soll Kakteen geben deren Verzehr psychoaktive Nebenwirkungen hat.") ;
 clearAction ;
}

event Take -> Kaktus {
 Ego:
  walkToStdEventObject(Kaktus) ;
  say("Ich will ihn nicht. Er ist mir zu gro}.") ;
}

event Push -> Kaktus {
 Ego: 
  walkToStdEventObject(Kaktus) ;
 suspend ;
 EgoUse ;
  say("AUTSCH!") ;
  say("Er hat mich gestochen!") ;
  say("Aber daf]r ist Schmerz die einzige Verbindung zur Realit#t.") ;
 clearAction ;
}

event Pull -> Kaktus {
 triggerObjectOnObjectEvent(Push, Kaktus) ;
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,Open,316,270,DIR_WEST) ;	
 setClickArea(241,125,326,256) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]ren" ;
}

event LookAt -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
  say("Eine Glast]ren f]hren in das Geb#ude.") ;
}

event Use -> Tuer {
 triggerObjectOnObjectEvent(Open, Tuer) ;
}

event Open -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 EgoStartUse ;
 doEnter(Finaleeingang) ;
}

event Close -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
  say("Sie ist schon geschlossen.") ;
 clearAction ;
}

/* ************************************************************* */

object Auto {
 setupAsStdEventObject(Auto,Use,546,318,DIR_EAST) ;	
 setClickArea(562,223,720,348) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Auto" ;
}

event LookAt -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
 suspend ;
  say("Blau. 460 bis 480 Nanometer Wellenl#nge.") ;
 clearAction ; 
}

event TalkTo -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
 suspend ;
  say("Hallo? Ist da jemand drin?") ;
 delay 17 ;
  say("Keine Antwort.") ;
 clearAction ;
}

event Pull -> Auto {
 triggerObjectOnObjectEvent(Push, Auto) ;
}

event Push -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
 suspend ;
 delay ;
  EgoUse ; 
 delay 2 ;
  say("Es bewegt sich nicht.") ;
 clearAction ;  
}

event Take -> Auto {
 triggerObjectOnObjectEvent(Use, Auto) ;
}

event Open -> Auto {
 triggerObjectOnObjectEvent(Use, Auto) ;
}

event Use -> Auto {
 Ego: 
  walkToStdEventObject(Auto) ;
 suspend ;
  EgoUse ;
  say("Abgeschlossen.") ;
  say("Au}erdem will ich gar nicht von hier weg.") ;
 clearAction ;
}

/* ************************************************************* */

object Kaktus2 {
 setupAsStdEventObject(Kaktus2,LookAt,557,286,DIR_EAST) ;	
 setClickArea(578,171,624,261) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kaktus" ;
}

event LookAt -> Kaktus2 {
 Ego:
  walkToStdEventObject(Kaktus2) ;
 suspend ;
  say("Ein ziemlich gro}er Kaktus.") ;
 if (random(3)==0) say("Es soll Kakteen geben, deren Verzehr psychoaktive Nebenwirkungen hat.") ;
 clearAction ;
}

event Take -> Kaktus2 {
 Ego:
  walkToStdEventObject(Kaktus2) ;
  say("Ich will ihn nicht. Er ist mir zu gro}.") ;
}

event Push -> Kaktus2 {
 Ego: 
  walkToStdEventObject(Kaktus2) ;
 suspend ;
 EgoUse ;
  say("AUTSCH!") ;
  say("Er hat mich gestochen!") ;
 clearAction ;
}

event Pull -> Kaktus2 {
 triggerObjectOnObjectEvent(Push, Kaktus2) ;
}

event Use -> Kaktus2 {
 triggerObjectOnObjectEvent(Push, Kaktus2) ;
}


/* ************************************************************* */

object Weg {
 setupAsStdEventObject(Weg,WalkTo,637,291,DIR_EAST) ;	
 setClickArea(766,172,841,256) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Weg" ;
}

event LookAt -> Weg {
 Ego:
  walkToStdEventObject(Weg) ;
 suspend ;
  say("Von dort bin ich hergekommen.") ;
 clearAction ;
}

event Take -> Weg {
 triggerObjectOnObjectEvent(Use, Weg) ;
}

event Use -> Weg {
 Ego:
  walkToStdEventObject(Weg) ;
 suspend ;
  say("Nein, ich habe hier zu tun.") ;
 clearAction ;
}

