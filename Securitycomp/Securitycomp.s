// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
  
 forceHideInventory ; 
 STATUS_FORCEHIDE ;
 Darkbar.enabled = false ;
 backgroundImage = Securitycomp_image;
 backgroundZBuffer = null ;
 scrollX = 0 ;
 
 Ego:
  setPosition(320,185) ; 
  enabled = false ;
  captionY = 0 ;
  path = 0 ; 
  
 if (hackedComputer) {
   changeLoginButtons(false) ;
   changeMenuButtons(true) ;
   Status.visible = true ;
   Status.frame = 8 ;
   delay transitionTime ;
 } else {
   changeLoginButtons(false) ;
   changeMenuButtons(false) ;
   Status.visible = true ;
   Status.frame = 0 ;
   delay transitionTime ;
   delay 13 ;
   Status.frame = 1 ;
   delay 19 ;
   Status.frame = 2 ;
   delay 19 ;
   Status.visible = false ;
   changeLoginButtons(true) ;
   
   do_reset ;
   static var first = true ;
   if (first) {
    delay transitionTime ;
    delay 20 ;
    Ego:     
    delay 10 ;
     "Peter sagte, ich m]sste als Passwort 'ON' eingeben."
   }
 }
 
 clearAction ;
}

/* ************************************************************* */

script changeLoginButtons(senabled) {
  Bfff.enabled = senabled ;
  Bfffn.enabled = senabled ;
  Bno.enabled = senabled ;
  Boff.enabled = senabled ;
  Blogin.enabled = senabled ;
  
  BfffImage.enabled = senabled ;
  BfffnImage.enabled = senabled ;
  BnoImage.enabled = senabled ;
  BoffImage.enabled = senabled ;
  BloginImage.enabled = senabled ;
  
  outputobj.enabled = senabled ;
}


/* ************************************************************* */

script changeMenuButtons(senabled) {
	
  MBLaser.enabled = senabled ;
  MBMeasure.enabled = senabled ;
  MBPrint.enabled = senabled ;
  MBLogout.enabled = senabled ;
  
  MBLaserImage.enabled = senabled ;
  MBMeasureImage.enabled = senabled ;
  MBPrintImage.enabled = senabled ;
  MBLogoutImage.enabled = senabled ;
  
}

/* ************************************************************* */

object pwStatus {
 setPosition(0,0) ;
 setAnim(passwortOK_image) ;
 enabled = false ;
 visible = true ;
 absolute = false ;
 clickable = false ;
 priority = 200 ;
}

/* ************************************************************* */

object MBLaser {
 setClickArea(196,119,480,166) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

object MBLaserImage {
  setAnim(0) ;
  setPosition(201,125) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover MBLaser {
  if (! suspended)
  MBLaserImage.setAnim(MenuButtons_sprite) ;
  MBLaserImage.frame = 0 ;
}

event mouseoff MBLaser {
  if (! suspended)
  MBLaserImage.setAnim(0) ;
}

event default -> MBLaser {
  start soundBoxPlay(Click_wav) ;	 	    		
  delay 3 ;
  changeMenuButtons(false) ;
  Status.frame = 11 ;
  delay 33 ;
  pwStatus.setAnim(Verbindung_image) ;
  pwStatus.enabled = true ;   
  delay 20 ;
  if (! cactusMutated)  Ego.say("Schade...") ;
   else {
     Ego.say("Schade, Oscar.") ;
     Ego.say("Hier h#tten wir bestimmt viel Spa} gehabt...") ;
   }
  pwStatus.enabled = false ;   
  Status.frame = 8 ;
  changeMenuButtons(true) ;
  clearAction ;
}

event LookAt -> MBLaser {
  Ego.say("Mit diesem Knopf kann man den Laser abfeuern.") ;
  clearAction ;
}

/* ************************************************************* */

object MBMeasure {
 setClickArea(170,190,497,236) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

object MBMeasureImage {
  setAnim(0) ;
  setPosition(184,199) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover MBMeasure {
  if (! suspended)
  MBMeasureImage.setAnim(MenuButtons_sprite) ;
  MBMeasureImage.frame = 1 ;
}

event mouseoff MBMeasure {
  if (! suspended)
  MBMeasureImage.setAnim(0) ;
}

event default -> MBMeasure {
  start soundBoxPlay(Click_wav) ;	 	    		
  delay 3 ;
  changeMenuButtons(false) ;
  Status.frame = 12 ;
  delay 33 ;
  pwStatus.setAnim(Verbindung_image) ;
  pwStatus.enabled = true ;    
  delay 20 ;
  Ego.say("Scheint leider nicht zu funktionieren...") ;
  pwStatus.enabled = false ;
  Status.frame = 8 ;
  changeMenuButtons(true) ;
  clearAction ;  
}

event LookAt -> MBMeasure {
 Ego.say("Auf diesem Knopf steht 'Messung starten'") ;
 clearAction ;
}

/* ************************************************************* */


object MBPrint {
 setClickArea(112,262,571,345) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

object MBPrintImage {
  setAnim(0) ;
  setPosition(121,270) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover MBPrint {
  if (! suspended)
  MBPrintImage.setAnim(MenuButtons_sprite) ;
  MBPrintImage.frame = 2 ;
}

event mouseoff MBPrint {
  if (! suspended)
  MBPrintImage.setAnim(0) ;
}

event default -> MBPrint {
  start soundBoxPlay(Click_wav) ;	 	    		
  if (!installedPrinter) { 
    changeMenuButtons(false) ;
    delay 3 ;
    Status.frame = 12 ;
    delay 23 ;
    Status.frame = 10 ;
    pwStatus.setAnim(KeinDrucker_image) ;
    pwStatus.enabled = true ;  
    delay 23 ;
    Ego.say("Wie kann es sein, dass am SamTec-Zentralrechner kein Drucker angeschlossen ist?") ;
    delay 5 ;
    pwStatus.enabled = false ;
    Status.frame = 8 ;
    changeMenuButtons(true) ;
    delay 5 ;
    Ego.say("Hier muss man sich um alles selbst k]mmern!") ;    
    clearAction ;
  } else {
    changeMenuButtons(false) ;
    delay 3 ;
    Status.frame = 12 ;
    delay 23 ;
    printCutscene = true ;
    doEnter(Securitylab1) ;
  }
}

event LookAt -> MBPrint {
  Ego.say("Mit diesem Knopf werden die stren geheimen Dokumente gedruckt.") ;
  clearAction ;
}


/* ************************************************************* */


object MBLogout {
 setClickArea(259,369,401,427) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

object MBLogoutImage {
  setAnim(0) ;
  setPosition(271,383) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover MBLogout {
  if (! suspended)
  MBLogoutImage.setAnim(MenuButtons_sprite) ;
  MBLogoutImage.frame = 3 ;
}

event mouseoff MBLogout {
  if (! suspended)
  MBLogoutImage.setAnim(0) ;
}

event default -> MBLogout {
  start soundBoxPlay(Click_wav) ;	 	    		
  changeMenuButtons(false) ;
  delay 3 ;
  Status.frame = 12 ;
  delay 23 ;
  Status.frame = 0 ;
  delay 23 ;
  hackedComputer = false ;
  doEnter(Securitylab1) ;
}

event LookAt -> MBLogout {
  Ego.say("Damit kann man sich abmelden.") ;
  clearAction ;
}

/* ************************************************************* */


/* ************************************************************* */

object Status {
 setPosition(73,52) ;
 visible = false ;
 enabled = true ;
 absolute = false ;
 clickable = false ;
 setAnim(Status_sprite) ;
 autoAnimate = false ;
 frame = 0 ;
}

/* ************************************************************* */

var letter_n = 0 ;
var letter_o = 0 ;
var letter_f = 0 ;

const CHAR_N = 'N' ;
const CHAR_O = 'O' ;
const CHAR_F = 'F' ;

script do_reset {
  letter_n = 0 ;
  letter_o = 0 ;
  letter_f = 0 ;
 
  add(CHAR_N) ;
  add(CHAR_O) ;
}

script add(key) {
  switch key {
    case CHAR_N: letter_n.bit[getLastChar+1] = true ; 
    case CHAR_O: letter_o.bit[getLastChar+1] = true ; 
    case CHAR_F: letter_f.bit[getLastChar+1] = true ; 
  }
}

script getLastChar {
  var res = -1 ;
  for (int i=0; i<32; i++) {
    if (letter_n.bit[i] or letter_o.bit[i] or letter_f.bit[i]) res = i ; 
  }
  return res ;
}

script insertSpace(index) {
  if ((index > getLastChar) or (index > 31) or (index < 0)) return ;
  for (int i=31; i>=index; i--) {
    letter_n.bit[i] = letter_n.bit[i-1] ;
    letter_o.bit[i] = letter_o.bit[i-1] ;
    letter_f.bit[i] = letter_f.bit[i-1] ;
  }
  letter_n.bit[index] = false ;
  letter_o.bit[index] = false ;
  letter_f.bit[index] = false ; 
}

script delChar(index) {
  if ((index > getLastChar) or (index > 31) or (index < 0)) return ;
  for (int i=index; i<=getLastChar; i++) {
    if (i+1 < 32) {
      letter_n.bit[i] = letter_n.bit[i+1] ;
      letter_o.bit[i] = letter_o.bit[i+1] ;
      letter_f.bit[i] = letter_f.bit[i+1] ;
    }
  }
}

script do_login {
 var correct = ((getLastChar == 1) and (letter_o.bit[0]) and (letter_n.bit[1])) ;
 Status.frame = 3 ;
 Status.visible = true ;
 outputObj.enabled = false ;
 delay 23 ;
 if (correct) {
   changeLoginButtons(false) ;	 
   pwStatus.setAnim(passwortOK_image) ;
   pwStatus.enabled = true ;   
   Status.frame = 4 ;
   start soundBoxPlay(Login_wav) ;	 
   delay 23 ;
   pwStatus.enabled = false ;
   hackedComputer = true ;
   Status.frame = 7 ;
   delay 23 ;
   Status.frame = 12 ;
   delay 23 ;
   Status.frame = 8 ;   
   changeMenuButtons(true) ;
   return true ;
 } else {	 
   Status.frame = 5 ;
   pwStatus.setAnim(passwortFALSCH_image) ;
   pwStatus.enabled = true ;   
   start soundBoxPlay(Denied_wav) ;	 	 
   delay 22 ;
   pwStatus.enabled = false ;   
   Status.visible = false ;
   outputObj.enabled = true ;
   do_reset ;
   return false ;
 }
}

script do_off {
  if (getLastChar >= 29) {
    start soundBoxPlay(Click_wav) ;	 	  
    do_restart ;
    return false ;   
  }
  start soundBoxPlay(Click_wav) ;	 
  add(CHAR_O) ;
  add(CHAR_F) ;
  add(CHAR_F) ;
  return true ;
}

script do_no {
  for (int i=getLastChar; i>=1; i--) {
    if (letter_o.bit[i] and letter_n.bit[i-1]) {
      start soundBoxPlay(Click_wav) ;	 	    
      delChar(i) ;
      delChar(i-1) ;
      return true ;
    }
  }
  return false ;
}

script do_fffn {
  start soundBoxPlay(Click_wav) ;	 	    	
  for (int i=getLastChar; i>=2; i--) {
    if (letter_f.bit[i] and letter_f.bit[i-1] and letter_f.bit[i-2]) {
      delChar(i-2) ;
      delChar(i-2) ;
      letter_f.bit[i-2] = false ;
      letter_n.bit[i-2] = true ;
      return true ;
    }
  }
  return false ;
}

script do_fff {
  int fcnt = 0 ;
  start soundBoxPlay(Click_wav) ;	   
  for (int a=0; a<=getLastChar; a++) {
    if (letter_f.bit[a]) fcnt++ ;
  }
  if (fcnt+getLastChar > 31) {
    do_restart ;
    return 0 ;
  }
  int i = 0 ;
  do {
    if (letter_f.bit[i] and (i+1 < 32)) {
      insertSpace(i+1) ;
      letter_f.bit[i+1] = true ;
      i++ ;  // skip just inserted f
    }
    i++ ;
  } while ((i <= getLastChar) or (i < 32)) ;
  return (fcnt>0) ;
}

script do_restart {
  pwStatus.setAnim(Datenmenge_image) ;
  pwStatus.enabled = true ;  	
  outputObj.enabled = false ;
  start soundBoxPlay(Restart_wav) ;	 	
  delay 32 ;
  do_reset ;
  pwStatus.enabled = false ;
  outputObj.enabled = true ;
}

/* ************************************************************* */

object outputObj {
 enabled = true ;
 visible = true ;
 clickable = false ;
 Priority = 254 ;
} 

event paint outputObj {
 var outputString = "" ;
 StringClear(outputString) ;
 
 for (int i=0; i<=getLastChar; i++) {
   if (letter_n.bit[i]) stringAppendChar(outputString, CHAR_N) ;
    else if (letter_o.bit[i]) stringAppendChar(outputString, CHAR_O) ;
    else if (letter_f.bit[i]) stringAppendChar(outputString, CHAR_F) ;
 }
  
 int dtc = drawingTextColor ;
 int dtf = drawingFont ;
 drawingFont = STATUS_FONT ;
 drawingPriority = 250 ;
 drawingTextColor = COLOR_LIGHT_GREEN ; 
 drawText(130,247-5,outputString) ; 
 drawingTextColor = dtc ; 
 StringClear(outputString) ;
} 


/* ************************************************************* */

object Blogin {
 setClickArea(271,380,398,425) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "'Login'-Knopf" ;
}

object BloginImage {
  setAnim(0) ;
  setPosition(286+1,388-5) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover Blogin {
  if (! suspended)
  BloginImage.setAnim(Buttons_sprite) ;
  BloginImage.frame = 4 ;
}

event mouseoff Blogin {
  if (! suspended)
  BloginImage.setAnim(0) ;
}

static var bloginFirstComment = false ;

event WalkTo -> Blogin { 
  BloginImage.setAnim(0) ;
  STATUS_FORCEHIDE ;	
  if (!do_login) and (!bloginFirstComment) {
    delay 18 ;
    Ego.say("Ich h#tte wahrscheinlich 'ON' eingeben m]ssen.") ;
    bloginFirstComment = true ;	  
  }  
  clearAction ;
} 

event LookAt -> Blogin {
 BloginImage.setAnim(0) ;	
 STATUS_FORCEHIDE ;	
 Ego:
  "Auf diesem Knopf steht 'Login'."
 if (bloginFirstComment) say("Wahrscheinlich muss ich ihn dr]cken, sobald ich 'ON' eingegeben habe.") ;
 clearAction ;
}

/* ************************************************************* */

object Boff {
 setClickArea(91,311,200,354) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "'Off'-Knopf" ;
}

object BoffImage {
  setAnim(0) ;
  setPosition(111+1+1,318-4) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover Boff {
  if (! suspended)
  BoffImage.setAnim(Buttons_sprite) ;
  BoffImage.frame = 0 ;
}

event mouseoff Boff {
  if (! suspended)
  BoffImage.setAnim(0) ;
}

static var boffFirstComment = false ;

event WalkTo -> Boff { 
  BoffImage.setAnim(0) ;	
  STATUS_FORCEHIDE ;	
  if (do_off) and (!boffFirstComment) {
    delay 18 ;
    Ego.say("Dieser Knopf f]gt der Zeichenkette ein 'OFF' hinzu.") ;
    boffFirstComment = true ;
  }    
  clearAction ;
} 

event LookAt -> Boff {
 BoffImage.setAnim(0) ;	
 STATUS_FORCEHIDE ;	
 Ego:
  "Auf diesem Knopf steht 'Off'."
 if (boffFirstComment) say("Er f]gt der Zeichenkette ein zus#tzliches 'OFF' hinzu.") ;
 clearAction ;
}

/* ************************************************************* */

object Bno {
 setClickArea(221,314,318,356) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "'-No-'-Knopf" ;
}

object BnoImage {
  setAnim(0) ;
  setPosition(233+1,319-5) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover Bno {
  if (! suspended)
  BnoImage.setAnim(Buttons_sprite) ;
  BnoImage.frame = 1 ;
}

event mouseoff Bno {
  if (! suspended)
  BnoImage.setAnim(0) ;
}

static var bnoFirstComment = false ;

event WalkTo -> Bno {   
  BnoImage.setAnim(0) ;	
  STATUS_FORCEHIDE ;	
  if (do_no) and (!bnoFirstComment) {
    delay 18 ;
    Ego.say("Dieser Knopf entfernt das letzte 'NO' in der Zeichenkette.") ;
    bnoFirstComment = true ;
  }  
  clearAction ;  
} 

event LookAt -> Bno {
 BnoImage.setAnim(0) ;	
 STATUS_FORCEHIDE ;	
 Ego:
  "Auf diesem Knopf steht '-No-'."
 if (bnoFirstComment) say("Er entfernt das letzte Vorkommen von 'NO' in der Zeichenkette.") ;
 clearAction ;
}

/* ************************************************************* */

object Bfffn {
 setClickArea(338,312,447,359) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "'FFF > N'-Knopf" ;
}

object BfffnImage {
  setAnim(0) ;
  setPosition(349+1,318-5) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover Bfffn {
  if (! suspended)
  BfffnImage.setAnim(Buttons_sprite) ;
  BfffnImage.frame = 2 ;
}

event mouseoff Bfffn {
  if (! suspended)
  BfffnImage.setAnim(0) ;
}

static var bfffnFirstComment = false ;

event WalkTo -> Bfffn {   
  BfffnImage.setAnim(0) ;	
  STATUS_FORCEHIDE ;	
  if (do_fffn) and (!bfffnFirstComment) {
    delay 18 ;
    Ego.say("Wenn ich diesen Knopf dr]cke, verwandeln sich die letzten drei zusammenh#ngenden 'F's in ein 'N'.") ;
    bfffnFirstComment = true ;
  }  
  clearAction ;  
} 

event LookAt -> Bfffn {
 BfffnImage.setAnim(0) ;	
 STATUS_FORCEHIDE ;	
 Ego:
  "Auf diesem Knopf steht 'FFF > N'."
 if (bfffnFirstComment) say("Er verwandelt die letzten drei zusammenh#ngenden 'F's in ein 'N'.") ;
 clearAction ;
}

/* ************************************************************* */

object Bfff {
 setClickArea(460,317,563,357) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "'F > FF'-Knopf" ;
}

object BfffImage {
  setAnim(0) ;
  setPosition(476+1,320-5) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  autoAnimate = false ;
}

event mouseover Bfff {
  if (! suspended)
  BfffImage.setAnim(Buttons_sprite) ;
  BfffImage.frame = 3 ;
}

event mouseoff Bfff {
  if (! suspended)
  BfffImage.setAnim(0) ;
}


static var bfffFirstComment = false ;

event WalkTo -> Bfff { 
  BfffImage.setAnim(0) ;	
  STATUS_FORCEHIDE ;	
  if (do_fff) and (!bfffFirstComment) {
    delay 18 ;
    Ego.say("Wenn ich diesen Knopf dr]cke, verdoppeln sich die 'F's in der Zeichenkette.") ;
    bfffFirstComment = true ;
  }
  clearAction ;  
} 

event LookAt -> Bfff {
 BfffImage.setAnim(0) ;	
 STATUS_FORCEHIDE ;	
 Ego:
  "Auf diesem Knopf steht 'F > FF'."
 if (bfffFirstComment) say("Er verdoppelt alle 'F's in der Zeichenkette.") ;
 clearAction ;
}

/* ************************************************************* */

object dt {
 setClickArea(0,450,640,480) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

event animate dt {
 return if suspended ;
 drawingTextColor = RGB(180,180,180) ;
 if (PointInRect(mouseX,mouseY,0,450,640,480)) drawText (mouseX+10, mouseY-5, "zur]ck") ;
}

event default -> dt {
 doEnter(Securitylab1) ;	
}