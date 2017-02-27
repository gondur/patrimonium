// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

 static var showedID = false ;

event enter {
 backgroundImage = Finalebuehne_image ; 
 backgroundZBuffer = Finalebuehne_zbuffer ;
 forceShowInventory ;
 scrollX = 0 ;
 Ego:
  enabled = true ;
  visible = true ;
  reflection = true ; 
  reflectionOffsetY = 185 ; 
  reflectionOffsetX = 0 ;
  reflectionTopColor = RGBA(128,128,255,64) ; 
  reflectionBottomColor = RGBA(128,128,255,64) ; 
  reflectionAngle = 0.0 ; 
  reflectionStretch = 1.0 ;
 
 
 if (previousScene==Finalesaal) {
   setPosition(440,310) ;
   face(DIR_NORTH) ;
   path = Finalebuehne_path ;
   if (!showedID) forceHideInventory ;
   delay transitionTime ;
   if (!showedID) checkID ;
 } else {
   setPosition(483,230) ;
   face(DIR_SOUTH) ;
   path = Finalebuehne_path ;
   delay transitionTime ;
 }
   
   
 takesFingerPrint = false ;
 clearAction ;
}

/* ************************************************************* */

script checkID {
 
 static var first = true ;
  
  delay 10 ;
  Steher:
   "Haben Sie eine Identifikationskarte?"
  knowsIDCard = true ;
  if (!hasItem(Ego, IDCard)) {
    delay 5 ;
    Ego.say("Nein?") ;
    Steher.say("Dann verschwinden Sie mal lieber wieder von hier.") ;
    Steher.say("Zugang nur f]r berechtigte Personen.") ;
    if (first) {
      Ego.say("Aber ich bin...") ;
      Steher.say("Keine Diskussion.") ;      
      Steher.say("Sonst muss ich ungem]tlich werden.") ;      
      Steher.say("Und BITTE tun Sie mir den Gefallen Sie Gr]nschnabel!") ;
      first = false ;
    }
    delay 6 ;
    Ego.walk(440,310) ;
    Ego.turn(DIR_SOUTH) ;
    delay ;
    forceShowInventory ;
    doEnter(FinaleSaal) ;
    finish ;
  } else {
    Ego.say("Ja.") ;	  
    Steher.say("Zeigen Sie her!") ;
    delay 3 ;
    EgoUse ;
    delay 4 ;
    Steher.say("Na gut, Herr Lange.") ;
    Steher.say("Sie d]rfen passieren.") ;
    showedID = true ;
    forceShowInventory ;
  }
}

object Steher { 
 setupAsActor ;
 reflection = true ; 
 reflectionOffsetY = 167 ; 
 reflectionOffsetX = 0 ;
 reflectionTopColor = RGBA(128,128,255,64) ; 
 reflectionBottomColor = RGBA(128,128,255,64) ; 
 reflectionAngle = 0.0 ; 
 reflectionStretch = 1.0 ;

 setupAsStdEventObject(Steher,TalkTo,500,314,DIR_NORTH) ; 
 pathAutoScale = false ;
 path = 0 ;
 setAnim(Steher_sprite) ;
 scale = 800 ;
 setPosition(517,284) ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 captionwidth = 240 ;
 captionX = 5  ;
 captionY = -170 ;
 captionColor = COLOR_STEHER ; 
 setClickArea(-64,-133,60,9) ; 
 autoAnimate = false ;
 name = "grimmiger Typ" ; 
 frame = 0 ;
 autoAnimate = false ;
}

var Si = 0 ;

event animate Steher {
  
  Si++ ;
  switch Steher.animMode {
   case ANIM_TALK: 
	if (Steher.frame == 1) Steher.frame = 0 ;
	if (Steher.frame == 2) Steher.frame = 3 ;
	if ((Si >= 4) and (random(3)==0)) {
	  Si = 0 ;
	  if (Steher.frame<2) Steher.frame = 3 ;
	    else Steher.frame = 0 ;
        }
	if ((Si >= 2) and (random(32)==0)) { 
	  if (Steher.frame<2) Steher.frame = random(2) ;
	    else Steher.frame = random(2)+2 ;		
	}
   default:
	if ((Steher.frame==3) or (Steher.frame==2)) Steher.frame = 0 ;
	if ((Steher.frame==1) or (Steher.frame==5) or (Steher.frame==7)) Steher.frame = Steher.frame-1 ;
        if (Si >= 35+random(15)) and (random(8)==0) {
          Si = 0 ;		
	  if (Steher.frame>1) Steher.frame = 0 ;
	    else Steher.frame = random(2)*2+4 ;
	}
	if ((Si >= 12) and (random(16)==0)) {
	  if (Steher.frame < 2) Steher.frame = random(2) ;
	  if ((Steher.frame > 3) and (Steher.frame < 6)) Steher.frame = random(2)+4 ;
	  if (Steher.frame > 5) Steher.frame = random(2)+6 ;
	}
  }
}

event LookAt -> Steher {
 Ego:
  walkToStdEventObject(Steher) ;
  say("Er erinnert mich an die T]rsteher, die mich nie in die Clubs reinlassen wollten.") ;
}

event Take -> Steher {
 Ego:
  walkToStdEventObject(Steher) ;
  say("Nicht mein Typ.") ;
}

event Use -> Steher {
 triggerObjectOnObjectEvent(Take, Steher) ;
}

event Push -> Steher {
 Ego:
  walkToStdEventObject(Steher) ;
 suspend ;
  say("Ich lege mich besser nicht mit ihm an.") ;
 clearAction ;
}

event Pull -> Steher {
 triggerObjectOnObjectEvent(Push, Steher) ;
}

static var talkedToSteher = false ;

event TalkTo -> Steher { 
 Ego:
  walkToStdEventObject(Steher) ;
 suspend ;
  say("Hi!") ;
  delay 13 ;
  if (talkedToSteher) say("Er ist wohl nicht so sehr der kommunikationsfreudige Typ.") ;
  talkedToSteher = true ;
 clearAction ;
}

event invDrinks -> Steher {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Steher) ;
 suspend ;
 if (used) {
   say("Ich lege mich besser nicht mit ihm an.") ;
 } else {
   say("M[chten Sie ein Getr#nk?") ;
   delay 10 ;
   if (talkedToSteher) say("Er ist wohl nicht so sehr der kommunikationsfreudige Typ.") ;
   talkedToSteher = true ;
 }
 clearAction ;
}

/* ************************************************************* */

object Bedienfeld {
 setupAsStdEventObject(Bedienfeld,WalkTo,450,240,DIR_WEST) ;
 setClickArea(380,115,431,183);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Konsole" ;
}

object BedienfeldGra {
 setPosition(413,60) ;
 setAnim(Tueroffen_sprite) ;
 autoAnimate = false ;
 frame = 0 ;
 clickable = false ;
 visible = true ;
 enabled = false ;
 absolute = false ;
}


script wrongFingerprint {
 suspend ;
 soundBoxStart(Music::Denyfingerprint_wav) ;
 delay 2 ;
 BedienfeldGra.enabled = false ;
 takesFingerPrint = false ;
 delay 2 ;
 Ego.say("Das war wohl nicht der richtige Fingerabdruck.") ;
 clearAction ;
}

var takesFingerPrint = false ;

event Use -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
 if (! takesFingerPrint) {
    say("Ich verwende die Identifikationskarte.") ;
   triggerObjectOnObjectEvent(IDCard, Bedienfeld) ;
   return ;
 } else {
    say("Ich halte meinen Daumen an das Leseger#t.") ;
    EgoUse ;
    wrongFingerprint ;
    clearAction ;
 }
}

event IDCard -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
 if (TuerGra.enabled) {
   say("Die T]r ist schon offen.") ;
   clearAction ;    
   return ;
 } else {
   if (!takesFingerPrint) {
     egoStartUse ;
     soundBoxPlay(Music::Insertcard_wav) ;
     egoStopUse ;
     BedienfeldGra.enabled = true ;
     soundBoxPlay(Music::Acceptcard_wav) ;
     takesFingerPrint = true ;
     needsFingerPrint = true ;
      "Nun wird nach einem Fingerabdruck verlangt."
   } else {
     Ego.say("Es wird nach einem Fingerabdruck verlangt.") ;
   }
 }
 clearAction ;
}

event InvObj -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
 if (!takesFingerPrint) {
   say("Erst muss eine Identifikationskarte eingef]hrt werden.") ;
   clearAction ;
   return ;
 } 
  say("Auf diesem Gegenstand befindet sich vielleicht ein Fingerabdruck von mir.") ;
  EgoUse ;
  wrongFingerprint ;
 clearAction ;
}

event SFormularV -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
 if (!takesFingerPrint) {
   say("Erst muss eine Identifikationskarte eingef]hrt werden.") ;
   clearAction ;
   return ;
 }
  EgoUse ;
  wrongFingerprint ;
  delay 2 ;
  say("Das Formularblatt ist nass und voller verschmierter Seife.") ;
  say("So funktioniert das nicht.") ;
 clearAction ;
}

event SFormularS -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
 if (!takesFingerPrint) {
   say("Erst muss eine Identifikationskarte eingef]hrt werden.") ;
   clearAction ;
   return ;
 } 
  EgoUse ;
  wrongFingerprint ;
  delay 2 ;  
  say("Es befindet sich zwar ein Seifenabdruck auf dem Blatt, aber der ist zu transparent.") ;
  say("Er wird nicht anerkannt.") ;
  
  switch upcounter(3) {
    case 0: "Den Seifenabdruck alleine kann man kaum erkennen."
    case 1: "Ich sollte den Abdruck irgendwie sichtbarer machen."    
    default: "M[glicherweise hilft mir die Bleistiftmine weiter."
  }
  
 clearAction ;
}

event SFormularF -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
 if (!takesFingerPrint) {
   say("Erst muss eine Identifikationskarte eingef]hrt werden.") ;
   clearAction ;
   return ;
 }	
 soundBoxPlay(Music::AcceptFingerprint_wav) ;
 delay 3 ;
 BedienfeldGra.enabled = false ;
 start { Bedienfeld.playSound(Music::Dooropens_wav) ; }
 takesFingerPrint = false ;
 delay 3 ;
 TuerGra.enabled = ! Tuergra.enabled ;	
 clearAction ;
}

event LookAt -> Bedienfeld {
 Ego: 
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
  say("Mit dieser Konsole l#sst sich die T]r [ffnen.") ;
  say("Vorrausgesetzt, man hat die richtige Identifikationskarte und einen dazu registrierten Fingerabdruck.") ;
 clearAction ;
}

event Push -> Bedienfeld {
 triggerObjectOnObjectEvent(Use, Bedienfeld) ;
}

event Pull -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
  EgoStartUse ;
 delay 2 ;
  say("Die Konsole ist fest in der Wand verankert.") ;
 clearAction ;
}

event TalkTo -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
  say("Sesam, [ffne dich?") ;
  delay 13 ;
  say("Nichts.") ;
 clearAction ;
}

event Screwdriver -> Bedienfeld {
 Ego:
  walkToStdEventObject(Bedienfeld) ;
 suspend ;
  say("Mit dem Schraubenzieher komme ich hier nicht weiter.") ;
 clearAction ;
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,WalkTo,483,230,DIR_NORTH) ;
 setClickArea(484,85,568,217);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
} 

event Open -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 if (TuerGra.enabled) {
   Ego.say("Die T]r ist schon offen.") ;
 } else {
   EgoUse ;
   Ego.say("Man kann die T]r nicht manuell [ffnen.") ;
   Ego.say("Sie wird ]ber die Konsole bedient.") ;
 }
 clearAction ;
}

event Use -> Tuer {
 if (TuerGra.enabled) triggerObjectOnObjectEvent(WalkTo, Tuer) ;
  else triggerObjectOnObjectEvent(Open, Tuer) ;
}

event WalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 if (TuerGra.enabled) {
  suspend ;
  doEnter(Finalevorhang) ;
  return ;
 }
 clearAction ;
}

event TalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
  say("Sesam [ffne dich!") ;
  delay 14 ;  
 clearAction ;
}

event Pull -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 EgoUse ;
 delay 3 ;
 Ego.say("Sie bewegt sich kein St]ck") ;
 clearAction ;
}

event Push -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 EgoStartUse ;
 delay 3 ;
 EgoStopUse ;
 if (TuerGra.enabled) TuerGra.enabled = false ;
  else Ego.say("Sie bewegt sich kein St]ck") ;
 clearAction ;
}

object TuerGra {
 setPosition(413,60) ;
 setAnim(Tueroffen_sprite) ;
 autoAnimate = false ;
 frame = 1 ;
 clickable = false ;
 visible = true ;
 enabled = false ;
 absolute = false ;
}

/* ************************************************************* */

object Lampe {
 setupAsStdEventObject(Lampe,LookAt,483,230,DIR_NORTH) ;
 setClickArea(512,63,530,80);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Lampe" ;
}

event LookAt -> Lampe {
 Ego: 
  walkToStdEventObject(Lampe) ;
 suspend ;
  if (TuerGra.enabled) say("Die Lampe leuchtet gr]n.") ;
    else say("Die Lampe leuchtet rot.") ;
 clearAction ;
}

event Push -> Lampe {
 Ego:
  walkToStdEventObject(Lampe) ;
  say("Ich komme nicht ran.") ;
}

event Pull -> Lampe {
 triggerObjectOnObjectEvent(Push, Lampe) ;
}

event Take -> Lampe {
 triggerObjectOnObjectEvent(Push, Lampe) ;
}

event TalkTo -> Lampe {
 Ego: 
  walkToStdEventObject(Lampe) ;
 suspend ;
  say("Hallo?") ;
 delay 15 ;
  say("Darin wohnt sicherlich kein W]nsche-erf]llender Lampengeist.") ;
 clearAction ;
}

/* ************************************************************* */

object Ranking {
 setupAsStdEventObject(Ranking,LookAt,365,298,DIR_WEST) ;
 setClickArea(274,67,371,244);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Ranking-Schild" ;
}

event LookAt -> Ranking {
 Ego:
  walkToStdEventObject(Ranking) ;
 suspend ;
  say("Auf diesem Plakat steht in gro}en Lettern \"Gebots-Ranking\".") ;
  say("Vielleicht wird hinter dieser T]r etwas versteigert?") ;
 clearAction ;
}

event Take -> Ranking {
 Ego: 
  walkToStdEventObject(Ranking) ;
  say("Daf]r habe ich keine Verwendung.") ;
}

event Bleistift -> Ranking {
 Ego:
  walkToStdEventObject(Ranking) ;
 suspend ;
  say("Lieber nicht.") ;
  say("Wer wei} was ich mir da einbrocken w]rde, wenn ich dort meinen Namen hinterlasse...") ;
 clearAction ;
}

event Pull -> Ranking {
 Ego:
  walkToStdEventObject(Ranking) ;
 suspend ;
  say("Ich m[chte es nicht von der Wand rei}en.") ;
  say("Zumindest nicht solange dieser grimmige Typ in der N#he ist.") ;
 clearAction ;
}

event Push -> Ranking {
 Ego:
  walkToStdEventObject(Ranking) ;
 suspend ;
  EgoUse ;
  say("Ich kann kein Geheimfach hinter dem Poster ertasten.") ;
 clearAction ;
}

/* ************************************************************* */

object Back {
 setupAsStdEventObject(Back,WalkTo,440,310,DIR_SOUTH) ;
 setClickArea(0,77,266,360);  
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "zur]ck" ;
}

event LookAt -> Back {
 Ego: 
  walkToStdEventObject(Back) ;
  say("Hier gelangt man zur]ck zum Pr#sentationssaal.") ;
}

event WalkTo -> Back {
 Ego:
  walkToStdEventObject(Back) ;
 suspend ;
 doEnter(Finalesaal) ;
}
