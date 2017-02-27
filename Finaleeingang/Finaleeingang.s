// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var firstEnter = true ;

event enter {
 backgroundImage = Finaleeingang_image ;
 backgroundZBuffer = Finaleeingang_zbuffer ;
 Si = 0 ;
 Ego:
  path = Finaleeingang_path ;
 if (previousScene==Finaledavor) {
  scrollX = 0 ;
  setPosition(27,285) ;
  face(DIR_EAST) ;
  pathAutoScale = false ;
  scale = 585;
  path = 0 ;
  delay transitionTime ;
  soundBoxStart(Music::Tuerauf3_wav) ;
  TuerGra.frame = 0 ;
  TuerGra.enabled = true ;
  delay 3 ;
  walk(114,306) ;
  turn(DIR_EAST) ;
  path = Finaleeingang_path ;
  pathAutoScale = true ;
  turn(DIR_WEST) ;
  delay 2 ;
  EgoStartUse ;
  soundBoxStart(Music::Tuerzu2_wav) ;
  TuerGra.enabled = false ;
  EgoStopUse ;
  turn(DIR_EAST) ;
  if (firstEnter) start rosaChecks ;
 } else {
  scrollX = 850-640 ;
  pathAutoScale = false ;
  path = 0 ;
  scale = 266 ;
  setPosition(624,103) ;
  face(DIR_WEST) ;
  delay transitionTime ;
  walk(562,102) ;
  turn(DIR_WEST) ;
  delay 10 ;
  pathAutoScale = true ;
  path = Finaleeingang_path ;
 }
 
 start rosaAsleep ;
 
 forceShowInventory ;
 clearAction ;
}

/* ************************************************************* */

script rosaChecks {
 killOnExit = true ;
 loop {
   if (Ego.positionX > 280) { makeRosaFirstTalk ; return ; }
   delay ;
   return if (!firstEnter) ;
 }
}

/* ************************************************************* */

object Zuechter {
 setupAsStdEventObject(Zuechter,TalkTo,165,347,DIR_WEST) ;
 setAnim(Kleintier_sprite) ;
 setPosition(103,343) ;
 setClickArea(-37,-103,31,6) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Kleintierz]chter" ;
 CaptionColor = COLOR_ORANGE ;
 captionY = -120 ;
 captionX = 60 ;
 captionWidth = 320 ;
 scale = 850 ;
 autoAnimate = false ; 
}

var Zi = 0 ;

event animate Zuechter {
  Zi++ ;
  var blink = false ;
  switch (Zuechter.animMode) {
    case ANIM_TALK: 
      if (Zuechter.frame < 2) Zuechter.frame = 2 ;
      if (Zuechter.frame==2) blink = true ;
      if ((Zi > 2) and (random(2)==0)) {
        Zi = 0 ;
	if (Zuechter.frame==2) Zuechter.frame = 3 ;
         else Zuechter.frame = 2 ;	
      }
      if (blink and (Zuechter.frame==2) and(random(40)==0)) Zuechter.frame = 1 ;
    default:
      if (Zuechter.frame==3) Zuechter.frame = 2 ;
      if (Zuechter.frame==1) Zuechter.frame = 2 ;
      if ((Zuechter.frame == 0) and (Zi > 17+random(5))) {
        Zi = 0 ;
	if (random(2)==0) Zuechter.frame = 2 ;
      }
      if (Zi > 63+random(30)) {
        Zi = 0 ;
	if (random(3)==0) {
	  if (Zuechter.frame==2) Zuechter.frame = 0 ;
	    else Zuechter.frame = 2 ;
	}
      }
      if ((Zuechter.frame==2) and (random(40)==0)) Zuechter.frame = 1 ;
  }
}

event LookAt -> Zuechter {
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
  say("Da ist ja schon wieder dieser kleine lustige Verr]ckte mit dem Kleintierz]chterverein.") ;
 clearAction ;
}

event Pull -> Zuechter {
 triggerObjectOnObjectEvent(Push, Zuechter) ;
}

event Push -> Zuechter {
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
  say("Das w]rde ihm glaube ich nicht gefallen.") ;
 clearAction ;
}

event Take -> Zuechter {
 Ego: 
  walkToStdEventObject(Zuechter) ;
 suspend ;
  say("Nicht mein Typ.") ;
 clearAction ;
}

event Use -> Zuechter {
 triggerObjectOnObjectEvent(Take, Zuechter) ;
}

event Cactus -> Zuechter {
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
 if (!talkedZuechter) triggerObjectOnObjectEvent(TalkTo, Zuechter) ;
  else Ego.say("Er hat den Kleinen doch schon begutachten d]rfen. Das muss reichen.") ;
 clearAction ;
}

event invDrinks -> Zuechter {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
 if (used) {
   say("Gute Idee.") ;
   say("Ich m[chte aber die Reinigung seiner Kleidung nicht bezahlen.") ;
 } else {
   say("M[chten Sie ein Getr#nk?") ;
   if (cactusDestroyed) Zuechter.say("Bleiben Sie fern von mir!") ;
     else Zuechter.say("Nein danke, ich erfreue mich vollster Zufriedenheit.") ;
 }
 clearAction ;
}

static var talkedZuechter = false ;

event TalkTo -> Zuechter {
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
 
 if (!talkedZuechter) {
   talkedZuechter = true ;
   ZD ;
 } else { 
   say("Ich m[chte mich nicht weiter mit ihm unterhalten.") ;
   say("Vielleicht ist diese Kleintierz]chterei ja ansteckend.") ;
 }
 clearAction ;
}

/* ************************************************************* */

object Rosa {
 setupAsStdEventObject(Rosa,TalkTo,264,287,DIR_NORTH) ;
 setAnim(Rosa_sprite) ;
 setPosition(200,151) ;
 captionX = 23 ;
 captionWidth = 430 ;
 setClickArea(5,6,48,76) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "junge Frau" ;
 autoAnimate = false ;
 captionColor = COLOR_ROSA ;
 member asleep = false ;
 member talks = false ;
}

var Ri = 0 ;
var Si = 0 ;
var Ti = 0 ;

event animate Rosa { 

  // wenn Züchter oder Julian reden, wacht Rosi auf
  
  if ((Zuechter.caption != null) or ((findDistance(220,230,Ego.positionX, Ego.positionY) <= 210) and (Ego.caption != null))) {
    Rosa.asleep = false ;
    Si = 0 ; 
  }
  
  return if (Rosa.asleep) ;
  Ri++ ;
  Si++ ;
  Ti++ ;
  switch (Rosa.animMode) {
    case ANIM_TALK: ;
      Si = 0 ;
      if (Rosa.frame == 1) Rosa.frame = 0 ;
      if (Rosa.frame == 3) Rosa.frame = 2 ;  
      if (Rosa.frame == 5) Rosa.frame = 4 ;		
      if (Rosa.frame == 7) Rosa.frame = 6 ;		

      if (Rosa.frame>7) Rosa.frame = 0 ;
	      
      if ((Ri >= 52+random(8)) and (random(3)==0)) { // change direction she looks at
        Ri = 0 ;
        if (random(3)==0) {
          if (Rosa.frame > 3) Rosa.frame = 0 ;
	    else Rosa.frame = 4 ;
        }
      }
      if ((Ti >= 2) and (random(2)==0)) { // change mouth movement
        Ti = 0 ;
	if (Rosa.frame > 3) {
	  if (Rosa.frame==4) Rosa.frame=6 ;
	   else Rosa.frame = 4 ;
        } else { 
	  if (Rosa.frame==0) Rosa.frame=2 ;
	   else Rosa.frame = 0 ;
        }
      }
      if ((Ri > 16) and (random(30)==0)) { // blink with her eyes
        if (Rosa.frame == 0) Rosa.frame = 1 ;
	if (Rosa.frame == 2) Rosa.frame = 3 ;  
        if (Rosa.frame == 4) Rosa.frame = 5 ;		
        if (Rosa.frame == 6) Rosa.frame = 7 ;		
      }
	    
    default: 
      if (Si < 220) { // asleep?
        if (Rosa.frame == 1) Rosa.frame = 0 ;	      
        if (Rosa.frame == 5) Rosa.frame = 4 ;		
        if (Rosa.frame > 7) Rosa.frame = 0 ;
	if ((Rosa.frame==2) or (Rosa.frame==3)) Rosa.frame = 0 ;
        if ((Rosa.frame==6) or (Rosa.frame==7)) Rosa.frame = 4 ;		
        if ((Ri >= 30+random(8)) and (random(3)==0)) { // change direction she looks at
          Ri = 0 ;
  	  if (random(3)==0) {
            if (Rosa.frame > 1) Rosa.frame = 0 ;
	      else Rosa.frame = 4 ;
          }
        }
        if ((Ri > 16) and (random(30)==0)) { // blink with her eyes
          if (Rosa.frame > 1) Rosa.frame = 5 ;
	    else Rosa.frame = 1 ;
        }
      } else {  // fall asleep
        if ((random(2)==0) and (!Rosa.talks)) Rosa.asleep = true ;
	  else Si = 0 ;
      }
  }
}

script rosaAsleep {
 killOnExit = true ;
 loop {
  if (Rosa.asleep) {
    Rosa.frame = 0 ;
    for (var i=0;i<17;i++) { if (Rosa.asleep) delay ; }
    Rosa.frame = 8 ;
    for (i=0;i<22;i++) { if (Rosa.asleep) delay ; }
    Rosa.frame = 0 ;
    for (i=0;i<29;i++) { if (Rosa.asleep) delay ; }
    Rosa.frame = 9 ;
    for (i=0;i<33;i++) { if (Rosa.asleep) delay ; }
    while (Rosa.asleep) {
      if (Rosa.asleep) Rosa.frame = 10 ;
      for (i=0;i<60;i++) { if (Rosa.asleep) delay ; }
      if (Rosa.asleep) Rosa.frame = 11 ;
      for (i=0;i<60;i++) { if (Rosa.asleep) delay ; }
    }    
  } else delay ;
 }
}

script makeRosaFirstTalk {
 suspend ;
 forceHideInventory ;
 Rosa.asleep = false ;
 Si = 0 ; 
 delay ;
 Ego.stop ;
 Rosa.say("Hey!") ;
 Rosa.say("Sie da!") ;
 delay 3 ;
 Ego.turn(DIR_NORTH) ;
 delay 2 ;
 Ego.say("Ich?") ;
 delay 3 ;
 Rosa.say("Ja.") ;
 Rosa.say("Wollen Sie zur Pr#sentation?") ;
 delay 2 ;
 Ego.say("@hm...") ;
 Ego.say("Ja?") ;
 delay 3 ;
 Rosa.say("Dann m]ssen Sie sich erst hier anmelden.") ;
 delay 2 ;
 Ego.walkToStdEventObjectNoResume(Rosa) ;
 rosaFirstTalk ;
}

script doRosaFirstTalk { 
 forceHideInventory ;
 Rosa.say("Wollen Sie zur Pr#sentation?") ;
 delay 2 ;
 Ego.say("@hm...") ;
 Ego.say("Ja?") ;
 delay 3 ;
 Rosa.say("Gut.") ; 
 rosaFirstTalk ;
}

script rosaFirstTalk {
  firstEnter = false ;
  Rosa.say("Wie lautet Ihr Name?") ;
  delay 2 ;
  Ego.say("Hobler. Julian Hobler.") ;
  Rosa.say("K[nnen Sie sich ausweisen, Herr Hobler?") ;
  delay ;
  Ego.say("Selbstverst#ndlich. Hier ist mein Personalausweis.") ;
  EgoUse ;    
  Rosa.frame = 0 ;
  delay ;
  Rosa.frame = 0 ;
  delay ;
  Rosa.say("Alles klar.") ;
  delay 3 ;
  Rosa.say("Ich sehe mal eben, ob ich Sie im Computer habe...") ;
  delay 3 ;
  Rosa.frame = 0 ;
  delay 2 ;
  Rosa.frame = 0 ;
  delay 4 ;
  Rosa.say("Nein.") ;
  Rosa.say("Dann war es das auch schon Herr Hobler.") ;
  delay 3 ;
  Ego.say("Moment mal...") ;
  Ego.say("Was wird hier denn ]berhaupt pr#sentiert?") ;
  Ego.say("Und wieso sollte ich in Ihrem Computer stehen?") ;
  delay 3 ;
  Rosa.say("Das Unternehmen SamTec stellt der |ffentlichkeit ihre neueste Entwicklung vor.") ;
  Rosa.say("Au}erdem diskutiert der SamTec-Vorstand mit Vertretern von ausgew#hlten Unternehmen ]ber m[gliche Kooperationsm[glichkeiten.") ;
  Rosa.say("Und diese Vertreter stehen in meinem Computer.") ;
  delay 3 ;
  Rosa.say("Und jetzt viel Spa} bei der Pr#sentation.") ;
  Rosa.say("Gehen Sie einfach die Treppe hoch und dann rechts.") ;
  
  forceShowInventory ;
  clearAction ;
}

event TalkTo -> Rosa {
 var hadHaarklammer = hasItem(Ego, Haarklammer) ;
 Ego:
  walkToStdEventObject(Rosa) ;
 suspend ;
 start {
   delay 3 ;
   Rosa.asleep = false ;
   Rosa.talks = true ;
   Si = 0 ;
 }
 if (firstEnter) say("Hallo!") ;
  else
 switch (random(3)) {
   case 0: say("Hi!") ;
   case 1: say("Hallo nochmal.") ;
   default: say("Da bin ich wieder.") ;
 }
 delay 2 ;
 if (rosaBeleidigt) {
   Rosa.say("Sie schon wieder?") ;
   Rosa.say("Wie k[nnen Sie es wagen, nach Ihrer verbalen Entgleisung hier nochmal aufzutauchen?") ;
   delay 3 ;
   Ego.say("Beruhigen Sie sich, ich habe es doch nicht so gemeint.") ;
   Ego.say("Ich wollte Sie doch nur etwas #rgern.") ;
   delay 4 ;
   Rosa.say("Na gut.") ;
   rosaBeleidigt = false ;
 }
 if (firstEnter) doRosaFirstTalk ;
   else {
     Rosa.say("Hallo Herr Hobler.") ;
     RD ;
   }
 Rosa.talks = false ;   
 if ((!hadHaarklammer) and (hasItem(Ego, Haarklammer))) {
  delay 3 ;
  Ego.turn(DIR_SOUTH) ;
  delay 4 ;
  Ego.say("Das war gut.") ;
 }
 clearAction ;
}

event LookAt -> Rosa {
 Ego:
  walkToStdEventObject(Rosa) ;
 suspend ;
 var rosaAsleep = Rosa.asleep ; 
  say("Eine junge Frau sitzt vor einem Laptop an dem Empfangstisch.") ;
  delay 5 ;
  say("Sie hat sich mit einigen Haarklammern das Haar zur]ck gesteckt.") ;
 if (rosaAsleep) say("Bis eben war sie eingenickt.") ;
 knowsHaarKlammer = true ;
 clearAction ;
}

event Stock -> Rosa {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Rosa) ;
 suspend ;
 if (used) {
   if (knowsHaarKlammer and (!hasItem(Ego, Haarklammer))) Ego.say("Ich k[nnte versuchen, mir eine ihrer Haarklammern zu angeln. Aber das w]rde sie definitiv bemerken.") ;
     else say("Die meisten Leute werden nerv[s, wenn man sie mit einem Stock bedroht.") ;
 } else {
   say("W#ren Sie an diesem Prachtexemplar an Bambusstock interessiert?") ;
   Rosa.say("Nein, wirklich nicht.") ;
 }
 clearAction ;
}


event Pull -> Rosa {
 triggerObjectOnObjectEvent(Push, Rosa) ;
}

event Push -> Rosa {
 Ego:
  walkToStdEventObject(Rosa) ;
 suspend ;
  say("Das w]rde ihr glaube ich nicht gefallen.") ;
 clearAction ;
}

event Take -> Rosa {
 Ego: 
  walkToStdEventObject(Rosa) ;
 suspend ;
  say("Nicht jetzt.") ;
 clearAction ;
}

event Use -> Rosa {
 triggerObjectOnObjectEvent(Take, Rosa) ;
}

event invDrinks -> Rosa {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Rosa) ;
 suspend ;
 if (used) {
   say("Gute Idee.") ;
   say("Aber das w]rde ihr nicht gefallen.") ;
 } else {
   say("M[chten Sie ein Getr#nk?") ;
   Rosa.say("Vielen Dank, nein.") ;
 }
 clearAction ;
}

/* ************************************************************* */

object Plakat1 {
 setupAsStdEventObject(Plakat1,LookAt,284,293,DIR_NORTH) ;	
 setClickArea(228,0,341,218) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Plakat" ;
}

event LookAt -> Plakat1 {
 Ego:
  walkToStdEventObject(Plakat1) ;
 suspend ;
  say("Auf dem Plakat ist ein leuchtender Kristall zu sehen.") ;
  say("Darunter steht: 'The future of power begins today'.") ;  
 clearAction ;
}

event Take -> Plakat1 {
 Ego:
  walkToStdEventObject(Plakat1) ;
 suspend ;
  say("Ich komme nicht ran.") ;
 clearAction ;
}

event Push -> Plakat1 {
 triggerObjectOnObjectEvent(Take, Plakat1) ;
}

event Pull -> Plakat1 {
 triggerObjectOnObjectEvent(Take, Plakat1) ;
}

/* ************************************************************* */

object Bombe {
 setupAsStdEventObject(Bombe,LookAt,605,338,DIR_EAST) ;	
 setClickArea(707,227,786,357) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Bombe" ;
}

event Take -> Bombe {
 Ego:
  walkToStdEventObject(Bombe) ;
  say("Ich will sie nicht.") ;
}

event Use -> Bombe {
 Ego: 
  walkToStdEventObject(Bombe) ;
  say("Sie ist aus Plastik.") ;
}

event LookAt -> Bombe {
 Ego:
  walkToStdEventObject(Bombe) ;
 suspend ;
  say("Eine Plastiknachbildung der Bombe, die ich im SamTec-Sicherheitsbereich gesehen habe.") ;
 clearAction ;
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,Open,114,306,DIR_WEST) ;	
 setClickArea(1,135,115,306) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "T]ren" ;
}

event Close -> Tuer {
 Ego: 
  walkToStdEventObject(Tuer) ;
 suspend ;
  say("Die T]ren sind bereits geschlossen.") ;
 clearAction ;
}

event LookAt -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
  say("Die T]ren f]hren nach drau}en.") ;
}

event Use -> Tuer {
 triggerObjectOnObjectEvent(Open, Tuer) ;
}

event Open -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 delay 2 ;
 EgoStartUse ;
 soundBoxStart(Music::Tuerauf3_wav) ;
 TuerGra.frame = 1 ;
 TuerGra.enabled = true ;
 EgoStopUse ;
 Ego:
  pathAutoScale = false ;
  path = 0 ;
  scale = 585 ;
  walk(20,285) ;
 
 turn(DIR_EAST) ;
 soundBoxStart(Music::Tuerzu2_wav) ;
 TuerGra.enabled = false ;
 Ego.visible = false ;
 
 delay ;
 Ego.visible = true ;
 Ego.pathAutoScale = true ;  
 doEnter(Finaledavor) ;
}


object TuerGra {
 setPosition(33,173) ;
 setAnim(Tueroffen_sprite) ;
 autoAnimate = false ;
 visible = true ;
 enabled = false ;
 clickable = false ;
 absolute = false ;
}

/* ************************************************************* */

object Durchgang {
 setupAsStdEventObject(Durchgang,WalkTo,562,102,DIR_EAST) ;
 setClickArea(572,45,604,106) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Durchgang" ;
}

event Take -> Durchgang {
 triggerObjectOnObjectEvent(WalkTo, Durchgang) ;
}

event Use -> Durchgang {
 triggerObjectOnObjectEvent(WalkTo, Durchgang) ;
}

event WalkTo -> Durchgang {
 Ego:
  walkToStdEventObject(Durchgang) ;
 suspend ;
 pathAutoScale = false ;
 path = 0 ; 
 scale = 266 ;
 walk(624,103) ;
 delay 10 ;
 pathAutoScale = true ;
 doEnter(Finalesaal) ;
}

event LookAt -> Durchgang {
 Ego:
  walkToStdEventObject(Durchgang) ;
  say("Ich kann da hinten einen gro}en Saal erkennen.") ;
}

/* ************************************************************* */

object Plakat2 {
 setupAsStdEventObject(Plakat2,LookAt,600,290,DIR_EAST) ;
 setClickArea(706,1,794,226) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Plakat" ;
}

static var sawBomb = false ;

event LookAt -> Plakat2 {
 Ego:
  walkToStdEventObject(Plakat2) ;
 suspend ;
  say("Auf dem Plakat ist eine Art Bombe abgebildet.") ;
  say("Darunter steht: 'A bomb to change the world'.") ;   
 sawBomb = true ;
 clearAction ;
}

event Take -> Plakat2 {
 Ego:
  walkToStdEventObject(Plakat2) ;
 suspend ;
  say("Ich komme nicht ran.") ;
 clearAction ;
}

event Push -> Plakat2 {
 triggerObjectOnObjectEvent(Take, Plakat2) ;
}

event Pull -> Plakat2 {
 triggerObjectOnObjectEvent(Take, Plakat2) ;
}

/* ************************************************************* */

object Kaktus {
 setupAsStdEventObject(Kaktus,LookAt,460,250,DIR_WEST) ;
 setClickArea(411,168,449,249) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
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
 clearAction ;
}

event Pull -> Kaktus {
 triggerObjectOnObjectEvent(Push, Kaktus) ;
}

/* ************************************************************* */

object Banner {
 setupAsStdEventObject(Banner,LookAt,274,222,DIR_NORTH) ;
 setClickArea(164,236,382,277) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Banner" ;
}

event LookAt -> Banner {
 Ego:
  walkToStdEventObject(Banner) ;
 suspend ;
  say("Die Pr#sentation findet laut dem Banner im ersten Stock statt.") ;
 clearAction ;
}

event Take -> Banner {
 Ego: 
  walkToStdEventObject(Banner) ;
 suspend ;
  say("Ich glaube nicht, dass er mir irgendwie weiterhelfen kann.") ;
 clearAction ;
}

/* ************************************************************* */

object Bild {
 setupAsStdEventObject(Bild,LookAt,510,100,DIR_NORTH) ;
 setClickArea(473,13,542,67) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 name = "Bild" ;
}

event Take -> Bild {
 Ego:
  walkToStdEventObject(Bild) ;
  say("Ich will es nicht mit mir herumtragen.") ;
}

event LookAt -> Bild {
 Ego:
  walkToStdEventObject(Bild) ;
 suspend ;
  say("Goyas Kampf mit den Mamelucken am 2. Mai 1808 in Madrid.") ;
 clearAction ;
}

event Push -> Bild {
 Ego:
  walkToStdEventObject(Bild) ;
 suspend ;
  EgoUse ;
  say("Es ist zu gut an der Wand befestigt.") ;
 clearAction ;
}

event Pull -> Bild {
 triggerObjectOnObjectEvent(Push, Bild) ;
}

event Take -> Bild {
 triggerObjectOnObjectEvent(Push, Bild) ;
}

/* ************************************************************* */

object Bleistifte {
 setupAsStdEventObject(Bleistifte,LookAt,490,340,DIR_SOUTH) ;
 setClickArea(450,327,464,356) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 name = "Bleistifte" ;
}

event LookAt -> Bleistifte {
 Ego:
  walkToStdEventObject(Bleistifte) ;
 say("Diese Bleistifte sind dazu da, damit Besucher diese Formulare hier auf dem Tisch ausf]llen k[nnen.") ;
 clearAction ;
}

event TalkTo -> Bleistifte {
 Ego:
  walkToStdEventObject(Bleistifte) ;
 suspend ;
  say("Hallo ihr Bleistifte.") ;
  delay 10 ;
 clearAction ;
}

event Pull -> Bleistifte {
 Ego:
  walkToStdEventObject(Bleistifte) ;
 suspend ;
  say("Ich m[chte sie nicht herunterwerfen.") ;
 clearAction ;
}

event Push -> Bleistifte {
 triggerObjectOnObjectEvent(Pull, Bleistifte) ;
}

event Bleistift -> Bleistifte {
 Ego: 
  walkToStdEventObject(Bleistifte) ;
 suspend ;
  say("Ich lege den Stift zur]ck.") ;
 EgoStartUse ;
  dropItem(Ego, Bleistift) ;
 EgoStopUse ;
 clearAction ;
}

event Take -> Bleistifte {
 Ego:
  walkToStdEventObject(Bleistifte) ;
 suspend ;
 if (hasItem(Ego, Bleistift)) Ego.say("Ich habe mir schon einen genommen.") ;
  else { 
    say("Einen nehme ich mit.") ;
    egoStartUse ;
    delay 2 ;
    takeItem(Ego, Bleistift) ;
    egoStopUse ;
  }
 clearAction ;
}

/* ************************************************************* */

object Formulare {
 setupAsStdEventObject(Formulare,LookAt,490,340,DIR_SOUTH) ;
 setClickArea(475,335,503,359) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 name = "Formulare" ;
}

event LookAt -> Formulare {
 Ego:
  walkToStdEventObject(Formulare) ;
 say("Hier kann man seinen Namen und Adresse hinterlassen, um sich ]ber neue Entwicklungen des SamTec-Konzerns informieren zu lassen.") ;
 clearAction ;
}

event TalkTo -> Formulare {
 Ego:
  walkToStdEventObject(Formulare) ;
 suspend ;
  say("Hallo zusammen!") ;
  delay 10 ;
 clearAction ;
}

event Bleistift -> Formulare {
 Ego:
  walkToStdEventObject(Formulare) ;
 suspend ;
  say("Ich m[chte diesem SamTec-Konzern ganz bestimmt nicht meine Adresse zukommen lassen.") ;
 delay 3 ;
  say("Zumal ich gar kein Haus mehr besitze.") ;
 clearAction ;
}

event Take -> Formulare {
 Ego:
  walkToStdEventObject(Formulare) ;
 suspend ;
 if (hasItem(Ego, SFormular)) {
   say("Ich habe bereits ein Formular.") ;
   clearAction ;
   return ;
 } 
 if (hasItem(Ego, SFormularV)) {
   say("Ich lege das Formular mit dem verwischten Seifenabdruck zur]ck in den Stapel und nehme mir ein Frisches.") ;
   egoStartUse ;
   dropItem(Ego, SFormularV) ;
   egoStopUse ;
   delay 2 ;
   egoStartUse ;
   takeItem(Ego, SFormular) ;
   egoStopUse ;
   clearAction ;
   return ;
 }
 if ((hasItem(Ego, SFormularS)) or (hasItem(Ego, SFormularF))) {
   say("Ich ben[tige nicht noch ein Formular.") ;
   clearAction ;
   return ;
 }
 egoStartUse ;
 soundBoxStart(Music::Papier_wav) ;
 takeItem(Ego, SFormular) ;
 egoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Box {
 setupAsStdEventObject(Box,LookAt,490,340,DIR_SOUTH) ;
 setClickArea(509,327,542,355) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 name = "Box" ;
}

event LookAt -> Box {
 Ego:
  walkToStdEventObject(Box) ;
 say("Dort werden die Formulare mit den Namen und Adressen eingeworfen.") ;
 clearAction ;
}

event SFormular -> Box {
 Ego:
  walkToStdEventObject(Box) ;
 suspend ;  
 EgoStartUse ;
  dropItem(Ego, SFormular) ;
 EgoStopUse ;
 clearAction ;
}

event SFormularV -> Box {
 Ego:
  walkToStdEventObject(Box) ;
 suspend ;
  say("Das verschmierte Formular kann ich bestimmt nicht mehr gebrauchen.") ;
 EgoStartUse ;
  dropItem(Ego, SFormularV) ;
 EgoStopUse ;
 clearAction ;
}

event SFormularS -> Box {
 Ego:
  walkToStdEventObject(Box) ;
 suspend ;
  say("Den Fingerabdruck auf dem Formular k[nnte ich noch gebrauchen.") ;
 clearAction ;
}

event SFormularF -> Box {
 triggerObjectOnObjectEvent(SFormularS, Box) ;
}

event TalkTo -> Box {
 Ego:
  walkToStdEventObject(Box) ;
 suspend ;
  say("Hallo?") ;
 delay 3 ;
  say("Ist da jemand drinnen?") ;
 delay 10 ;
 clearAction ;
}

/* ************************************************************* */

static var knowsHaarKlammer = false ;
static var rosaEingeschleimt = false ;
static var rosaBeleidigt = false ;

script RD {

 static var knowsPatri = false ;
 static var RDa = false ;
 static var RDb = false ;
 static var RDc = false ;
 static var RDd = false ;
 static var RDf = false ;
 static var RDg = false ;
 
 static var gaveKlammer = false ;


 loop {
  Ego:

   AddChoiceEchoEx(1, "Was ist das hier nochmal f]r eine Pr#sentation?", true) ;
   AddChoiceEchoEx(2, "Ist das eine Bombe da dr]ben auf dem Plakat?", true) if ((!RDb) and sawBomb) ;
   AddChoiceEchoEx(3, "Wo finde ich den SamTec-Vorstand?", true) if (!RDc) ;
   AddChoiceEchoEx(4, "K[nnte ich eine Identifikationskarte bekommen?", true) if (knowsIDCard and (!hasItem(Ego, IDCard))) ;
   AddChoiceEchoEx(5, "Was k[nnen Sie mir ]ber diese regenerative Energiequelle erz#hlen?", true) if (knowsPatri) ;
   AddChoiceEchoEx(6, "H]bsche Halskette!", true) if ((!RDf) and (RDg)) ;
   AddChoiceEchoEx(6, "Sagte ich bereits, dass Sie da eine sehr h]bsche Halskette tragen?", true) if (RDf and RDg and (!rosaEingeschleimt)) ;
   AddChoiceEchoEx(7, "K[nnten Sie mir eine Ihrer Haarklammern ausleihen?", true) if (knowsHaarKlammer and (!gaveKlammer) and (!rosaEingeschleimt)) ;
   AddChoiceEchoEx(7, "K[nnten Sie mir vielleicht nicht doch eine Ihrer Haarklammern ausleihen? Eine weniger tut Ihrer Sch[nheit doch keinen Abbruch...", true) if (knowsHaarKlammer and (!gaveKlammer) and (rosaEingeschleimt)) ;
   AddChoiceEchoEx(8, "Ich muss dann mal wieder weiter.", true) ;
   
   
  var d = dialogEx () ;
  
  switch d {
    case 1:
      Rosa.say("Die Firma SamTec stellt zum ersten Mal der |ffentlichkeit ihre neueste Entwicklung namens 'Patrimonium' vor.") ;
      if (!knowsPatri) {
        delay 2 ;
        Ego.say("Patrimonium?") ;
	delay ;
	Rosa.say("Genau.") ;
	delay ;
	knowsPatri = true ;
      }
      Rosa.say("Es handelt sich dabei um eine regenerative Energiequelle.") ;
      RDa = true ;
    case 2:
      Rosa.say("Das haben Sie richtig erkannt.") ;
      Rosa.say("Sie stellt ein Symbol daf]r dar, dass 'Patrimonium' bei der Welt[ffentlichkeit wie eine Bombe einschlagen wird.") ;
      if (!knowsPatri) {
        delay 2 ;
        Ego.say("Patrimonium?") ;
	delay ;
	Rosa.say("Genau.") ;
	delay ;
	Rosa.say("Eine regenerative Energiequelle.") ;
	knowsPatri = true ;
      }
      RDB = true ;
    case 3:
      Rosa.say("Herr Brander empf#ngt nur Vertreter ausgew#hlter Unternehmen.") ;
      Rosa.say("Vielleicht entt#usche ich Sie wenn ich Ihnen sage, dass sie nicht dazu geh[ren.") ;
      delay 4 ;
      Ego.say("Ach das ist schon in Ordnung, sowas h[re ich st#ndig.") ;
      delay 2 ;
      RDc = true ;
    case 4:
      if (!RDd) {
        Rosa.say("Da muss ich Sie leider entt#uschen, Herr Hobler.") ;
        Rosa.say("Laut meinem Computer haben Sie keine Berechtigung f]r den internen Bereich.") ;
        RDd = true ;
      } else Rosa.say("Ich sagte doch schon, dazu sind Sie nicht berechtigt.") ;
      RDI ;
    case 5:
      Rosa.say("Nicht viel, Herr Hobler.") ;
      Rosa.say("Sehen Sie sich einfach die Pr#sentation an.") ;
      Rosa.say("Dort finden Sie einen Experten auf diesem Gebiet.") ;
    case 6:
      Rosa.say("Danke sch[n!") ;
      RDf = true ;
      RDS ;
    case 7:
      RDg = true ;
      if (rosaEingeschleimt) {
	Rosa.say("Vielleicht haben Sie Recht.") ;
        Rosa.say("F]r Sie werde ich mal eine kleine Ausnahme machen, Herr Hobler.") ;
        Rosa.say("Bitte sehr.") ;
        EgoStartUse ;
        takeItem(Ego, Haarklammer) ;
	gaveKlammer = true ;
        EgoStopUse ;
	return ;
      } else {
        Rosa.say("Nein, tut mir Leid.") ;	      
      } 
    default: 
      switch random(2) {
       case 0: Rosa.say("Ist gut.") ;
       default: Rosa.say("Auf wiedersehen.") ;
      }
      return ;	
  }
 }

}

script RDS {
  var RDSa = 0 ;
  
  loop {
   Ego:
   
    addChoiceEchoEx(1,"Sie passt ausgezeichnet zu Ihren Ohrringen.",true) if (RDSa==0) ;
    addChoiceEchoEx(2,"Haben Sie die etwa aus der Bravo?",true) if (RDSa==0) ;	    
	
    addChoiceEchoEx(2,"Meine Urgro}mutter tr#gt die gleichen, wirkt damit aber j]nger als Sie.",true) if (RDSa==1) ;	    	    	    	
    addChoiceEchoEx(4,"Subtil stellen Sie damit Geschmack und Stil unter Beweis.",true) if (RDSa==1) ;	    
    
    addChoiceEchoEx(1,"Ihr bezaubernd sch[nes Gesicht wird durch den eleganten Schmuck unaufdringlich betont.",true) if (RDSa==2) ;	    
    addChoiceEchoEx(2,"Ihr Schmuck lenkt die Aufmerksamkeit von den Unreinheiten in Ihrem Gesicht ab.",true) if (RDSa==2) ;	    	    
	    
    addChoiceEchoEx(2,"Schade nur, dass Ihr Haar den Gesamteindruck total ruiniert.",true) if (RDSa==3) ;	    	    
    addChoiceEchoEx(4,"Ihr gl#nzendes kr#ftiges Haar l#sst sie jung und vital aussehen.",true) if (RDSa==3) ;	    	    
	    
    addChoiceEchoEx(1,"Und Ihre modische Frisur unterstreicht dabei Ihre Pers[nlichkeit und Individualit#t...",true) if (RDSa==4) ;	    
    addChoiceEchoEx(2,"Aber diese Vokuhila-Frisur ist doch schon seit Jahren total out.",true) if (RDSa==4) ;	    	    
	    
    addChoiceEchoEx(2,"...und zwar im negativen Sinn. Sie passt ]berhaupt nicht zu Ihnen.",true) if (RDSa==5) ;	    
    addChoiceEchoEx(4,"Sie haben doch einen Trick wie Sie solch traumhaft tolle Haare hinbekommen.",true) if (RDSa==5) ;	    	    
	    
    addChoiceEchoEx(3,"Zu etwas anderem...", true) ;
    
    var f = dialogEx ;
    
    switch f {
      case 1,4: 
        switch (RDSa) {
	  case 0: Rosa.say("Sie sind Ihnen aufgefallen?") ; 
	  case 1: Rosa.say("Sie Charmeur!") ;
	  case 2: Rosa.say("Wenn Sie so weiter machen, werde ich noch ganz rot!") ;
	  case 3: Rosa.say("Sie wissen, wie man einer Frau Komplimente macht.") ;
	  case 4: Rosa.say("Nun h[ren Sie auf mit Ihren Schmeicheleien.") ;
	  case 5: Rosa.say("Nein, bis auf ein paar Haarklammern habe ich keine Tricks.") ; rosaEingeschleimt = true ;
	}
	RDSa++ ;
      case 2: Rosa.say("Hmmpf!") ; rosaBeleidigt = true ; delay 3 ; Ego.turn(DIR_SOUTH) ; Ego.say("Mehr Feingef]hl Julian, mehr Feingef]hl!") ; clearAction ; finish ; 
      default: return ;
    }
    
  }
  
}


script RDI {
 loop {
 Ego:
   
   addChoiceEchoEx(1,"Der interne Bereich..?", true) ;
   addChoiceEchoEx(2,"Wie bekommt man eine solche Berechtigung f]r den internen Bereich?", true) ;
   addChoiceEchoEx(3,"Zu etwas anderem...", true) ;
   
   var e = dialogEx ;
   
   switch e {
     case 1:
       Rosa.say("Sie haben richtig geh[rt.") ;       
       Rosa.say("Der ist nur f]r SamTec-Kooperationspartner bestimmt.") ;
       Ego.say("Kooperationspartner?") ;
       Rosa.say("Unternehmen, die an der neuen Technologie interessiert sind.") ;
       Ego.say("Verstehe.") ;
     case 2:
       Rosa.say("Sie m]ssten ein Unternehmen repr#sentieren, dass an Kooperationsm[glichkeiten mit SamTec interessiert ist.") ;
       Rosa.say("Dann w]rden Sie in meinem Computer stehen, was Sie allerdings nicht tun, Herr Hobler.") ;
     default: return ;
   }
 }
}

/* ************************************************************* */

script ZD {
   Zuechter.say("Ahhhhh...") ;
   delay ;
   Zuechter.say("Wie wunderbar!") ;
   Zuechter.say("Ein bekanntes Gesicht!") ;
   Zuechter.say("Sch[n, Mitglieder des Vereins 'Ein Herz f]r Kleintiere e. V.' ]berall auf der Welt zu treffen!") ;
   delay 2 ;
   Ego.say("Was machen Sie denn hier?") ;
   delay ;
   Zuechter.say("Psssst...") ;
   delay 3 ;
   Zuechter.say("K[nnten Sie bitte etwas leiser reden?") ;
   delay 3 ;
   Ego.say("Ach verstehe, Sie rekrutieren hier wieder einmal weitere Mitglieder f]r ihren Verein.") ;
   delay 2 ;
   Ego.say("Wer h#tte das gedacht...") ;
   delay 2 ;
   Ego.say("Wie geht es Ihrem Verein denn?") ;
   delay ;
   Zuechter.say("Wunderbar!") ;
   Zuechter.say("Wir haben nun ]ber 1500 Mitglieder, die sich wie Sie aufopferungsvoll um ihre kleine Lieblinge k]mmern.") ;
   
   Ego.say("{ber 1500 Mitglieder?!") ;
   
   Zuechter.say("Aber ja!") ;
   Zuechter.say("Das ist ja auch kein Wunder, bei den exklusiven Vorteilen die Mitglieder des Vereins genie}en.") ;
   Zuechter.say("Wie zum Beispiel das j#hrliche Vereinsmagazin oder...") ;
   Ego.say("Schon gut, ich wei} doch Bescheid.") ;
   delay ;
   Zuechter.say("Sie sind ja auch ein gl]ckliches Mitglied des 'Ein Herz f]r Kleintiere e.V.'-Vereins!") ;
   delay 2 ;
   Zuechter.say("Ich hoffe, Ihr kleiner Oscar ist ebenso gl]cklich!") ;
   delay 2 ;
   Zuechter.say("Kann ich ihn mal sehen?") ;
   delay 3 ;
   
   if (!hasItem(Ego, Cactus)) {
     Ego.say("Tut mir leid, ich habe ihn momentan nicht bei mir.") ;
     Zuechter.say("Schade!") ;
     Zuechter.say("Ich hoffe er ist gut beh]tet.") ;
     Ego.say("Aber sicher ist er das.") ;
     Ego.say("Ich muss jetzt dann mal weiter.") ;
     Ego.say("Auf wiedersehen.") ;
     Zuechter.say("Tsch]ss Herr Wonciek!") ;
     clearAction ;
     return ;
   }
   
   EgoStartUse ;
   dropItem(Ego, Cactus) ;
   
   delay 22 ;
   
   if (cactusDestroyed) {
     Zuechter.say("Oh mein Gott!") ;
     Zuechter.say("Wer hat Ihrem Kleinen denn DAS angetan?") ;
     delay 10 ;
     Ego.say("@hhhh...") ;
     delay 3 ;
     Ego.say("Ich habe ihn nur mal kurz eine Woche meinem vergesslichen Nachbarn anvertraut.") ;
     Ego.say("Er muss den kleinen Oscar wohl f]r eine Esskastanie gehalten...") ;
     Ego.say("...und zu lange in die Pfanne geworfen haben.") ;
     delay 2 ;
     Zuechter.say("Wie unachtsam!") ;
     Zuechter.say("Es haben nicht alle Menschen ein Herz f]r Kleintiere.") ;
     Zuechter.say("Merken Sie sich das gef#lligst f]r's n#chste mal!") ;
     delay 3 ;
     Zuechter.say("Unter diesen Umst#nden m]ssen wir Ihre Mitgliedschaft k]ndigen.") ;
     Zuechter.say("H#ndigen Sie mir bitte unverz[glich Ihren Mitgliedsausweis aus!") ;
     delay 5 ;
     if (hasItem(Ego,Membercard)) {
       Ego.say("Hier haben Sie ihn.") ;
       EgoStartUse ;
       delay ;
       dropItem(Ego, Membercard) ;
       delay ;
       EgoStopUse ;
     } else {
       Ego.say("Ich habe ihn nicht bei mir.") ;
       delay 2 ;
       Zuechter.say("Dann vernichten Sie ihn, sobald Sie ihn wieder in die H#nde bekommen.") ;
     }
     delay 2 ;
     Zuechter.say("Unser Gespr#ch ist an dieser Stelle beendet.") ;
     Zuechter.say("Gehen Sie jetzt, Herr Wonciek.") ;
     Zuechter.say("Und bleiben Sie fern von mir.") ;
     clearAction ;
     return ;
   } else {
     if (cactusBurned) {
       Zuechter.say("Das ist ja schrecklich!") ;
       Zuechter.say("Ihr Kleiner hat ja einen Sonnenbrand!") ;
       if (cactusDrowned) Zuechter.say("Und er ist ja ganz nass!") ;
       delay 10 ;
       Ego.say("@hhhh...") ;
       delay 3 ;
       Ego.say("Wir sind beide wohl etwas zu lang am Strand gelegen.") ;
       if (cactusDrowned) Ego.say("Und dann wurden wir von einem gewaltigen Unwetter ]berrascht!") ;
       delay 2 ;
       if (cactusDrowned) Zuechter.say("Zu viel Sonne und zu viel Regen schaden jedem Kleintier!") ;
	 else Zuechter.say("Zu viel Sonne schadet jedem Kleintier!") ;
       delay 5 ;
       Zuechter.say("Meine kleine W]stenrennmaus Hugo litt einst aufgrund einer Unterk]hlung...") ;
       Zuechter.say("...nach einem n#chtlichen Strandbad unter chronischer Bronchitis, bis er von uns gehen musste.") ;
       delay 2 ;
       Zuechter.say("Geben Sie also immer gut Acht und lassen Sie sich das eine Lektion f]r's n#chste mal sein!") ;
     } else if (cactusMutated) {
       Zuechter.say("Ihr Kleiner entwickelt sich ja pr#chtig!") ;
       delay 2 ;
       Zuechter.say("Sehen Sie sich doch die ausgepr#gten Stacheln an!") ;
       delay 2 ;
       Zuechter.say("Das ist ja wunderbar!") ;
       if (cactusDrowned) { 
         delay 3 ;
	 Zuechter.say("Etwas nass ist er jedoch.") ;
	 Ego.say("Ja, das macht er ab und zu.") ;
	 Zuechter.say("Muss wohl an der Aufregung liegen.") ;
       }
       delay 2 ;
       Ego.say("Da haben Sie Recht.") ;       
       Zuechter.say("Ich hoffe Sie k]mmern sich weiterhin so gut um den Kleinen!") ;
     } else if (cactusDrowned) {
       Zuechter.say("Hallo Oscar!") ;
       Zuechter.say("Na wie geht's dir denn mein Kleiner...") ;
       delay 14 ;
       Zuechter.say("Nanu?") ;
       delay 10 ;
       Zuechter.say("Er ist ja ganz nass!") ;
       delay 2 ;
       Ego.say("Ja, das macht er hin und wieder.") ;
       delay 1 ;
       Zuechter.say("Muss wohl an der Aufregung liegen.") ;       
       delay 2 ;
       Ego.say("Da haben Sie Recht.") ;       
       Zuechter.say("Ich hoffe Sie k]mmern sich weiterhin so gut um den Kleinen!") ;       
     } else {
       Zuechter.say("Hallo Oscar!") ;
       Zuechter.say("Na wie geht's dir denn mein Kleiner...") ;	
       delay 6 ; 
       Zuechter.say("Ganz der Alte!") ;       
       delay 1 ;
       Zuechter.say("Er hat sich kaum weiterentwickelt.") ;
       delay 3 ;
       Ego.say("Wie meinen Sie das?") ;
       delay 2 ;
       Zuechter.say("G[nnen Sie Ihrem kleinen Liebling doch mal was!") ;
       Zuechter.say("Etwas leckeres zu trinken, ein bi}chen W#rme, ein sch[nes Bad oder eine Laserakupunktur zum Beispiel.") ;       
       delay 5 ;
       Zuechter.say("Merken Sie sich das f]r's n#chste mal!") ;
     }
   }
   
   EgoStopUse ;
   takeItem(Ego, Cactus) ;
   
   Ego.say("Ich muss dann mal weiter.") ;
   Zuechter.say("Wie Sie meinen, Herr Wonciek...") ;
   Zuechter.say("Tsch]ss Oscar!") ;	
}


