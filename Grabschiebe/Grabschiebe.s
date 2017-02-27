// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var los = imageToID(Schilfoben_image) ;
static var mos = imageToID(Leer_image) ;
static var ros = imageToID(Leer_image) ;

static var lms = imageToID(Schilfmitte_image) ;
static var mms = imageToID(Wasser_image) ;
static var rms = imageToID(Leer_image) ;

static var lus = imageToID(Schilfunten_image) ;
static var mus = imageToID(Hocker_image) ;
static var rus = imageToID(Leer_image) ;

static var kennteinschub = false ;

event enter {
 DarknessEffect.enabled = false ;
 FlashlightEffect.enabled = false ;
 
 Ego:	
  backgroundImage = Grabschiebe_image;
  backgroundZBuffer = 0 ;
  path = 0 ;
  PositionX = 300 ;
  PositionY = 210 ;
  enabled = false ;  
 
 static int first = true ;
 if (first) { 
  delay(20) ;
  Ego: "Auf der quadratischen Grundfl#che sind neun Steinquader gleichm#}ig angeordnet,..."
       "...links und rechts der Anordnung befinden sich jeweils drei schmale Spalte."
       "Was das wohl zu bedeuten hat?"
  first = false ;
 }
 
 forceShowInventory ;
 clearAction ; 
 if (hasItem(Ego, ScheibeBrotLaib) and hasItem(Ego, ScheibeSonnenscheibe)) {
   start { akt3Save ; } ;	 
 }
} 

/* ************************************************************* */

object zurueck {
 setClickArea(0,0,90,360);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Zur]ck" ;
}

event default -> zurueck {
 InterruptCaptions ;
 doEnter(GrabSonnenraum ) ;
}

object zurueck2 {
 setClickArea(514,0,640,360);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Zur]ck" ;
}

event default -> zurueck2 {
 InterruptCaptions ;	
 doEnter(GrabSonnenraum ) ;
}

/* ************************************************************* */

script idToImage(sId) {
 if (sId == 0) return Brotlaib_image ;
  else if (sId == 1) return Hocker_image ;
  else if (sId == 2) return Leer_image ;
  else if (sId == 3) return Schilfoben_image ;	
  else if (sId == 4) return Schilfmitte_image ;
  else if (sId == 5) return Schilfunten_image ;
  else if (sId == 6) return Sonnenscheibe_image ;
  else if (sId == 7) return Wasser_image ;	
 return null ;
}

script imageToId(sImage) {
 if (sImage == Brotlaib_image) return 0 ;
  else if (sImage == Hocker_image) return 1 ;
  else if (sImage == Leer_image) return 2 ;
  else if (sImage == Schilfoben_image) return 3 ;
  else if (sImage == Schilfmitte_image) return 4 ;
  else if (sImage == Schilfunten_image) return 5 ;
  else if (sImage == Sonnenscheibe_image) return 6 ;
  else if (sImage == Wasser_image) return 7 ;	
}

script leerCount {
 var res = 0 ;
 if (HasItem(Ego, Scheibeleer)) res++ ;
 if (HasItem(Ego, Scheibeleer2)) res++ ;
 return res ;
}

script getNextLeerScheibe {
 switch leerCount {
  case 0: return Scheibeleer ;
  case 1: return Scheibeleer2 ; 
 }
 return null ;
}

script getHighLeerScheibe {
 if (hasItem(Ego, Scheibeleer2)) return Scheibeleer2 ;	
 if (hasItem(Ego, Scheibeleer)) return Scheibeleer ;	 
 return null ;
}

script getInvScheibe(scheibenGrafik) {
 if (scheibenGrafik == Brotlaib_image) return ScheibeBrotlaib ;
  else if (scheibenGrafik == Hocker_image) return ScheibeHocker ;
  else if (scheibenGrafik == Leer_image) return getNextLeerScheibe ;
  else if (scheibenGrafik == Schilfoben_image) return ScheibeSchilfoben ;
  else if (scheibenGrafik == Schilfmitte_image) return ScheibeSchilfmitte ;
  else if (scheibenGrafik == Schilfunten_image) return ScheibeSchilfunten ;
  else if (scheibenGrafik == Sonnenscheibe_image) return ScheibeSonnenscheibe ;
  else if (scheibenGrafik == Wasser_image) return ScheibeWasser ;	  
 return 0 ;
}

script checkCombi {
 if ((lo.getAnim(ANIM_STOP, 0) == Schilfoben_image) and
     (lm.getAnim(ANIM_STOP, 0) == Schilfmitte_image) and
     (lu.getAnim(ANIM_STOP, 0) == Schilfunten_image) and
     (mo.getAnim(ANIM_STOP, 0) == Brotlaib_image) and
     (mm.getAnim(ANIM_STOP, 0) == Wasser_image) and
     (mu.getAnim(ANIM_STOP, 0) == Sonnenscheibe_image) and
     (ro.getAnim(ANIM_STOP, 0) == Leer_image) and
     (rm.getAnim(ANIM_STOP, 0) == Leer_image) and
     (ru.getAnim(ANIM_STOP, 0) == Leer_image)) { return true ; } else
 if ((mo.getAnim(ANIM_STOP, 0) == Schilfoben_image) and
     (mm.getAnim(ANIM_STOP, 0) == Schilfmitte_image) and
     (mu.getAnim(ANIM_STOP, 0) == Schilfunten_image) and
     (ro.getAnim(ANIM_STOP, 0) == Brotlaib_image) and
     (rm.getAnim(ANIM_STOP, 0) == Wasser_image) and
     (ru.getAnim(ANIM_STOP, 0) == Sonnenscheibe_image) and
     (lo.getAnim(ANIM_STOP, 0) == Leer_image) and
     (lm.getAnim(ANIM_STOP, 0) == Leer_image) and
     (lu.getAnim(ANIM_STOP, 0) == Leer_image)) { return true ; }     
  else return false ;
}

// Auswürfe rechts
object ero {
 setPosition(422,92) ;
 setClickArea(0,0,80,82) ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
 if (kennteinschub) name="Auswurf"; else name="Spalt" ;
}

object erm {
 setPosition(422,178) ;
 setClickArea(0,0,80,82) ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
 if (kennteinschub) name="Auswurf"; else name="Spalt" ;
}

object eru {
 setPosition(422,264) ;
 setClickArea(0,0,80,82) ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
 if (kennteinschub) name="Auswurf"; else name="Spalt" ;
}

event default -> ero { DefEvER;}
event default -> erm { DefEvER; }
event default -> eru { DefEvER; }

script DefEvER {	
 if IsClassDerivate(SelectedObject,InvObj) {
  Ego:
   if (IsScheibe(SelectedObject)) {
   Ego:
    "Der Quader gleitet zwar ein St]ck weit in den Spalt,..."
    "...springt aber sofort wieder heraus wenn ich versuche ihn ganz hineinzudr]cken."
   } else {  
   Ego:
   "Das kann ich weder in den Spalt stecken..."
   "...noch den Spalt damit aufweiten."
   }
 } else triggerDefaultEvents ; 
 clearAction ;
}

event LookAt -> ero { triggerObjectOnObjectEvent(LookAt,eru) ; }
event LookAt -> erm { triggerObjectOnObjectEvent(LookAt,eru) ; }
event LookAt -> eru {	
 Ego:
  if (!KenntEinschub) {
   "Ein schmaler Spalt im Stein."
   "Er sieht genauso aus wie die anderen f]nf."
  } else {
   "Der schmale Spalt ist offenbar eine Art Auswurf."
   "Schiebe ich links einen passenden Steinquader hinein,..."
   "...so wirft er den nun ]berz#hlige Quader aus."
  }
 clearAction ;
}

// Einschub links oben

object elo {
 setPosition(98,92) ;
 setClickArea(0,0,80,82) ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
 if (kennteinschub) name="Einschub"; else name="Spalt" ;
}

event default -> elo {	
 if IsClassDerivate(SelectedObject,InvObj) {
  if (isScheibe(SelectedObject)) {
   if (SelectedObject == ScheibeBrotlaib)  { dropItem(Ego, SelectedObject) ; schiebeLinksOben(Brotlaib_image) ; }
    else if (SelectedObject == ScheibeHocker)  { dropItem(Ego, SelectedObject) ; schiebeLinksOben(Hocker_image) ; }
    else if (SelectedObject == ScheibeLeer)  { dropItem(Ego, getHighLeerScheibe) ; schiebeLinksOben(Leer_image) ; }
    else if (SelectedObject == ScheibeLeer2)  { dropItem(Ego, getHighLeerScheibe) ; schiebeLinksOben(Leer_image) ; }
    else if (SelectedObject == ScheibeSchilfoben)  { dropItem(Ego, SelectedObject) ; schiebeLinksOben(Schilfoben_image) ; }
    else if (SelectedObject == ScheibeSchilfmitte)  { dropItem(Ego, SelectedObject) ; schiebeLinksOben(Schilfmitte_image) ; }
    else if (SelectedObject == ScheibeSchilfunten)  { dropItem(Ego, SelectedObject) ; schiebeLinksOben(Schilfunten_image) ; }
    else if (SelectedObject == ScheibeSonnenscheibe)  { dropItem(Ego, SelectedObject) ; schiebeLinksOben(Sonnenscheibe_image) ; }
    else if (SelectedObject == ScheibeWasser) { dropItem(Ego, SelectedObject) ; schiebeLinksOben(Wasser_image) ; }
   if (!KenntEinschub) EinschubSayFirst ;
  } else {
   Ego:
   "Das kann ich weder in den Spalt stecken..."
   "...noch den Spalt damit aufweiten."
  } 
 } else triggerDefaultEvents ;
 if (checkCombi) { delay 10 ; solvedAtonPuzzle = true ; doEnter(GrabSonnenraum) ; }
 clearAction ;
}

script schiebeLinksOben(scheibenGrafik) {
 soundBoxStart(Music::Schieb_wav) ;
 takeItem(Ego,getInvScheibe(ro.getAnim(ANIM_STOP, 0))) ;
 ro.setAnim(mo.getAnim(ANIM_STOP, 0)) ;
 mo.setAnim(lo.getAnim(ANIM_STOP, 0)) ;
 lo.setAnim(scheibenGrafik) ;
 los = imageToId(lo.getAnim(ANIM_STOP, 0)) ;
 mos = imageToId(mo.getAnim(ANIM_STOP, 0)) ;
 ros = imageToId(ro.getAnim(ANIM_STOP, 0)) ;
 KartuscheChanged = true ; 
}

/* ************************************************************* */

// Einschub links mitte

object elm {
 setPosition(98,178) ;
 setClickArea(0,0,80,82) ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
 if (kennteinschub) name="Einschub"; else name="Spalt" ;
}

event default -> elm {	
 if IsClassDerivate(SelectedObject,InvObj) {
  if (isScheibe(SelectedObject)) {
   if (SelectedObject == ScheibeBrotlaib)  { dropItem(Ego, SelectedObject) ; schiebeLinksMitte(Brotlaib_image) ; }
    else if (SelectedObject == ScheibeHocker)  { dropItem(Ego, SelectedObject) ; schiebeLinksMitte(Hocker_image) ; }
    else if (SelectedObject == ScheibeLeer)  { dropItem(Ego, getHighLeerScheibe) ; schiebeLinksMitte(Leer_image) ; }
    else if (SelectedObject == ScheibeLeer2)  { dropItem(Ego, getHighLeerScheibe) ; schiebeLinksMitte(Leer_image) ; }
    else if (SelectedObject == ScheibeSchilfoben)  { dropItem(Ego, SelectedObject) ; schiebeLinksMitte(Schilfoben_image) ; }
    else if (SelectedObject == ScheibeSchilfmitte)  { dropItem(Ego, SelectedObject) ; schiebeLinksMitte(Schilfmitte_image) ; }
    else if (SelectedObject == ScheibeSchilfunten)  { dropItem(Ego, SelectedObject) ; schiebeLinksMitte(Schilfunten_image) ; }
    else if (SelectedObject == ScheibeSonnenscheibe)  { dropItem(Ego, SelectedObject) ; schiebeLinksMitte(Sonnenscheibe_image) ; }
    else if (SelectedObject == ScheibeWasser) { dropItem(Ego, SelectedObject) ; schiebeLinksMitte(Wasser_image) ; }
   if (!KenntEinschub) EinschubSayFirst ;
  } else {
   Ego:
   "Das kann ich weder in den Spalt stecken..."
   "...noch den Spalt damit aufweiten."
  } 
 } else triggerDefaultEvents ;
 if (checkCombi) { delay 10 ; solvedAtonPuzzle = true ;  clearAction ; doEnter(GrabSonnenraum) ; }
 clearAction ;
}

script EinschubSayFirst {
 Ego: 
 "Huch!"
 "Der Steinquader gleitet nahezu widerstandslos in den Spalt,..."
 "...verschiebt die bereits vorhandenen Quader nach rechts..."
 "...und dr]ckt den ]berz#hligen Quader durch den rechten Spalt heraus."
 "Ein sehr interessanter Mechanismus..."
 "...ich frage mich nur was er bewirken soll."
 KenntEinschub = true ;
 ELO.name = "Einschub" ;
 ELM.name = "Einschub" ;
 ELU.name = "Einschub" ;
 ERO.name = "Auswurf" ;
 ERM.name = "Auswurf" ;
 ERU.name = "Auswurf" ;
}

script schiebeLinksMitte(scheibenGrafik) {
 soundBoxStart(Music::Schieb_wav) ;
 takeItem(Ego,getInvScheibe(rm.getAnim(ANIM_STOP, 0))) ;
 rm.setAnim(mm.getAnim(ANIM_STOP, 0)) ;
 mm.setAnim(lm.getAnim(ANIM_STOP, 0)) ;
 lm.setAnim(scheibenGrafik) ;
 lms = imageToId(lm.getAnim(ANIM_STOP, 0)) ;
 mms = imageToId(mm.getAnim(ANIM_STOP, 0)) ;
 rms = imageToId(rm.getAnim(ANIM_STOP, 0)) ; 
 KartuscheChanged = true ; 
}

/* ************************************************************* */

// Einschub links unten

object elu {
 setPosition(98,264) ;
 setClickArea(0,0,80,82) ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
 if (kennteinschub) name="Einschub"; else name="Spalt" ;
}

event default -> elu {	
 if IsClassDerivate(SelectedObject,InvObj) {
  if (isScheibe(SelectedObject)) {
   if (SelectedObject == ScheibeBrotlaib)  { dropItem(Ego, SelectedObject) ; schiebeLinksUnten(Brotlaib_image) ; }
    else if (SelectedObject == ScheibeHocker)  { dropItem(Ego, SelectedObject) ; schiebeLinksUnten(Hocker_image) ; }
    else if (SelectedObject == ScheibeLeer)  { dropItem(Ego, getHighLeerScheibe) ; schiebeLinksUnten(Leer_image) ; }
    else if (SelectedObject == ScheibeLeer2)  { dropItem(Ego, getHighLeerScheibe) ; schiebeLinksUnten(Leer_image) ; }   
    else if (SelectedObject == ScheibeSchilfoben)  { dropItem(Ego, SelectedObject) ; schiebeLinksUnten(Schilfoben_image) ; }
    else if (SelectedObject == ScheibeSchilfmitte)  { dropItem(Ego, SelectedObject) ; schiebeLinksUnten(Schilfmitte_image) ; }
    else if (SelectedObject == ScheibeSchilfunten)  { dropItem(Ego, SelectedObject) ; schiebeLinksUnten(Schilfunten_image) ; }
    else if (SelectedObject == ScheibeSonnenscheibe)  { dropItem(Ego, SelectedObject) ; schiebeLinksUnten(Sonnenscheibe_image) ; }
    else if (SelectedObject == ScheibeWasser) { dropItem(Ego, SelectedObject) ; schiebeLinksUnten(Wasser_image) ; }
   if (!KenntEinschub) EinschubSayFirst ;
  } else {
   Ego:
   "Das kann ich weder in den Spalt stecken..."
   "...noch den Spalt damit aufweiten."
  }  
 } else triggerDefaultEvents ;
 if (checkCombi) { delay 10 ; solvedAtonPuzzle = true ;  clearAction ; doEnter(GrabSonnenraum) ; }
 clearAction ;
}

script schiebeLinksUnten(scheibenGrafik) {
 soundBoxStart(Music::Schieb_wav) ;	
 takeItem(Ego,getInvScheibe(ru.getAnim(ANIM_STOP, 0))) ;
 ru.setAnim(mu.getAnim(ANIM_STOP, 0)) ;
 mu.setAnim(lu.getAnim(ANIM_STOP, 0)) ;
 lu.setAnim(scheibenGrafik) ;
 lus = imageToId(lu.getAnim(ANIM_STOP, 0)) ;
 mus = imageToId(mu.getAnim(ANIM_STOP, 0)) ;
 rus = imageToId(ru.getAnim(ANIM_STOP, 0)) ; 
 KartuscheChanged = true ; 
}

event Pull -> elo { triggerObjectOnObjectEvent(Pull, elu) ; }
event Pull -> elm { triggerObjectOnObjectEvent(Pull, elu) ; }
event Pull -> ero { triggerObjectOnObjectEvent(Pull, elu) ; }
event Pull -> erm { triggerObjectOnObjectEvent(Pull, elu) ; }
event Pull -> eru { triggerObjectOnObjectEvent(Pull, elu) ; }

event Pull -> elu { 
 Ego:
  delay 5 ;
  say("Ich finde mit den Fingern keinen Halt.") ;
 clearAction ;	
}

event Push -> elo { triggerObjectOnObjectEvent(Push, elu) ; }
event Push -> elm { triggerObjectOnObjectEvent(Push, elu) ; }

event Push -> ero { triggerObjectOnObjectEvent(Push, elu) ; }
event Push -> erm { triggerObjectOnObjectEvent(Push, elu) ; }
event Push -> eru { triggerObjectOnObjectEvent(Push, elu) ; }

event Push -> elu {
 Ego:
  delay 5 ;
  say("Das hat nichts bewirkt.") ;
 clearAction ;
}


event LookAt -> elo { triggerObjectOnObjectEvent(LookAt,elu) ; }
event LookAt -> elm { triggerObjectOnObjectEvent(LookAt,elu) ; }
event LookAt -> elu {	
 Ego:
  if (!KenntEinschub) {
   "Ein schmaler Spalt im Stein."
   "Er sieht genauso aus wie die anderen f]nf."
  } else {
   "Der schmale Spalt ist offenbar eine Art Einwurf."
   "Schiebe ich in ihn einen passenden Steinquader hinein,..."
   "...so verschiebt sich die gesamte Anordnung..."
   "...und der ]berz#hlige Quader wird rechts ausgeworfen."
  }
 clearAction ;
}



/* ************************************************************* */

object QuaderClass { }

event InvObj -> QuaderClass { 
 Ego:
  if (isScheibe(selectedObject)) {    
    say("Ich bekomme die eine Scheibe nicht raus.") ;
    say("So kann ich die Scheiben nicht austauschen.") ;
  } else triggerInvDefaultEvents(selectedObject, Quaderclass) ;
 clearAction ;
}

event LookAt -> QuaderClass {
 //var to = TargetObject ;
 Ego.say("Der Steinquader ist oben und unten in einer Art Halterung fixiert...") ;
 if (getAnim(ANIM_STOP, 0) == LEER_IMAGE) {
   Ego.say("...seine Oberfl#che ist v[llig glatt.") ;
  } else {
   Ego.say("...auf seiner sonst glatten Oberfl#che ist etwas eingraviert.") ;
  }	  
 clearAction ;
}

event Take -> QuaderClass {
 Ego:
  "Ich kann r]tteln und zerren so viel ich will,..."
  "...der Steinquader l[st sich nicht aus seiner Fassung."
  clearAction ;
}

event Push -> QuaderClass {
 Ego:
  "Der Steinquader l#sst sich nicht mit blosser Hand verschieben."
  clearAction ;
}
event Pull -> QuaderClass { TriggerObjectOnObjectEvent(Push,Quaderclass); } 

object lo {
 class = QuaderClass ;
 setAnim(idToImage(los)) ;	
 setPosition(179,92) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ; 
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object mo {
 class = QuaderClass ;
 setAnim(idToImage(mos)) ;	
 setPosition(260,92) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object ro {
 class = QuaderClass ;
 setAnim(idToImage(ros)) ;	
 setPosition(341,92) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ; 
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object lm {
 class = QuaderClass ;
 setAnim(idToImage(lms)) ;	
 setPosition(179,178) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ; 
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object mm {
 class = QuaderClass ;
 setAnim(idToImage(mms)) ;	
 setPosition(260,178) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object rm {
 class = QuaderClass ;
 setAnim(idToImage(rms)) ;	
 setPosition(341,178) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object lu {
 class = QuaderClass ;
 setAnim(idToImage(lus)) ;	
 setPosition(179,264) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object mu {
 class = QuaderClass ;
 setAnim(idToImage(mus)) ;	
 setPosition(260,264) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ; 
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}

object ru {
 class = QuaderClass ;
 setAnim(idToImage(rus)) ;	
 setPosition(341,264) ;
 setClickArea(0,0,80,82) ;
 name = "Quader" ;
 visible = true ;
 enabled = true ;
 clickable = true ;
 absolute = false ;
}