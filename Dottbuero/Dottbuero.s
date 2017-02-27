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
 forceShowInventory ;
 backgroundImage = Dottbuero_image;
 backgroundZBuffer = Dottbuero_zbuffer ;
  setPosition(0,287) ;
  face(DIR_EAST) ;
  visible = false ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 725 ;
 delay transitionTime ;
 soundBoxStart(Music::Tuerauf2_wav) ;
 TuerGra.enabled = true ;
  visible = true ;
  walk(115,287) ;
  turn(DIR_WEST) ;
 soundBoxStart(Music::Tuerzu3_wav) ;  
 EgoStartUse ; 
 TuerGra.enabled = false ;
 delay 2 ;
 EgoStopUse ;
 delay 2 ;
  turn(DIR_EAST) ;
  pathAutoScale = true ;
  path = Dottbuero_path ;
 if (! sawAgentsHint) { 
   forceHideInventory ;
   seeAgentsHintCutscene ;
   forceShowInventory ;
 }
 clearAction ;
}

/* ************************************************************* */

script seeAgentsHintCutscene {
  sawAgentsHint = true ;
  delay 10 ;
  Ego:
   walk(214,297) ;
   turn(DIR_EAST) ;
  delay 10 ;
   "Das Gesicht kommt mir irgendwie bekannt vor."
  delay 2 ;
   jukeBox_Enqueue(Music::BG_Short3_mp3) ;
   jukeBox_Shuffle(false) ;
   jukeBox_Start ;  
  delay 2 ;
   "Das ist doch einer dieser zwei Schr#nke!"
  delay 2 ;
   "'Mitarbeiter des Monats'?"
  delay 10 ;
   walk(313,337) ;
   turn(DIR_NORTH) ;
  delay 10 ;
   "Auf diesem Namensschild steht 'John Jackson'."
  delay 5 ;
   turn(DIR_EAST) ;
  delay 10 ;   
   walk(827,249) ;
   turn(DIR_NORTH) ;
  delay 10 ;
   "Und auf diesem Namensschild steht 'Jack Johnson'."
  delay 2 ;
   turn(DIR_NORTH) ;
  delay 4 ;
   "Das sind die beiden."
   "Wie ich es vermutet hatte."
   "Mal sehen, was Peter dazu zu sagen hat."
   
  jukeBox_fadeOut(5) ;
  jukeBox_Enqueue(Music::BG_Amountofevil_mp3) ;
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,Use,115,287,DIR_WEST) ; 		
 setClickArea(0,114,49,292) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ; 
 name = "T]r" ;
}

event HotelKey -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 say("Die T]r hat kein Schloss.") ;
 clearAction ;
}

event LookAt -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
  say("Eine T]r.") ;
  say("Unten ist ein kleines L]ftungsgitter angebracht.") ;	
}

event WalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
}

event Use -> Tuer {
 triggerObjectOnObjectEvent(Open, Tuer) ;
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

event Open -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 soundBoxStart(Music::Tuerauf2_wav) ;
 EgoStartUse ;
 TuerGra.enabled = true ;
 EgoStopUse ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 725 ;
  walk(0,287) ;
 delay 10 ;
 soundBoxStart(Music::Tuerzu3_wav) ;
 delay 4 ;
 TuerGra.enabled = false ;
 Ego.visible = false ;
 delay 10 ;
 Ego.visible = true ;
  pathAutoScale = true ;
 doEnter(Dottgarage) ;
}

object TuerGra {
 setPosition(0,97) ;
 priority = PRIORITY_HIGHEST ;
 setAnim(Tueroffen_image) ;
 enabled = false ;
 visible = true ;
 absolute = false ;
 clickable = false ;
}

/* ************************************************************* */

object Chuck {
 setupAsStdEventObject(Chuck,LookAt,108,270,DIR_NORTH) ; 		
 setClickArea(73,128,141,258) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Chuck die Pflanze" ;
}

event WalkTo -> Chuck {
 Ego:
  walkToStdEventObject(Chuck) ;
}

event TalkTo -> Chuck {
 Ego:
  walkToStdEventObject(Chuck) ;
 suspend ;
 delay 4 ;
  say("Hallo, Chuck!") ;
 delay 10 ;
 clearAction ;
}

event LookAt -> Chuck {
 Ego:
  walkToStdEventObject(Chuck) ;
 suspend ;
 delay 4 ;
  say("Es ist Chuck die Pflanze.") ;
 clearAction ;	
}

event Use -> Chuck {
 triggerObjectOnObjectEvent(Take, Chuck) ;
}

event Push -> Chuck {
 triggerObjectOnObjectEvent(Take, Chuck) ;
}

event Take -> Chuck {
 Ego:
  walkToStdEventObject(Chuck) ;
 suspend ;
 EgoUse ;
 delay 2 ;
 say("AUTSCH!") ;
 delay 3 ;
 say("Der Kaktus hat Stacheln!") ;
 clearAction ;
}

event Probe -> Chuck {
 Ego:
  walkToStdEventObject(Chuck) ;
 suspend ;
 EgoStartUse ;
  delay 3 ;
  dropItem(Ego, Probe) ; 
  takeItem(Ego, Reagenzglas) ;
 EgoStopUse ;
 delay 3 ;
 if (cactusMutated) {
  delay 19 ;	 
  say("Hmmmm.") ;
  say("Es ist nichts passiert.") ;
  say("Chuck ist wahrscheinlich schon mutiert.") ;
 } else {
  say("Hier hast Du etwas Abwasser, Chuck.") ;
  say("Etwas besseres habe ich nicht auftreiben k[nnen.") ;
 }
 clearAction ;
}


/* ************************************************************* */

object Computer {
 setupAsStdEventObject(Computer,Use,202,272,DIR_EAST) ; 		
 setClickArea(233,173,284,242) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Computer" ;
}

event WalkTo -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
}

event LookAt -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
 say("Ein Desktop-PC.") ; 
 say("Er sieht besch#digt aus.") ;
 clearAction ;
}

event Use -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Er ist offensichtlich kaputt und hat keinen Strom.") ; 
 clearAction ;
}

event Battery -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Das wird so ohne weiteres nicht funktionieren.") ; 
 clearAction ;	
}

event Pull -> Computer {
 triggerObjectOnObjectEvent(Push, Computer) ;
}

event Push -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Ich m[chte nicht in Gefahr laufen, mich zu verletzen.") ; 
 clearAction ;		
}

event Open -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Dazu brauche ich passendes Werkzeug.") ; 
 clearAction ;		
}

event Screwdriver -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Ich glaube nicht, dass ich darin etwas Wichtiges finden w]rde.") ; 
  say("Der Computer sieht zu alt aus, als dass man f]r ihn hier ernsthaft Verwendung gefunden h#tte.") ; 
 clearAction ;			
}

event Take -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Der Computer sieht zu alt aus, als dass man f]r ihn hier ernsthaft Verwendung gefunden h#tte.") ; 
  say("Au}erdem ist er kaputt.") ;
 clearAction ;				
}

/* ************************************************************* */

object Klingel {
 setupAsStdEventObject(Klingel,Use,466,286,DIR_WEST) ; 	
 setClickArea(392,213,413,245) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Klingel" ;
}

event WalkTo -> Klingel {
 Ego:
  walkToStdEventObject(Klingel) ;
}

event Push -> Klingel {
 triggerObjectOnObjectEvent(Use, Klingel) ;
}

event Use -> Klingel {
 Ego:
  walkToStdEventObject(Klingel) ;
 suspend ;
 start soundBoxPlay(Music::Cling_wav) ;	
 EgoUse ;
 clearAction ;				
}

event Take -> Klingel {
 Ego:
  walkToStdEventObject(Klingel) ;
 suspend ;
  say("Ich lasse sie lieber da, wo sie ist.") ; 
 clearAction ;				
}

/* ************************************************************* */

object Mdm {
 setupAsStdEventObject(Mdm,LookAt,203,282,DIR_EAST) ; 		
 setClickArea(368,100,431,175) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "'Mitarbeiter des Monats'-Schild" ;
}

event WalkTo -> Mdm {
 Ego:
  walkToStdEventObject(Mdm) ;
}

event LookAt -> Mdm {
 Ego:
  walkToStdEventObject(Mdm) ;
 suspend ;
  say("Ein 'Mitarbeiter des Monats'-Schild mit dem Anlitz von John Jackson.") ;
 clearAction ;
}

event Take -> Mdm {
 Ego:
  walkToStdEventObject(Mdm) ;
 suspend ;
  say("Ich m[chte das Schild nicht mit mir herumtragen.") ;
  say("Mir gef#llt sein Aussehen nicht.") ;
 clearAction ;	
}

/* ************************************************************* */

object TelefonO {
 setupAsStdEventObject(TelefonO,Use,492,289,DIR_NORTH) ; 		
 setClickArea(451,125,521,215) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Telefon" ;
}

event WalkTo -> TelefonO {
 Ego:
  walkToStdEventObject(TelefonO) ;
}

event LookAt -> TelefonO {
 Ego:
  walkToStdEventObject(TelefonO) ;
 suspend ;
  say("Ein modernes jedoch auf alt getrimmtes Telefon mit Digitaldisplay.") ;
  say("Etwas zu gro} f]r meinen Geschmack.") ;
 clearAction ;	
}

event Use -> TelefonO {
 Ego:
  walkToStdEventObject(TelefonO) ;
 suspend ;
 EgoUse ;
  say("Weder Strom noch Signal.") ;
 clearAction ;	
}

event Shim -> TelefonO {
 Ego:
  walkToStdEventObject(TelefonO) ;
 suspend ; 
  say("Es gibt keinen M]nzschlitz.") ;
 clearAction ;		
}

/* ************************************************************* */

// PujaTipp: Tresorkombination einstellen

script pujaTipp {
 Ego:
 if (!hasitem(Ego, Notiz)) { 
  "Es ist unwahrscheinlich, dass ich die richtige Kombination errate."
  "Vielleicht finde ich irgendwo einen Hinweis."
  return ;
 }
  switch upcounter(9) {
    case 0: "Vielleicht werfe ich einen Blick auf diesen pinken Notizzettel."  
    case 1,2: "Ich sollte mir diesen pinken Notizzettel nochmal anschauen."    
    case 3,4,5: "Den Hinweisen auf dem Notizzettel nach, sollte ich irgendwo an dem Tresor die ersten beiden Zahlen finden." 	        
    default : "Vielleicht kann mir Professor Wonciek weitere Tipps geben."
   }  		
}

object Tresor {
 setupAsStdEventObject(Tresor,LookAt,640,320,DIR_NORTH) ; 		
 setClickArea(553,142,675,246) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Tresor" ;
}

object TresorGra {
 setAnim(Tresor_sprite) ;
 autoAnimate = false ;
 if (openedSafe) frame = 1 ;
   else frame = 0 ;
 setPosition(544,136) ;
 visible = true ;
 enabled = true ;
 clickable = false ;
 absolute = false ;
}

event WalkTo -> Tresor {
 Ego:
  walkToStdEventObject(Tresor) ;
}

event LookAt -> Tresor {
 Ego:
  walkToStdEventObject(Tresor) ;
 suspend ;
 if (openedSafe) Ego.say("Ein leerer Tresor, aus dem ich die Dokumente entwendete.") ;
  else { 
    Ego.say("Ein Tresor-Schrank.") ;
    Ego.say("Darin befindet sich etwas.") ;
    if (hasItem(Ego, Notiz)) { 
      Ego.say("Und zwar 'streng vertrauliche Dokumente' wenn man dem Notizzettel, den ich fand, Glauben schenken darf.") ;
      Ego.say("Die haben wohl Jackson und Johnson hier vergessen.") ;
      Ego.say("Oder sie haben die Kombination nicht mehr gewusst.") ;
    }
  }
 clearAction ;
}

event Use -> Tresor {
  triggerObjectOnObjectEvent(Open, Tresor) ;
}

event Open -> Tresor {
 Ego:
  walkToStdEventObject(Tresor) ;
 suspend ;
 if (openedSafe) {
   "Ich habe die Dokumente bereits."
 } else {
   "Welche Zahl soll ich als erstes einstellen?"
   var a = openSafeDia ;
   if (a==10) {clearAction ; return ; }
   EgoUse ;
   "Die Zweite?"
   var b = openSafeDia ;
   if (b==10) {clearAction ; return ; }
   EgoUse ;
   "Die Dritte?"
   var c = openSafeDia ;
   if (c==10) {clearAction ; return ; }
   EgoUse ;
   "Und die Vierte?"
   var d = openSafeDia ;
   if (d==10) {clearAction ; return ; }
   EgoUse ;
   
   if ((a==4) and (b==6) and (c==5) and (d==7)) {
     // klick
     "Das war die richtige Kombination!"
     openedSafe = true ;
     EgoStartUse ;
     soundBoxStart(Music::Secret_wav) ;
     TresorGra.frame = 2 ;
     EgoStopUse ;
     EgoStartUse ;
     soundBoxStart(Music::Pageturn_wav) ;
     delay 2 ;
     takeItem(Ego, Dokumente) ;
     TresorGra.frame = 3 ;
     delay 4 ;
     EgoStopUse ;
     EgoStartUse ;
     soundBoxStart(Music::Tuerzu2_wav) ;
     TresorGra.frame = 1 ;
     EgoStopUse ;
     delay 3 ;
     jukeBox_addIn(Music::BG_Short4_mp3,10) ;
      "Moment mal!"
     delay 2 ;
      "Das sind von einem unabh#ngigen Institut vorgenommene Gentoxizit#tstests..."
      "...dieses SamTec-Labors in der Al Azhar Street von vor etwa zwei Monaten."      
     delay 3 ;
      "Und nach internationalen Kriterien sind die Abw#sser eindeutig mutagen!"
     delay 2 ;
      "Das sollte ich unbedingt Peter zeigen."     
   } else {
     "Das hat nichts gebracht."
     delay 2 ;
     pujaTipp ;
   }
   
 }
 clearAction ; 
}

script openSafeDia {
  loop {
  Ego:
   addChoiceEchoEx(1, "1", false) ;
   addChoiceEchoEx(2, "2", false) ;
   addChoiceEchoEx(3, "3", false) ;
   addChoiceEchoEx(4, "4", false) ;
   addChoiceEchoEx(5, "5", false) ;
   addChoiceEchoEx(6, "6", false) ;
   addChoiceEchoEx(7, "7", false) ;
   addChoiceEchoEx(8, "8", false) ;
   addChoiceEchoEx(9, "9", false) ;
   addChoiceEchoEx(10, "Aufh[ren", false) ;
  
   var d = dialogEx () ;  
   return d ;
 }	
 
}

event Take -> Tresor {
 Ego:
  walkToStdEventObject(Tresor) ;
 suspend ;
  say("Dazu ist er zu massiv.") ;
 clearAction ;	
}

event Push -> Tresor {
 triggerObjectOnObjectEvent(Pull, Tresor) ;
}

event Pull -> Tresor {
 Ego:
  walkToStdEventObject(Tresor) ;
 suspend ;
 delay 4 ;
 EgoUse ;
 delay 4 ;
  say("Er ist zu schwer.") ;
 clearAction ;	
}

event Notiz -> Tresor {
 Ego:
  walkToStdEventObject(Tresor) ;
 suspend ;
 if (openedSafe) {
   say("Ich habe die richtige Kombination schon ausget]ftelt.") ;
 } else {
   say("Die Hinweise auf dem Zettel k[nnten mir hier weiterhelfen.") ;
   say("Aber was ist die richtige Kombination?") ;
 }
 clearAction ;
}

/* ************************************************************* */

object Banner {
 setupAsStdEventObject(Banner,LookAt,170,270,DIR_NORTH) ; 		
 setClickArea(116,70,116+185,70+49) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Banner" ;
}

event LookAt -> Banner {
 Ego:
  walkToStdEventObject(Banner) ;
 suspend ;
  "Zu verkaufen." 
  "Den Wohnbereich h#tte ich mir von au}en bedeutend gr[}er vorgestellt." 
  "Deshalb sollte man sich bei Immobilien-Besichtigungen immer erst alles ganz genau ansehen."
 clearAction ;
}

/* ************************************************************* */

object Pult {
 setupAsStdEventObject(Pult,LookAt,111,326,DIR_SOUTH) ; 		
 setClickArea(0,322,136,360) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pult" ;
}

event LookAt -> Pult {
 Ego:
  walkToStdEventObject(Pult) ;
 suspend ;
  "Nichts. Nur ein ]berdurchschnittlich h#ssliches Pult." 
 clearAction ;
}

/* ************************************************************* */

object Spalt {
 setupAsStdEventObject(Spalt,LookAt,640,317,DIR_NORTH) ; 		
 setClickArea(613,282,666,303) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Spalt unter der Uhr" ;
}

event LookAt -> Spalt {
 Ego:
  walkToStdEventObject(Spalt) ;
 suspend ;
 delay 3 ;
  "Nichts au}er Jahrzehnte altem Staub." 
 if ((keyCardpos == 1) and (!hasItem(Ego, Keycard))) {
   delay 7 ;
   "Moment!" 
   "Ich hab unter der zentimeterdicken Staubschicht doch etwas Interessantes gefunden!"
   delay 3 ;
   EgoStartUse ;
   takeItem(Ego,Keycard) ;
   EgoStopUse ;
   delay 2 ;
   "Eine SamTec-Security-Keycard."
 }
 clearAction ;
}

/* ************************************************************* */

object Teppich {
 setupAsStdEventObject(Teppich,LookAt,782,272,DIR_EAST) ; 		
 setClickArea(807,216,879,258) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Teppich" ;
}

object TeppichGra {
 setPosition(801,219) ;
 setAnim(Matte_sprite) ;
 autoAnimate = false ;
 absolute = false ;
 clickable = false ;
 enabled = false ;
 visible = true ; 
}


event LookAt -> Teppich {
 Ego:
  walkToStdEventObject(Teppich) ;
 suspend ;
 delay 3 ;
  "Ein kleiner Staubf#nger vor dem Schreibtisch."   
 clearAction ;
}

event Take -> Teppich {
 Ego:
  walkToStdEventObject(Teppich) ;
 suspend ;  
  "Ich will ihn nicht."
  "Aber ich riskiere mal einen Blick darunter..."
 triggerObjectOnObjectEvent(Pull, Teppich) ;
}

event Pull -> Teppich {
 Ego:
  walkToStdEventObject(Teppich) ;
 suspend ;
 EgoStartUse ;
  TeppichGra.enabled = true ;
 if ((keyCardpos == 2) and (!hasItem(Ego, Keycard))) TeppichGra.frame = 0 ;
  else TeppichGra.frame = 1 ;
 EgoStopUse ;
 delay 9 ;
 if ((keyCardpos == 2) and (!hasItem(Ego, Keycard))) {
    Ego.say("Was haben wir denn da?") ;
    EgoStartUse ;
    takeItem(Ego,Keycard) ;
    TeppichGra.frame = 1 ;
    EgoStopUse ;
    Ego.say("Eine SamTec-Security-Keycard.") ;	 
 } else Ego.say("Nichts.") ; 
 delay 7 ;
 EgoStartUse ;
  TeppichGra.enabled = false ;
 EgoStopUse ;
 delay 3 ;
 clearAction ;
}


/* ************************************************************* */

object Plakat {
 setupAsStdEventObject(Plakat,LookAt,830,250,DIR_NORTH) ; 		
 setClickArea(726,14,857,103) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Plakat" ;
}

event WalkTo -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
}

event LookAt -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
 suspend ;
  say("Jack Johnson spielt w#hrend eines wundersch[nen Sonnenunterganges Gitarre.") ;
  say("Ich w]nschte, ich h#tte Zeit f]r sowas.") ;
  delay 2 ;
  say("Moment mal.") ;
  delay ;
  say("Jack Johnson?") ;
  delay 2 ;
  say("Hmmm...") ;
 clearAction ;	
}

event Pull -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
  say("Ich m[chte es nicht herunterrei}en.") ;
}

event Take -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
 suspend ;
  say("Ich bin zwar Fan, aber kein Groupie.") ;
 clearAction ;
}

/* ************************************************************* */

static var breakDrawer = false ;

object Schubloffen {
 setPosition(751,153) ;
 setAnim(Schubladeoffen_image) ;
 absolute = false ;
 clickable = false ;
 enabled = Schublade.getField(0) ;
 visible = true ;
}

object Schublade {
 setupAsStdEventObject(Schublade,Use,810,252,DIR_NORTH) ; 		
 setClickArea(751,150,807,179) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schublade" ;
}

event WalkTo -> Schublade {
 Ego:
  walkToStdEventObject(Schublade) ;
}

event Pull -> Schublade {
 Ego:
  walkToStdEventObject(Schublade) ;
 suspend ;
  say("Wie ein Blitz schoss mir gerade das Verb '[ffnen' durch den Kopf.") ;
  say("Ich wei} aber auch nicht, warum.") ;
 clearAction ;
}

event Open -> Schublade {
 Ego:
  walkToStdEventObject(Schublade) ;
 suspend ;
 
 if (!breakDrawer) {
   EgoUse ;
   Ego.say("Sie ist abgeschlossen.") ;
   clearAction ;
   return ;
 }
 
 if (Schublade.getField(0)) say("Sie ist schon offen.") ;
   else {
     EgoStartUse ;
     soundBoxStart(Music::Schublade_wav) ;
     Schublade.setField(0,1) ;
     Schubloffen.enabled = true ;
     EgoStopUse ;
   }
 clearAction ;
}

event Close -> Schublade {
 Ego:
  walkToStdEventObject(Schublade) ;
 suspend ;
 if (! Schublade.getField(0)) say("Sie ist schon geschlossen.") ; 
  else {
    EgoStartUse ;
    soundBoxStart(Music::Schublade_wav) ;
    Schublade.setField(0,0) ;
    Schubloffen.enabled = false ;
    EgoStopUse ;
  }
 clearAction ;
}

event Use -> Schublade {
 if (Schublade.getField(0)) triggerObjectOnObjectEvent(Close, Schublade) ;
   else triggerObjectOnObjectEvent(Open, Schublade) ;
}

event Screwdriver -> Schublade {
 Ego:
  walkToStdEventObject(Schublade) ;
 suspend ;
 if (!breakDrawer) {
   say("Ich stochere mal mit dem Schraubenzieher im Schloss herum...") ;
   delay 2 ;
   EgoUse ;
   delay 3 ;
   EgoUse ;
   delay 2 ;
   EgoStartUse ;
   soundBoxStart(Music::Secretmirror_wav) ;
   breakDrawer = true ;
   EgoStopUse ;
   delay 5 ;
   EgoStartUse ;
   soundBoxStart(Music::Schublade_wav) ;
   Schubloffen.enabled = true ;
   EgoStopUse ;
   delay 5 ;
   EgoStartUse ;
   soundBoxStart(Music::Schublade_wav) ;
   Schubloffen.enabled = false ;
   EgoStopUse ;
   say("Jetzt ist sie aufgeschlossen.") ;
   delay 3 ;
   if (keycardPos == 0) say("Ich glaube, darin war etwas.") ;
 } else {
   say("Nein, die Schublade ist nich abgeschlossen.") ;
 }
 clearAction ;	
}

event LookAt -> Schublade {
 Ego:
  walkToStdEventObject(Schublade) ;
 suspend ;
 if (not Schublade.getField(0)) Ego.say("Eine geschlossene Schreibtischschublade.") ;
  else {
    if ((hasItem(Ego,Keycard) or (keycardPos != 0)) and (hasItem(Ego, Klappspaten))) Ego.say("Die Schublade ist leer.") ;
     else {
       if ((!hasItem(Ego, Keycard)) and (keycardPos==0)) {
         Ego.say("Was haben wir denn da?") ;
         EgoStartUse ;
         takeItem(Ego,Keycard) ;
         EgoStopUse ;
         Ego.say("Eine SamTec-Security-Keycard.") ;
	 clearAction ;
	 return ;
       }
       if (!hasItem(Ego, Klappspaten)) {
	 if (keyCardpos==0) Ego.say("Hier ist noch etwas drin.") ;
	  else Ego.say("Hier ist etwas drin.") ;
	 Ego.say("Ein bedrucktes Blatt Papier mit der {berschrift 'Operation Klappspaten'.") ;
	 Ego.say("Es muss Agent Jackson geh[ren.") ;
         EgoStartUse ;
         takeItem(Ego,klappspaten) ;	 
         EgoStopUse ;
       }
     }
  }
 clearAction ;
}

/* ************************************************************* */

object Fenster {
 setupAsStdEventObject(Fenster,Open,855,253,DIR_EAST) ; 		
 setClickArea(933,6,973,136) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fenster" ;
}

event WalkTo -> Fenster {
 Ego:
  walkToStdEventObject(Fenster) ;
}

event LookAt -> Fenster {
 Ego:
  walkToStdEventObject(Fenster) ;
 suspend ;
 delay 10 ;
  say("Es sieht irgendwie idyllisch aus da drau}en...") ;
 clearAction ;
}

event Open -> Fenster {
 Ego:
  walkToStdEventObject(Fenster) ;
 suspend ;
 delay 10 ;
  say("Das Fenster hat keinen Griff.") ;
  say("Es l#sst sich wohl nicht [ffnen.") ;
 clearAction ;	
}

event Close -> Fenster {
 Ego:
  walkToStdEventObject(Fenster) ;
  "Es ist schon zu."
}

/* ************************************************************* */

object Matte {
 setupAsStdEventObject(Matte,LookAt,118,323,DIR_WEST) ; 		
 setClickArea(20,269,106,330) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fu}matte" ;
}

object Mattegra {
 setPosition(52,269) ;	
 setAnim(Fussmatte_image) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = false ;
}

event WalkTo -> Matte {
 Ego:
  walkToStdEventObject(Matte) ;
}

event Use -> Matte {
 Ego:
  walk(73,300) ;
  turn(DIR_WEST) ;
 suspend ;
 delay 5 ;
  autoAnimate = false ;
  animMode = ANIM_WALK ;
  frame = 0 ;
 soundBoxStart(Music::Schuh_wav) ;
 for (var i=0; i<=8; i++) {
   delay Ego.walkAnimDelay ;
   Ego.frame = i ;
 }
 for (i=0; i<=8; i++) {
   delay Ego.walkAnimDelay ;
   Ego.frame = i ;
 } 
  animMode = ANIM_STOP ;
  autoAnimate = true ;
 clearAction ;
	
}

event LookAt -> Matte {
 Ego:
  walkToStdEventObject(Matte) ;
 suspend ;
  say("Eine Matte um die Schuhe abzustreifen.") ;
 delay 4 ;
  say("In meiner alten Studentenbude versteckte ich unter sowas immer meinen Hausschl]ssel.") ;
 clearAction ;
}

event Take -> Matte {
 Ego:
  walkToStdEventObject(Matte) ;
  "Ich will sie nicht."
  "Aber ich riskiere mal einen Blick darunter..."
 triggerObjectOnObjectEvent(Pull, Matte) ;
}

event Pull -> Matte {
 Ego:
  walk(118,323) ;
  turn(DIR_WEST) ;
 EgoStartUse ;
  Mattegra.visible = true ;
 EgoStopUse ;
 delay 9 ;
 Ego.say("Nichts?") ; 
 delay 7 ;
 EgoStartUse ;
  Mattegra.visible = false ;
 EgoStopUse ;
 delay 3 ;
 clearAction ;
}

/* ************************************************************* */

object NotizAnWand {
 setupAsStdEventObject(NotizAnWand,LookAt,170,270,DIR_NORTH) ; 		
 setClickArea(172,178 ,194,191);
 absolute = false ;
 clickable = true ;
 enabled = ! hasItem(Ego, Notiz) ;
 visible = false ;
 name = "Notiz" ;
}

event LookAt -> NotizAnWand {
 Ego:
  walkToStdEventObject(NotizAnWand) ;
 suspend ;
  say("Da ist eine Notiz auf pinkem Papier, zum Teil von dem Plakat verdeckt.") ;
  say("Was drauf steht, kann ich von hier aus nicht lesen.") ;
 clearAction ;
}

event Pull -> NotizAnWand {
 Ego:
  walkToStdEventObject(NotizAnWand) ;
 suspend ;
  say("Wie ein Blitz schoss mir gerade das Verb 'nehmen' durch den Kopf.") ;
  say("Ich wei} aber auch nicht, warum.") ;
 clearAction ;	
}

object NotizGra {
 setPosition(174,180) ;	
 setAnim(Notiz_image) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = ! hasItem(Ego, Notiz) ;
}

event Take -> NotizAnWand {
 Ego:
  walkToStdEventObject(NotizAnWand) ;
 suspend ;	
 egoStartUse ;
 takeItem(Ego, Notiz) ;
 NotizGra.visible = false ;
 EgoStopUse ;
 delay 2 ;
 triggerObjectOnObjectEvent(LookAt, Notiz) ;
 clearAction ;
}

/* ************************************************************* */

object Plakatpinn {
 setupAsStdEventObject(Plakatpinn,LookAt,170,270,DIR_NORTH) ; 		
 setClickArea(159,148 ,211,185) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Plakat" ;
}

event LookAt -> Plakatpinn {
 Ego:
  walkToStdEventObject(Plakatpinn) ;
 suspend ;
  say("Auf dem Plakat steht irgendein franz[sischer Text.") ;
  say("Ich kann aber kein franz[sisch, und das ist auch gut so.") ;
  say("Hier steht allerdings ein '1.' gefolgt von etwas Text, den ich nicht verstehe.") ;
  say("Dann kommt ein '2. ???'.") ;
  say("Und abschlie}end steht da '3. profit'.") ;
 delay 3 ;
 if (!hasItem(Ego, Notiz)) say("Hinter dem Plakat ist irgend etwas...") ;  
 clearAction ;
}

event Take -> Plakatpinn {
 Ego:
  walkToStdEventObject(Plakatpinn) ;
  "Ich m[chte es nicht, der Text ist auf franz[sisch!"
}

/* ************************************************************* */

object Pinnwand {
 setupAsStdEventObject(Pinnwand,LookAt,170,270,DIR_NORTH) ; 			
 setClickArea(140,133 ,229,200);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pinnwand" ;
}

event LookAt -> Pinnwand {
 Ego:
  walkToStdEventObject(Pinnwand) ;
 suspend ;
  say("Die Pinnwand aus Kork hat einen h[lzernen Rahmen.") ;
  say("An ihr h#ngt ein Plakat.") ;
 delay 3 ;  
 if (!hasItem(Ego, Notiz)) say("Hinter dem Plakat ist irgend etwas...") ;
 clearAction ;
}

event Use -> Pinnwand {
 Ego:
  walkToStdEventObject(Pinnwand) ;	
  "Ich m[chte nichts aufh#ngen."
}

event Take -> Pinnwand {
 Ego:
  walkToStdEventObject(Pinnwand) ;
  "Nein, die wird mir nichts bringen."
}



