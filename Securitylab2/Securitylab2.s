// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
	
 interruptCaptions ;	
 
 John.enabled = false ;
 Jack.enabled = false ;
 scrollX = 0 ;
 
 if ((hasItem(Ego, Ausdruck)) and (hasItem(Ego, Nachtsicht))) {
   PlatteGra.setField(0,0) ;
   PlatteGra.enabled = false ;
 }
 
 if (BunsenStage == 1) BunsenStage = 2 ;
 Ego:
 enableEgoTalk ;
  enabled = true ;
  visible = true ;
 forceShowInventory ;
 if (shortCircuit) backgroundImage = Securitylab2D_image;
  else backgroundImage = Securitylab2_image;
 backgroundZBuffer = Securitylab2_zbuffer ;
  path = Securitylab2_path ;
 if (BunsenStage == 2) path = Securitylab2b_path ;
  
 if (Bunsenweg.enabled or BunsenSchreibt.enabled) start bunsenSound ;
  
 if (previousScene == Securitygang || previousScene == Chefbuero) {
   if (previousScene == Chefbuero) nextScene = 0 ;	 
   if (chaseStage == 2) {
     John:
      setPosition(242,290) ;
      face(DIR_WEST) ;
      scale = 648 ;
      pathAutoScale = false ;
      visible = true ;
      enabled = true ;
   }
   Tueroffen.enabled = false ;
   delay 10 ;
   soundBoxStart(Music::Tuerauf2_wav) ;
   Tueroffen.enabled = true ;
   Ego:  
   setPosition(107,285) ;
   face(DIR_EAST) ;
   path = 0 ;
   scale = 646 ;
   pathAutoScale = false ;
   walk(170,292) ;
   turn(DIR_WEST) ;
   EgoStartUse ;
   soundBoxStart(Music::Tuerzu4_wav) ;
   Tueroffen.enabled = false ;
   EgoStopUse ;
   turn(DIR_EAST) ;
   path = Securitylab2_path ;
   pathAutoScale = true ;  
   if (chaseStage == 2) {
     hideInventory ;
     delay 7 ;
     catchSecMusic ;
     John:     
      "Hab ich Sie!"
     delay 10 ;
     doEnter(Securitygef) ;
     finish ;
   }   
 } else {  
   setPosition(336,246) ;
   face(DIR_SOUTH) ;
   if (chaseStage == 1) {
    hideInventory ;	   
    John.enabled = false ;
    Ego.walk(420,340) ;
    start {
      delay 12 ;
      John:
       enabled = true ;
       visible = true ;
       path = Securitylab2b_path ;
       priority = PRIORITY_AUTO ;
       pathAutoScale = true ;
       scale = 378 ;
       setPosition(336,246) ;
       face(DIR_SOUTH) ;
       delay 4 ;
       say("Bleiben Sie stehen!") ;
       walk(420,340) ;
       turn(DIR_WEST) ; 
    }
    Ego:
     walk(170,292) ;
     chaseStage = 2 ;
     EgoStartUse ;
     soundBoxStart(Music::Tuerauf2_wav) ;
     Tueroffen.enabled = true ;
     EgoStopUse ;
     Ego:
      path = 0 ;
      pathAutoScale = false ;
      walk(107,285) ;
     delay 2 ;
      turn(DIR_SOUTH) ;
     EgoStartUse ;  
      visible = false ;
     soundBoxStart(Music::Tuerzu4_wav) ;
     Tueroffen.enabled = false ;
     delay 3 ;
     John:
      delay 10 ;
      turn(DIR_NORTH) ;
      delay 17 ;
      "HAHAHA!"
      delay 3 ;
      "Der gef#llt mir!"
      delay 7 ;
      turn(DIR_WEST) ;
     Ego:
      visible = true ;
      pathAutoScale = true ;      
      doEnter(Securitygang) ;
   } else if (chaseStage == 2) start countDown ;
 } 
 
 static var BunsenComment = false ;
 
 if ((BunsenStage == 2) and (previousScene == Securitylab1) and (BunsenComment == false)) {
   delay 35 ;
   Ego.say("Wie ist er denn bitte so schnell hier hergekommen?") ;
   BunsenComment = true ;
 }
 
 clearAction ;
}

/* ************************************************************* */

script bunsenSound {
  killOnExit = true ;
  loop {
    if (Bunsenweg.enabled) {
      if (Bunsenweg.frame == 2) { Bunsenweg.playSound(Music::Kopftafel_wav) ; }
      delay 1 ;
    } else if (Bunsenschreibt.enabled) {
      Bunsenschreibt.playSound(Music::Bunsenschreibt_wav) ;
      delay 1 ;
    }
  }
}

/* ************************************************************* */

script countDown {
  eventGroup = 123653 ;
  delay 240 ;	
  delay (upcounter(5) * 15) ; // PUJA
  Ego.stop ;
  suspend ;
  hideInventory ;
  John:
   enabled = true ;
   visible = true ;
   path = Securitylab2b_path ;
   priority = PRIORITY_AUTO ;
   pathAutoScale = true ;
   scale = 378 ;
   setPosition(336,246) ;
   face(DIR_SOUTH) ;
   delay 4 ;   
  if (Ego.positionX > 316) {
    Ego.turn(DIR_NORTH) ;
    delay 2 ;
    catchSecMusic ;
    John.say("Hab ich Sie!") ;
    delay 7 ;
    doEnter(Securitygef) ;
    finish ;
  } else {
    John.say("Bleiben Sie stehen!") ;  
    start {
      delay 8 ;
      John.walk(420,340) ;
      John.turn(DIR_WEST) ;
    }
    Ego:
     walk(170,292) ;      
     EgoStartUse ;
     soundBoxStart(Music::Tuerauf2_wav) ;
     Tueroffen.enabled = true ;
     EgoStopUse ;
     Ego:
      path = 0 ;
      pathAutoScale = false ;
      walk(107,285) ;
     delay 2 ;
      turn(DIR_SOUTH) ;
     EgoStartUse ;  
      visible = false ;
     soundBoxStart(Music::Tuerzu4_wav) ;
     Tueroffen.enabled = false ;
     delay 3 ;	  
     doEnter(Securitygang) ;
     finish ;
  }
}

/* ************************************************************* */

object Lab1tuer {
 setupAsStdEventObject(Lab1tuer,Open,335,245,DIR_NORTH) ; 		
 setClickArea(311,166,345,214) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event LookAt -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
  say("Diese Glast]r f]hrt ins 'Labor 1'.") ;		
}

event Close -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
  say("Sie ist bereits geschlossen.") ;	
}

event Push -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
 suspend ;
 EgoUse ;
  say("Sie bewegt sich nicht.") ;  
 clearAction ;
}

event Open -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
 killEvents(123653) ;
 suspend ;
 if (wagenMoved) {
  EgoUse ;
  "Die T]r klemmt!"
  clearAction ;
 } else doEnter(Securitylab1) ;
}

event HotelKey -> Lab1tuer {
 triggerObjectOnObjectEvent(Lab2key, Lab1tuer) ;
}

event Lab2Key -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
  say("Diese T]r hat kein Schl]sselloch.") ;
}

event Use -> Lab1tuer {
 triggerObjectOnObjectEvent(Open, Lab1tuer) ;
}

/* ************************************************************* */

object Papier {
 setupAsStdEventObject(Papier,LookAt,350,255,DIR_EAST) ; 		
 setPosition(372,224) ;
 setClickArea(0,0,21,11) ;
 setAnim(Papier_image) ;
 absolute = false ;
 enabled = !Papier.getField(0) ;
 visible = true ;
 clickable = true ; 
 name = "Stapel Papier" ;
}

event LookAt -> Papier {
 Ego:
  walkToStdEventObject(Papier) ;
 suspend ;
  say("Hier liegt ein Stapel Din A4-Bl#tter.") ;	
 clearAction ;
}

event Zitrone -> Papier {
 Ego:
  walkToStdEventObject(Papier) ;
 suspend ;
  say("Dazu sollte ich den Stapel Bl#tter ersteinmal nehmen.") ;	
 clearAction ;
}

event Take -> Papier {
 Ego:
  walkToStdEventObject(Papier) ;
 suspend ;
 egoStartUse ;
  takeItem(Ego, Faxpapier) ;
 Papier.setField(0, true) ;
 Papier.enabled = false ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object KreideB {
 setupAsStdEventObject(KreideB,LookAt,405,282,DIR_EAST) ; 	
 setClickArea(430,234,457,247) ;
 absolute = false ;
 clickable = true ;
 enabled = (!Bunsenschreibt.enabled) and (!Bunsenweg.enabled) ;
 visible = false ;
 name = "Kreide" ;
}

event LookAt -> KreideB {
 Ego:
  walkToStdEventObject(KreideB) ;
 suspend ;
  say("Unter der Tafel liegen in einem Beh#lter mehrere St]cke Kreide.") ;
 clearAction ;
}

event Kreide -> KreideB {
 Ego:
  walkToStdEventObject(KreideB) ;
 suspend ;
  say("Ich lege das St]ck Kreide zur]ck.") ;
 EgoStartUse ;
  dropItem(Ego, Kreide) ;
 EgoStopUse ;
 clearAction ;
}

event Take -> KreideB {
 Ego:
  walkToStdEventObject(KreideB) ;
 suspend ;
 if (!hasItem(Ego, Kreide)) {
   say("Eine nehme ich mit.") ;
   delay 3 ;
   EgoStartUse ;
    takeItem(Ego, Kreide) ;
   EgoStopUse ;
 } else say("Ich habe schon ein St]ck mitgenommen.") ;
 clearAction ;
}

event Use -> KreideB {
 Ego:
  walkToStdEventObject(KreideB) ;
 suspend ;
  say("Dazu sollte ich sie erstmal nehmen.") ;
 clearAction ;	
}

/* ************************************************************* */

object BunsenSchreibt {
 setupAsStdEventObject(BunsenSchreibt,LookAt,423,329,DIR_NORTH) ; 		
 setAnim(BunsenSchreibt_sprite) ;
 setPosition(399,138) ;
 setClickArea(0,0,71,151) ;
 enabled = ((BunsenStage > 0) and (BunsenStage < 3) and (lastRiddle != RIDDLE_PARADOX)) ; ;
 visible = true ;
 absolute = false ;
 clickable = true ;
 stopAnimDelay = 2 ;
 name = "Doktor Bunsen" ;
 captionColor = COLOR_WHITE ;

}

event Push -> Bunsenschreibt {
 triggerObjectOnObjectEvent(Pull, Bunsenschreibt) ;
}

event Pull -> Bunsenschreibt {
 Ego:
  walkToStdEventObject(BunsenSchreibt) ;
 suspend ;
 delay 3 ;
 EgoStartUse ;
 delay 2 ;
 Bunsenschreibt.autoAnimate = false ;
 EgoStopUse ;
 delay 4 ;
 Bunsenschreibt.say("Lassen Sie das!") ;
 Bunsenschreibt.say("Ich muss mich konzentrieren.") ;
 Bunsenschreibt.autoAnimate = true ; 
 clearAction ;
}

event Hammer -> Bunsenschreibt {
 Ego:
  walkToStdEventObjectNoResume(Bunsenschreibt) ; 
 if (did(Use))  say("Nein, so spielen wir hier nicht.") ;
  else say("Ich glaube nicht, dass er den will.") ;
 clearAction ;
}

event LookAt -> Bunsenschreibt {
 Ego:
  walkToStdEventObject(BunsenSchreibt) ;
 suspend ;
  say("Das ist Dr. Bunsen.") ;	
 delay 5 ;
  say("Er sieht besch#ftigt aus.") ;
 clearAction ;
}

event RaetselBuch -> Bunsenschreibt {
 Ego:
  walkToStdEventObject(Bunsenschreibt) ;
 suspend ;
  say("Ich habe ihm schon ein R#tsel gestellt.") ;
  say("Das versucht er gerade zu l[sen.") ;
 clearAction ;
}

event Take -> Bunsenschreibt {
 triggerObjectOnObjectEvent(Use, Bunsenschreibt) ;
}

event Use -> Bunsenschreibt {
 Ego: 
  walkToStdEventObject(Bunsenschreibt) ;
  "Nicht mein Typ."	
}

event Cactus -> Bunsenschreibt {
 Ego:
  walkToStdEventObjectNoResume(BunsenSchreibt) ;
 if (did(Use)) {
   EgoUse ;
   delay 2 ;
   Bunsenschreibt.say("AUTSCH!") ;
   Bunsenschreibt.say("Lassen Sie das!") ;
 } else Ego.say("Ich glaube nicht, dass er den will.") ;
 clearAction ;
}

event TalkTo -> BunsenSchreibt {
 Ego:
  walkToStdEventObject(BunsenSchreibt) ;
 suspend ;
 delay 2 ;
  switch random(2) {
   case 0 : "Hallo nochmal." ;
   case 1 : "Ich bin's wieder." ;
  } 
 delay 3 ;
 Bunsenschreibt.say("Bitte st[ren Sie mich nicht, ich muss mich konzentrieren.") ;
 clearAction ;
}

/* ************************************************************* */

object SchluesselB {
  setupAsStdEventObject(SchluesselB,LookAt,403,321,DIR_NORTH) ; 			
  setAnim(Schluessel_image) ;
  setPosition(399,293) ;
  setClickArea(0,0,16,13) ;
  visible = true ;
  clickable = true ;  
  name = "Schl]ssel" ;
  enabled = ((not hasItem(Ego, Lab2Key)) and (chaseStage == 2)) ;
}

event LookAt -> SchluesselB {
 walkToStdEventObject(SchluesselB) ;
 Ego.say("Ein Schl]ssel, der Dr. Bunsen aus der Tasche gefallen sein muss.") ;
}

event Take -> SchluesselB {
 walkToStdEventObject(SchluesselB) ;	
 suspend ;
 EgoStartUse ;
 takeItem(Ego, Lab2Key) ;
 SchluesselB.enabled = false ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object BunsenWeg {
 setupAsStdEventObject(BunsenWeg,LookAt,423,329,DIR_NORTH) ; 			
 setAnim(BunsenWeg_sprite) ;
 setPosition(398,186) ;
 setClickArea(18,0,76,122) ;
 enabled = ((BunsenStage > 0) and (BunsenStage < 3) and (lastRiddle == RIDDLE_PARADOX) and (chaseStage < 3)) ;
 visible = true ;
 absolute = false ;
 clickable = true ;
 stopAnimDelay = 3 ;
 name = "Doktor Bunsen" ;
}

event RaetselBuch -> Bunsenschreibt {
 Ego:
  walkToStdEventObject(Bunsenschreibt) ;
 suspend ;
  say("Ich glaube, er hat vorerst genug von R#tseln.") ;  
 clearAction ;
}

event Push -> BunsenWeg {
 triggerObjectOnObjectEvent(Pull, Bunsenweg) ;
}

event Cactus -> BunsenWeg {
 triggerObjectOnObjectEvent(Pull, Bunsenweg) ;
}

event Hammer -> BunsenWeg {
 Ego: 
  walkToStdEventObject(Bunsenweg) ;
  "Das ist nun nicht mehr n[tig."	
}

event Take -> BunsenWeg {
 triggerObjectOnObjectEvent(Use, BunsenWeg) ;
}

event Use -> BunsenWeg {
 Ego: 
  walkToStdEventObject(Bunsenweg) ;
  "Nicht mein Typ."	
}

event Pull -> BunsenWeg {
 Ego: 
  walkToStdEventObject(Bunsenweg) ;
 suspend ;
 EgoUse ;
 delay 10 ;
 clearAction ;
}

event LookAt -> BunsenWeg {
 Ego:
  walkToStdEventObject(Bunsenweg) ;
 suspend ;
  say("Er wirkt etwas... ]berfordert.") ;
 clearAction ;	
}

event TalkTo -> BunsenWeg {
 Ego:
  walkToStdEventObject(Bunsenweg) ;
 suspend ;
 delay 3 ;
  say("Hallo Dr. Bunsen.") ;
 delay 23 ;
  say("Dr. Bunsen?") ;
 delay 20 ;  
 clearAction ;
}

/* ************************************************************* */

object Tafel {
 setupAsStdEventObject(Tafel,LookAt,405,282,DIR_EAST) ; 		
 setClickArea(428,139,505,231) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Tafel" ;
}

object TafelParadox {
 setPosition(431,136) ;
 setAnim(Tafelparadox_image) ;
 visible = true ;
 enabled = ((BunsenStage > 0) and (BunsenStage < 3) and (lastRiddle == RIDDLE_PARADOX) and (chaseStage < 3)) ;
 clickable = false ;
 absolute = false ;
}

object TafelVoll {
 setPosition(429,139) ;
 setAnim(Tafelvoll_image) ;
 visible = true ;
 enabled = (((BunsenStage == 0) or (BunsenStage == 3)) and (countSolvedRiddles > 0)) ;
 clickable = false ;
 absolute = false ;
}

event LookAt -> Tafel {
 Ego:
  walkToStdEventObject(Tafel) ;
 suspend ;
  say("Hier h#ngt eine Tafel.") ;
  if ((!TafelVoll.enabled) and (!TafelParadox.enabled) and (!Bunsenschreibt.enabled)) say("Sie ist gewischt.") ;
  if (Bunsenschreibt.enabled) say("Sie wird gerade von Dr. Bunsen beschrieben.") ;
  if (TafelVoll.enabled) say("Dr. Bunsen hat hier ein R#tsel gel[st.") ;
  if (TafelParadox.enabled) say("Dr. Bunsen hat hier versucht ein R#tsel zu l[sen.") ;
 clearAction ;
}

event Push -> Tafel {
 Ego:
  walkToStdEventObject(Tafel) ;
 suspend ;
  EgoUse ;
 clearAction ;  
}

event Take -> Tafel {
 Ego:
  walkToStdEventObject(Tafel) ;
  "Nein, ich will sie nicht."	
}

event Kreide -> Tafel {
 if (did(Use)) triggerObjectOnObjectEvent(Use, Tafel) ;
  else {
   Ego:
    walkToStdEventObject(Tafel) ;
    "Meine Intuition sagt mir, dass die Tafel die Kreide nicht haben will."
  }
}

event Use -> Tafel {
 Ego:
  walkToStdEventObject(Tafel) ;
 suspend ;
 if (Bunsenschreibt.enabled or Bunsenweg.enabled) say("Der Wissenschaftler verperrt mir den Weg.") ;
  else say("F]r solche Spielereien habe ich jetzt keine Zeit.") ;
 clearAction ;
}

/* ************************************************************* */

object Dusche {
 setupAsStdEventObject(Dusche,LookAt,227,286,DIR_WEST) ; 		
 setClickArea(138,120,172,145) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Dusche" ;
}

event LookAt -> Dusche {
 Ego:
  walkToStdEventObject(Dusche) ;
  "Eine Notdusche ist ]ber der T]r angebracht."
 if (hasItem(Ego, Nachtsicht)) say("Steckdosen neben die T]r angebracht zu haben, ist deswegen etwas leichtsinnig.") ;
}

event Open -> Dusche {
 triggerObjectOnObjectEvent(Use, Dusche) ;
}

event Use -> Dusche {
 Ego:
  walkToStdEventObject(Dusche) ;
  "Ich denke, man schaltet Sie mit diesem Knopf hier links an."
}

/* ************************************************************* */

object Herdplatte {
 setupAsStdEventObject(Herdplatte,LookAt,170,355,DIR_WEST) ; 		
 setClickArea(0,232,141,276) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Platte" ;
}

event LookAt -> Herdplatte {
 Ego:
  walkToStdEventObject(Herdplatte) ;
 suspend ;
  say("Sieht nach einer por[sen Kunststoffoberfl#che aus.") ;
  say("Zu was sie dient, wei} ich nicht.") ;
 clearAction ;
}

event Use -> Herdplatte {
 Ego:
  walkToStdEventObject(Herdplatte) ;
  say("Ich wei} nicht, wie.") ;	
  say("Vielleicht kann man etwas mit den Reglern hier anfangen.") ;
}

event Push -> Herdplatte {
 triggerObjectOnObjectEvent(Pull, Herdplatte) ;
}

event Take -> Herdplatte {
 triggerObjectOnObjectEvent(Pull, Herdplatte) ;
}

event Open -> Herdplatte {
 triggerObjectOnObjectEvent(Pull, Herdplatte) ;	
}

event Pull -> Herdplatte {
 Ego:
  walkToStdEventObject(Herdplatte) ;
 suspend ;
  EgoUse ;
  say("Ich kann sie nicht bewegen.") ;
 clearAction ;
}

/* ************************************************************* */

object Bedienelemente {
 setupAsStdEventObject(Bedienelemente,Push,500,365,DIR_EAST) ; 		
 setClickArea(513,258,570,284) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Bedienelemente" ;
}

event LookAt -> Bedienelemente {
 Ego:
  walkToStdEventObject(Bedienelemente) ;
  "Mit diesen Drehschaltern wird man wohl die Herdplatte regulieren k[nnen." 
}

event Push -> Bedienelemente {
 triggerObjectOnObjectEvent(Use, Bedienelemente) ;
}

event Use -> Bedienelemente {
 Ego:
  walkToStdEventObject(Bedienelemente) ;
 suspend ;
 if ((hasItem(Ego, Ausdruck)) and (hasItem(Ego, Nachtsicht))) {
   say("Das bringt mich jetzt auch nicht weiter.") ;
   say("Ich sollte mich darauf konzentrieren, hier herauszukommen.") ;
   clearAction ;
   return ;
 }
 EgoUse ;
 if (maschineOn) {
   if (PlatteGra.getField(0)) platteAus ;
     else platteAn ;
 } else say("Es ist nichts passiert.") ;
 clearAction ;
}

/* ************************************************************* */

object Gangtuer {
 setupAsStdEventObject(Gangtuer,Open,170,292,DIR_WEST) ; 	
 setClickArea(124,145,170,231) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event LookAt -> Gangtuer {
 Ego:
  walkToStdEventObject(Gangtuer) ;
  say("Die T]r f]hrt wohl wieder in den Gang.") ;
  say("Eine Notdusche ist ]ber ihr installiert.") ;
}

event Close -> Gangtuer {
 Ego:
  walkToStdEventObject(Gangtuer) ;
  say("Sie ist schon zu.") ;  
}

event Push -> Gangtuer {
 Ego:
  walkToStdEventObject(Gangtuer) ;
 suspend ;
 EgoUse ;
 delay 2 ;
  say("Es ist nichts passiert.") ;
 clearAction ;
}

object Tueroffen {
 setPosition(115,143) ;
 //priority = 250 ;
 if (!shortCircuit) {
   if (Xray.enabled) setAnim(Tueroffen_image) ;
    else setAnim(TueroffenX_image) ;
 } else {
   if (Xray.enabled) setAnim(TueroffenD_image) ;
    else setAnim(TueroffenDX_image) ;	 
 }
 absolute = false ;
 clickable = false ;
 enabled = false ;
 visible = true ;
}

event Hotelkey -> Gangtuer {
 Ego:
  walkToStdEventObject(Gangtuer) ;
 suspend ;
 EgoUse ;
  say("Der Schl]ssel passt hier nicht.") ;
 clearAction ;
}

event Lab2Key -> Gangtuer {
 Ego:
  walkToStdEventObject(Gangtuer) ;
 suspend ;
 EgoUse ;
  say("Der Schl]ssel passt, aber ich halte das f]r keine gute Idee!") ;
 clearAction ;
}

event Open -> Gangtuer {
 Ego:
  walkToStdEventObject(Gangtuer) ;
 killEvents(123653) ;  
 suspend ;
 EgoStartUse ;
 soundBoxStart(Music::Tuerauf2_wav) ;
 Tueroffen.enabled = true ;
 EgoStopUse ;
 Ego:
  path = 0 ;
  pathAutoScale = false ;
  walk(107,285) ;
  delay 2 ;
  turn(DIR_SOUTH) ;
  EgoStartUse ;  
  visible = false ;
 soundBoxStart(Music::Tuerzu4_wav) ;  
 Tueroffen.enabled = false ;
 delay 3 ;
 Ego:
  visible = true ;
  pathAutoScale = true ;
 doEnter(Securitygang) ;
}

/* ************************************************************* */

object Xray {
 setupAsStdEventObject(Xray,LookAt,228,284,DIR_NORTH) ; 	
 priority = 2 ;
 setPosition(210,147) ;
 setAnim(Xray_image) ;
 setClickArea(0,0,27,36) ;
 absolute = false ;
 clickable = true ;
 enabled = !hasItem(Ego, Monkey) ;
 visible = true ;
 name = "R[ntgenbild" ;
}

event LookAt -> Xray {
 Ego:
  walkToStdEventObject(Xray) ;
 suspend ;

 triggerObjectOnObjectEvent(LookAt, Monkey) ;
 clearAction ;
}

event Take -> Xray {
 Ego:
  walkToStdEventObject(Xray) ;
 suspend ;
 say("Du kommst mit mir.") ;
 EgoStartUse ;
 Xray.enabled = false ;
 Tueroffen.setAnim(TueroffenX_image) ;
 takeItem(Ego, Monkey) ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Knopf {
 setupAsStdEventObject(Knopf,LookAt,175,292,DIR_WEST) ; 		
 setClickArea(112,199,124,211) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Knopf" ;
}

event LookAt -> Knopf {
 Ego:
  walkToStdEventObject(Knopf) ;
  say("Damit schaltet man die Notdusche an.") ;
}

event Push -> Knopf {
 triggerObjectOnObjectEvent(Use, Knopf) ;
}

event Use -> Knopf {
 Ego:
  walkToStdEventObject(Knopf) ;
 suspend ;
 if (hasItem(Ego, Nachtsicht)) {
   delay 2 ;
   say("Hmmmm....") ;
   delay 4 ;
   say("Gute Idee.") ;
   say("Wenn Wasser in die Steckdosen neben die T]r gelangt, wird wahrscheinlich ein Kurzschluss verursacht.") ;
   say("Schalte ich aber die Dusche an, gef#hrde ich mich dabei nur selbst!") ;
 } else say("Ich m[chte mich jetzt nicht duschen.") ;
 clearAction ;
}

/* ************************************************************* */

object Steckdosen {
 setupAsStdEventObject(Steckdosen,LookAt,175,292,DIR_WEST) ; 			
 setClickArea(113,212,127,232) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Steckdosen" ;
}

event LookAt -> Steckdosen {
 Ego:
  walkToStdEventObject(Steckdosen) ;
 suspend ;
  say("Zwei Steckdosen befinden sich hier links von der T]r.") ;
  if (hasItem(Ego, Nachtsicht)) say("Ob es schlau war, die Notdusche in unmittelbarer N#he zu installieren?") ;
 clearAction ;
}

event Use -> Steckdosen {
 Ego:
  walkToStdEventObject(Steckdosen) ;
  "Was soll ich einstecken?"	
}

event Fax -> Steckdosen {
 Ego:
  walkToStdEventObject(Steckdosen) ;
 suspend ;
  "Ich w]sste nicht, wozu."	
  "Es fehlt hier ein Telefon- oder Computeranschluss."
 clearAction ;
}

event CarpetScrap -> Steckdosen {
 Ego:
  walkToStdEventObject(Steckdosen) ;
 suspend ;
 if (shortCircuit) say("Ich w]sste nicht, wozu.") ;
  else {
    say("Er ist noch mit Benzin getunkt.") ;
    say("Ich m[chte keine unn[tigen Risiken eingehen.") ;
  }
 clearAction ;
}

event Kittel -> Steckdosen {
 Ego:
  walkToStdEventObject(Steckdosen) ;
 suspend ;
  say("Das kann ich nicht in die Steckdosen stecken.") ;	
 clearAction ;
}

event Push -> Steckdosen {
 Ego:
  walkToStdEventObject(Steckdosen) ;
 suspend ;
  "Ich h#nge an meinem Leben."		
 clearAction ;
}

event Shoe -> Steckdosen {
 Ego:
  walk(175,292) ;
  turn(DIR_WEST) ;
 if (did(give)) {
   say("Die Steckdose will das nicht.") ;
   clearAction ;
   return ;
 }
 if (! Shoe.getField(0)) {
   say("Das w]rde nichts bringen.") ;
   clearAction ;
   return ;
 }
 if (! hasItem(Ego, Ausdruck)) {
   say("Lieber nicht.") ;
   say("Das k[nnte einen Kurzschluss verursachen...") ;
   say("Und ich w]sste nicht, wie mir das jetzt weiterhelfen sollte.") ;
   clearAction ;
   return ;
 }
 if (! hasItem(Ego, Nachtsicht)) { // obsolete
   say("Die Idee ist gar nicht mal so schlecht.") ;
   say("Das Problem ist, ich habe nur diese Taschenlampe, um mich zurecht zu finden.") ;
   say("Und diese zwei Affen w]rden sie bestimmt sehen.") ;
   delay 10 ;
   say("Und ich glaube auch nicht, dass ich sie irgendwie erschrecken kann.") ;
   clearAction ;
   return ;
 }
 if (shortCircuit) {
   say("Ich habe bereits einen Kurzschluss verursacht!") ;
   clearAction ;
   return ;
 }
 delay 5 ;
  say("Das k[nnte klappen.") ;
 delay 4 ;
  EgoStartUse ;
 soundBoxPlay(Music::Wassermarsch_wav) ;
 soundBoxStart(Music::Kurzschluss_wav) ;
 if (!nightvision.enabled) darknessEffect.enabled = true ;
 shortCircuit = true ;
 if (Xray.enabled) Tueroffen.setAnim(TueroffenD_image) ;
  else Tueroffen.setAnim(TueroffenDX_image) ;	 
 backgroundImage = Securitylab2D_image ;
 Shoe.name = "alter Schuh" ;
 Shoe.setField(0,0) ;
  EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

script maschineOn {
  return Maschine.getField(0) ;
}

object Maschine {
 setupAsStdEventObject(Maschine,LookAt,445,326,DIR_EAST) ; 			
 setClickArea(506,174,549,243) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Ger#t" ;
}

object MaschineGra {
 setAnim(MaschineOn_image) ;
 setPosition(514,181) ;
 absolute = false ;
 enabled = Maschine.getField(0) ;
 visible = true ;
 clickable = false ;
}

event LookAt -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
 suspend ;
  say("Das Ger#t hat einige Kn[pfe, ein Display, und ist an mehrere Rohre angeschlossen.") ;
  say("Auf dem Display steht:") ;
  if (Maschine.getField(0)) say("'on'") ;
   else say("'off'") ;
 clearAction ;
}

event Push -> Maschine {
 triggerObjectOnObjectEvent(Use, Maschine) ;
}

event Take -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
 suspend ;
  "Lieber nicht."
  "Vielleicht wird sie hier f]r etwas wichtiges ben[tigt."
 clearAction ;
}

event TalkTo -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
 suspend ;
  say("Hallo?") ;	
 delay 4 ;
  say("Ist da jemand drin?") ;
 delay 22 ;
 clearAction ;
}

event Use -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
 suspend ;
 EgoStartUse ;
 if (Maschine.getField(0)) MaschineGra.enabled = false ;
  else MaschineGra.enabled = true ;
 if (MaschineGra.enabled) soundBoxStart(Music::Onoffmaschine_wav) ;
 Maschine.setField(0, MaschineGra.enabled) ;
 EgoStopUse ;
 if ((!MaschineGra.enabled) and (PlatteGra.getField(0))) platteAus ;
 clearAction ;
}

/* ************************************************************* */

object Platte {
 setupAsStdEventObject(Platte,LookAt,500,365,DIR_EAST) ; 				
 setClickArea(531,244,635,261) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Platte" ;
}

event LookAt -> Platte {
 Ego:
  walkToStdEventObject(Platte) ;
 suspend ;
  say("Eine Herdplatte.") ;
 if (PlatteGra.getField(0)) say("Sie ist an.") ;
  else say("Sie ist aus.") ;
 if (PlatteGra.getField(0)) {
  say("Und sie sieht ziemlich hei} aus.") ;
  if (hasItem(Ego, Cactus)) and (random(2)==0) and (!cactusBurned) { 
    say("Ich frage mich gerade, ob es Oscar kalt ist.") ;
  }
 }
 clearAction ;
}

event Use -> Platte {
 triggerObjectOnObjectEvent(Push, Platte) ;
}

event Push -> Platte {
 Ego:
  walkToStdEventObject(Platte) ;
 suspend ;
  if (PlatteGra.getField(0)) say("Nein. In meinem Leichtsinn k[nnte ich mich noch verletzen.") ;
   else say("Lieber nicht. Schlechte Erfahrungen.") ;
 clearAction ;
}

event Faxpapier -> Platte {
 triggerObjectOnObjectEvent(Thermopapier, Platte) ;
}

event Thermopapier -> Platte {
 Ego:
  walkToStdEventObject(Platte) ;
 suspend ;
 if (PlatteGra.getField(0)) say("Ich will das Papier nicht verbrennen. Es k[nnte noch n]tzlich sein.") ;
  else say("Solange die Platte aus ist, wird nichts passieren.") ;
 clearAction ;
}

event Ausdruck -> Platte {
 Ego:
  walkToStdEventObject(Platte) ;
 suspend ;
 if (PlatteGra.getField(0)) say("Auf keinen Fall! Der Ausdruck ist wichtig.") ;
  else say("Solange die Platte aus ist, wird nichts passieren.") ;
 clearAction ;
	
}

event Cactus -> Platte {
 Ego:
  walkToStdEventObject(Platte) ;
 suspend ;
 
 if (cactusDestroyed) {
  say("Nein, daf]r ist es jetzt zu sp#t.") ;
  say("M[ge er in Frieden ruhen.") ;
  clearAction ;
  return ;
 }
 
 if ((hasItem(Ego, Ausdruck)) and (hasItem(Ego, Nachtsicht))) {
   say("Das bringt mich jetzt auch nicht weiter.") ;
   say("Ich sollte mich darauf konzentrieren, hier herauszukommen.") ;
   clearAction ;
   return ;
 }
 
 if (cactusBurned) {
  say("Ich denke, ihm ist jetzt warm genug.") ;
  clearAction ;
  return ;
 }
 
 say("Na Oscar, ist dir kalt?") ;
 delay 19 ;
 say("Du sagst ja gar nichts...") ;
 delay 10 ;
 
 if (!maschineOn) {
   EgoStartUse ;  
    dropItem(Ego, cactus) ;
    if (cactusMutated) OscarGra.frame = 1 ;  
     else OscarGra.frame = 0 ;
    OscarGra.enabled = true ;
   EgoStopUse ;
   delay 10 ;
   EgoUse ;
   delay 5 ;
   say("Hmmm... die Herdplatte scheint nicht zu funktionieren.") ; 
   EgoStartUse ;
   takeItem(Ego, Cactus) ;
   OscarGra.enabled = false ;
   EgoStopUse ;
   clearAction ;
   return ;
 }
 
 if (cactusMutated) say("Ich glaube, er ist noch etwas sauer auf mich, weil ich ihn mit dem mutagenen Abwasser gegossen habe.") ;
 delay 2 ;
 if (platteGra.getField(0)) {
  EgoUse ;
  platteAus ;
  delay 3 ;
 }
 EgoStartUse ;  
 soundBoxStart(Music::Putoscar_wav) ;
  dropItem(Ego, cactus) ;
  if (cactusMutated) OscarGra.frame = 1 ;  
   else OscarGra.frame = 0 ;
  OscarGra.enabled = true ;
 EgoStopUse ;
 delay 10 ;
 EgoUse ;
 platteAn ;
 delay 14 ;
 start soundBoxStart(Music::Burn_wav) ;
 delay 7 ;
 OscarGra.frame = 2 ;
 delay 10 ;
 EgoUse ;
 platteAus ;
 delay 5 ;
 EgoStartUse ;
  burnCactus ;
  takeItem(Ego, Cactus) ;
  OscarGra.enabled = false ;
 EgoStopUse ;
 if (cactusMutated) {
   delay 10 ;
   say("Seine Mutanten-Stacheln sind verbrannt.") ;
   say("Er sollte mir dankbar sein.") ;
 }
 clearAction ;	
}

object OscarGra {
 setPosition(551,214) ;
 setAnim(Oscar_sprite) ;
 autoAnimate = false ;
 frame = 0 ;
 visible = true ;
 enabled = false ;
 absolute = false ;
 clickable = false ;
 priority = 2 ;
}

object PlatteGra {
 setPosition(545,228) ;
 setAnim(Platte_sprite) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 autoAnimate = false ;
 if (getField(0)) frame = 10 ;
  else frame = 0 ;
 priority = 1 ;
}

script platteAn {
 PlatteGra:
  setField(0, 1) ;
  frame = 0 ;
 for (var i=0; i<11; i++) {
  delay 5 ;
  frame = i ;
 }
}

script platteAus {
 PlatteGra:
  setField(0, 0) ;
  frame = 10 ;
 for (var i=10; i>=0; i--) {
  delay 5 ;
  frame = i ;
 }
}


/* ************************************************************* */

object Wasserhahn {
 setupAsStdEventObject(Wasserhahn,LookAt,308,370,DIR_SOUTH) ; 					
 setClickArea(229,286,396,362) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Wasserhahn" ;
}

event Cactus -> Wasserhahn {
 Ego:
  walkToStdEventObject(Wasserhahn) ;
 suspend ;
 
 if (cactusDestroyed) {
  say("Nein, daf]r ist es jetzt zu sp#t.") ;
  say("M[ge er in Frieden ruhen.") ;
  clearAction ;
  return ;
 }
 
 if (!cactusDrowned) {
 
  say("Hast Du Durst, Oscar?") ; 
 delay 23 ;
 EgoStartUse ;
 
 dropItem(Ego, Cactus) ;
 soundBoxPlay(Music::Oscargiess_wav) ;

 drownCactus ;
 
 takeItem(Ego, Cactus) ;
 EgoStopUse ;
 } else Ego.say("Ich glaube, er hat genug getrunken.") ;
 
 clearAction ;
}

event LookAt -> Wasserhahn {
 Ego:
  walkToStdEventObject(Wasserhahn) ;
  "Ein stinktnormaler Wasserhahn."
}

event Close -> Wasserhahn {
 Ego:
  walkToStdEventObject(Wasserhahn) ;
  "Er ist schon geschlossen."	
}

event Open -> Wasserhahn {
 triggerObjectOnObjectEvent(Use, Wasserhahn) ;
}

event Use -> Wasserhahn {
 Ego:
  walkToStdEventObject(Wasserhahn) ;
 suspend ;
  say("Ich kann mir nicht vorstellen, wie mir das weiterhelfen k[nnte.") ;
 clearAction ;
}

event Take -> Wasserhahn {
 Ego:
  walkToStdEventObject(Wasserhahn) ;
  "Dazu br#uchte ich passendes Werkzeug." ;
}

event Shoe -> Wasserhahn {
 Ego:
  walk(308,370) ;
  turn(DIR_SOUTH) ;
 if did(give) {
   Ego.say("Ich denke der Wasserhahn will das nicht.") ;
   clearAction ;
   return ;
 }
 if (Shoe.getField(0)) {
   Ego.say("Der Schuh ist schon voller Wasser.") ;
   clearAction ;
   return ;
 }
 if (shortCircuit) {
   Ego.say("Ich brauche kein weiteres Wasser mehr.") ;
   clearAction ;
   return ;
 }
  EgoStartUse ;
  
  dropItem(Ego, Shoe) ;
 soundBoxPlay(Music::Fillshoe_wav) ;
  EgoStopUse ;
  takeItem(Ego, Shoe) ;
  Shoe.name = "alter Schuh voller Wasser" ;
  Shoe.setField(0, 1) ;
 clearAction ;
}

/* ************************************************************* */

object Besteck {
 setupAsStdEventObject(Besteck,LookAt,230,306,DIR_EAST) ; 					
 setClickArea(246,221,310,255) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Sezierbesteck" ;
}

event LookAt -> Besteck {
 Ego:
  walkToStdEventObject(Besteck) ;
 suspend ;
 say("Uuuh. Ich will gar nicht wissen, was man hier alles erforscht.") ;
 clearAction ;
}

event Take -> Besteck {
 Ego:
  walkToStdEventObject(Besteck) ;
 suspend ;
 say("Es ist unglaublich, aber es gibt Dinge, die will ich einfach nicht mitnehmen.") ;
 clearAction ;
}

/* ************************************************************* */

object Regal {
 setupAsStdEventObject(Regal,LookAt,350,253,DIR_EAST) ; 					
 setClickArea(358,179,418,242) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Regal" ;
}

event LookAt -> Regal {
 Ego:
  walkToStdEventObject(Regal) ;
 suspend ;
  say("Ein Schwerlasten-Regal.") ;
 if (!Papier.getField(0)) say("Ein Stapel Papier liegt auf einem der Regalbretter.") ;  
 clearAction ;
}

event Take -> Regal {
 Ego:
  walkToStdEventObject(Regal) ;
 suspend ;
  say("Dazu m]sste ich es erst demontieren.") ;
  say("Au}erdem will ich es nicht.") ;
 clearAction ;
}