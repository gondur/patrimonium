// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
	
 if (!stopWater) {
   Rohre.setField(0, false) ; 
   SauberGra.enabled = false ;
 }
	 
 Ego:
 enableEgoTalk ;
  enabled = true ; 
  visible = true ;  
  lightmap = Lightmap_image ;
  lightmapAutoFilter = true ;  
 forceShowInventory ;
 backgroundImage = Dottrohre_image;
 backgroundZBuffer = null ;
  path = Dottrohre_path ;
 if (previousScene == Leer) setPosition(70,233) ;
  else setPosition(2,268) ;
  face(DIR_EAST) ;
 
 if (stopWater) start animateTropfen ;
 start animateFisch ;
 
 start WaterSound ;
 
 if (firstEnter and (previousScene == Dott)) {
  forceHideInventory ;
  delay transitionTime ;
  firstEnterScene ;
  forceShowInventory ;
 }
 
 if (previousScene == Leer)  Ego.say("Schon besser.") ;
	 
 if (previousScene == Dottgarage) {
  forceHideInventory ;
  Ego.visible = false ;
  delay transitionTime ;
  delay 66 ;
  doEnter(Dottgarage) ;
 }

 clearAction ;
 
}

script WaterSound {
 killOnExit = true ;
 
 if (not stopWater) { 
   markResource(Music::Wasser_wav) ;
   loop {
     Verkaufsschild.playSound(Music::Wasser_wav) ; 
   }	
 } else {
   loop {
     if (FlussganzGra.frame == 9) verkaufsSchild.playSound(Music::Tropf_wav) ; 
     delay ;
   }
 }
 
}

/* ************************************************************* */

object Effekt1 {
 setPosition(180,123) ;
 absolute = false ;
 clickable = false ;
 enabled = !stopWater ;
 visible = true ;
 stopAnimDelay = 3 ;
 priority = 10 ;
 frame = 0 ; 
 if (enabled) setAnim(Effekt1_sprite) ; // do not load the sprite to save memory
}

object Effekt2 {
 setPosition(244,196) ;
 absolute = false ;
 clickable = false ;
 enabled = !stopWater ;
 visible = true ;
 stopAnimDelay = 4 ;
 priority = 11 ;
 frame = 0 ; 
 if (enabled) setAnim(Effekt2_sprite) ; // do not load the sprite to save memory
}

object Effekt3 {
 setPosition(171,116) ;
 absolute = false ;
 clickable = false ;
 enabled = !stopWater ;
 visible = true ;
 stopAnimDelay = 3 ;
 priority = 13 ;
 frame = 0 ; 
 if (enabled) setAnim(Effekt3_sprite) ; // do not load the sprite to save memory
}

object FlussganzGra {
 setPosition(142,183) ;
 absolute = false ;
 clickable = false ;
 enabled = stopWater ;
 autoAnimate = false ;
 visible = true ;
 stopAnimDelay = 3 ;
 priority = 2 ;
 frame = 0 ; 
 if (enabled) setAnim(Flussganz_sprite) ; // do not load the sprite to save memory
}

object MatschGra {
 setPosition(185,150) ;
 setAnim(Rohrsiff_sprite) ;
 absolute = false ;
 clickable = false ;
 enabled = stopWater ;
 visible = true ;
 priority = 3 ;
}

object TropfenGra {
 setAnim(Tropfen_image) ;
 setPosition(213,186) ;
 enabled = stopWater ; 
 visible = true ;
 priority = 4 ;
}

script animateTropfen {
 killOnExit = true ;
 FlussganzGra.frame = 0 ;
 loop {
   FlussganzGra.frame++ ;
   if (FlussganzGra.frame>=10) FlussganzGra.frame = 0 ;
   TropfenGra.positionY = 176 + 6 * FlussganzGra.frame ;
   delay ;
   TropfenGra.positionY = 176 + 6 * FlussganzGra.frame + 2 ;
   delay ;
   TropfenGra.positionY = 176 + 6 * FlussganzGra.frame + 4 ;
   delay ;
 }
}

object RohrGra {
 setPosition(177,116) ;
 absolute = false ;
 clickable = false ;
 enabled = !stopWater ;
 visible = true ;
 stopAnimDelay = 3 ;
 priority = 2 ;
 if (enabled) setAnim(Rohr_sprite) ;
}

object TunnelGra {
 setPosition(149,184) ;
 absolute = false ;
 clickable = false ;
 enabled = !stopWater ;
 visible = true ;
 stopAnimDelay = 3 ;
 priority = 1 ;
 if (enabled) setAnim(Tunnel_sprite) ;
}

object FlussGra {
 setPosition(243,190) ; 
 absolute = false ;
 clickable = false ;
 enabled = !stopWater ;
 visible = true ;
 stopAnimDelay = 2 ;
 priority = 1 ;
 if (enabled) setAnim(Fluss_sprite) ;
}

object VG {
 setPosition(218,245) ; 
 absolute = false ;
 clickable = false ;
 enabled = !stopWater ;
 visible = true ;
 priority = 19 ;
 if (enabled) setAnim(Vg_image) ;
}

object SauberGra {
 setPosition(1,0) ; 
 absolute = false ;
 clickable = false ;
 enabled = cleanedRohre ;
 visible = true ; 
 priority = 1 ;
 if (enabled) setAnim(Sauber_sprite) ;
}

/* ************************************************************* */

object Tropfen {
 setupAsStdEventObject(Tropfen,LookAt,147,267,DIR_EAST) ; 				
 setClickArea(188,149,234,193) ;
 absolute = false ;
 clickable = true ;
 enabled = stopWater ;
 visible = false ;
 name = "tropfendes Abwasser" ;
}

event Shoe -> Tropfen {
 Ego:
  walkToStdEventObject(Tropfen) ;
 suspend ;
  say("Der Schuh ist zu wasserdurchl#ssig.") ;
 clearAction ;	
}

event LookAt -> Tropfen {
 Ego:
  walkToStdEventObject(Tropfen) ;
 suspend ;
  say("Es tropft langsam aus dem Rohr.") ;
 clearAction ;
}

event Take -> Tropfen {
 Ego:
  walkToStdEventObject(Tropfen) ;
  say("Mit blo}en H#nden komme ich nicht weit.") ;  
}

event TalkTo -> Tropfen {
 Ego:
  walkToStdEventObject(Tropfen) ;
 suspend ;
  say("Hallo?") ;
 delay 10 ;
 clearAction ;
}

event Reagenzglas -> Tropfen { 
 Ego:
  walkToStdEventObject(Tropfen) ;
 suspend ;
 delay 10 ;
 EgoStartUse ;
  dropItem(Ego, Reagenzglas) ;
 soundBoxPlay(Music::Reagenz_wav) ;
  takeItem(Ego, Probe) ;
 EgoStopUse ;
  say("Das sollte reichen.") ;
 if ((!cactusMutated) and (hasItem(Ego, Cactus))) {
   delay 5 ;
    say("Ich frage mich, ob dieses Abwasser tats#chlich eine so mutagene Wirkung hat.") ;
    // Oscar-Mutations-Hinweis
   if (random(2)==0) {  
     delay 4 ;
      say("Ich habe ja noch Oscar, meinen Kaktus-Igel dabei.") ;
      say("Vielleicht ist er durstig?") ;
   }
 }
 clearAction ;	
}

event Cactus -> Tropfen {
 Ego:
  walk(147,267) ;
  turn(DIR_EAST) ;
 
 if (cactusMutated) {
   say("Na Oscar, m[chtest Du noch mehr?") ;
  delay 10 ;
   say("Lieber nicht.") ;
   say("Er sieht nicht gl]cklich aus.") ;
  clearAction ;
  return  ;
 }
 
  say("Oscar alter Junge!") ;
  say("Bist Du durstig?") ;
 delay 5 ;
 EgoStartUse ;
  dropItem(Ego, Cactus) ;
 soundBoxPlay(Music::Reagenz_wav) ; 
  takeItem(Ego, Cactus) ;
 EgoStopUse ;
 delay 15 ;
 mutateCactus ;
 delay 10 ;
 Ego:
  say("Erstaunlich.") ;
  say("Seine Stacheln sind gewachsen.") ;
  
 if (hasItem(Ego, Probe)) say("Ich sollte Peter die Probe zeigen.") ;
 if ( (!hasItem(Ego, Probe)) and (!wonciekSample)) say("Ich sollte unbedingt eine Probe von diesem Abwasser nehmen!") ;
  
  
 clearAction ;
}

/* ************************************************************* */

object Abwasserstrahl {
 setupAsStdEventObject(Abwasserstrahl,LookAt,147,267,DIR_EAST) ; 			
 setClickArea(188,125,358,271) ;
 absolute = false ;
 clickable = true ;
 enabled = !stopWater ;
 visible = false ;
 name = "Abwasserstrahl" ;
}

event Shoe -> Abwasserstrahl {
 Ego:
  walkToStdEventObject(Abwasserstrahl) ;
 suspend ;
  say("Der Schuh ist zu wasserdurchl#ssig.") ;
 clearAction ;	
}


event LookAt -> Abwasserstrahl {
 Ego:
  walkToStdEventObject(Abwasserstrahl) ;
  say("Eine ekelhafte Suppe schie}t aus den Rohren in den Fluss.") ;
}

event Take -> Abwasserstrahl {
 Ego:
  walkToStdEventObject(Abwasserstrahl) ;
 suspend ;
  say("Mit blo}en H#nden komme ich hier nicht weit.") ;
 clearAction ;
}

event Pull -> Abwasserstrahl {
 triggerObjectOnObjectEvent(Use, Abwasserstrahl) ;
}

event Push -> Abwasserstrahl {
 triggerObjectOnObjectEvent(Use, Abwasserstrahl) ;
}

event Use -> Abwasserstrahl {
 Ego:
  walkToStdEventObject(Abwasserstrahl) ;
  say("Ich m[chte nicht reinfassen.") ;
}

event Reagenzglas -> Abwasserstrahl {
 Ego:
  walkToStdEventObject(Abwasserstrahl) ;
 suspend ;
 Ego.say("Das Abwasser schie}t zu stark aus den Rohren.") ;
 Ego.say("Und wenn davon Lebewesen mutieren, m[chte ich damit lieber nicht in Kontakt kommen!") ;
 Ego.say("Vielleicht finde ich einen Weg es etwas zu regulieren.") ;
 clearAction ;	
}

event Cactus -> Abwasserstrahl {
 Ego:
  walk(147,267) ;
  turn(DIR_EAST) ;
 suspend ;
  say("Oscar alter Junge!") ;
  say("Bist Du durstig?") ;
 delay 5 ;
  say("Hmmmm....") ;
  say("Das Abwasser schie}t zu stark aus den Rohren, als dass ich ihn jetzt gie}en m[chte.") ;
 clearAction ;
}

/* ************************************************************* */

object HowTo {
 setupAsStdEventObject(HowTo,LookAt,147,267,DIR_NORTH) ;
 setPosition(142,222) ;
 setAnim(HowTo_image) ;
 setClickArea(0,0,17,17) ;
 absolute = false ;
 clickable = true ;
 enabled = (!hasItem(Ego, Anleitung)) and (!firstEnter) ;
 visible = true ;
 name = "Kn#uel" ;
}

event LookAt -> HowTo {
 Ego:
  walkToStdEventObject(HowTo) ;
 suspend ;
  "Nanu?"	
  "Das m]ssen wohl die Rohre ausgespuckt haben." 
  "Es wurde bestimmt nicht ohne Grund runtergesp]lt." 
  "Vielleicht sollte ich mir das mal genauer ansehen."
 clearAction ;
}

event Take -> HowTo {
 Ego:
  walkToStdEventObject(HowTo) ;
 suspend ;
 EgoStartUse ;
  takeItem(Ego, Anleitung) ;
  HowTo.enabled = false ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Fisch { 
 setPosition(580,327) ;
 setAnim(Fisch_sprite) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ; 
 priority = 3 ;
 autoAnimate = false ;
 frame = 0 ;
}

script animateFisch {
 killOnExit = true ;
 loop {
  Fisch.frame = 0 ; delay 3 ;
  Fisch.frame = 1 ; delay 2 ;
  Fisch.frame = 2 ; delay 2 ;
  Fisch.frame = 3 ; delay 2 ;
  Fisch.frame = 4 ; delay 3 ;
  Fisch.frame = 5 ; delay 4 ;
  Fisch.frame = 4 ; delay 3 ;
  Fisch.frame = 3 ; delay 2 ;
  Fisch.frame = 2 ; delay 2 ;
  Fisch.frame = 1 ; delay 3 ;
  Fisch.frame = 0 ; delay 4 ;
 }
}
/* ************************************************************* */

object Kabel {
 setupAsStdEventObject(Kabel,LookAt,60,230,DIR_NORTH) ;
 setPosition(57,154) ;
 setAnim(Kabel_image) ;
 setClickArea(0,0,14,12) ;
 absolute = false ;
 clickable = true ;
 enabled = !hasItem(Ego, Wires) ;
 visible = true ;
 name = "kleiner Plastikbeutel" ;
}

event WalkTo -> Kabel {
 Ego:
  walkToStdEventObject(Kabel) ;
}

event LookAt -> Kabel {
 Ego:
  walkToStdEventObject(Kabel) ;
  "Ein kleiner Plastikbeutel mit vielen roten K#belchen."
}

event Take -> Kabel {
 Ego:
  walkToStdEventObject(Kabel) ;
 suspend ;
 EgoStartUse ;
 Kabel.enabled = false ;
 takeItem(Ego, Wires) ;
 EgoStopUse ;
 Ego.say("Ob ihn jemand hier versteckt hat?") ;
 clearAction ;
}

/* ************************************************************* */

object Verkaufsschild {
 setupAsStdEventObject(Verkaufsschild,LookAt,230,370,DIR_EAST) ; 		
 setClickArea(297,5,417,138) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event WalkTo -> Verkaufsschild {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
}

event LookAt -> Verkaufsschild {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
  "'Mit Industriem]ll verseuchtes Gebiet - zu verkaufen'"
}

event Take -> Verkaufsschild {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
  "Ich komme nicht hin."
}

event Push -> Verkaufsschild {
 triggerObjectOnObjectEvent(Take, Verkaufsschild) ;
}

event Pull -> Verkaufsschild {
 triggerObjectOnObjectEvent(Take, Verkaufsschild) ;
}

/* ************************************************************* */

object Besitzschild {
 setClickArea(441,42,561,147) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event WalkTo -> Besitzschild {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
}

event LookAt -> Besitzschild {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
  "'Eigentum von SamTec'."
}

event Push -> Besitzschild {
 triggerObjectOnObjectEvent(Take, Verkaufsschild) ;
}

event Pull -> Besitzschild {
 triggerObjectOnObjectEvent(Take, Verkaufsschild) ;
}

event Take -> Besitzschild {
 triggerObjectOnObjectEvent(Take, Verkaufsschild) ;
}

/* ************************************************************* */

script firstEnter {
 return !Abwasser.getField(0) ;
}

script firstEnterScene {
  Abwasser.setField(0, true) ;
  Ego:
   walk(90, 274) ;
  delay 10 ;
   say("Uuh! Hier riecht es ]bel nach Chemikalien...") ;
  delay ;
   say("Was f]r eine widerliche Br]he.") ;
  delay 4 ;
   walk(230,370) ;
   turn(DIR_EAST) ;
  delay 4 ;
   say("Auf dem Schild hier steht:") ;
  delay 1 ;
   "'Mit Industriem]ll verseuchtes Gebiet - zu verkaufen'"
  delay 4 ;
  if (openedSafe) {
   say("Laut den Dokumenten die ich im Inneren des Geb#udes gefunden habe...") ;
   say("...ist das Abwasser hier eindeutig mutagen.") ;
   say("Das wird ein Nachspiel f]r SamTec haben.") ;   
  } else {
   say("Ich sollte diese Abw#sser n#her untersuchen.") ;
   say("Sollte SamTec wirklich f]r diese mutierten Lebewesen im Nil verantwortlich sein...") ;
   say("...wird das ein Nachspiel haben.") ;   
  }
  delay 2 ;
   say("Ich frage mich, warum niemand der Sache nachgegangen ist, wenn sogar die Presse dar]ber berichtete.") ;
  delay 4 ;
   say("Ich sollte eine Probe von dem Abwasser nehmen, und Peter bringen.") ;    
}

object Abwasser {
 setClickArea(343,218,640,335) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Abwasser" ;
}

event Shoe -> Abwasser {
 Ego:
  walkToStdEventObject(Abwasser) ;
 suspend ;
  say("Der Schuh ist zu wasserdurchl#ssig.") ;
 clearAction ;	
}


event WalkTo -> Abwasser {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
}

event LookAt -> Abwasser {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
  "Sieht ziemlich verschmutzt aus."
}

event Reagenzglas -> Abwasser {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
 suspend ;
  say("Ich sollte die Probe direkt von dem Wasser nehmen...") ;
  say("...das aus den Abflussrohren des Forschungsgeb#udes stammt.") ;
  say("Sonst kann ich nicht beweisen, ob eventuelle Verunreinigungen nicht schon in dem Fluss waren...") ;
  say("...der unter dem Haus durchstr[mt.") ;
 clearAction ;
}

event Cactus -> Abwasser {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
 suspend ;
  if (! cactusMutated) say("Oscar sieht schon danach aus, als ob ihm etwas Wasser gut tun w]rde.") ;
  say("Ich komme hier aber schlecht ran, vielleicht gie}e ich ihn mit der Fl]ssigkeit, die aus den Rohren kommt.") ;
 if (stopWater) triggerObjectOnObjectEvent(Cactus, Tropfen) ;
   else triggerObjectOnObjectEvent(Cactus, Abwasserstrahl) ;
}

event Probe -> Abwasser {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
 suspend ;
 delay 4 ;
  say("Ich leere das Reagenzglas.") ;
 EgoStartUse ;
  dropItem(Ego, Probe) ;
 delay 10 ;
  takeItem(Ego, Reagenzglas) ;
 EgoStopUse ;
 clearAction ;
}

event default -> Abwasser {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
  say("Lieber nicht.") ;
}

event Use -> Abwasser {
 Ego:
  walkToStdEventObject(Verkaufsschild) ;
  say("Ich habe jetzt keine Lust darin zu baden.") ;
}


/* ************************************************************* */

object Zurueck {
 setClickArea(0,205,26,317) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Hof" ;
}

event LookAt -> Zurueck {
 Ego:
  turn(DIR_WEST) ;
  say("Hier geht es zur]ck zum Hof.") ;
 clearAction ;
}

event WalkTo -> Zurueck {
 Ego:
  walk(1,261) ;
 suspend ;
 unMarkResource(Music::Wasser_wav) ;
 doEnter(Dott) ;
}

/* ************************************************************* */

object Rohre {
 setupAsStdEventObject(Rohre,LookAt,70,233,DIR_EAST) ; 		
 setClickArea(110,91,297,182) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Abflussrohre" ;
}

script cleanedRohre {
 return Rohre.getField(0) ;
}

event Carpetscrap -> Rohre {
 Ego:
  walkToStdEventObject(Rohre) ;
  
 if (did(give)) { 
   say("Den wollen sie nicht.") ;
   return ;
 }
  
 if (!stopWater) {
   say("Solange der Strahl mit der widerlichen Suppe hier rausschie}t...") ;
   say("...halte ich das f]r keine gute Idee.") ;
   return ;
 }
  
 if (cleanedRohre) {
   "Ich habe die Rohre schon ges#ubert."
 } else {
   suspend ;
   delay 4 ;
    "Putzfimmel Ahoi!" 
   Rohre.setField(0, true) ;
   EgoStartUse ;
   delay 10 ;
   doEnter(Leer) ;   
 }
}

event LookAt -> Rohre {
 Ego:
  walkToStdEventObject(Rohre) ;
  say("Das sind Abflussrohre aus dem Laborgeb#ude.") ;
}

event Pull -> Rohre {
 triggerObjectOnObjectEvent(Push, Rohre) ;
}

event Push -> Rohre {
 Ego:
  walkToStdEventObject(Rohre) ;
 suspend ;
 EgoUse ;
 delay 5 ;
  say("Sie bewegen sich kein St]ck.") ;
 clearAction ;
}

event Close -> Rohre {
 Ego:
  walkToStdEventObject(Rohre) ;
 suspend ;
 delay 5 ; 
  say("Man kann sie nicht schlie}en.") ;
 if (!stopWater) say("Vielleicht finde ich wo anders eine M[glichkeit, den Wasserfluss zu regulieren.") ;
 clearAction ;
}

event Use -> Rohre {
 triggerObjectOnObjectEvent(Take, Rohre) ;
}

event Take -> Rohre {
 Ego:
  walkToStdEventObject(Rohre) ;
  say("Ich bin kein Klemptner.") ;
}