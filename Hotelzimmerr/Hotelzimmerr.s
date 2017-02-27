// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
	
  backgroundImage = hotelzimmerr_image ;
  backgroundZBuffer = hotelzimmerr_zbuffer ;
  Ego:
   path = hotelzimmerr_path ;
   positionX = 408 ;
   positionY = 359 ;
   face(DIR_NORTH) ;
   walk(408,317) ;
  
  static var sayContactWonciek = true ;
  
  if (HasRoom and sayContactWonciek) {   
   Ego: 
    turn(DIR_SOUTH) ;
    "Jetzt, wo ich mein Zimmer habe, sollte ich Peter Hallo sagen."
   sayContactWonciek = false ;
  } 
  clearAction ;  
}

/* ************************************************************* */

object Fernseher {
 setClickArea(466,170,548,238);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fernseher" ;
 class = StdEventObject ; 
 StdEvent = Use ;  
}

event WalkTo -> Fernseher {
 clearAction ;
 Ego:
  walk(432,302) ;
  turn(DIR_EAST) ;
}

event LookAt -> Fernseher {
 clearAction ;
 Ego: 
  walk(432,302) ;
  turn(DIR_EAST) ; 
  "Jetzt nicht. Ich habe zu tun."
}

event Use -> Fernseher {
 TriggerObjectOnObjectEvent(LookAt, Fernseher) ;
}

event Take -> Fernseher {
 clearAction ;
 Ego:
  walk(432,302) ;
  turn(DIR_EAST) ;
  "Wusstest Du, dass die h#ufigste Todesursache von Elefantenbabys Fluss]berquerungen sind?"	
}

/* ************************************************************* */

object Spiegel {
 setClickArea(551,65,609,250);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Spiegel" ;
 class = StdEventObject ; 
 StdEvent = LookAt ;   
}

event WalkTo -> Spiegel {
 clearAction ;	
 Ego:
  walk(442,325) ;
  turn(DIR_EAST) ; 
}

event LookAt -> Spiegel {
 Ego:
  walk(442,325) ;
  turn(DIR_EAST) ;
  "Verdammt, sehe ich gut aus!"
 clearAction ;
}

/* ************************************************************* */

object Streich { 
 setAnim(Matches_image) ;
 setPosition(123,249) ;
 setClickArea(0,0,18,13) ;
 absolute = false ;
 clickable = true ;
 enabled = (! Streich.getField(0)) and (! HasRoom) ;
 visible = (! Streich.getField(0)) and (! HasRoom) ;
 if (hasRoom) visible = false ;
 name = "Streichh[lzer" ;
 class = StdEventObject ; 
 StdEvent = Take ;   
}

event WalkTo -> Streich {
 clearAction ;
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ;
}

event LookAt -> Streich {
 clearAction ;
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ;
  "Eine Packung Streichh[lzer liegt auf dem Nachttisch."
}

event Take -> Streich {
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ;
  EgoStartUse ;
  Streich.enabled = false ;
  Streich.setField(0, true) ;
  takeItem(Ego, Matches) ;
  EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Nachttisch {
 setClickArea(88,252,150,290);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Nachttisch" ;
 class = StdEventObject ; 
 StdEvent = Open ;   
}

event WalkTo -> Nachttisch {
 clearAction ;
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ; 
}

event Open -> Nachttisch {
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ; 
  delay ;
  EgoUse ;
  delay ;
  "Er ist leer."  
 clearAction ;
}

event Use -> Nachttisch {
 triggerObjectOnObjectEvent(Open, Nachttisch) ;
}

event Pull -> Nachttisch {
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ; 
  "Lieber nicht."  
 clearAction ;	
}

event Push -> Nachttisch {
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ; 
  "Er steht schon direkt an der Wand."  
 clearAction ;	
}

/* ************************************************************* */

object decke1 {
 setClickArea(75,289,295,357);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Bettdecke" ;
}

event WalkTo -> decke1 {
 clearAction ;
 Ego:
  walk(228,309) ;
  turn(DIR_SOUTH) ;
}

event Take -> decke1 {
 Ego:
  walk(228,309) ;
  turn(DIR_SOUTH) ;
  "Ich will die Decke nicht."  
 clearAction ;
}

event LookAt -> decke1 {
 clearAction ;
 Ego:
  walk(228,309) ;
  turn(DIR_SOUTH) ;
  "Eine Bettdecke."	  
}

event Pull -> Decke1 {
 clearAction ;
 Ego:
  walk(228,309) ;
  turn(DIR_SOUTH) ;
  EgoUse ;
  "Da ist nichts darunter."	  	
}

/* ************************************************************* */

object decke2 {
 setClickArea(215,219,331,283);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Bettdecke" ;
}

event WalkTo -> decke2 {
 clearAction ;
 Ego:
  walk(293,230) ;
  turn(DIR_SOUTH) ;
}

event Take -> decke2 {
 Ego:
  walk(293,230) ;
  turn(DIR_SOUTH) ;
  "Ich will die Decke nicht."
 clearAction ;
}

event LookAt -> decke2 {
 clearAction ;
 Ego:
  walk(293,230) ;
  turn(DIR_SOUTH) ;
  "Eine Bettdecke."	  
}

event Pull -> Decke2 {
 clearAction ;
 Ego:
  walk(293,230) ;
  turn(DIR_SOUTH) ;
  EgoUse ;
  "Da ist nichts darunter."	  	
}


/* ************************************************************* */

object Bild {
 setClickArea(127,90,191,147);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Bild" ;
}

event WalkTo -> Bild {
 clearAction ;
 Ego:
  walk(236,233) ;
  turn(DIR_WEST) ;
}

event LookAt -> Bild {
 clearAction ;	
 Ego:
  walk(236,233) ;
  turn(DIR_WEST) ;
  "Die Pyramiden."
}

event Take -> Bild {
 Ego:
  walk(236,233) ;
  turn(DIR_WEST) ;
  "Unfug."
 clearAction ;		
}

/* ************************************************************* */

object Lampe1 {
 setClickArea(102,170,135,228);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Lampe" ;
}

event WalkTo -> Lampe1 {
 clearAction ;
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ; 
}

event LookAt -> Lampe1 {
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ; 
  "Eine Lampe."	
  "Sie ist ausgeschaltet."
 clearAction ;
}

event Use -> Lampe1 {
 Ego:
  walk(174,296) ;
  turn(DIR_WEST) ; 
  "Eigentlich ist es hell genug."	  
 clearAction ;	
}


/* ************************************************************* */

object Fenster {
 setClickArea(283,82,418,208);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fenster" ;
}

event WalkTo -> Fenster {
 clearAction ;
 Ego:
  walk(373,227) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Fenster {
 Ego: 
  walk(373,227) ;
  turn(DIR_NORTH) ;  
  "Ein gro}es Fenster, das sich nur kippen l#sst."
  "Drau}en befinden sich weder Balkon, noch Fenstersims."
 clearAction ;  
}

event Open -> Fenster {
 Ego:
  walk(373,227) ;
  turn(DIR_NORTH) ;
  "Man kann das Fenster nur kippen."  
 if (needPickLock2) {
  "Soweit ich das erkennen kann, f]hrt kein Sims zu Peters Zimmer."
  "Au}erdem enden solche waghalsigen Aktionen oft damit, dass ich weinen muss."
 }
 clearAction ;
}

event Close -> Fenster {
 clearAction ;
 Ego:
  walk(373,227) ;
  turn(DIR_NORTH) ; 
  "Es ist schon zu." 
}

event Use -> Fenster {
 TriggerObjectOnObjectEvent(Open, Fenster) ;
}

/* ************************************************************* */

object Schubl1 {
 setClickArea(466,244,488,307);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schublade" ;
}

event WalkTo -> Schubl1 {
 clearAction ;
 Ego:
  walk(451,339) ;
  turn(DIR_EAST) ;
}

event LookAt -> Schubl1 {
 Ego:
  walk(451,339) ;
  turn(DIR_EAST) ;
  EgoUse ;
  "Eine Schublade."  
  "Sie ist leer."
 clearAction ;
}

event Take -> Schubl1 {
 clearAction ;		
 Ego:
  walk(451,339) ;
  turn(DIR_EAST) ;
  "Was will ich damit?"  
}

event Open -> Schubl1 { 
 Ego:
  walk(451,339) ;
  turn(DIR_EAST) ;
  EgoUse ;
  "Sie ist leer."  
 clearAction ;		  
}

event Close -> Schubl1 {
 Ego:
  walk(451,339) ;
  turn(DIR_EAST) ;
  EgoUse ;
  "Sie ist schon zu."  
 clearAction ;		  	
}

event Use -> Schubl1 {
 triggerObjectOnObjectEvent(Open, Schubl1) ;
}

object Schubl2 {
 setClickArea(488,286,518,360) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schublade" ;
}

event WalkTo -> Schubl2 {
 triggerObjectOnObjectEvent(WalkTo, Schubl1) ;
}

event LookAt -> Schubl2 {
 triggerObjectOnObjectEvent(LookAt, Schubl1) ;
}

event Take -> Schubl2 {
 triggerObjectOnObjectEvent(Take, Schubl1) ;
}

event Open -> Schubl2 {
 triggerObjectOnObjectEvent(Open, Schubl1) ;
}

event  Close -> Schubl2 {
 triggerObjectOnObjectEvent(Close, Schubl1) ;
}

event Use -> Schubl2 {
 triggerObjectOnObjectEvent(Open, Schubl1) ;
}

/* ************************************************************* */
/*
object notebook {
 setAnim(Notebook_image) ;
 setPosition(492,239) ;
 absolute = false ;
 clickable = true ;
 visible = ! getField(0) ;
 if (hasRoom) visible = false ;
 enabled = (! getField(0)) and (! HasRoom) ;
 enabled = false ; 
 priority = 36 ;
 name = "Telefonbuch" ;
 setClickArea(0,0,39,34) ;
 class = StdEventObject ; 
 StdEvent = LookAt ;   
}

event WalkTo -> Notebook {
 clearAction ;
 Ego:
  walk(440,305) ;
  turn(DIR_EAST) ;
}

event LookAt -> NoteBook {
 Ego:
  walk(440,305) ;
  turn(DIR_EAST) ;
  "Ein kleines, aufgeschlagenes Buch, mit Namen und Telefonnummern."
 clearAction ;  
}

event Close -> Notebook {
 Ego:
  walk(440,305) ;
  turn(DIR_EAST) ;
  "Vielleicht sollte ich es nehmen, und es mir genauer anschauen."
 clearAction ;  	
}

event Take -> Notebook {
 Ego:
  walk(440,305) ;
  turn(DIR_EAST) ;
 EgoStartUse ;
 notebook.visible = false ;
 notebook.enabled = false ;
 notebook.setField(0,1) ;
 takeItem(Ego, Telbook) ;
 EgoStopUse ;
 clearAction ;
}
*/
/* ************************************************************* */

object Koffer { 
 setAnim(Koffer_image) ;
 setPosition(414,205) ;
 setClickArea(0,0,54,61) ;
 absolute = false ;
 clickable = true ;
 enabled = ! hasRoom ;
 visible = ! hasRoom ; 
 name = "Lederkoffer" ;
}

event WalkTo -> Koffer {
 clearAction ;
 Ego:
  walk(412,265) ;
  turn(DIR_EAST) ;
}

event  LookAt -> Koffer {
 Ego:
  walk(412,265) ;
  turn(DIR_EAST) ;
  "Ein teuer aussehender Koffer aus Leder."	
  EgoUse ;
  "Darin befindet sich ausschlie}lich Kleidung."
 clearAction ;
}

event Take -> Koffer {
 Ego:
  walk(412,265) ;
  turn(DIR_EAST) ;
  EgoUse ;
  "Nein."
  "Darin befindet sich nur Kleidung."
 clearAction ;  
}

/* ************************************************************* */

object Lampe2 {
 setClickArea(507,62,544,118);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Lampe" ;
}

event WalkTo -> Lampe2 {
 clearAction ;
 Ego:
  walk(479,259) ;
  turn(DIR_SOUTH) ;
}


event LookAt -> Lampe2 {
 Ego:
  walk(479,259) ;
  turn(DIR_SOUTH) ;
  "Eine Lampe."	
  "Sie ist ausgeschaltet."
 clearAction ;
}

event Use -> Lampe2 {
 Ego:
  walk(479,259) ;
  turn(DIR_SOUTH) ;
  "Es ist hell genug hier."
 clearAction ;	
}

/* ************************************************************* */

object zurueck {
 setClickArea(305,332,486,360);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Flur" ;
}

event LookAt -> zurueck {
 clearAction ;
 Ego:
  turn(DIR_SOUTH) ;
  "Hier geht es zur]ck zum Flur."
}

event WalkTo -> zurueck {
 clearAction ;
 Ego:
  walk(390,360) ; 
 suspend ;
 doEnter(Hotelgang) ;
}