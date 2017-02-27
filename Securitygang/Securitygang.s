// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var firstEscapeComment = 0 ;

event enter {
	
 sawDrStrangeLove = false ;  // Kommentar bei Benutze Laborkittel / Nasenbrille
 
 Ego:
 enableEgoTalk ;
  enabled = true ;
  visible = true ;
  lightmap = Lightmap_image ;
  lightmapAutoFilter = true ;  
 forceShowInventory ;
 if (shortCircuit) backgroundImage = SecuritygangD_image ;
  else backgroundImage = Securitygang_image ;
 backgroundZBuffer = Securitygang_zbuffer ;
  path = Securitygang_path ;
  
 if (chaseStage < 2) {
   if (jukeBox.CurRes != Music::BG_Interloper_mp3) {
     jukeBox_Stop ;
     jukeBox_Enqueue(Music::BG_Interloper_mp3) ;
     jukeBox_Shuffle(true) ;
     jukeBox_Start ;	   
   }
 }
  
 if (chaseStage>2) {  Tuergrafik.enabled = true ;  if (!shortCircuit) start checkPlayerPos2 ; }
  
 if (previousScene == SamtecEmpfang) {
   firstEnterCutscene ;
 } else if (previousScene == Securitylab1) {
  scrollX = 360 ;
  setPosition(826,320) ;
  face(DIR_SOUTH) ;
  
  if ((hasItem(Ego, Ausdruck)) and (chaseStage==2)) endingCutscene ;
  
 } else if (previousScene == Securitylab2) { 
  scrollX = 360 ;	 
  setPosition(944,340) ;
  face(DIR_WEST) ;

  // cutscene: It is dark, Julian has nightvision goggles and passes the agents who are afraid of the dark

  if (shortCircuit) {
   chaseStage = 4 ;
   leaveCutScene ;
  }

 } 
 
 if (chaseStage >= 2) {
   John.enabled = false ;
   Jack:
    enabled = true ;
    visible = true ;
    setPosition(385,245) ;
    face(DIR_SOUTH) ;
    path = Securitygang_path ;
    pathAutoScale = true ;
   if (chaseStage == 2) {
     if (previousScene != Securityhack) start checkPlayerPos ;
     if ((previousScene == Securitylab2) and (not secLab2Locked)) start countDown ;
     if ((previousScene == Securitylab1) and (secLab2Locked)) start countDownLocked ;
     if ((previousScene == Securitylab1) and (not secLab2Locked)) {
       hideInventory ;
       John:
        enabled = true ;
	visible = true ;
        setPosition(855,343) ;
        face(DIR_NORTH) ;
        path = Securitygang_path ;
	lightmap = Lightmap_image ;
	lightmapAutoFilter = true ;
        pathAutoScale = true ;
        scale = 723 ;      
       delay transitionTime ;
       delay 5 ;
       catchSecMusic ;
       John.say("Hab ich Sie!") ; 
       delay 7 ;
       Ego:
        lightmap = null ;
        lightmapAutoFilter = false ;       
       John:
        lightmap = null ;
        lightmapAutoFilter = false ;
       doEnter(Securitygef) ;
     }
   }
   
   if ((previousScene == Securitygef) || (chaseStage==3) || (previousScene==Securityhack)) {
     John:
      enabled = true ;
      visible = true ;
      setPosition(403,253) ;
      face(DIR_NORTH) ;
      path = Securitygang_path ;
      pathAutoScale = true ;
     if (chaseStage == 2) start escapeCheck ;
   }
 }
 
 if (((previousScene==Securitylab1) or (previousScene==Securitylab2)) and (chaseStage==3)) start agentsDialog2 ;
 
 if ((previousScene==Securityhack) || (previousScene==Securitygef)) { // Gefängnis
 
 Ego: 
  setPosition(10,335) ;
  face(DIR_EAST) ;	 
  path = 0 ;
  pathAutoScale = false ;
  scale = 681 ;
 delay transitionTime ;  
 soundBoxStart(Music::Opensecurity_wav) ;
 Tuergrafik.enabled = true ; 
 delay 10 ;
  walk(86,355) ;
  path = Securitygang_path ;
  pathAutoScale = true ;
 delay 10 ;
 soundBoxStart(Music::Geftuerzu_wav) ;
 delay 3 ;

 Tuergrafik.enabled = false ;

 if (firstEscapeComment == 0) {
   delay 5 ;
   Ego:
    turn(DIR_WEST) ;
    delay 5 ;
    turn(DIR_EAST) ;
    firstEscapeComment = 1 ;
 }
 
 if (chaseStage==3) agentsDialog ;
 
} 

 clearAction ;
}

/* ************************************************************* */

// Julian enters security area for the first time

script firstEnterCutscene {
 Ego:
  forceHideInventory ;
   setPosition(384,244) ;
   face(DIR_SOUTH) ;
  delay 30 ;
   walk(384,200) ;
  delay 10 ;
   walk(420,340) ;
   turn(DIR_WEST) ;
  delay 10 ;
   walk(335,340) ;
  delay 10 ;
   turn(DIR_EAST) ;
  delay 10 ;
   walk(775,353) ;
  delay 10 ;
   say("Jetzt wo ich drin bin, lege ich meine Verkleidung wieder ab.") ;
  delay 3 ;
  disableScrolling ;
   walk(300,340) ;
   turn(DIR_SOUTH) ;
  delay 3 ;
  JulianUnDress ;
  delay 45 ;
  enableScrolling ;
  forceShowInventory ;
}

/* ************************************************************* */

// Julian gets locked deeper in the jail

object NiederschlagAni {
 setPosition(687,140) ;
 setAnim(Niederschlag_sprite) ;
 autoAnimate = false ;
 enabled = false ;
 visible = true ;
 frame = 0 ;
}

script endingCutscene {
  forceHideInventory ;
  John.enabled = false ;
  Jack.enabled = false ;
  Ego.enabled = false ;
  NiederschlagAni.enabled = true ;
  MaschineAni.enabled = false ;
  delay transitionTime ;
  delay 5 ;
  NiederschlagAni.frame = 1 ;
  delay 3 ;
  NiederschlagAni.frame = 2 ;
  delay 2 ;
  NiederschlagAni.frame = 3 ;
  delay 2 ;
  NiederschlagAni.frame = 4 ;
  delay 8 ;
  
  start { 
    soundBoxStart(Music::Niederschlag_wav) ;
    Ego.say("Autsch!") ; 
  }
  
  NiederschlagAni.frame = 5 ;
  delay 4 ;
  NiederschlagAni.frame = 6 ;
  delay 4 ;
  NiederschlagAni.frame = 7 ;
  delay 4 ;
  NiederschlagAni.frame = 8 ;
  delay 4 ;
  NiederschlagAni.frame = 9 ;
  delay 69 ;
  chaseStage = 3 ;
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Smokinggun_mp3) ;
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;  
  panelFrequency = random(10)+1 ;
  Ego:
   lightmap = null ;
   lightmapAutoFilter = false ;  
  Jack:
   lightmap = null ;
   lightmapAutoFilter = false ;
  doEnter(Leer) ;
}

/* ************************************************************* */

// Julian enters security area for the first time

script agentsDialog {
  forceHideInventory ;
  Jack.captionWidth = 360 ;
  John.captionWidth = 360 ;
  Jack.captionY = -100 ;
  John.captionY = -100 ;
  Ego.walk(370,344) ;
  Ego.turn(DIR_NORTH) ;

  Jack: "Jetzt haben wir ihn!" 
        "Wei}t du noch, als wir diesen Super-Geheimagenten mit seiner High-Tech-Ausr]stung geschnappt haben?" 
	"Nicht mal der ist von da unten wieder rausgekommen..."
  John:	"Du meinst wohl den Super-Geheimagenten, den ICH geschnappt habe?"
  Jack:	"Was soll das hei}en?!"
  John:	"Wei}t du, was ich einfach nicht verstehe Jack?"
  Jack:	"Was denn?"
  John:	"Warum du die 'Mitarbeiter des Monats Auszeichnung' bekommen hast, und nicht ich..."
  Jack:	"Na ja, immerhin hab ich das Haus von diesem Hobler in die Luft gesprengt."
  John:	"W#hrend wir in der K]che standen!? Ganz prima, wirklich."
  Jack:	"Na und? Au}erdem hab ich ihn in die Grabkammer gesperrt."
  John:	"Und er ist wieder entkommen."
  Jack:	"Und die Pumpen in der Al Azhar Street hab auch ich bedient."
  John:	"Daf]r hast du den Code f]r den Tresor vergessen. Und wie man h[rt, laufen die Pumpen mittlerweile gar nicht mehr."
  John: "Und warte nur, bis ich 'Operation Klappspaten' umgesetzt habe!"
  Jack:	"Egal! Ich bin Mitarbeiter des Monats und damit basta!"
  John:	"Aber das ist unfair! Unfair! UNFAIR!"
  Jack:	"Kein Grund gleich so rumzuschmollen."
  John:	"Grrrmlll..."
  forceShowInventory ;
}


script agentsDialog2 {
  eventGroup = 234878 ;
  Jack.captionWidth = 360 ;
  John.captionWidth = 360 ;
  Jack.captionY = -100 ;
  John.captionY = -100 ;
  delay 30 ;
  Jack:	"Bist du immer noch b[se wegen der 'Mitarbeiter des Monats'-Auszeichnung?"
  John:	"Ja! Das ist unfair! Unfair! UNFAIR!"
  Jack:	"Aber das ist doch kein Grund gleich so rumzuschmollen."
  John:	"Grrrmlll..."
}

/* ************************************************************* */

object Agentenzitternd {
 setPosition(356,269) ;
 setAnim(Agentenzitternd_sprite) ;
 absolute = false ;
 enabled = false ;
 visible = true ;
 clickable = false ;
 stopAnimDelay = 4 ;
}

/* ************************************************************* */

script leaveCutScene {
 forceHideInventory ;
 MaschineAni.enabled = false ;
 
 jukeBox_Stop ;
 jukeBox_Shuffle(false) ;
 jukeBox_Enqueue(Music::BG_Mystic_mp3) ;   
 jukeBox_Start ;
 delay 2 ;
 
 Agentenzitternd.enabled = true ;
 Jack:
  enabled = true ;
  visible = true ;
  setPosition(385,245) ;
  face(DIR_SOUTH) ;
  path = Securitygang_path ;
  pathAutoScale = true ;
  visible = false ;
 John:
  enabled = true ;
  visible = true ;
  setPosition(403,253) ;
  face(DIR_NORTH) ;
  path = Securitygang_path ;
  pathAutoScale = true ;
  visible = false ;
 delay 20 ;
 Ego:
  walk(457,352) ;
  turn(DIR_NORTH) ;
 delay 10 ;
 Jack.say("Tu doch was, John!") ;
 delay 3 ;
 John.say("Warum ich??? Du bist Mitarbeiter des Monats!") ;
 delay 3 ;
 John.say("Aber ich kann nichts sehen!") ;
 delay 3 ;
 Jack.say("Ich auch nicht!") ;
 delay 1 ;
 John.captionY = -140 ;
 start { John.say("Ich ha... ha... hab Aaangst!") ; }
 Jack.say("Ich ha... ha... hab Aaangst!") ;
 delay 20 ;
 Ego:
  say("Das habt ihr davon, wenn ihr euch mit JULIAN HOBLER anlegt!") ;
 delay 10 ;
  say("Der, der nie im Dunklen tappt!") ;
 delay 10 ;
 John.say("Wer hat das gesagt?!") ;
 delay 4 ; 
  walk(434,278);
 turn(DIR_WEST) ;
 delay 5 ;
 EgoUse ;
 Jack.say("HILFE!") ;
 Jack.say("ETWAS HAT MICH BER{HRT!") ;
 delay 10 ;
  walk(384,244) ;
  turn(DIR_NORTH) ;
 delay 10 ;
 Ego:
  lightmap = null ;
  lightmapAutoFilter = false ; 
 doEnter(Hotelgang) ; 
}

/* ************************************************************* */

script escapeCheck {
  while (true) {
   delay ;
   if (Ego.positionX > 346) {
     hideInventory ;
     interruptCaptions ;
     suspend ;
     delay 5 ;
     start { 
       if (firstEscapeComment == 1) { 
         Jack.say("Da ist er!") ; 
	 Jack.captionWidth = 200 ;
	 Jack.say("Er ist ausgebrochen!") ;
	 Jack.captionWidth = 0 ;
	 firstEscapeComment = 2 ;
       } else {
	 switch(random(3)) {
	   case 0: Jack.say("Da ist er schon wieder!") ;
	   case 1: Jack.say("Da ist er wieder!") ;
	   default: Jack.say("Ich sehe ihn schon wieder!") ;
	 }
       }
     }     
     start {
       jukeBox_Stop ;
       jukeBox_Shuffle(true) ;

       jukeBox_Enqueue(Music::BG_Rounddrums_mp3) ;       
       jukeBox_Shuffle(true) ;
       jukeBox_Start ;	     
     }
     Ego.walk(436,344) ;
     delay 2 ;
     start { Ego.turn(DIR_NORTH) ; }
     John.turn(DIR_SOUTH) ;
     start { delay 18 ; John.walk(436,344) ; delay 4 ; turn(DIR_EAST) ; delay 4 ; walk(824,320) ; }
     Ego.walk(824,320) ;
     Ego.turn(DIR_NORTH) ; 
     if (chaseStage == 2) killEvents(123655) ; 
     Ego:
      lightmap = null ;
      lightmapAutoFilter = false ;	     
     doEnter(Securitylab1) ;     
     finish ;
   }
  }
}

/* ************************************************************* */

script checkPlayerPos {
  while (true) {
    if (Ego.positionX < 600) {
      hideInventory ;
      killEvents(123655) ;
      suspend ;
      Ego.stop ;
      Jack.walk(510,330) ;
      Jack.turn(DIR_EAST) ;
      catchSecMusic ;

      Jack.say("Hab ich Sie!") ;
      delay 7 ;
      Ego:
       lightmap = null ;
       lightmapAutoFilter = false ;
      doEnter(Securitygef) ;      
      finish  ;
    }	
    delay ;
 }
}

/* ************************************************************* */

script countDownLocked {
  eventGroup = 123655 ;	
  John:
   enabled = true ;
   visible = false ;
   path = 0 ;
   setPosition(900,343) ;
  delay 44 ;
  start {
   soundBoxPlay(Music::doorknock_wav) ;	
  }
  delay 2 ;
  John.say("*KLOPF*") ;
  delay 7 ;
  start {   
   soundBoxPlay(Music::doorknock_wav) ;	
  }
  delay 2 ;
  John.say("*KLOPF* *KLOPF*") ;
  delay 10 ;
  John.say("|ffnen Sie die T]r Herr Hobler!") ;
  delay 215 ;
  delay (upcounter(5) * 15) ; // PUJA
  suspend ;
  InterruptCaptions ;
  hideInventory ;
  delay 5 ;
  John:
   setPosition(826,320) ;
   face(DIR_SOUTH) ;
   visible = true ;
   enabled = true ;
   lightmap = Lightmap_image ;
   lightmapAutoFilter = true ;   
   path = Securitygang_path ;
   pathAutoScale = true ;
   scale = 603 ;
  delay 10 ;
  catchSecMusic ;
  John.say("Hab ich Sie!") ;
  delay 7 ;
  Ego:
   lightmap = null ;
   lightmapAutoFilter = false ;  
  John:
   lightmap = 0 ;
   lightmapAutoFilter = false ;  
  doEnter(Securitygef) ;
  finish ;
}

/* ************************************************************* */

script countDown {
  eventGroup = 123655 ;
  delay(transitionTime) ;
  
  delay 120 ;
  delay (upcounter(5) * 15) ; // PUJA
  
  suspend ;
  Ego.stop ;
  InterruptCaptions ;
  hideInventory ;
  John:
   setPosition(944,340) ;
   face(DIR_WEST) ;	 
   path = Securitygang_path ;
   lightmap = Lightmap_image ;
   lightmapAutoFilter = true ;
   pathAutoScale = true ;
   scale = 707 ;
   enabled = true ;
   delay 5 ;
   Ego.turn(Ego.findDirection(John.positionX, John.positionY)) ;
   delay 4 ;
   catchSecMusic ;
   
   John.say("Hab ich Sie!") ;
   delay 7 ;
   Ego:
    lightmap = null ;
    lightmapAutoFilter = false ;   
   John:
    lightmap = 0 ;
    lightmapAutoFilter = false ;   
   doEnter(Securitygef) ;
   finish ;
}

/* ************************************************************* */

script checkPlayerPos2 {
  while (true) {
    if (Ego.positionY < 311) {
      suspend ;
      killEvents(234878) ;
      Jack.caption = "" ;
      John.caption = "" ;
      Ego.stop ;
      Ego.turn(DIR_NORTH) ;
      delay 5 ;
      Jack.say("Da ist er wieder!") ;
      John.turn(DIR_SOUTH) ;
      delay 10 ;
      switch random(3) {
       case 0: John.say("Soll er doch kommen.") ;
       case 1: John.say("Lass ihn doch kommen.") ;
       case 2: John.say("Er muss hier vorbei.") ;
      }
      delay 3 ;
      switch random(3) {
       case 0: John.say("Dann machen wir ihn platt!") ;
       case 1: John.say("Dann wird er sein blaues Wunder erleben!") ;
       case 2: John.say("Dann machen wir ihn fertig!") ;
      }
      delay 7 ;
      Ego.walk(430,337) ;
      Ego.turn(DIR_SOUTH) ;
      delay 4 ;
      Ego.say("So einfach komme ich an diesen beiden Schr#nken nicht vorbei.") ;
      resume ;
      start checkPlayerPos2 ;
    }	
    delay ;
 }
}

/* ************************************************************* */

object Faxg {
 setupAsStdEventObject(Faxg,LookAt,530,320,DIR_EAST) ; 	
 setPosition(549,233) ;
 setClickArea(0,0,60,35) ;
 setAnim(Fax_image) ;
 absolute = false ;
 clickable = true ;
 visible = true ;
 enabled = not Faxg.getField(0) ;
 name = "Faxger#t" ; 
}

event LookAt -> Faxg {
 Ego:
  walkToStdEventObject(Faxg) ;
 suspend ;
  say("Sieht mir nach einem #lteren Faxger#t aus.") ;
 clearAction ;
}

event Use -> Faxg {
 Ego:
  walkToStdEventObject(Faxg) ;
 suspend ;
  say("Man kann es nicht so ohne weiteres verwenden.") ;
 clearAction ;
}

event Open -> Faxg {
 Ego:
  walkToStdEventObject(Faxg) ;
 suspend ;
  say("Das geht nicht ohne passendes Werkzeug.") ;
 clearAction ;
}

event Screwdriver -> Faxg {
 Ego:
  walkToStdEventObject(Faxg) ;
 suspend ;
  say("Ich denke nicht, dass mir das weiterhilft.") ;
 clearAction ;
}

event Pull -> Faxg {
 Ego:
  walkToStdEventObject(Faxg) ;
 suspend ;
  say("Nicht, dass es noch herunterf#llt und kaputt geht.") ;
 clearAction ;
}

event Take -> Faxg {
 Ego:
  walkToStdEventObject(Faxg) ;
 suspend ;
 egoStartUse ;
 takeItem(Ego, Fax) ;
 Faxg.setField(0, true) ;
 Faxg.enabled = false ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Empfangtuer {
 setupAsStdEventObject(Empfangtuer,Open,384,244,DIR_NORTH) ; 	
 setClickArea(372,201,397,240);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Sicherheitst]r" ;
}

event Open -> Empfangtuer {
 walkToStdEventObject(Empfangtuer) ;	
  turn(DIR_NORTH) ;
 suspend ;
 Ego:
  "Ich sollte mich erstmal in dem Zentralrechner nach weiteren Hinweisen umsehen."
 clearAction ;
}

event Use -> Empfangtuer {
 triggerObjectOnObjectEvent(Open, Empfangtuer) ;
}

event LookAt -> Empfangtuer {
 Ego:
  walkToStdEventObject(Empfangtuer) ;	
 suspend ; 
  say("Diese T]r f]hrt wieder raus, in dem Empfangsraum.") ;
 clearAction ;
}

event Close -> Empfangtuer {
 Ego:
  walkToStdEventObject(Empfangtuer) ;	
 suspend ; 
  say("Die T]r ist bereits geschlossen.") ;
 clearAction ;
}

event Pull -> Empfangtuer {
 Ego:
  walkToStdEventObject(Empfangtuer) ;	
 suspend ; 
  say("Ich finde keine Angriffsfl#che.") ;
 clearAction ;
}

event Push -> Empfangtuer {
 Ego:
  walkToStdEventObject(Empfangtuer) ;	
 suspend ; 
 delay 2 ;
 EgoUse ;
 delay 3 ;
  say("Sie bewegt sich nicht.") ;
 clearAction ;
}


/* ************************************************************* */
/*
object Buch {
 setPosition(880,300) ;
 setupAsStdEventObject(Buch,LookAt,930,335,DIR_WEST) ; 	
 setAnim(Buch_image) ;
 setClickArea(0,0,25,20) ; 
 visible = true ;
 enabled = !hasitem(Ego, Raetselbuch) ;
 clickable = true ;
 absolute = false ;
 name = "Buch" ;
}

event LookAt -> Buch {
 Ego:
  walkToStdEventObject(Buch) ;
 suspend ;
  say("Hier liegt ein Buch mit blauem Einband auf dem Boden.") ;
 clearAction ;
}

event Take -> Buch {
 Ego:
  walkToStdEventObject(Buch) ;
 suspend ;
 EgoStartUse ;
  takeItem(Ego, Raetselbuch) ;
 Buch.enabled = false ;
 EgoStopUse ;
 triggerObjectOnObjectEvent(LookAt, Raetselbuch) ;
 clearAction ;
}
*/
/* ************************************************************* */

object Gefaengnistuer {
 setupAsStdEventObject(Gefaengnistuer,Open,100,328,DIR_WEST) ; 	
 setClickArea(25,135,96,306) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Sicherheitst]r" ;
}

event Lab2key -> Gefaengnistuer {
 Ego:
  walkToStdEventObject(Gefaengnistuer) ;
 suspend ;
  say("Diese T]r hat kein Schloss wo dieser Schl]ssel passen k[nnte.") ;
}

event freqDevice -> Gefaengnistuer {
 Ego:
 if (did(give)) {
   walkToStdEventObject(Gefaengnistuer) ;
   suspend ;
    say("Die T]r will das Ding nicht haben.") ;
   clearAction ;
   return ;	 
 }
 walkToStdEventObject(Gefaengnistuer) ;
  say("Ich will da nicht wieder rein.") ;
}

object Tuergrafik {
 if (!shortCircuit) setAnim(tueroffen_image) ;
  else setAnim(TuerOffenD_image) ;
 setPosition(6,129) ;
 visible = true ;
 enabled = false ;
 clickable = false ;
 absolute = false ;
}

event LookAt -> Gefaengnistuer {
 Ego:
  walkToStdEventObject(Gefaengnistuer) ;
 suspend ;
  "Den Schildern zu Folge kann man sie wohl nur in einer Richtung durchschreiten." 
  "Man k[nnte sagen: eine Einbahnstra}ent]r."
 clearAction ;
}

event Use -> Gefaengnistuer {
 if (Tuergrafik.enabled) triggerObjectOnObjectEvent(Close, Gefaengnistuer) ;
   else triggerObjectOnObjectEvent(Open, Gefaengnistuer) ;
}

event Open -> Gefaengnistuer {
 Ego:
  walkToStdEventObject(Gefaengnistuer) ;
  "Ich kann die T]r von hier nicht [ffnen." 
  "Au}erdem bin ich mir gar nicht so sicher, ob ich da ]berhaupt rein will..."
}

event Close -> Gefaengnistuer {
 Ego:
  walkToStdEventObject(Gefaengnistuer) ;
 suspend ;
 if (!Tuergrafik.enabled) say("Sie ist schon zu.") ;
  else say("Ich w]sste nicht, wie ich sie schlie}en kann.") ;
 clearAction ;
}

event Push -> Gefaengnistuer {
 Ego:
  walkToStdEventObject(Gefaengnistuer) ;
 suspend ;
 if (!Tuergrafik.enabled) {
   EgoUse ;
   say("Sie bewegt sich keinen Millimeter.") ;
 } else say("Nicht, solange sie offen ist.") ;
 clearAction ;
}

event WalkTo -> Gefaengnistuer {
 Ego:
  walkToStdEventObject(Gefaengnistuer) ;
  if (Tuergrafik.enabled) {
    suspend ;
    Ego:
     lightmap = null ;
     lightmapAutoFilter = false ;    
    doEnter(Securitygef) ;
  }
}

/* ************************************************************* */

object Kamera {
 setupAsStdEventObject(Kamera,LookAt,140,329,DIR_NORTH) ; 
 setClickArea(141,86,166,119) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kamera" ;
}

event LookAt -> Kamera {
 Ego:
  walkToStdEventObject(Kamera) ;
 suspend ;
 delay 3 ;
  say("Vielleicht war es doch keine gute Idee, meine Verkleidung wieder abzulegen...") ;
 clearAction ;
}

event TalkTo -> Kamera {
 Ego:
  walkToStdEventObject(Kamera) ;
 suspend ;
 delay 3 ;
  say("Hallo?") ;
 clearAction ;
}

event default -> Kamera {
 Ego:
  walkToStdEventObject(Kamera) ;
  say("Ich komme nicht hin.") ;	
}

object KameraGra {
 setPosition(148,100) ;
 setAnim(KameraBlink_sprite) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = false ;
 stopAnimDelay = 12 ;
}

/* ************************************************************* */

object Knopf {
 setupAsStdEventObject(Knopf,Push,755,352,DIR_NORTH) ; 		
 setClickArea(762,250,774,264) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Knopf" ;
}

event LookAt -> Knopf {
 Ego:	
  walkToStdEventObject(Knopf) ;
  "Ein kleiner roter Knopf."
}

event Use -> Knopf {
 triggerObjectOnObjectEvent(Push, Knopf) ;
}

event Push -> Knopf {
 walkToStdEventObject(Knopf) ;
 suspend ;
 EgoStartUse ;
 delay 2 ;
 flipMaschine ;
 EgoStopUse ;
 clearAction ;
}

object Maschine {
 setupAsStdEventObject(Maschine,LookAt,755,352,DIR_NORTH) ; 	
 setClickArea(675,203,773,339) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Maschine" ;
}

event Hammer -> Maschine {
 Ego:	
  walkToStdEventObject(Maschine) ;
 suspend ;
  say("Lieber nicht.") ;	  
 clearAction ;
}

event LookAt -> Maschine {
 Ego:	
  walkToStdEventObject(Maschine) ;
 suspend ;
  say("Vermutlich ein Heizkessel, der an ein Rohrsystem angeschlossen ist.") ;
  say("Auf seiner Front befindet sich ein kleiner roter Knopf.") ;
  if (animateMaschine) say("Etwas weiter unter dem Knopf blinken drei LEDs.") ;
 clearAction ;
}

event Use -> Maschine {
 Ego:	
  walkToStdEventObject(Maschine) ;
  say("Ich sollte es mit dem Knopf versuchen.") ;	
}

event Push -> Maschine {
 triggerObjectOnObjectEvent(Pull, Maschine) ;
}

event Pull -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
 suspend ;
 EgoUse ;
  say("Die Maschine bewegt sich kein St]ck.") ;
 clearAction ;
}

event Open -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
 suspend ;
 delay 5 ; 
  say("Es sieht nicht danach aus, dass man diese Maschine [ffnen k[nnte.") ;
 clearAction ;		
}

event TalkTo -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
 suspend ;
  say("Hallo?") ;
 delay 5 ;
 clearAction ;	
}

event Take -> Maschine {
 Ego:
  walkToStdEventObject(Maschine) ;
  say("Ich k[nnte sie nicht einmal anheben.") ;
}

script animateMaschine {
 return !Maschine.getField(0) ;
}

script flipMaschine {
 Maschine.setField(0, !Maschine.getField(0)) ;
 MaschineAni.enabled = animateMaschine ;
 if (animateMaschine) soundBoxStart(Music::Maschinean_wav) ;
  else soundBoxStart(Music::Maschineaus_wav) ;
}

object MaschineAni {
 setPosition(742,283) ;
 setAnim(Maschine_sprite) ;
 clickable = false ;
 enabled = animateMaschine ;
 visible = true ;
 absolute = false ;
 stopAnimDelay = 5 ;
}

/* ************************************************************* */

object Lab1tuer {
 setupAsStdEventObject(Lab1tuer,Open,824,320,DIR_NORTH) ; 	
 setClickArea(794,188,840,305) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event LookAt -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
  "Eine geschlossene T]r mit Knauf."
  "Links davon steht 'Labor 1' an der Wand."
}

event Open -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
 suspend ;
 if (chaseStage == 2) killEvents(123655) ; 
 // Cutscene
 if (lastScene == SamtecEmpfang) {
   nextScene = Securitylab1 ;
   Ego:
    lightmap = null ;
    lightmapAutoFilter = false ;   
   doEnter(Leer) ;
   return   ;
 }	 
  lightmap = null ;
  lightmapAutoFilter = false ;
 doEnter(Securitylab1) ;
}

event Lab2Key -> Lab1tuer {
 Ego:
  walkToStdEventObject(Lab1tuer) ;
 suspend ;
 EgoUse ;
 Ego.say("Der Schl]ssel passt hier nicht.") ;
 clearAction ;
}

event Hotelkey -> Lab1Tuer {
 triggerObjectOnObjectEvent(Lab2key, Lab1tuer) ;
}


event Use -> Lab1tuer {
 triggerObjectOnObjectEvent(Open, Lab1tuer) ;
}

/* ************************************************************* */

object Lab2tuer {
 setupAsStdEventObject(Lab2tuer,Open,930,335,DIR_EAST) ; 	
 setClickArea(927,187,991,329) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event LookAt -> Lab2tuer {
 Ego:
  walkToStdEventObject(Lab2tuer) ;
  "Eine geschlossene T]r mit Knauf."
  "Links davon steht 'Labor 2' an der Wand."
}

event Open -> Lab2tuer {
 Ego:
  walkToStdEventObject(Lab2tuer) ;
 if (secLab2Locked) {
  say("Die T]r ist abgeschlossen.") ;
  return ;
 }
  suspend ;
  delay 2 ;
 // Cutscene
 if (lastScene == SamtecEmpfang) {
   nextScene = Securitylab2 ;
   Ego:
    lightmap = null ;
    lightmapAutoFilter = false ;   
   doEnter(Leer) ;
   return ;
 }
 Ego:
  lightmap = null ;
  lightmapAutoFilter = false ;
 doEnter(Securitylab2) ;
}

event Use -> Lab2tuer {
 triggerObjectOnObjectEvent(Open, Lab2tuer) ;
}

event Hotelkey -> Lab2Tuer {
 Ego:
  walkToStdEventObject(lab2Tuer) ;
 suspend ;
 EgoUse ;
  say("Der Schl]ssel passt hier nicht.") ;
 clearAction ;
}

event Lab2Key -> Lab2Tuer {
 Ego:
  walkToStdEventObjectNoResume(lab2Tuer) ;
 if (chaseStage>2) {
  suspend ;
  Ego.say("Wozu?") ;
  delay 3 ;
  Ego.say("Ich werde doch nicht mehr verfolgt.") ;
  clearAction ;
 }
 if (did(give)) {
   Ego.say("Sie nimmt ihn nicht.") ;	 
 } else {   
   suspend ;
   turn(DIR_EAST) ;
   if (secLab2Locked) {
     Ego.say("Die T]r ist schon abgeschlossen.") ;
   } else {
     killEvents(123655) ;
     EgoStartUse ;
     soundBoxStart(Music::Lab2lock_wav) ;
     EgoStopUse ;
     secLab2Locked = true ;
     start countDownLocked ;
   }	 
 }
 clearAction ;
}

/* ************************************************************* */

object Kiste {
 setupAsStdEventObject(Kiste,LookAt,290,330,DIR_NORTH) ; 	
 setClickArea(267,237,326,291);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kiste" ;
}

object KisteGra {
 setPosition(265,235) ;
 setAnim(Kisteoffen_image) ;
 absolute = false ;
 clickable = false ;
 enabled = false ;
 visible = true ;
}

event LookAt -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Eine Kiste aus Karton.") ;
  say("Vorne drauf steht 'K[nnte ungesund sein.'.") ;
 clearAction ;  
}

event Pull -> Kiste {
 triggerObjectOnObjectEvent(Push, Kiste) ;
}

event Push -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Ich HASSE es, Kisten zu verschieben.") ;
 clearAction ;	
}

event Take -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Ich m[chte keine R]ckenprobleme.") ;
 clearAction ;		
}

event TalkTo -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Hallo, ungesunde Kiste!") ;
 delay 10 ;
 clearAction ;	
}

event Zitrone -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
  say("Die Zitrone ist bei mir soweit ganz gut aufgehoben.") ;
 clearAction ;
}

event Open -> Kiste {
 Ego:
  walkToStdEventObject(Kiste) ;
 suspend ;
 if (not Kiste.getField(0)) {
   Ego:
   EgoStartUse ;
   soundBoxStart(Music::Karton_wav) ;
   KisteGra.enabled = true ;
   EgoStopUse ;
    "In der Kiste ist genmutiertes Riesenobst!"
   delay 2 ;
    "Bananen, Datteln und Zitronen."
   delay 2 ;    
   knowsCitron = true ;
   delay 2 ;
   static var expComment = false ;
   if (!expComment) {
      say("Vielleicht sind das {berreste aus irgendwelchen zwielichtigen Experimenten...") ;
      say("Oder eine weitere Auswirkung des verseuchten Nilwassers.") ;
     expComment = true ;
   }
   if (needsCitron) {
     delay 3 ;
     Ego.say("Eine Zitrone nehme ich mit.") ;
     egoStartUse ;
     Kiste.setField(0, true) ;    
     takeItem(Ego, Zitrone) ;
     EgoStopUse ;
     needsCitron = false ;
   }
   EgoStartUse ;
   KisteGra.enabled = false ;
   EgoStopUse ;
 } else {
   Ego:
    "In der Kiste ist genmutiertes Riesenobst!"
    "Wahrscheinlich eine weitere Auswirkung des verseuchten Nilwassers."
    delay 2 ;
    "Daraus hatte ich vorher eine Zitrone genommen."
 }
 clearAction ;
}

/* ************************************************************* */

object Warnschild {
 setupAsStdEventObject(Warnschild,LookAt,330,340,DIR_WEST) ; 	
 setClickArea(203,48,274,111);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Warnschild" ;
}

event LookAt -> Warnschild {
 Ego:
  walkToStdEventObject(Warnschild) ;
 suspend ;
 delay 5 ;
  say("Da oben steht 'Vorsicht - Gefahr geradeaus'.") ;  
 clearAction ;
}

event default -> Warnschild {
 Ego:
  walkToStdEventObject(Warnschild) ;
 suspend ;
 delay 5 ;
  say("Ich komme nicht ran.") ;
 clearAction ;
}
	

/* ************************************************************* */

object Anacon {
 setupAsStdEventObject(Anacon,LookAt,864,320,DIR_NORTH) ;
 setClickArea(850,251,894,276) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kiste mit Schriftzug" ; 
}

event LookAt -> Anacon {
 Ego:
  walkToStdEventObject(Anacon) ;
 suspend ;
  say("Eine kleine Kiste aus Karton.") ;
  say("Auf ihr ist 'anacon.com' gedruckt.") ;
 clearAction ;
}

event Open -> Anacon {
 Ego:
  walkToStdEventObject(Anacon) ;
 suspend ;
 delay 3 ;
 if (hasItem(Ego, Raetselbuch)) {
   EgoUse ;
   delay 5 ;
    say("Sie ist leer.") ;
 } else {
   EgoStartUse ;
   soundBoxStart(Music::Karton_wav) ;
   takeItem(Ego, Raetselbuch) ;
   EgoStopUse ;
   say("Darin befand sich ein Buch mit blauem Einband.") ;
   triggerObjectOnObjectEvent(LookAt, Raetselbuch) ;
 }
 clearAction ;
}

event Close -> Anacon {
 Ego:
  walkToStdEventObject(Anacon) ;
 suspend ;
  say("Sie ist schon zu.") ;
 clearAction ;
}

event Pull -> Anacon {
 triggerObjectOnObjectEvent(Push, Anacon) ;
}

event Push -> Anacon {
 Ego:
  walkToStdEventObject(Anacon) ;
 suspend ;
  say("Ich HASSE es, Kisten zu verschieben.") ;
 clearAction ;
}

event Take -> Anacon {
 Ego:
  walkToStdEventObject(Anacon) ;
 suspend ;
  say("Ich will sie nicht.") ;
 clearAction ;
}

/* ************************************************************* */

object Kisten {
 setupAsStdEventObject(Kisten,LookAt,864,320,DIR_NORTH) ; 	
 setClickArea(850,276,894,310);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kiste" ;
}

event LookAt -> Kisten {
 Ego:
  walkToStdEventObject(Kisten) ;
 suspend ;
  say("In dieser Ecke steht eine Kiste aus Karton.") ;
  say("Eine rote aufgedruckte Flamme warnt vor brennbarem Inhalt.") ;
 clearAction ;
}

event Open -> Kisten {
 Ego:
  walkToStdEventObject(Kisten) ;
 suspend ;
 delay 3 ;
 EgoUse ;
 delay 5 ;
  say("Sie ist leer.") ;
  say("Schade.") ;
 clearAction ;
}

event Close -> Kisten {
 Ego:
  walkToStdEventObject(Kisten) ;
 suspend ;
  say("Sie ist schon zu.") ;
 clearAction ;
}

event Pull -> Kisten {
 triggerObjectOnObjectEvent(Push, Kisten) ;
}

event Push -> Kisten {
 Ego:
  walkToStdEventObject(Kisten) ;
 suspend ;
  say("Ich HASSE es, Kisten zu verschieben.") ;
 clearAction ;
}

event Take -> Kisten {
 Ego:
  walkToStdEventObject(Kisten) ;
 suspend ;
  say("Ich will sie nicht.") ;
 clearAction ;
}


/* ************************************************************* */

object Regal {
 setupAsStdEventObject(Regal,LookAt,530,320,DIR_EAST) ; 
 setClickArea(540,128,619,326);
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
  say("Zwei Bretter sind an Halterungen befestigt.") ;
  say("Ein weiteres Brett lehnt daneben an der Wand") ;
 if (Faxg.enabled) say("Auf dem unteren Brett befindet sich ein Faxger#t.") ;
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

/* ************************************************************* */

object Rotboden {
 setupAsStdEventObject(Rotboden,LookAt,350,334,DIR_WEST) ; 	
 setClickArea(322,296,337,361) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "rote Bodenmarkierung" ;
}

event LookAt -> Rotboden {
 clearAction ;
 Ego:
  walkToStdEventObject(Rotboden) ;
  say("Hier gibt's kein Zur]ck.") ;
}

/* ************************************************************* */

object Gruenboden {
 setupAsStdEventObject(Gruenboden,LookAt,664,354,DIR_EAST) ; 	
 setClickArea(667,336,741,359) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "gr]ne Bodenmarkierung" ;
}

event LookAt -> Gruenboden {
 clearAction ;
 Ego:
  walkToStdEventObject(Gruenboden) ;
  say("Hier geht's zu den Laboren.") ;
}

/* ************************************************************* */

object Totenkopf {
 setupAsStdEventObject(Totenkopf,LookAt,238,328,DIR_NORTH) ; 		
 setClickArea(190,145,314,235) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Totenkopf" ;
}

event LookAt -> Totenkopf {
 Ego:
  walkToStdEventObject(Totenkopf) ;
 suspend ;
  say("Das grimmige Gesicht des Todes.") ;
  delay 2 ;
  say("Das erinnert mich an einem Traum:") ;
  say("Im Jenseits ist der Tod ein Beruf und es herrscht rege Konkurrenz, die neuen toten Seelen in das Reich der ewigen Ruhe zu begleiten...") ; 
  delay 3 ;
  say("Hmmm, vielleicht sollte ich das besser einem Psychologen erz#hlen.") ;
 clearAction ;
}

/* ************************************************************* */

object Gefahrschild {
 setupAsStdEventObject(Gefahrschild,LookAt,211,326,DIR_WEST) ; 		
 setClickArea(109,222,166,279) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event LookAt -> Gefahrschild {
 Ego:
  walkToStdEventObject(Gefahrschild) ;
  say("Vorsicht!") ;
}

event Take -> Gefahrschild {
 Ego:
  walkToStdEventObject(Gefahrschild) ;
  say("Ich brauche es nicht.") ;
}

/* ************************************************************* */

object Keepschild {
 setupAsStdEventObject(Keepschild,LookAt,211,326,DIR_WEST) ; 		
 setClickArea(20,86,100,121) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event LookAt -> Keepschild {
 Ego:
  walkToStdEventObject(Keepschild) ;
  say("Dem Schild nach sollte man hier besser drau}en bleiben.") ;
}


event Pull -> KeepSchild {
 triggerObjectOnObjectEvent(Take, Keepschild) ;
}

event Take -> Keepschild {
 Ego:
  walkToStdEventObject(Keepschild) ;
  say("Ich komme nicht ran.") ;
}
