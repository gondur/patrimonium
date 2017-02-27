// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 if (previousScene!=Securityhack) panelFrequency = random(8) ;
 LEDGra.stopAnimDelay = (panelFrequency+1) * 2 ;	

 if (!hasItem(Ego, Ausdruck)) wagenMoved = false ;
 
 scrollX = 0 ;
 Jack.enabled = false ;
 John.enabled = false ;
 Ego:
 enableEgoTalk ;
  enabled = true ;
  visible = true ;
 hideInventory ;
 backgroundImage = Securitygef_image;
 backgroundZBuffer = Securitygef_zbuffer ;
  path = Securitygef_path ;
  
 if (previousScene == Securityhack) { // LED 
  setPosition(256,265) ;
  face(DIR_NORTH) ;
  backgroundZBuffer = 0 ;
  forceShowInventory ;
 } else if (previousScene == Securitygef2) { //raum hinter gemälde
  Tuerzu.enabled = true ;	 
  setPosition(305,290) ;
  face(DIR_WEST) ;
  forceShowInventory ;
  backgroundZBuffer = 0 ;
  if (FlashLight.getField(0)) {
    FlashlightOff ;
    DarknessEffect.enabled = false ;
    delay transitionTime ;
    if (hasItem(Ego, Nachtsicht)) {
      say("Die Batterien der Taschenlampe sind nun endg]ltig leer.") ;
      say("Ich werfe sie weg.") ;
      EgoStartUse ;
      Flashlight.setField(1, true) ;
      delay ;
      EgoStopUse ;
    } else say("Die Taschenlampe habe ich ausgeschaltet.") ;
  }
  if (nightVision.enabled) {
    nightVisionOff ;
    DarknessEffect.enabled = false ;
    delay transitionTime ;
    say("Das Nachtsichtger#t habe ich ausgeschaltet.") ;
  }
 } else {
  if (chaseStage == 2) busted ;
   else {
    setPosition(299,287) ;
    face(DIR_EAST) ;
    backgroundZBuffer = 0 ;
    forceShowInventory ;
   }
 }
 
 secLab2Locked = false ;
 clearAction ;
}

/* ************************************************************* */

object LED {
 setupAsStdEventObject(LED,LookAt,256,265,DIR_NORTH) ;
 setClickArea(239,168,255,186) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "LED" ;
}

event LookAt -> LED {
 Ego:
  walkToStdEventObject(LED) ;
 suspend ;
 if (!readSciDiary) {
  say("Auf dieser LED steht 'GAME OVER'.") ;
  say("Sie blinkt.") ;
 } else Ego.say("Das muss die LED sein, von der der Wissenschaftler in seinen Aufzeichnungen schrieb.") ;
 clearAction ;
}

event Push -> LED {
 Ego:
  walkToStdEventObject(LED) ;
 suspend ;
 EgoUse ;
  say("Es ist nichts passiert.") ;
 clearAction ;
}

event Open -> LED {
 triggerObjectOnObjectEvent(Take, LED) ;
}

event Pull -> LED {
 triggerObjectOnObjectEvent(Take, LED) ;
}

event Take -> LED {
 Ego:
  walkToStdEventObject(LED) ;
 suspend ;
 EgoUse ;
  say("Ich bekomme sie nicht ab.") ;
 clearAction ;
}

event Screwdriver -> LED {
 Ego:
  walkToStdEventObject(LED) ;
 suspend ;
 EgoUse ;
  say("Damit bekomme ich sie nicht weggehebelt.") ;
 clearAction ;	
}

event Hammer -> LED {
 Ego:
  walkToStdEventObject(LED) ;
 suspend ;
 EgoUse ;
  say("Lieber nicht.") ;
  say("Vielleicht zerst[re ich dabei die gesamte T]r-Elektrik, und bleibe f]r immer hier gefangen!") ;
 clearAction ;		
}

object LEDGra {
 setPosition(238,165) ;
 setAnim(LEDblinkt_sprite) ;
 visible = true ;
 enabled = true ;
 clickable = false ;
 absolute = false ;
 stopAnimDelay = panelFrequency * 2 ;
}

event freqDevice -> LED {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(LED) ;
 suspend ;
 if (used) {
   if (readSciDiary) {
     if (freqDeviceWorking) {
       EgoStartUse ;
       doEnter(Securityhack) ;
       return ;
     } else say("Der Frequenzmultiplext]r[ffner funktioniert ohne Batterien nicht.") ;
   } else say("Ich wei} doch nichtmal, wozu dieses Ger#t dient.") ;
 } else say("Ich glaube nicht, dass die LED das Ger#t haben m[chte.") ;
 clearAction ;
}

event Use -> LED {
 Ego:
  walkToStdEventObject(LED) ;
 suspend ;
 if (readSciDiary) {
   if (freqDeviceWorking) {
     say("Ich verwende den Frequenzmultilplext]r[ffner.") ;
     EgoStartUse ;
     doEnter(Securityhack) ;
     return ;
   } else say("Ich k[nnte diesen Frequenzmultiplext]r[ffner versuchen, aber der funktioniert ohne Batterien nicht.") ;
 } else say("Ich w]sste nicht, wie...") ;
 clearAction ;
}

/* ************************************************************* */

script busted {

 static var firstBusted = true ;
 Tuerzu.enabled = false ;
 John:
  priority = PRIORITY_AUTO ;
  enabled = true ;
  if (! firstBusted) { enabled = false ; }
  visible = true ;
  setPosition(104,290) ;
  face(DIR_EAST) ;
  path = 0 ;
  scale = 700 ;
  pathAutoScale = false ;
 Ego:
  setPosition(104,290) ;
  face(DIR_EAST) ;
  path = 0 ;
  scale = 700 ;
  pathAutoScale = false ;
  walk(299,287) ;
  path = Securitygef_path ;
  pathAutoScale = true ;
 John:
  if (firstBusted) {
    walk(162,282) ;
    "Und hier bleiben Sie Herr Hobler."
    delay 10 ;
    walk(104,290) ;
  }
  enabled = false ;
 backgroundZBuffer = 0 ;
 soundBoxStart(Music::Geftuerzu_wav) ;
 Tuerzu.enabled = true ;
 firstBusted = false ;
 
 delay 3 ;

 start {
   if JukeBox.running {
     delay while (GetMusicPosition(jukeBox.CurRes) < GetDuration(jukeBox.CurRes)) ;
   }
   jukeBox_Stop ;
   jukeBox_Enqueue(Music::BG_Serpentinetrek_mp3) ;
   jukeBox_Shuffle(true) ;
   jukeBox_Start ;
 }    
 
 forceShowInventory ;
 delay 3 ;
}

/* ************************************************************* */

object Lukezu {
 setPosition(329,200) ;
 setAnim(Lukezu_image) ;
 absolute = false ;
 enabled = (chaseStage <= 2) ;
 visible = true ;
 clickable = false ;
}

object Leiter {
 setupAsStdEventObject(Leiter,Use,305,290,DIR_EAST) ; 				
 setClickArea(337,271,409,307) ;
 absolute = false ;
 clickable = true ;
 enabled = (chaseStage > 2) ;
 visible = false ;
 name = "Leiter" ;
}

event LookAt -> Leiter {
 Ego:
  walkToStdEventObject(Leiter) ;
  say("Eine rote stabile Leiter, die in einen geheimen Raum weiter unten f]hrt.") ;
}

event Take -> Leiter {
 Ego:
  walkToStdEventObject(Leiter) ;
 suspend ;
  say("Ich kann sie nicht nehmen.") ;
  say("Sie ist festgemacht.") ;
 clearAction ;
}

event Use -> Leiter {
 clearAction ;
 Ego:
  walk(305, 290) ;
 suspend ;
  turn(DIR_EAST) ;
 delay 3 ;
 if (!hasItem(Ego, Nachtsicht)) doEnter(Securitygef2) ;
  else {
    say("Jetzt da ich das Nachtsichtger#t habe, ist da unten absolut nichts mehr, was mir weiterhelfen k[nnte.") ;
    clearAction ;
  }
}

/* ************************************************************* */

object TuerZu {
 setPosition(156,128) ;
 setAnim(Tuerzu_image) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = false ; 
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,LookAt,230,284,DIR_WEST) ; 		
 setClickArea(163,161,240,302) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event freqDevice -> Tuer {
 Ego:
 if (did(give)) {
   walkToStdEventObject(Tuer) ;
   suspend ;
    say("Die T]r will das Ding nicht haben.") ;
   clearAction ;
   return ;	 
 }
 if (!readSciDiary) {
   walkToStdEventObject(Tuer) ;
   suspend ;
    say("Ich wei} nicht, wie das funktionieren soll.") ;
   clearAction ;
   return ;
 }
  say("Ich benutze das Ger#t mit der blinkenden LED.") ;
  triggerObjectOnObjectEvent(freqDevice, LED) ;
}

event LookAt -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 if (!TuerZu.enabled) say("Die T]r ist offen.") ;
  else say("Eine massive Stahlt]r. Rechts davon blinkt etwas.") ;
 clearAction ;
}

event WalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 if (!TuerZu.enabled) {
  suspend ;
  doEnter(Securitygang) ;
 } else clearAction ;
}

event Use -> Tuer {
 if (!TuerZu.enabled) triggerObjectOnObjectEvent(WalkTo, Tuer) ;
  else triggerObjectOnObjectEvent(Open, Tuer) ;
}

event Close -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 if (TuerZu.enabled) say("Die T]r ist bereits zu.") ;
  else say("Ich kann sie nicht schlie}en.") ;
 clearAction ;
}

event Open -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 if (!TuerZu.enabled) say("Die T]r ist bereits offen.") ;
  else { 
    EgoUse ; 
    delay 5 ; 
    say("Sie hat keinen Griff.") ;
  }
 clearAction ;
}

event Push -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 if (!TuerZu.enabled) say("Das geht nicht, solange sie offen ist.") ;
  else {
   delay 2 ;
   EgoUse ;
   delay 4 ;
    say("Sie bewegt sich kein St]ck.") ;
  }
 clearAction ;
}

event TalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 delay 3 ;
  say("Hallo?") ; 
 delay 10 ;
 clearAction ;
}

event Lab2key -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
  say("Diese T]r hat kein Schloss wo dieser Schl]ssel passen k[nnte.") ;
 clearAction ;
}

/* ************************************************************* */

object Plan {
 setupAsStdEventObject(Plan,LookAt,290,268,DIR_NORTH) ; 		
 setClickArea(283,103,380,159) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Plan" ;
}

event TalkTo -> Plan {
 Ego:
  walkToStdEventObject(Plan) ;
 suspend ;
 delay 2 ;
  "Hallo?"
 delay 10 ;
 clearAction ;
}

event default -> Plan {
 Ego:
  walkToStdEventObject(Plan) ;
 suspend ;
  say("Ich komme nicht ran.") ;	
 clearAction ;
}

event LookAt -> Plan {
 Ego:
  walkToStdEventObject(Plan) ;
 suspend ;
  "Hier h#ngt ein Plan an der Wand."
  "Ich glaube, ihn schonmal gesehen zu haben."
 clearAction ;
}

/* ************************************************************* */

object Lampe {
 setupAsStdEventObject(Lampe,LookAt,240,292,DIR_EAST) ; 		
 setClickArea(307,52,353,75) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Lampe" ;
}

event LookAt -> Lampe {
 Ego:
  walkToStdEventObject(Lampe) ;
  say("Darauf haben sich schon Spinnweben abgesetzt.") ;
}

event TalkTo -> Lampe {
 Ego:
  walkToStdEventObject(Lampe) ;
 suspend ;
 delay 3 ; 
  say("Hallo?") ;
 delay 12 ;
 clearAction ;
}

event default -> Lampe {
 Ego:
  walkToStdEventObject(Lampe) ;
 suspend ;
  say("Ich komme nicht ran.") ;	
 clearAction ;
}

/* ************************************************************* */

object Schwein {
 setupAsStdEventObject(Schwein,Open,298,276,DIR_NORTH) ; 		
 setClickArea(322,163,348,180) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schwein" ;
}

event LookAt -> Schwein {
 Ego:
  walkToStdEventObject(Schwein) ;
 suspend ;
  say("Ein rosa Prozelan-Sparschwein steht auf einer der Boxen.") ;
 clearAction ;
}

event Take -> Schwein {
 Ego:
  walkToStdEventObject(Schwein) ;
 suspend ;
 delay 3 ;
 EgoStartUse ;
 delay 10 ;
 EgoStopUse ;
  say("Es ist leer.") ;
  say("Ich brauche es nicht.") ;
 clearAction ;	
}

event Push -> Schwein {
 triggerObjectOnObjectEvent(Pull, Schwein) ;
}

event Pull -> Schwein {
 Ego:
  walkToStdEventObject(Schwein) ;
 suspend ;
  say("Ich m[chte es nicht herunterwerfen.") ;
 clearAction ;	
}

event TalkTo -> Schwein {
 Ego:
  walkToStdEventObject(Schwein) ;
 suspend ;
 delay 3 ;
  say("Hallo, Schwein!") ;
 delay 18 ;
 clearAction ;	
}

event Open -> Schwein {
 Ego:
  walkToStdEventObject(Schwein) ;
 suspend ;
  say("Man muss es kaputt machen, um an den Inhalt zu gelangen.") ;
 clearAction ;	
}

event Hammer -> Schwein {
 Ego:
  walkToStdEventObject(Schwein) ;
 suspend ;
 delay 3 ;
 EgoStartUse ;
 delay 10 ;
 EgoStopUse ; 
  say("Es ist leer.") ;
  say("Ich brauche es also nicht kaputt zu schlagen.") ;
 clearAction ;	
}

/* ************************************************************* */

object Katze {
 setupAsStdEventObject(Katze,LookAt,299,279,DIR_EAST) ; 		
 setClickArea(365,188,391,216) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Wachs-Katze" ;
}

event LookAt -> Katze {
 Ego:
  walkToStdEventObject(Katze) ;
 suspend ;
  say("Eine graue Katzenfigur aus Wachs steht dort hinten.") ;
  say("Sie schaut in die Ecke.") ;
 clearAction ;
}

event Take -> Katze {
 Ego:
  walkToStdEventObject(Katze) ;
 suspend ;
  say("Sie hilft mir nicht weiter.") ;
  say("Ich m[chte sie nicht unn[tig mit mir herumtragen.") ;
 clearAction ;	
}

/* ************************************************************* */

object Idol {
 setupAsStdEventObject(Idol,LookAt,300,290,DIR_EAST) ; 		
 setClickArea(377,205,402,249) ;
 absolute = false ;
 clickable = true ;
 enabled = (chaseStage <= 2) ;
 visible = false ;
 name = "sagenumwobenes Idol" ;
}

event LookAt -> Idol {
 Ego:
  walkToStdEventObject(Idol) ;
 suspend ;
  say("Ein G[tzenbild mit einer langen Nase.") ;
  if (random(2)==0) say("Es kommt mir bekannt vor.") ;
 clearAction ;	
}

event TalkTo -> Idol {
 Ego:
  walkToStdEventObject(Idol) ;
 suspend ;
 delay 3 ;
  say("Hallo?") ;
 delay 14 ;
 clearAction ;		
}

event Take -> Idol {
 Ego:
  walkToStdEventObject(Idol) ;
 suspend ;
  say("Ich brauche es nicht.") ;
 clearAction ;
}

/* ************************************************************* */

object Schrei {
 setupAsStdEventObject(Schrei,LookAt,300,290,DIR_EAST) ; 		
 setClickArea(410,152,459,256) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Gem#lde" ;
}

event LookAt -> Schrei {
 Ego:
  walkToStdEventObject(Schrei) ;
 suspend ;
  say("Entweder das Original oder eine Kopie von Edward Munchs Bild 'Der Schrei'.") ;
  say("Zweifelsohne ein expressionistisches Meisterwerk.") ;
 clearAction ;
}

event TalkTo -> Schrei {
 Ego:
  walkToStdEventObject(Schrei) ;
 suspend ;
 delay 5 ;
  say("HALLO!") ;
 delay 16 ;
 clearAction ;	
}

event Take -> Schrei {
 Ego:
  walkToStdEventObject(Schrei) ;
 suspend ;
  say("Lieber nicht.") ;
  say("Das Bild ist zu unhandlich, um es mit mir herumzutragen.") ;
 clearAction ;	
}

/* ************************************************************* */

object Naht {
 setupAsStdEventObject(Naht,LookAt,255,344,DIR_EAST) ; 			
 setClickArea(289,335,315,354);
 enabled = !hasItem(Ego, SciDiary) ;
 visible = false ;
 clickable = true ;
 absolute = false ;
 name = "Anhebung" ;
}

event LookAt -> Naht {
 Ego:
  walkToStdEventObject(Naht) ;
 suspend ;
 delay 5 ;
  say("Hier ist die Matratze etwas h[her als sonst.") ;
 delay 10 ;
  say("Ein St]ck des {berzugs wurde an dieser Stelle nachtr#glich wieder angen#ht.") ;
 clearAction ;
}

event Pull -> Naht {
 triggerObjectOnObjectEvent(Take, Naht) ;
}

event Open -> Naht {
 triggerObjectOnObjectEvent(Take, Naht) ;
}

event Take -> Naht {
 Ego:
  walkToStdEventObject(Naht) ;
 suspend ;
 delay 4 ;
 EgoUse ;
 delay 2 ;
 EgoUse ;
  say("Mit blo}en H#nden bekomme ich die Naht nicht aufgerissen.") ;
 clearAction ;	
}

event Hammer -> Naht {
 triggerObjectOnObjectEvent(Screwdriver, Naht) ;
}

event Lab2key -> Naht {
 triggerObjectOnObjectEvent(Screwdriver, Naht) ;	
}

event Hotelkey -> Naht {
 triggerObjectOnObjectEvent(Screwdriver, Naht) ;	
}

event Pen -> Naht {
 triggerObjectOnObjectEvent(Screwdriver, Naht) ;	
}

event Screwdriver -> Naht {
 Ego:
  walkToStdEventObject(Naht) ;
 suspend ;
 delay 5 ;
  say("Damit k[nnte ich die Naht aufrei}en.") ; 
 delay 7 ;
 EgoStartUse ;
   soundBoxStart(Music::Stoff_wav) ;
   delay 3 ;
   Naht.enabled = false ;
   MatratzeOffenGra.enabled = true ;   
   takeItem(Ego, freqDevice) ;
   takeItem(Ego, SciDiary) ;
 delay 7 ;
 EgoStopUse ;
 delay 3 ;
  say("Hier hatte jemand die Matratze als Versteck umfunktioniert.") ;
 delay 4 ;
  say("Darin befand sich eine Art Tagebuch, und ein seltsames Ger#t.") ;
  say("Ich habe beides eingesteckt.") ;
 delay 3 ;
 clearAction ;
}

object MatratzeOffenGra {
 setPosition(289,326) ;
 setAnim(MatratzeOffen_image) ;
 absolute = false ;
 enabled = hasItem(Ego, SciDiary) ; 
 visible = true ;
 clickable = false ;
}


object Matratze {
 setupAsStdEventObject(Matratze,Use,260,335,DIR_EAST) ; 		
 setClickArea(291,305,450,358) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Matratze" ;
}

event LookAt -> Matratze {
 Ego:
  walkToStdEventObject(Matratze) ;
 suspend ;
  say("Eine alte, gebrauchte Matraze.") ;
  if (flipCounter) say("Vielleicht waren hier vor mir schon andere eingesperrt.") ;
 clearAction ;
}

event Use -> Matratze {
 Ego:
  walkToStdEventObject(Matratze) ;
 suspend ;
  say("Ich habe momentan wesentlich wichtigeres zu tun, als ans Schlafen zu denken!") ;
 clearAction ;
}
