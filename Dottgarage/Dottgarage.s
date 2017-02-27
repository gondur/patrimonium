// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 Ego:
 
 enableEgoTalk ;
  enabled = true ;
  visible = true ;
 forceShowInventory ;
 backgroundImage = Dottgarage_image;
 backgroundZBuffer = Dottgarage_zbuffer ;
  path = Dottgarage_path ;
  
 if (previousScene == Dott) {
  setPosition(588,223) ;
  face(DIR_WEST) ;
 } else if (previousScene == Dottrohre) {
  setPosition(317,194) ;  
  face(DIR_WEST) ;
 } else {
  setPosition(475,135) ;
  face(DIR_SOUTH) ;
 }
 
 
 
 start playSounds ;
 
 delay transitionTime ;
 
 clearAction ; 
 
}

/* ************************************************************* */

script playSounds {
 killOnExit = true ;
 killOnExit = true ;
 delay transitionTime ;
 loop {
   delay 69 ;
   delay random(69) ;
   delay (23)*(random(4)+4)+(23)*(random(5)+1) ;
   Auto.playSound(Music::Wasserunten_wav) ;      
 }
}

/* ************************************************************* */


// PujaTipp: Wasser regulieren

script pujaTipp {
 Ego:
  switch upcounter(6) {
    case 0: ;
    case 1: "Vielleicht schaue ich mir diese Maschine etwas genauer an."    
    case 2,3: "Diesen Deckel da kann man doch [ffnen." 
    case 4,5: "Vielleicht muss ich die Maschine erst irgendwie aktivieren, um diesen Hebel bedienen zu k[nnen."
    default : "So #hnlich wie die Maschine einem Auto sieht... vielleicht hilft mir eine Autobatterie?"
   }  		
}

/* ************************************************************* */

object draussen {
 setClickArea(600,39,640,286) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Hof" ;
}

event WalkTo -> draussen {
 clearAction ;
 Ego:
  walk(595,221) ;
 suspend ; 
 doEnter(Dott) ;
}

event LookAt -> draussen {
 clearAction ;
 Ego:
  turn(DIR_EAST) ;
  say("Hier geht es wieder auf den Hof.") ;
}

/* ************************************************************* */

object CKittel {
 setupAsStdEventObject(CKittel,Take,55,209,DIR_WEST) ; 			
 setPosition(0,86) ;
 setClickArea(0,0,40,20) ;
 setAnim(Kittel_image) ;
 enabled = ! hasItem(Ego, Kittel) ;
 visible = ! hasItem(Ego, Kittel) ;
 absolute = false ;
 clickable = true ;
 name = "Laborkittel" ;
}

event WalkTo -> CKittel {
 Ego:
  walkToStdEventObject(CKittel) ;
}

event Take -> CKittel {
 suspend ;
 Ego:
  walkToStdEventObject(CKittel) ;
 EgoStartUse ;
 takeItem(Ego, Kittel) ;
 CKittel:
  visible = false ;
  enabled = false ;
 EgoStopUse ;
 clearAction ;
}

event LookAt -> CKittel {
 Ego:
  walkToStdEventObject(CKittel) ;
  "Ein Laboranzug wie ich ihn damals im Chemie-Praktikum benutzt habe..."
  "...um Alkohol zu destillieren."
}

event Use -> CKittel {
 Ego:
  walkToStdEventObject(CKittel) ;
  say("Dazu sollte ich ihn lieber nehmen.") ;	
}

event Push -> CKittel {
 triggerObjectOnObjectEvent(Pull, CKittel) ;
}

event Pull -> CKittel {
 Ego:
  walkToStdEventObject(CKittel) ;
  say("Mit dem Laborkittel das Regal wischen?") ;
  say("Daf]r habe ich nicht Physik studiert.") ;
}

/* ************************************************************* */

object Tonnen {
 setupAsStdEventObject(Tonnen,LookAt,150,270,DIR_WEST) ; 		
 setClickArea(0,168,96,289) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Tonnen" ;
}

event LookAt -> Tonnen {
 Ego:
  walkToStdEventObject(Tonnen) ;
 EgoStartUse ;
 soundBoxStart(Music::Deckelzu_wav) ;
 EgoStopUse ;
 if (hasItem(Ego, Probe) or hasItem(Ego, Dokumente) or wonciekSample or wonciekDocuments) {
   Ego.say("Das erkl#rt einiges.") ;
 } else Ego.say("Hmmm... Sie sind leer.") ; 
}

event Reagenzglas -> Tonnen {
 Ego:
  walkToStdEventObject(Tonnen) ;
 suspend ;
  Ego.say("Die Tonnen sind leer.") ;
 clearAction ;
}

event Take -> Tonnen {
 Ego:
  walkToStdEventObject(Tonnen) ;
 Ego.say("Viel zu schwer.") ;	
 Ego.say("Au}erdem stinken sie zu sehr!") ;
}

event Push -> Tonnen {
 Ego:
  walkToStdEventObject(Tonnen) ;
 Ego.say("Viel zu schwer.") ;	
}

event Pull -> Tonnen {
 triggerObjectOnObjectEvent(Push, Tonnen) ;
}
	

/* ************************************************************* */

object Kiste {
 setupAsStdEventObject(Kiste,LookAt,500,134,DIR_EAST) ; 		
 setClickArea(516,89,566,142) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kiste" ;
}

object KisteGra {
 setPosition(509,75) ;
 setAnim(KisteOffen_image) ;
 clickable = false ;
 enabled = false ;
 visible = true ;
 absolute = false ;
}

event WalkTo -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
}

static var tookReagenz = false ;

event Open -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
 if (hasItem(Ego, Reagenzglas) or hasItem(Ego, Probe) or tookReagenz) { 
   EgoStartUse ;
   soundBoxStart(Music::Karton_wav) ;
   KisteGra.enabled = true ;
   delay 12 ;      
   KisteGra.enabled = false ;
   EgoStopUse ;	 
   say("Ich m[chte keine roten Heringe.") ;	
   delay 3 ;
   say("Schlechte Erfahrungen.") ;
   delay 2 ;
   say("Und von dem restlichen, gebrauchten Laborzubeh[r kann ich auch nichts mehr sinnvoll verwenden.") ;
 } else {
   EgoStartUse ;
   soundBoxStart(Music::Karton_wav) ;
   KisteGra.enabled = true ;
   delay 4 ;
   takeItem(Ego, Reagenzglas) ;
   tookReagenz = true ;
   delay 8 ;
   KisteGra.enabled = false ;
   EgoStopUse ;
   Kiste.setField(0,1) ;
   "Da sind Unmengen rote Zeltheringe drin."
   "Und neben gebrauchtem Laborzubeh[r ein einziges, sauberes Reagenzglas."
   "Ich habe es eingesteckt."
  }
 clearAction ; 
}

event LookAt -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Hier in der Ecke steht eine Umzugskiste aus Karton.") ; 
  if (Kiste.getField(0)) say("Es sind neben gebrauchtem Laborzubeh[r Unmengen rote Zeltheringe drin.") ;
 clearAction ;
}

event Pull -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
 if (Kiste.getField(0)) say("Unter einer Kiste voller roter Heringe kann man doch nicht ernsthaft etwas Wichtiges erwarten.") ;
  else say("Nein. Ich HASSE es, Kisten zu verschieben.") ;
 clearAction ;
}

event Push -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Noch weiter in Richtung Wand werde ich die Kiste nicht schieben k[nnen.") ;
 clearAction ;
}

event Close -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Sie ist schon geschlossen.") ;
 clearAction ;
}

event TalkTo -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  "Hallo?"
 clearAction ;  
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,Use,475,135,DIR_NORTH) ; 			
 setClickArea(436,27,506,129) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event LookAt -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
  "Oben ist ein roter Klebestreifen mit einem 'SamTec'-Aufdruck."
  "Unten ist ein kleines L]ftungsgitter."
}

event TalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 if (sawAgentsHint) {
   say("Hallo?") ;
  delay 10 ;
  clearAction ;
  return ;
 }
 delay 3 ;
 start EgoStartUse ;
 delay 3 ;
 start soundBoxPlay(Music::doorknock_wav) ;	
 
 delay 6 ;
 EgoStopUse ;
 delay 4 ;
  say("Hallo?") ;
 delay 1 ;
  say("Ist jemand da?") ;
 delay 12 ;
  say("Keine Antwort.") ;
 clearAction ;
}

event WalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
}

event Use -> Tuer {
 triggerObjectOnObjectEvent(Open, Tuer) ;
}

event Open -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;	
 suspend ;
 EgoStartUse ;
 doEnter(Dottbuero) ;
}

event Close -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
  say("Sie ist schon geschlossen.") ;
 clearAction ; 
}

event Push -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 delay 2 ;
 EgoUse ;
 delay 2 ; 
  say("Nichts.") ;
 clearAction ;
}

event Pull -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 delay 2 ; 
  say("Ich finde bis auf den T]rknauf keinen Angriffspunkt.") ;
 delay 5 ;
  say("Da f#llt mir ein, dass man T]ren ja auch [ffnen kann.") ;
 clearAction ;
}

event HotelKey -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
  say("Die T]r hat kein Schloss.") ;
 clearAction ;
}

/* ************************************************************* */

script insertedBattery {
 return Deckel.getField(0) ;
}

object Deckel {
 setupAsStdEventObject(Deckel,LookAt,141,227,DIR_NORTH) ; 	
 setClickArea(132,97,176,129) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Deckel" ;
}

event Battery -> Deckel {
 walkToStdEventObject(Deckel) ;
 suspend ;
 EgoStartUse ;
 DeckelGra.enabled = true ;
 EgoStopUse ;
 delay 2 ;
 Ego.say("Wie war das doch gleich?") ;
 delay 3;
 Ego.say("Schwarz ist Rot und Plus ist Minus.") ;
 delay 4 ;
 EgoStartUse ;
 dropItem(Ego, Battery) ;
 Deckel.setField(0, true) ;
 DeckelGra.setAnim(DeckelOffen2_image) ;
 EgoStopUse ;
 EgoStartUse ;
 DeckelGra.enabled = false ;
 EgoStopUse ;
 delay 2 ;
 clearAction ;
}

event LookAt -> Deckel {
 Ego:
  walkToStdEventObject(Deckel) ;
  "Sieht nach einem Deckel mit Griff aus."
}

event Battery -> Deckel {
 triggerObjectOnObjectEvent(Open, Deckel) ;
}

event Open -> Deckel {
 Ego:
  walkToStdEventObject(Deckel) ;
 suspend ;
 EgoStartUse ;
 soundBoxStart(Music::Deckelauf_wav) ;
 delay 5 ;
 DeckelGra.enabled = true ;
 EgoStopUse ;
 if (!insertedBattery) {
   delay 2 ;
   if (!hasItem(Ego, Battery)) {
     Ego.say("Zwei Anschl]sse. Einer Rot, einer schwarz.") ;
     Ego.say("Dem Aussehen dieser Maschine zu urteilen kann man hier vielleicht eine Autobatterie anschlie}en.") ;     
     needsBattery = true ;
   } else {
     delay 2 ;
     Ego.say("Ich schlie}e die Autobatterie an.") ;
     delay 3 ;
     Ego.say("Wie war das doch gleich?") ;
     delay 3;
     Ego.say("Schwarz ist Rot und Plus ist Minus.") ;
     delay 4 ;
     EgoStartUse ;
     soundBoxPlay(Music::Batrein_wav) ;
     dropItem(Ego, Battery) ;
     Deckel.setField(0, true) ;
     DeckelGra.setAnim(DeckelOffen2_image) ;
     EgoStopUse ;
     delay 2 ;
     soundBoxStart(Music::Beepbeep_wav) ;	     
     Blinker.enabled = true ; delay 2 ;
     blinker.enabled = false ; delay 2 ;
     Blinker.enabled = true ; delay 2 ;
     blinker.enabled = false ; delay 2 ;     
   }
 } else {
   delay 2 ;
   Ego.say("Ich habe die Autobatterie aus dem Truck angeschlossen.") ;
 }
 EgoStartUse ;
 soundBoxStart(Music::Deckelzu_wav) ;
 delay ;
 DeckelGra.enabled = false ;
 EgoStopUse ;
 clearAction ;
}

object DeckelGra {
 setPosition(134,96) ;
 setAnim(DeckelOffen_image) ;
 if (insertedBattery) setAnim(DeckelOffen2_image) ;
 absolute = false ;
 clickable = false ;
 enabled = false ;
 visible = true ;
}

/* ************************************************************* */

object Blinker {
 setAnim(Blinker_sprite) ;
 setPosition(97, 63) ;
 absolute = false ;
 clickable = false ;
 enabled = false ;
 visible = true ;
}

object Auto {
 setupAsStdEventObject(Auto,LookAt,285,215,DIR_WEST) ; 			
 setClickArea(64,5,243,198) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Maschine" ;
 soundVolume = 230 ;
}

event WalkTo -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
}

event LookAt -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
 suspend ;
 "Hier wurde eine Fahrzeugkarosserie zu einer seltsamen Maschine mit einem Hebel umfunktioniert." 
 delay 10 ;
 "Ihr Zweck ist mir nicht ersichtlich."
 delay 12 ;
 if (!stopWater) Ego.say("Ich kann jedoch deutlich Wasser rauschen h[ren!") ;
  else Ego.say("Ich kann leise Wasser rauschen h[ren.") ;
 clearAction ;
}

event Use -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
  say("Ich sehe nichts, was man benutzen k[nnte.") ;	
  say("Bis auf den Hebel und den Deckel.") ;
}

event Pull -> Auto {
 triggerObjectOnObjectEvent(Push, Auto) ;
}

event Push -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
 suspend ;
 delay 4 ;
 EgoUse ;
 delay 5 ;
  say("Bewegt sich kein St]ck.") ;
 clearAction ;
}

event Open -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
 suspend ;
 delay 4 ;
 EgoUse ;
 delay 5 ;
  say("Sie l#sst sich nirgendwo bis auf den Deckel [ffnen.") ;
 clearAction ;
}

event Take -> Auto {
 Ego:
  walkToStdEventObject(Auto) ;
  "Ich m[chte keine R]ckenprobleme."	
}

/* ************************************************************* */

object Hebel {
 setupAsStdEventObject(Hebel,Use,317,194,DIR_WEST) ; 		
 setClickArea(236,49,291,96) ; 
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Hebel" ;
}

object Hebelgra {
 setAnim(Hebel_image) ;
 setPosition(223,48) ;
 absolute = false ;
 visible = stopWater ;
 enabled = true ;
 clickable = false ;
}
 
event Push -> Hebel {
 if (! HebelGra.visible) { triggerObjectOnObjectEvent(Use, Hebel) ; return ; }
 Ego:
  walkToStdEventObject(Hebel) ;
 suspend ;
 EgoUse ;
 delay 3 ;
  say("Weiter geht es nicht.") ;
 clearAction ;
}

event Pull -> Hebel {
 if (HebelGra.visible) { triggerObjectOnObjectEvent(Use, Hebel) ; return ; }
 Ego:
  walkToStdEventObject(Hebel) ;
 suspend ;
 EgoUse ;
 delay 3 ;
  say("Weiter geht es nicht.") ;
 clearAction ;
}

event LookAt -> Hebel {
 Ego:
  walkToStdEventObject(Hebel) ;
  say("Ein Hebel mit rotem Kunststoffgriff.") ;
}

event Take -> Hebel {
 Ego:
  walkToStdEventObject(Hebel) ;
  say("Er ist zwar beweglich montiert, ich kann ihn aber nicht entfernen.") ;	
}

event Use -> Hebel {
 Ego:
  walkToStdEventObject(Hebel) ;
 suspend ;
 start { delay 3 ; soundBoxStart(Music::Hebel_wav) ; }
 EgoStartUse ;
 if (! insertedBattery) {
   HebelGra.visible = true ;
   EgoStopUse ;
   delay 9 ;
   soundBoxStart(Music::Hebel_wav) ;	     
   HebelGra.visible = false ;
   delay 6 ;
   Ego.say("Der Hebel ist wieder nach unten geschnappt.") ;
   needsBattery = true ;   
   pujaTipp ;
 } else {

   forceHideInventory ;
   
   Hebelgra.visible = ! stopWater ;   
   stopWater = ! stopWater ;
   EgoStopUse ;


   soundBoxStart(Music::Beepbeep_wav) ;	     
   Blinker.enabled = true ; delay 2 ;
   Blinker.enabled = false ; delay 2 ;
   Blinker.enabled = true ; delay 2 ;
   Blinker.enabled = false ; delay 2 ;	 
	 
   delay 4 ;
   
   if (!stopWater) soundBoxPlay(Music::Wasserstopp_wav) ;
    else soundBoxPlay(Music::Wassermarsch_wav) ;
	    
   delay 23 ;	    
	    
   doEnter(Dottrohre) ;
   
 }
 
 delay 4 ;
 clearAction ;
}


