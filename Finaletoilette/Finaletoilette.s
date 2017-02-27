// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var WaschModVar = false ;

event enter {
 if (needsFingerPrint) WaschModVar = !WaschModVar ;
 if (WaschModVar) {
   Trinker.enabled = false ;
   TrinkerWasch.enabled = true ;
   Wasser.enabled = true ;
   SeifeH.enabled = false ;
 } else {
   Trinker.enabled = true ;
   TrinkerWasch.enabled = false ;
   Wasser.enabled = false ;
   SeifeH.enabled = true ;	 
 }
 if (!trinkerAtToilet) {
   Trinker.enabled = false ;
   TrinkerWasch.enabled = false ;
   Wasser.enabled = false ;
   SeifeH.enabled = true ;
 }
 backgroundImage = Finaletoilette_image ; 
 backgroundZBuffer = Finaletoilette_zbuffer ; 
 scrollX = 0 ;
 forceShowInventory ;
 Ego:
  if (TrinkerWasch.enabled) { path = FinaletoiletteW_path ; start waschSound ; }
    else path = Finaletoilette_path ;
  setPosition(202,232) ;
  face(DIR_SOUTH) ;
  reflection = true ; 
  reflectionOffsetY = 200 ; 
  reflectionOffsetX = -170 ;
  reflectionTopColor = RGBA(128,128,255,64) ; 
  reflectionBottomColor = RGBA(128,128,255,64) ; 
  reflectionAngle = FLOAT_PI ; 
  reflectionStretch = 1.0 ;
 
 delay transitionTime ; 
 clearAction ;
 
}

/* ************************************************************* */

script waschSound {
 killOnExit = true ;
 
 loop {
  return if (!TrinkerWasch.enabled) ;
  TrinkerWasch.playSound(Music::Washhands_wav) ;
  delay ;
 }
}

/* ************************************************************* */

object SeifeH {
 setupAsStdEventObject(SeifeH,LookAt,150,286,DIR_WEST) ;
 setAnim(Seife_image) ;
 setPosition(56,187) ;
 setClickArea(0,0,20,14) ;
 clickable = true ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 name = "Seife" ;
 priority = 15 ;
 
}

static var spottedFingerprint = false ;

event LookAt -> SeifeH {
 
 Ego: 
  walkToStdEventObject(SeifeH) ;
  suspend ;	
  "Ein St]ck Seife."
  if (needsFingerPrint) {
    say("Es ist ein Fingerabdruck darauf zu sehen!") ;
    spottedFingerprint = true ;
  }
 clearAction ;
}

event Use -> SeifeH {
 Ego: 
  walkToStdEventObject(SeifeH) ;
 suspend ;
 say("Ich habe mir vorher schon die H#nde gewaschen.") ;
 clearAction ;	
}

event Take -> SeifeH {
 Ego: 
  walkToStdEventObject(SeifeH) ;
 suspend ;
 if (needsFingerPrint) {
   if (spottedFingerprint) {
     Ego.say("Ich fasse sie vorsichtig an der Seite an, um den Fingerabdruck nicht zu zerst[ren.") ;
     EgoStartUse ;
      takeItem(Ego, Seife) ;
      SeifeH.enabled = false ;
     EgoStopUse ;
   } else Ego.say("Warum sollte ich die Seife einstecken?") ;
 } else Ego.say("Ich habe mir vorher schon die H#nde gewaschen.") ;
 clearAction ;
}



/* ************************************************************* */

object Seifenschale {
 setupAsStdEventObject(Seifenschale,WalkTo,150,286,DIR_WEST) ;	
 setClickArea(52,189,84,205);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Seifenschale" ;
}

event Seife -> Seifenschale {
 Ego: 
  walkToStdEventObject(Seifenschale) ;
 suspend ;
 EgoStartUse ;
  dropItem(Ego, Seife) ;
  Seifenschale.enabled = false ;
  SeifeH.enabled = true ;
  drySoap(false) ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Spiegel {
 setupAsStdEventObject(Spiegel,LookAt,189,260,DIR_WEST) ;		
 setClickArea(7,55 ,109,177);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Spiegel" ;
}

event Use -> Spiegel {
 Ego:
  walkToStdEventObject(Spiegel) ;
}

event LookAt -> Spiegel {
 Ego:
  walkToStdEventObject(Spiegel) ;
  say("Verdammt sehe ich GUT aus!") ;
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,Open,186,231,DIR_NORTH) ;			
 setClickArea(167,97,241,213);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
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

event Open -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 EgoStartUse ;
 Ego:
  reflectionOffsetX = 0 ;
  reflection = false ; 
 doEnter(Finalesaal) ;
}

/* ************************************************************* */

object Foen {
 setupAsStdEventObject(Foen,Use,248,263,DIR_EAST) ;				
 setClickArea(275,118,314,166);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Handf[n" ;
}

event Use -> Foen {
 Ego:
  walkToStdEventObject(Foen) ;
 suspend ;
 EgoStartUse ;
 soundBoxStart(Music::Foen_wav) ;
 EgoStopUse ;
 clearAction ;
}

event Seife -> Foen {
 Ego:
  walkToStdEventObject(Foen) ;
 suspend ;
 if (!driedSoap) {
   EgoStartUse ;
   soundBoxPlay(Music::Foen_wav) ;
   drySoap(true) ;
   EgoStopUse ;
 } else Ego.say("Ich habe die Seife schon gef[nt.") ;
 clearAction ;
}

/* ************************************************************* */

object TrinkerWasch {
 setupAsStdEventObject(TrinkerWasch, TalkTo, 180,320,DIR_WEST) ;
 
 setPosition(47,173) ;
 priority = 250 ;
 scale = 800 ;
 captionX = 70  ;
 captionY = -60 ;
 captionColor = COLOR_LANGE ; 
 captionWidth = 260 ;
 setAnim(TrinkerWaschen_sprite) ;
 setClickArea(0,0,95,205) ;
 absolute = false ;
 clickable = true ;
 enabled = false ;
 visible = true ;
 name = "Dr. Lange" ;
 autoAnimate = false ;
}

event TalkTo -> TrinkerWasch {
 Ego:
  walkToStdEventObject(TrinkerWasch) ;
 suspend ;
  Ego.say("Ich m[chte ihm nicht weiter zur Last fallen.") ;  
 clearAction ;
}

event IDCard -> TrinkerWasch {
 Ego:
  walkToStdEventObject(TrinkerWasch) ;
 suspend ;
  Ego.say("Das lasse ich lieber.") ;
 clearAction ;
}

event LookAt -> TrinkerWasch {
 Ego:
  walkToStdEventObject(TrinkerWasch) ;
 suspend ;
  say("Das ist Herr Lange.") ;
  say("Er scheint damit besch#ftigt zu sein, sich gr]ndlich die H#nde zu waschen.") ;  
 clearAction ;
}

event Push -> TrinkerWasch {
 triggerObjectOnObjectEvent(TalkTo, Trinkerwasch) ;
}

event Pull -> TrinkerWasch {
 triggerObjectOnObjectEvent(TalkTo, Trinkerwasch) ;
}

event Take -> TrinkerWasch {
 Ego:
  walkToStdEventObject(Trinkerwasch) ;
 suspend ;
  say("Nicht mein Typ.") ;
 clearAction ;
}

event Use -> Trinkerwasch {
 triggerObjectOnObjectEvent(Take, Trinkerwasch) ;
}

event invDrinks -> Trinkerwasch {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Trinkerwasch) ;
 suspend ;
 if (used) {
   say("Ih m[chte das Getr#nk jetzt erst recht nicht ]ber den armen Mann leeren.") ;
 } else {
   say("Darf ich Ihnen dieses Getr#nk hier anbieten?") ;
   Trinker.say("Nein, blo} nicht!") ;
 }
 clearAction ;
}

event animate TrinkerWasch {

  static int Ti = 0 ;
  static int Bi = 0 ;

  Ti++ ;
  Bi++ ;
  switch TrinkerWasch.animMode {
   case ANIM_TALK: 
	if ((TrinkerWasch.frame > 2) and (TrinkerWasch.frame < 6)) TrinkerWasch.frame = TrinkerWasch.frame - 3 ;
	if (TrinkerWasch.frame > 8) TrinkerWasch.frame = TrinkerWasch.frame - 3 ;
	
	if ((Ti >= 2) and (random(2)==0)) {
	  Ti = 0 ;
	  if (TrinkerWasch.frame<6) TrinkerWasch.frame = 6+random(3) ;
	    else TrinkerWasch.frame = random(3) ;
        }
	
	if ((Bi>=50+random(7))and(random(4)==0)) {
	  if (Bi < 6) TrinkerWasch.frame = 3+random(3) ;
            else TrinkerWasch.frame = 9+random(3) ;
	  Bi = 0 ;
	}
	
   default:
	if ((Ti >= 3) and (random(2)==0)) {
	  TrinkerWasch.frame++ ;
	  Ti = 0 ;
	}
	
	if (TrinkerWasch.frame>2) TrinkerWasch.frame = 0 ;	   
	
	if ((Bi >= 50+random(7))and(random(4)==0)) {
	  if ((TrinkerWasch.frame < 3)and(random(2)==0)) TrinkerWasch.frame = TrinkerWasch.frame + 3 ;

          Bi = 0 ;
	}

  }
}

/* ************************************************************* */

object Wasser {
 setPosition(46,220) ;
 priority = 256 ;
 stopAnimDelay = 2 ;
 setAnim(Wasser_sprite) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ; 
}


/* ************************************************************* */

object Muell {
 setupAsStdEventObject(Muell,LookAt,248,263,DIR_EAST) ;
 setClickArea(274,202,316,256);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "M]lleimer" ;
}

object Offen {
 setPosition(272,179) ;
 setAnim(Eimeroffen_image) ;
 absolute = false ;
 clickable = false ;
 visible = true ;
 enabled = getField(0) ;
}

event Use -> Muell {
 if (Offen.enabled) triggerObjectOnObjectEvent(Close, Muell) ;
   else triggerObjectOnObjectEvent(Open, Muell) ;
}

event Open -> Muell {
 Ego:
  walkToStdEventObject(Muell) ;
 suspend ;
 if (Offen.enabled) {
   say("Der M]lleimer ist schon ge[ffnet.") ;
 } else {
   EgoStartUse ;
   soundBoxStart(Music::Deckelauf_wav) ;
   Offen.enabled = true ;
   Offen.setField(0, true) ;
   EgoStopUse ;
 }
 clearAction ;
}

event Close -> Muell {
 Ego:
  walkToStdEventObject(Muell) ;
 suspend ;
 if (Offen.enabled) {
   EgoStartUse ;
   soundBoxStart(Music::Deckelzu_wav) ;   
   Offen.enabled = false ;
   Offen.setField(0, false) ;
   EgoStopUse ;
 } else Ego.say("Der M]lleimer ist bereits geschlossen.") ;
 clearAction ;
}

event LookAt -> Muell {
 Ego:
  walkToStdEventObject(Muell) ;
 suspend ;
  say("Ein M]lleimer.") ;
 if (Offen.enabled) {
   say("Er ist ge[ffnet.") ;
   say("Darin befinden sich nur ein paar benutzte Papierhandt]cher.") ;
   if (throwForm == 1) say("Und ein Formular.") ;
    else if (throwForm > 1) say("Und Formulare.") ;
 } else say("Er ist geschlossen.") ;
 clearAction ;
}

static var throwForm = 0 ;

event SFormular -> Muell {
 Ego:
  walkToStdEventObject(Muell) ;
 suspend ;  
 if (! Offen.enabled) {
   EgoStartUse ;
   soundBoxStart(Music::Deckelauf_wav) ;
   Offen.enabled = true ;
   Offen.setField(0, true) ;
   EgoStopUse ;
 }
  egoStartUse ;
  dropItem(Ego, SFormular) ;
  throwForm++ ;
  egoStopUse ;
  delay 3 ;
  egoStartUse ;
  triggerObjectOnObjectEvent(Close, Muell) ;
  egoStopUse ;
 clearAction ;
}

event SFormularS -> Muell {
 Ego:
  walkToStdEventObject(Muell) ;
 suspend ;  
 if (! Offen.enabled) {
   EgoStartUse ;
   soundBoxStart(Music::Deckelauf_wav) ;
   Offen.enabled = true ;
   Offen.setField(0, true) ;
   EgoStopUse ;
 }
  egoStartUse ;
  dropItem(Ego, SFormularS) ;
  throwForm++ ;
  egoStopUse ;
  delay 3 ;
  egoStartUse ;
  triggerObjectOnObjectEvent(Close, Muell) ;
  egoStopUse ;
 clearAction ;
}

event SFormularV -> Muell {
 Ego:
  walkToStdEventObject(Muell) ;
 suspend ;  
 if (! Offen.enabled) {
   EgoStartUse ;
   soundBoxStart(Music::Deckelauf_wav) ;
   Offen.enabled = true ;
   Offen.setField(0, true) ;
   EgoStopUse ;
 }
  egoStartUse ;
  dropItem(Ego, SFormularV) ;
  throwForm++ ;
  egoStopUse ;
  delay 3 ;
  egoStartUse ;
  triggerObjectOnObjectEvent(Close, Muell) ;
  egoStopUse ;
 clearAction ;
}

event SFormularF -> Muell {
 Ego:
  walkToStdEventObject(Muell) ;
 suspend ;
  say("Ich werfe doch nicht meinen m]hsam hergestellten Fingerabdruck in den M]ll!") ;
 clearAction ;
}

/* ************************************************************* */

object Automat {
 setupAsStdEventObject(Automat,LookAt,650,331,DIR_EAST) ;
 setClickArea(679,110,773,229);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kondom-Automat" ;
}

event LookAt -> Automat {
 Ego:
  walkToStdEventObject(Automat) ;
 suspend ;
  say("Ein Kondom-Automat mit der Aufschrift 'STOP AIDS'.") ;
 if (!hasItem(Ego, Coin)) {
   say("Da steckt da eine M]nze im M]nzr]ckgabefach!") ;
   say("Ich nehme sie mit.") ;
   takeItem(Ego, Coin) ;
 }
 clearAction ;
}

event Use -> Automat {
 Ego:
  walkToStdEventObject(Automat) ;
 suspend ;
 if (!hasItem(Ego, Coin)) say("Ich habe kein Kleingeld.") ;
  else say("Nicht jetzt.") ;
 clearAction ;
}

event Coin -> Automat {
 Ego:
  walkToStdEventObject(Automat) ;
 suspend ;
  if (!hasItem(Ego, IDCard)) say("Nicht jetzt.") ;
    else say("Nicht jetzt.") ;
 clearAction ;
}

event Pull -> Automat {
 triggerObjectOnObjectEvent(Push, Automat) ;
}

event Push -> Automat {
 Ego: 
  walkToStdEventObject(Automat) ;
 suspend ;
  EgoUse ;
  say("Er ist fest an der Wand befestigt.") ;
 clearAction ;
}

/* ************************************************************* */

object TTuer1 {
 setupAsStdEventObject(TTuer1,Use,427,296,DIR_NORTH) ;	
 setClickArea(352,70,481,248);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Toilettent]r" ;
}

event LookAt -> TTuer1 {
 Ego:
  walkToStdEventObject(TTuer1) ;
 suspend ;
  say("Eine Toilettent]r.") ;
  if (Trinker.enabled) say("Es ist besetzt.") ;
 clearAction ;
}


event Use -> TTuer1 {
 triggerObjectOnObjectEvent(Open, TTuer1) ;
}

event Close -> TTuer1 {
 Ego:
  walkToStdEventObject(TTuer1) ;
 suspend ;
  say("Sie ist schon zu.") ;
 clearAction ;
}

event Open -> TTuer1 {
 Ego: 
  walkToStdEventObject(TTuer1) ;
 suspend ;
  if (Trinker.enabled) {
    EgoUse ;
    say("Besetzt.") ;
  } else say("Ich muss da momentan nicht rein.") ;
 clearAction ;
}

/* ************************************************************* */

object TTuer2 {
 setupAsStdEventObject(TTuer2,Use,567,292,DIR_NORTH) ;
 setClickArea(515,71,629,247);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Toilettent]r" ;
}

event LookAt -> TTuer2 {
 Ego:
  walkToStdEventObject(TTuer2) ;
  say("Eine Toilettent]r. Auf dem Schild steht 'Au}er Betrieb'.") ;
}

event Coin -> TTuer2 {
 Ego:
  walkToStdEventObject(TTuer2) ;
 suspend ;
 
 if (!trinkerAtToilet) {
   say("Ich muss da momentan nicht rein.") ;
   clearAction ;
   return ;
 }
 
 if (!Gruen.enabled) {
   say("Ich versuche die T]r mit der M]nze aufzubekommen.") ;
   EgoStartUse ;
   soundBoxStart(Music::Toiletdoor_wav) ;
   Gruen.enabled = true ;
   Gruen.setField(0, true) ;
   EgoStopUse ;
   say("Das ging ja einfach.") ;
 } else Ego.say("Ich habe die T]r bereits aufgeschlossen.") ;
 clearAction ;
}

event ScrewDriver -> TTuer2 {
 Ego:
  walkToStdEventObject(TTuer2) ;
 suspend ;
 
 if (!trinkerAtToilet) {
   say("Ich muss da momentan nicht rein.") ;
   clearAction ;
   return ;
 }
 
 if (!Gruen.enabled) {
   say("Ich versuche die T]r mit dem Schraubenzieher aufzubekommen.") ;
   EgoStartUse ;
   soundBoxStart(Music::Toiletdoor_wav) ;
   Gruen.enabled = true ;
   Gruen.setField(0, true) ;
   EgoStopUse ;
   say("Das ging ja einfach.") ;
 } else Ego.say("Ich habe die T]r bereits aufgeschlossen.") ;
 clearAction ;
}

event Use -> TTuer2 {
 if ((!Gruen.enabled) and (Gruen.getField(0))) triggerObjectOnObjectEvent(Close, TTuer2) ;
  else triggerObjectOnObjectEvent(Open, TTuer2) ;
}

event Open -> TTuer2 {
 Ego:
  walkToStdEventObject(TTuer2) ;
 suspend ;
 if (Jultoi.enabled) {
  Gruen.enabled = false ;
  soundBoxStart(Music::Toiletopen_wav) ;
  Tueroffen.enabled = true ;
  Jultoi.enabled = false ;
  Ego.enabled = true ;
  Ego.face(DIR_SOUTH) ;
  objEnable(true) ;
 } else if (Gruen.getField(0)) {
   if (Gruen.enabled) {
     EgoStartUse ;
     soundBoxStart(Music::Toiletopen_wav) ;
     Tueroffen.enabled = true ;
     Tueroffen.setField(0, true) ;
     Gruen.enabled = false ;
     EgoStopUse ;
   } else Ego.say("Die T]r ist schon offen.") ;
 } else Ego.say("Die T]r ist abgeschlossen. Auf dem Schild steht 'Au}er Betrieb'.") ;
 clearAction ;
}

event Close -> TTuer2 {
 Ego:
  walkToStdEventObject(TTuer2) ;
 suspend ;
 if (Tueroffen.enabled) {
   EgoStartUse ;
   soundBoxStart(Music::Toiletclose_wav) ;
   Tueroffen.enabled = false ;
   Tueroffen.setField(0, true) ;
   Gruen.enabled = true ;
   EgoStopUse ;
 } else say("Die T]r ist schon zu.") ;
 clearAction ;
}

script objEnable(enable) {
  Spiegel.enabled = enable ;
  Tuer.enabled = enable ;
  Foen.enabled = enable ;
  Muell.enabled = enable ;
  Automat.enabled = enable ;
  TTuer1.enabled = enable ;
  SeifeH.enabled = enable ;
  Waschbecken.enabled = enable ;
}

event WalkTo -> TTuer2 {
 Ego: 
  walkToStdEventObject(TTuer2) ;
 if (Tueroffen.enabled) {
   if ((TrinkerAtToilet) and (!hasItem(Ego, IDCard))) {
     Ego.enabled = false ;
     soundBoxStart(Music::Toiletclose_wav) ;
     Tueroffen.enabled = false ;
     Jultoi.enabled = true ;
     Gruen.enabled = true ;
     objEnable(false) ;
   }
 }
 clearAction ;
}

object Tueroffen {
 setPosition(508,70) ;
 setAnim(Tueroffen_image) ;
 absolute = false ;
 clickable = false ;
 visible = true ;
 enabled = getField(0) ;
}

object Jultoi {
 setPosition(509,238) ;
 setAnim(Jultoi_image) ;
 absolute = false ;
 clickable = false ;
 visible = true ;
 enabled = false ;
}

object Gruen {
 setPosition(534,159) ;
 setAnim(TuerGruen_image) ;
 absolute = false ;
 clickable = false ;
 visible = true ;
 enabled = (getField(0) and (!Tueroffen.getField(0))) ;
}

/* ************************************************************* */

object Waschbecken {
 setupAsStdEventObject(Waschbecken,WalkTo,150,286,DIR_WEST) ;
 setClickArea(22,209,110,272);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Waschbecken" ;
}

event Use -> Waschbecken {
 Ego: 
  walkToStdEventObject(Waschbecken) ;
 suspend ;
  say("Meine H#nde sind schon sauber.") ;
 clearAction ;
}

event Push -> Waschbecken {
 Ego:
  walkToStdEventObject(Waschbecken) ;
 suspend ;
  EgoUse ;
  say("Es bewegt sich nicht.") ;
 clearAction ;
}

event Pull -> Waschbecken {
 triggerObjectOnObjectEvent(Push, Waschbecken) ;
}

event LookAt -> Waschbecken {
 Ego:
  walkToStdEventObject(Waschbecken) ;
  say("Nett.") ;
}

/* ************************************************************* */

object Karte {
 setupAsStdEventObject(Karte,Take,427,296,DIR_NORTH) ;
 setClickArea(447,252,447+16,252+11);
 absolute = false ;
 clickable = true ;
 enabled = !hasItem(Ego, IDCard) ;
 visible = false ;
 name = "Sicherheitskarte" ;
}

event LookAt -> Karte {
 Ego: 
  walkToStdEventObject(Karte) ;
 suspend ;
  if (knowsIDCard) say("Das ist die Identifikationskarte von Herrn Lange.") ;
   else say("Der Mann hat eine rote Karte in seiner Hosentasche stecken.") ;
 clearAction ;
}

event Pull -> Karte {
 triggerObjectOnObjectEvent(Take, Karte) ;
}

event Take -> Karte {
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 if (Jultoi.enabled) {
  say("Von hier aus komme ich mit blo}en H#nden nicht ran!") ;
 } else {
  EgoStartUse ;
 Trinker.say("Finger weg!") ;
  EgoStopUse ;
  delay 5 ;
  Ego.turn(DIR_SOUTH) ;
  pujaTipp ;
 }
 clearAction ;
}

event Stock -> Karte {
 var didUse = did(use) ;
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 if (!didUse) {
   say("Ich m[chte ihm das nicht geben.") ;
   clearAction ;
   return ;
 }
 if (Jultoi.enabled) {
  delay 10 ;
  say("Nur mit dem Stock kann ich die Karte nicht greifen.") ;
 } else {
  EgoStartUse ;
 Trinker.say("Nehmen Sie dieses Ding da weg!") ;
  EgoStopUse ;
  delay 5 ;
  Ego.turn(DIR_SOUTH) ;
  pujaTipp ;
 }
 clearAction ;
}


event Haarklammer -> Karte {
 var didUse = did(use) ;
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 if (!didUse) {
   say("Ich m[chte ihm das nicht geben.") ;
   clearAction ;
   return ;
 }
 if (Jultoi.enabled) {
  delay 10 ;
  say("Mit der Haarklammer  k[nnte ich die Karte zwar greifen, aber ich komme mit blo}en H#nden nicht ran.") ;
 } else {
  EgoStartUse ;
 Trinker.say("Nehmen Sie dieses Ding da weg!") ;
  EgoStopUse ;
  delay 5 ;
  Ego.turn(DIR_SOUTH) ;
  pujaTipp ;
 }
 clearAction ;
}


event Stockklammer -> Karte {
 var didUse = did(use) ;
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 if (!didUse) {
   say("Ich m[chte ihm das nicht geben.") ;
   clearAction ;
   return ;
 }
 if (Jultoi.enabled) {
  say("Das k[nnte funktionieren...") ;
  delay 10 ;
  takeItem(Ego, IDCard) ;
  Trinker.frame = 1 ;
  Karte.enabled = false ;
  Trinker.setField(0, 1) ;
  delay 5 ;
  say("Hab sie.") ;
 } else {
  EgoStartUse ;
 Trinker.say("Nehmen Sie dieses Ding da weg!") ;
  EgoStopUse ;
  delay 5 ;
  Ego.turn(DIR_SOUTH) ;
  pujaTipp ;
 }
 clearAction ;
}


script pujaTipp {
 switch (upCounter(4)) {
   case 0: Ego.say("Hmmm... Er hat mich gesehen.") ;
   case 1: Ego.say("Er hat mich schon wieder gesehen.") ;
   case 2: Ego.say("Wenn ich das von hier aus versuche, kann er mich sehen.") ;
   default: Ego.say("Er hat mich wieder gesehen. Vielleicht versuche ich es von der anderen Toilette aus.") ;
 }
}

/* ************************************************************* */

object Trinker {
 setupAsStdEventObject(Trinker,LookAt,427,296,DIR_NORTH) ;
 setAnim(Trinker_sprite) ;
 setPosition(380,156) ;
 setClickArea(4,90,66,122) ;
 autoAnimate = false ;
 frame = getField(0) ;
 absolute = false ;
 clickable = true ;
 enabled = trinkerAtToilet ;
 visible = true ;
 captionwidth = 300 ;
 captionX = 40  ;
 captionY = -70 ;
 captionColor = COLOR_LANGE ;
 name = "Dr. Lange" ;
}

event LookAt -> Trinker {
 Ego:
  walkToStdEventObject(Trinker) ;
 suspend ;
  say("Hier muss wohl jemand ein dringendes Gesch#ft erledigen.") ;
  if (!hasItem(Ego, IDCard)) say("Ich kann eine rote Karte in seiner Hosentasche erkennen.") ;
 clearAction ;
}

event TalkTo -> Trinker {
 Ego:
  walkToStdEventObject(Trinker) ;
 suspend ;
  say("Nicht jetzt.") ;
  say("Er sieht besch#ftigt aus.") ;
 clearAction ;
}



