// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var doPushCnt = random(3)+1 ;
var pushCnt = 0 ;

event enter {  
 enableEgoTalk ;

 backgroundImage   = Vorflughafen_image ; 
 backgroundZBuffer = Vorflughafen_zbuffer ; 
 path              = Vorflughafen_path ;

 Ego:  
 path = Vorflughafen_path ;
 
 if (Egypt == false) { 
   setPosition(312,276) ;
   darkbar.enabled = false ;
   face(DIR_SOUTH) ;
   visible = true ;
   enabled = true ;   
   walk(446,317) ;
   turn(DIR_SOUTH) ;
   Egypt = true ;
   Ego:
   delay 20 ;
    "Jetzt sollte ich erstmal herausfinden, in welchem Hotel Wonciek wohnt..."
   delay 4 ;
    "...und mir dort ein Zimmer nehmen."
   delay 4 ;
    "Dann wird er mir einiges erkl#ren m]ssen."
  } else if ((PreviousScene == Telefon) or (TelStage >= 10)) {   
   setPosition(195,265) ;
   face(DIR_NORTH) ;
   Jultele.visible = true ;   
  } else {  
   setPosition(80,310) ;
   face(DIR_SOUTH) ;	  
   visible = true ;
   enabled = true ;   
  }
  
  forceShowInventory ; 
    
  var auflegen ;
  auflegen = true ;
  
  if (TelStage > 0 and TelStage < 10 and TelStage != 7) 
   for (int i = 0 ; i < random(3)+2 ; i++) {
    delay 15 ;
    soundBoxPlay(Music::Telefonklingeln_wav) ;        
   }
  
  if (TelStage == 1) TelInfo(TelefonSpeaker) ;
  if (TelStage == 2) TelHotel1(TelefonSpeaker) ;
  if (TelStage == 3) TelHotel2(TelefonSpeaker) ;
  if (TelStage == 4) TelHotel3(TelefonSpeaker) ;	  
  if (TelStage == 5) {
    TelHotel4(TelefonSpeaker) ;	  
    delay 2 ;
    start soundBoxStart(Music::Telefon2_wav) ; 
    EgoStartUse ;
    Jultele.visible = false ;
    Ego.visible = true ;
    EgoStopUse ;
    delay 1 ;
    egoStartUse ;    
    takeItem(Ego, Shim) ;    
    EgoStopUse ;
    if (lastPhonedHotel) {
     lastPhonedHotel = 0 ;
     Ego:
      turn(DIR_SOUTH) ;
      "Sehr sch[n."
     delay 4 ;
      "Ich nehme am besten gleich das Taxi dort dr]ben."
     delay 4 ;
    }
    auflegen = false ;
  }

  if (TelStage == 6) TelHotel5(TelefonSpeaker) ;	 
  if (TelStage == 7) TelHotel6(TelefonSpeaker) ; 
  if (TelStage == 8) TelSamTec(TelefonSpeaker) ;	
   
  if (TelStage == 9) { DiaQuest_TelCombat(TelefonSpeaker,LastTelNum); } 
	  
  
  // Julian legt auf...
  
  if (previousScene == Telefon and auflegen) or (TelStage >= 10) {     
   delay 2 ;
   start soundBoxStart(Music::Telefon2_wav) ; 
   EgoStartUse ;
   Jultele.visible = false ;
   Ego.visible = true ;
   Ego.enabled = true ;
   EgoStopUse ;
   delay 1 ;
   if (UsedTelMoney == 1) {
    UsedTelMoney = 0 ;
   } else {
    egoStartUse ;
    takeItem(Ego, Shim) ;
    EgoStopUse ;   
   }
  }

  // ... und kommentiert evtl das Gespräch mit

  // SamTec-Empfangsdame

  if (TelStage == 8) {
   telStage = 0 ;
   Ego: delay(10) ;
        Face(DIR_SOUTH) ;
	delay(1) ;
        "Wenn ich dort selbst anrufe, ist die gute Dame zwar abgelenkt, aber ich hier am Flughafen." ; 
	"Das hilft mir nicht unbedingt weiter."
  } 	

  // SamTec-Chef Brander, nachdem Julian dem Truckverkäufer eine Option verkauft hat

  if (TelStage == 10) {
    telStage = 0 ;
    delay(10) ;
    Ego: face(DIR_SOUTH) ;
 	 delay(1) ;
         "Was f]r ein Trottel." ; 
         "Aber ich rufe besser nicht nochmal dort an."
         "Nicht, dass dies noch zu unvorhersehbaren Komplikationen f]hrt."	 
  } 	
  
  // SamTec-Chef Brander, wenn man ihn schonmal angerufen hat
  
  if (TelStage == 11) {
   TelStage = 0 ;
   delay(10) ;
   Ego: Face(DIR_SOUTH) ;
	delay(1) ;
	"Keine Chance."
	"Da ruf ich nicht nochmal an."
  } 
  
  // Julian hat den Truck, will aber noch weitere Leute anrufen
  
  if (TelStage == 12) {
   TelStage = 0 ;
   delay(10) ;
   Ego: Face(DIR_SOUTH) ;
	delay(1) ;
	"Ich habe was ich wollte."
	"Wozu sollte ich weiter herum telefonieren?"
  } 
 
  // Julian hat eine Option am Telefon verkauft
 
  if (TelStage == 13) {
   TelStage = 0 ;
   if (random(2) == 0) {
    delay(10) ;
    Ego: Face(DIR_SOUTH) ;
	delay(1) ;
	"Ich bin gut."
   } 
  } 
  
  if (TelStage == 14) {
   TelStage = 0 ;
   Ego: "Das hilft mir nicht weiter."
  }
  
 clearAction ; 
 
}

/* ************************************************************* */

object Schlemiel { // Wer oder was ist eigentlich ein "Schlemiel"??
 class = StdEventObject ;
 StdEvent = TalkTo ;
 setPosition(0,108) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 setClickArea(0,0,87,178) ;
 name = "Schlemiel" ; 
 autoAnimate = false ;
 CaptionColor = COLOR_SCHLEMIEL ;
 captionY = 0 ;
 captionX = 200 ;
 captionWidth = 400 ;	 
 setStopAnim(SchlemielStat_sprite) ;
 setTalkAnim(SchlemielTalk_sprite) ;
 animMode = ANIM_STOP ;
} 

event Wallet -> Schlemiel {
 var didGive = did(give) ;
 Ego:
  walk(110,312) ; 
  turn(DIR_WEST) ;
 if (didGive)	say("Auf gar keinen Fall!") ;
  else say("Nein, ich m[chte nichts kaufen.") ;
 clearAction ;
}

event Klappspaten -> Schlemiel {
 Ego: walk(110,312) ;
      turn(DIR_WEST) ;
 Ego.say("Ist Ihnen 'Operation Klappspaten' ein Begriff?") ;
 EgoStartUse ;
 dropItem(Ego, Klappspaten) ;
 delay 19 ;
 takeItem(Ego, Klappspaten) ;
 EgoStopUse ;
 Schlemiel.say("Ja.") ;
 Schlemiel.say("Meine Lieferung mit Klappspaten sollte demn#chst eintreffen.") ;
 Schlemiel.say("Wissen Sie, wann es los geht?") ;
 delay 2 ;
 Ego.say("Wenn die Zeit reif ist.") ;
 clearAction ;
}

event animate Schlemiel {
 activeObject = Schlemiel ;
 killOnExit = true ;

 static int cnt = 0 ;
 cnt = cnt + 1 ;
 if (cnt > 10) {
  switch animMode {
   case ANIM_STOP : if (random(30) == 0) { 
	             cnt = 0 ; 
		     frame = frame + 1 % 2 ; 
		    } 
   case ANIM_TALK : if (frame + random(15) == 1) or ((frame != 1) and (random(10) == 0)) { 
	             cnt = 0 ; 
		     frame = frame + random(3) % 3 ; 
		    } 
  } 
 }
} 

event WalkTo -> Schlemiel {
 clearAction ;
 Ego:
  walk(110,312) ; 
  turn(DIR_WEST) ;
}

event LookAt -> Schlemiel {
 clearAction ;
 Ego:
  walk(110,312) ; 
  turn(DIR_WEST) ;
  "Eine sehr zweifelhafte Erscheinung."
  "Es w]rde mich nicht wundern, wenn er mir etwas verkaufen will."
}

event Push -> Schlemiel {
 clearAction ;
 Ego:
  walk(110,312) ; 
  turn(DIR_WEST) ;
  "Das w]rde ihm nicht gefallen." 
}

event Pull -> Schlemiel {
 triggerObjectOnObjectEvent(Push, Schlemiel) ;
}

event OptionContract -> Schlemiel {
 var didGive = did(give) ;
 clearAction ;
 Ego:
  walk(110,312) ; 
  turn(DIR_WEST) ;
  if (didGive) say("Nein, vielleicht ist mir dieser Optionsvertrag noch n]tzlich.") ;
   else say("Ich glaube nicht, dass dieser Typ auf seine eigene Masche hereinf#llt.") ;
}

event Picklock -> Schlemiel {
 var didGive = did(Give) ; 
 Ego:
  walk(110,312) ;
  turn(DIR_WEST) ;
  if (didGive) {
    say("Wollen Sie mir einen Dietrich abkaufen?") ;
    EgoUse ;
    Schlemiel.say("Den haben Sie von mir...") ;
    Schlemiel.say("Aber ich mag Ihren Sinn f]rs Gesch#ft.") ;
  } else say("Dietriche verwendet man gew[hnlich mit Schl[ssern.") ;
 clearAction ;	  
}

event PinUpKalender -> Schlemiel {
 Ego:
  walk(110,312) ;
  turn(DIR_WEST) ;
  say("H#tten Sie Interesse an einem Pinup-Kalender?") ;
  say("F]r Sie mache ich einen Spezial-Preis.") ;
  delay 2 ;
  EgoUse ;
  delay 2 ;
  Schlemiel.say("Den habe ich selbst in meinem Angebot.") ;
 clearAction ;
}

/* ************************************************************* */

object JulTele { 
 setPosition(170,130) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = false ; 
 autoAnimate = false ;
 setAnim(Jultelefon_sprite) ;
} 

/* ************************************************************* */

object Schild {
 setClickArea(436,182,496,254) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event WalkTo -> Schild {
 clearAction ;
 Ego:
  walk(446,317) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Schild {
 clearAction ;
 Ego:
  walk(446,317) ;
  turn(DIR_NORTH) ; 
  "Da steht nichts."  
}

/* ************************************************************* */

object TelefonSpeaker {
 positionX = 195 ;
 positionY = 123 ;
 captionY = 0 ;
 captionX = 50 ;
 captionWidth = 325 ;	
}

/* ************************************************************* */

object Plakat {
 setClickArea(66,126,120,212) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Plakat" ;
}

event WalkTo -> Plakat {
 clearAction ;
 Ego:
  walk(31,296) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Plakat {
 clearAction ;	
 Ego:
  walk(31,296) ;
  turn(DIR_NORTH) ;
 suspend ;
  "GESUCHT - Haben Sie dieses Huhn gesehen?"
  // "WANTED - Have you seen this chicken?"
 delay(10) ;
  "In der Tat kommt es mir bekannt vor."
 clearAction ;
}

/* ************************************************************* */

object Muelleimer {
 setClickArea(564,297,624,359) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "M]lltonne" ;
}

event WalkTo -> Muelleimer {
 clearAction ;
 Ego:
  walk(461,355) ;
  turn(DIR_EAST) ;
}

event LookAt -> Muelleimer { 
 Ego:
  walk(461,355) ;
  turn(DIR_EAST) ;
  "Eine alte Blechm]lltonne mit Deckel."	
 if (! Muelleimer.getField(0)) triggerObjectOnObjectEvent(Take, Muelleimer) ;
  else clearAction ;
}

event Open -> Muelleimer {
 triggerObjectOnObjectEvent(Take, Muelleimer) ;
}

event Take -> Muelleimer { 
 Ego:
  if (! Muelleimer.getField(0)) {
   walk(476,356) ;
   pathAutoScale = false ;
   path = 0 ;
   walk(520,395) ;
   turn(DIR_EAST) ;
   "Mal sehen..."
   delay 4 ;
   EgoStartUse ;
   soundBoxStart(Music::Deckelauf_wav) ;
   delay 4 ;
   takeItem(Ego, Shoe) ;
   takeItem(Ego, Shoelace) ;
   Muelleimer.setField(0, 1) ;
   soundBoxStart(Music::Deckelzu_wav) ;
   EgoStopUse ;
   "Neben WIRKLICH unbrauchbarem M]ll war ein alter Schuh samt Schn]rsenkel darin."
   walk(476,356) ;
   path = Vorflughafen_path ;
   pathAutoScale = true ;
  } else {
   walk(461,355) ;
   turn(DIR_EAST) ;   
   "Darin befindet sich nichts Interessantes mehr."
  }
 clearAction ;
}

event default -> Muelleimer {
 Ego: 
  walk(461,355) ;
  turn(DIR_EAST) ; 
 if isClassDerivate(SourceObject, InvObj) {
  "Vielleicht kann ich diesen Gegenstand sp#ter noch gebrauchen..."
 } else triggerDefaultEvents ;
 clearAction ;
}


/* ************************************************************* */

object Taxi {
 setClickArea(0,260,230,360) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Taxi" ;
}

object TaxiSpeaker {
 positionX = 60 ;
 positionY = 240 ;
 captionY = 0 ;
 captionX = 50 ;
 captionWidth = 200 ;	
 captionColor = COLOR_TAXIFAHRER ;
}

event WalkTo -> Taxi {
 clearAction ;
 Ego:
  walk(80,310) ;
  turn(DIR_SOUTH) ; 
}

event Battery -> Taxi {
 clearAction ;
 Ego:
  walk(80,310) ;
  turn(DIR_SOUTH) ;
  say("Das Taxi hat bereits eine Autobatterie.") ;
}

event LookAt -> Taxi {
 clearAction ;
 Ego:
  walk(80,310) ;
  turn(DIR_SOUTH) ; 
  "Ein altmodisches, #gyptisches Taxi." 
  "Der brillentragender Fahrer sitzt darin und liest Zeitung."
}

event Wallet -> Taxi {
 triggerObjectOnObjectEvent(Use, Taxi) ;
}

event Take -> Taxi {
 triggerObjectOnObjectEvent(use, Taxi) ;
}

event Use -> Taxi {
 Ego:
  walk(80,310) ;
  turn(DIR_SOUTH) ;
 if (KnowsExcavation == false and KnowsHeadQuarters == false and KnowsHotel == false) { Ego.say("Ich w]sste nicht, wohin...") ; clearAction ; }
  else {
    static var taxiCredit = false ;
    if (! taxiCredit) {
     Ego:
      "Guten Tag."
     Taxispeaker:
      "Salam aleikum."
     Ego:
      "Nehmen Sie auch Kreditkarten?"
     Taxispeaker:
      "Aywa Effendi."
     Ego:
      "Wunderbar."
     taxiCredit = true ;
    }  
    doEnter(Taxikarte) ;
  }
}

event TalkTo -> Taxi {
 TriggerObjectOnObjectEvent(Use, Taxi) ;
}

event Picklock -> Taxi {
 clearAction ;
 Ego:
  walk(80, 310) ;
  turn(DIR_SOUTH) ;
  say("Der Dietrich w]rde hier nicht passen. Au}erdem sitzt der Fahrer im Auto und die T]ren sind nicht abgeschlossen.") ;
}

/* ************************************************************* */

object TelefonO { // field(0) = 1 -> Julian used shim + shoelace with phone
 if (TelefonO.getField(0)) setupAsStdEventObject(TelefonO,Use,195,265,DIR_NORTH) ; 	
 setClickArea(158,152,203,213) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Telefon" ;
}

event Coins -> TelefonO {
 Ego:
  walk(195,265) ;
  turn(DIR_NORTH) ;	
 if (did(give)) {
  "Ich bezweifle, dass das Telefon die M]nzen wollen w]rde..."
 } else
 if (TelefonO.getField(0)) {
  "Warum, ich kann doch die Unterlegscheibe verwenden..."
 } else {
  egoStartUse ;
  dropItem(Ego, Coins) ;
  soundBoxPlay(Music::Muenze_wav) ;
  EgoStopUse ;   
  delay(5) ;
  start soundBoxStart(Music::Telefon1_wav) ; 
  EgoStartUse ;
  visible = false ;
  JulTele.visible = true ;
  EgoStopUse ;
  UsedTelMoney = 1 ; 
  doEnter(Telefon) ;	 
  return ;
 }
 clearAction ;
}

event WalkTo -> TelefonO {
 clearAction ;
 Ego:
  walk(195,265) ;
  turn(DIR_NORTH) ;	
}

event Wallet -> TelefonO {
 clearAction ;
 Ego:
  walk(195,265) ;
  turn(DIR_NORTH) ;	
  say("In meinem Geldbeutel herrscht g#hnende Leere was M]nzen angeht.") ;
}

event Use -> TelefonO {
 Ego:
  walk(195,265) ;
  turn(DIR_NORTH) ;	
 if (TelefonO.getField(0)) {
  egoStartUse ;
  dropItem(Ego, Shim) ;
  soundBoxPlay(Music::Muenze_wav) ;
  EgoStopUse ;   
  delay(5) ;
   start soundBoxStart(Music::Telefon1_wav) ; 
   EgoStartUse ;
   visible = false ;
   JulTele.visible = true ;
   EgoStopUse ;
  doEnter(Telefon) ;
 } else {
  "Ich brauche Kleingeld zum Telefonieren." 
  clearAction ;
 }
}

event Shim -> TelefonO {
 Ego:
  walk(195,265) ;
  turn(DIR_NORTH) ;
 if (! Shim.getField(0)) {
  switch upcounter(3) {
    case 0: "Ich k[nnte die Unterlegscheibe bestimmt als M]nz-Ersatz missbrauchen..."
            "...aber dann h#tte ich nur ein Mal die M[glichkeit zu telefonieren."  
    case 1: "Wenn ich die Unterlegscheibe jetzt in den M]nzschacht des Telefons werfe..."
            "...h#tte ich keine M[glichkeit mehr, sie zur]ckzubekommen."
	    "M[glicherweise muss ich [fter telefonieren."	    
    case 2: "Dann w#re die Unterlegscheibe weg." 
	    "Vielleicht finde ich einen Weg, wie ich mir die Unterlegscheibe..."
	    "...zur]ckholen kann, nachdem ich sie als M]nze missbraucht habe."
    default: "Ich sollte irgendwie sicherstellen, dass ich die Unterlegscheibe nach dem Telefonieren wieder zur]ckbekomme."	     
	     "Wahrscheinlich muss ich [fter telefonieren."
  } 
  clearAction ; 
 } else
 if (did(use)) {
  if (! TelefonO.getField(0)) {
   "Mal sehen, ob der alte Trick noch klappt..."
   TelefonO.setField(0, 1) ;
   setupAsStdEventObject(TelefonO,Use,195,265,DIR_NORTH) ; 	
  }
  triggerObjectOnObjectEvent(Use, TelefonO) ;  
 } else {
   "Das macht keinen Sinn."
   clearAction ;
 }
}

event LookAt -> TelefonO {
 Ego:
  walk(195,265) ;
  turn(DIR_NORTH) ;
  "Ein M]nztelefon der #lteren Bauart."
  "Man wirft M]nzen hinein, und kann daf]r eine bestimmte Zeit lang telefonieren."
 clearAction ;  
}

/* ************************************************************* */

object Haltestellenschild { // getField(0) = 1 -> Julian saw the shim
 setClickArea(263,133,320,211) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Haltestellenschild" ;
}

event WalkTo -> Haltestellenschild {
 clearAction ;
 Ego:
  walk(340,330) ;
  turn(DIR_SOUTH) ;
}

script sightLineSign(x) { 
 return floatToInt(floatMul(floatDiv(36.0, 51.0), intToFloat(x))) - 125 ;
}

event LookAt -> Haltestellenschild { 
 Ego:
  turn(Ego.findDirection(290-positionX,480-positionY)) ;
  "Ein Haltestellenschild f]r Taxis."	
 if (sightLineSign(positionX) >= 480-positionY) { 
  "Von hier aus kann ich die der Stra}e zugewandte Seite sehen."	 
  if (Unterlegscheibe.getField(0)) {
   "Die verbleibende Schraube erf]llt ihre Funktion ausreichend."
  } else {
   "Eine der Schrauben samt Unterlegscheibe h#ngt locker aus ihrer Fassung."
   Haltestellenschild.setField(0, 1) ;
  }  
 } else {
  "Von hier aus kann ich nur die dem B]rgersteig zugewandte Seite sehen."
 }
 clearAction ;  
}

event Push -> HalteStellenschild {
 triggerObjectOnObjectEvent(Pull, Haltestellenschild) ;
}

event Pull -> HalteStellenschild {
 Ego:
  walk(323,347) ;
  turn(DIR_SOUTH) ; 	 
 if (! Haltestellenschild.getField(0)) {
  "Ich w]sste nicht, wozu." 
 } else {
  if (hasItem(Ego, Shim)) {
   "Ich w]sste nicht, wozu." 	  
  } else {
   pushCnt++ ;
   EgoStartUse ;
   soundBoxPlay(Music::Schild_wav) ;
   EgoStopUse ;
   if (pushCnt == doPushCnt) {
    delay 4 ;
    Unterlegscheibe:
     enabled = false ;     
     setField(0, 1) ;       
    soundBoxPlay(Music::Unterleg_wav) ;
    delay 10 ;
    EgoStartUse ;
    takeItem(Ego, Screw) ;
    takeItem(Ego, Shim) ;  
    EgoStopUse ;
    Ego:
     "Hoppla!"
     "Die Schraube und Unterlegscheibe sind heruntergefallen."
   } else {
    Ego:
    switch(pushCnt) {
     case 1: "Die Schraube hat sich etwas weiter gelockert."
     case 2: "Noch einmal, und die Schraube f#llt herunter."     
    }
   }
  }
 }	
 clearAction ;
}

event Take -> Haltestellenschild { 
 Ego:
  walk(340,330) ;
  turn(DIR_SOUTH) ; 	
 if (! Haltestellenschild.getField(0)) {
  "Ich w]sste nicht, was ich mit dem Schild anfangen soll..."
  clearAction ;
 } else {
  if (hasItem(Ego, Shim)) {
   "Ich w]sste nicht, was ich mit dem Schild anfangen soll..."
  } else {
   "Die Schraube und die Unterlegscheibe k[nnte ich noch gebrauchen."
   "Aber ich komme nicht ran."
  }
  clearAction ;
 }
}

/* ************************************************************* */

object Unterlegscheibe {  // getField(0) = 1 -> Julian took the shim
 setAnim(Unterlegscheibe_sprite) ;
 setPosition(313, 203) ;
 clickable = false ;
 enabled = ! getField(0) ;
 visible = ! getField(0) ;
 priority = PRIORITY_HIGHEST ;
 name = "Unterlegscheibe" ;
}

/* ************************************************************* */

object Pflanze {
 setClickArea(204,170,247,255) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pflanze" ;
}

event WalkTo -> Pflanze {
 clearAction ;
 Ego:
  walk(217,269) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Pflanze {
 clearAction ;
 Ego:
  walk(217,269) ;
  turn(DIR_NORTH) ;  
  "Interessante Gr]nt[ne."
}

/* ************************************************************* */

object Eingang {
 setClickArea(366,100,401,273) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Eingang" ;
}

event WalkTo -> Eingang {
 Ego:
  walk(365,290) ;
  turn(DIR_NORTH) ;
  "Da muss ich jetzt nicht mehr zur]ck."
 clearAction ;
}

event Use -> Eingang {
 TriggerObjectOnObjectEvent(WalkTo, Eingang) ;
}

event Close -> Eingang {
 Ego:
  walk(365,290) ;
  turn(DIR_NORTH) ;
  "Nein."  
 clearAction ;
}

event LookAt -> Eingang {
 clearAction ;
 Ego:
  walk(365,290) ;
  turn(DIR_NORTH) ;
  "Diese T]ren f]hren in den #gyptischen Flughafen."
  if (random(2) == 0) say("Es stinkt dort.") ;
}

/* ************************************************************* */

event TalkTo -> Schlemiel {
 Ego:
  walk(110,312) ; 
  turn(DIR_WEST) ;
 if (currentAct == 2) SD1 ;
  else SD2 ;
 clearAction ;	
} 

script SD1 {
 static var firstphrase = true ;
 static var german = false ;
 static var taunted = false ; 
 static var fooled = false ;
 static var giveInfo = false ;
 static var askedforwonciek = false ;
 static var skeptisch = true ;
 static var askedFire = false ;
 if (goingbusiness) skeptisch = false ;
	   
 if (firstphrase == true) {
  Ego: "Hallo!" 
  Schlemiel: "Seid gegr]sst, Effendi." 
 } else {
  Ego:
  switch random(3) {
   case 0 : "Ich bin's nochmal." 
   case 1 : "Da bin ich nochmal." 
   case 2 : "Da bin ich wieder" 
  } 
 } 
 
 loop {
  Ego:
  AddChoiceEchoEx(1, "Sie sprechen Deutsch?", false) if (german == false) ;
  AddChoiceEchoEx(2, "Was machen Sie hier?", false) unless (fooled) ;
  AddChoiceEchoEx(3, "Kennen Sie zuf#llig einen gewissen Peter Wonciek?", false) unless (askedforwonciek) ;
  AddChoiceEchoEx(3, "Wie war nochmal die Nummer der Auskunft?", false) if (askedforwonciek) ;
  AddChoiceEchoEx(4, "Haben Sie etwas, womit ich verschlossene T]ren aufkriege?", false) if ((NeedPickLock) and (!HasItem(Ego,PickLock))) ;
  AddChoiceEchoEx(5, "Ich h#tte da noch eine T]r, bei der ich Ihre Hilfe ben[tige.", false) if (NeedPickLock2) ;	
  AddChoiceEchoEx(6, "Ich traue der Sache mit den Optionen nicht ganz.", false) unless (!knowsoptions) or (hastruck) or ((!goingbusiness) xor skeptisch);
  AddChoiceEchoEx(7, "Wie haben Sie es geschafft, so ein schlagfertiger Verk#ufer zu werden?", false) unless (goingbusiness != 1) ;
  AddChoiceEchoEx(9, "Haben Sie Feuer?", false) if (NeedPickLock and (!askedFire)) ;
  if (fooled) AddChoiceEchoEx(8, "H[ren Sie auf, mich zu bel#stigen!", false) ;
   else AddChoiceEchoEx(8, "Ich gehe dann wieder.", false) ;
  
  firstphrase = false ; 
 
  var c = dialogEx() ;
 
  switch c {
	  
  case 9 : Ego: "Haben Sie Feuer?"
	   Schlemiel: "Nein, da muss ich Sie entt#uschen."
	   askedFire = true ;
	   
  case 1 : Ego: "Sie sprechen Deutsch?" 
	   Schlemiel: "Verwundert Sie das etwa?"
	   Ego: "Ehrlich gesagt, schon."
	   Schlemiel: "Wissen Sie, in meinem Beruf wird INTERNATIONALIT@T gro} geschrieben."
	   Ego: "Ok. Wie Sie meinen."
	   german = true ;
	   
  case 2 : Ego: "Was machen Sie hier?" ;	  
	   Schlemiel:
	    if (random(3) > 0) say("Ich verkaufe Optionen auf wertvolle Artefakte an beschr#nkte Hohlk[pfe wie Sie.") ;
             else say("Ich verkaufe Optionen auf wertvolle antike Artefakte an Touristen wie Sie.") ;           
	   Ego: "Ich habe noch nie davon geh[rt, dass ein Land seine Kulturg]ter an Touristen verscherbelt..."
	         "...au}er Frankreich vielleicht."
           Ego: "Und was hat es damit auf sich?"            
           Schlemiel: "Optionen, mein verehrter Freund, sind die Zukunft der modernen Tourismusbranche."
                  "Haben Sie nicht genug von diesen kleinen Plastik-Souvenirs oder billigen Ansichtskarten?"
	   Ego: "Nun ja..."
           Schlemiel: "Ich sehe schon, Sie sind ein Mann, Ihnen macht man so leicht nichts vor."
           Ego: "Aber ich wollte doch nur..." ;
           Schlemiel: "...eine wirklich authentische Erinnerung?"
                  "Warum nicht einen echten Steinquader der legend#ren Cheops-Pyramide..."
                  "(nur in limitierter Auflage erh#ltlich)"
                  "...oder ein St]ck des rechten Fusses der Sphinx?"
                  "Sichern Sie sich noch heute das Wunschteil Ihrer favorisierten Sehensw]rdigkeit!"
           Ego: "Aber was hat das mit Optionen zu tun?"
	   Schlemiel: "Reine Formalit#t."
                  "Sobald der Staat den Abbau seiner Kulturg]ter gestattet, bekommen Sie Ihr Wunschteil sofort geliefert."
	   Ego: "Aber warum sollte der Staat so etwas tun?"
	   Schlemiel: "Das lassen Sie mal unsere Sorge sein, um die Formalit#ten brauchen Sie sich nicht zu k]mmern."
	          "Haben Sie die Option in der Tasche, steht das gute St]ck schon so gut wie in Ihrem Wohnzimmer."
	          "Zuf#lligerweise habe ich schon ein Formular vorbereitet."
	          "Wenn Sie dann bitte hier unterschreiben m[chten..."
	   takeItem(Ego, OptionContract) ;
	   delay(4) ;
	   takeItem(Ego, OptionPen) ;
	   Ego: "Aber Sie wissen doch noch garnicht..."
           Schlemiel: "Wie gesagt, um die Formalit#ten k]mmern wir uns."
	          "Hier Ihr individueller Vertrag und ein Stift."
	          "Unterschreiben Sie und bringen Sie mir das Formular dann zur]ck."
	   fooled = true ;
           knowsoptions = true ; 
	   
  case 3: if (askedforwonciek) {
	    Ego:
	     "Wie war nochmal die Nummer der Auskunft?"	    
	    Schlemiel:
	     "Die ersten f]nf Stellen lauten:"
	     delay 10 ;
 	    Schlemiel.SaySlow(TelToStr(TelNums[5],MaxTelLen-1),10) ;
	    Ego:
	     "Danke."
	    
	  } else {
	    askedforwonciek = true ;
  	    Ego: "Kennen Sie zuf#llig einen gewissen Peter Wonciek?"
            Schlemiel: "Wonciek?";
	    Schlemiel: "Nein, definitiv noch nie geh[rt." ;
	    Ego: "H#tten Sie eine Idee, wie man ihn ausfindig machen k[nnte?"
	         "Er wollte sich ein Hotelzimmer in der Umgebung nehmen."
	    Schlemiel: "Sie k[nnten es einmal mit der hiesigen Auskunft versuchen."
	    Ego: "Haben Sie vielleicht auch deren Nummer?"
	    Schlemiel: "Die letzte Zahl wei} ich leider nicht mehr, aber den Rest kann ich Ihnen sagen."
	    delay(50) ;
	    Ego: "Ja?"
	    Schlemiel: "Die ersten f]nf Stellen lauten:"
	     delay 10 ;
	    Schlemiel.SaySlow(TelToStr(TelNums[5],MaxTelLen-1),10) ;
	    giveInfo = true ;
	    Ego: "Danke. Ich komme dann sp#ter wieder." 
	  }
  	    
  case 4: Ego: "Haben Sie etwas, womit ich verschlossene T]ren aufkriege?" ;
	  delay 5 ;
          Schlemiel: "Einen Dietrich?"
	  delay 7 ;
	  Ego: "Ja."
	  delay 5 ;
	  Schlemiel: "Nat]rlich, f]r wen halten Sie mich?"	  
	  delay 7 ;
	  Ego: "Was wollen Sie daf]r?"
	  delay 5 ;
	  Schlemiel: "Nichts, nehmen Sie einen."
	             "Die Qualit#t ist allerdings ziemlich minderwertig."
	  delay 10 ;
	  EgoUse ;
	  takeItem(Ego, Picklock) ;
	  NeedPickLock = false ;
	  delay 10 ;
	  Ego: "Danke sch[n."
	  delay 5 ;
	  Schlemiel: "Das Teil haben Sie nicht von mir."
	  delay 5 ;
	             "Und jetzt verschwinden Sie."
	  clearAction ;
	  return 0 ;
	  
  case 7: Ego: "Wie haben Sie es geschafft, so ein schlagfertiger Verk#ufer zu werden?"  
	  Schlemiel: "Jahrelanges Training und eine gute Ern#hrung."
	  Ego: "Training?"
	  Schlemiel: "Ich habe fr]her am Telefon Staubsauger verkauft."
	             "Kennen Sie einen Kunden, kennen Sie alle."
		     "Immer die gleichen d]mmlichen Fragen, jeden Tag."
	  Ego: "Verstehe."
	       "Haben Sie nicht bedenken, mich als Kunden zu vergraulen, wenn Sie so offen zu mir sind?"
	  Schlemiel: "Sie?"
	             "Gewiss nicht."
	  goingbusiness += 1 ;
	  
  case 8: if (fooled) {	  
	   Ego: "H[ren Sie auf, mich zu bel#stigen!" ;
	   Schlemiel: "Wem sagen Sie das."
          } else {
	   Ego: "Ich gehe dann wieder."
	   Schlemiel: "Sie kommen wieder."
	  }
	  clearAction ;
	  return 0 ;
	    
  case 5: Ego: "Ich h#tte da noch eine T]r, bei der ich Ihre Hilfe ben]tige."
	  delay 5 ;
          Schlemiel: "Tut mir leid."
                     "Ich habe Ihnen meinen letzten Dietrich bereits gegeben."
	  delay 7 ;
	  Ego: "Okay."
          NeedPickLock2 = false ;
	  clearAction ;
	  return 0 ;
	  
 case 6: Ego: "Ich traue der Sache mit den Optionen nicht ganz."
	  Schlemiel: "Was wollen Sie denn damit andeuten?"
                     "Sehe ich etwa so aus, als ob ich Leute ]bers Ohr hauen w]rde?"
		     "Der Handel mit Optionen ist ein anerkanntes, legales Unterfangen."
	  if (!goingbusiness) {
	   Ego: "Das mag wohl sein, allerdings bleiben viele Fragen offen."
	   Schlemiel: "Ach ja? Was wollen Sie denn wissen?"
	   Ego: "Nun ja."
	        "Mir f#llt im Moment keine Frage ein."
	        "Aber dennoch..."
	   Schlemiel: "Dann ist ja alles gekl#rt."
	              "Kommen Sie wieder, wenn Sie das Formular unterschrieben haben."
	  } else {	     

           Ego: "Das mag schon sein, aber..."
	   
	   var old = AskedMasterQuestion ;
           DiaQuest_PickQuestion(Schlemiel) ;	   
	   static var first = false ;
	   
	   if (!first) {
	     Schlemiel: "Denken Sie nochmal dar]ber nach."
			"Optionen sind eine absolut sichere Geldanlage."
		        "Und ich w]rde Sie niemals anl]gen!"
	     first = true ;
	   }
	   
	   if (AskedMasterQuestion != old) {
	    Ego: turn(DIR_SOUTH) ;
	    if (AskedMasterQuestion == 1) {
	     say("Oha.") ;
	     say("Der Truckverk#ufer scheint ein harter Brocken zu sein,...") ;
	     say("...wenn sogar der Fachmann keine ]berzeugenden Antworten liefern kann.") ;	     
	    } else
	    if (AskedMasterQuestion == 2) {
	     say("Ich sollte die schlagfertigen Fragen des Truckverk]ufers ab jetzt lieber f]r mich behalten.") ;
	     say("Der Kerl geht sonst noch an die Decke...") ;
	     say("...und Gegenargumente kann er mir scheinbar nicht liefern.") ;
	     say("Ich muss mir etwas einfallen lassen.") ;     
	    } 	    
	   } 	   
          }
	  skeptisch = false ;
	  clearAction ;
	  return 0 ;	

  }
 } 	
}

script SD2 {
  Ego:
  switch random(3) {
   case 0 : "Ich bin's nochmal." 
   case 1 : "Da bin ich nochmal." 
   case 2 : "Da bin ich wieder" 
  } 

  loop {
   Ego:
    addChoiceEchoEx(1, "Wissen Sie, wie man ein Stahl-Garagentor mit Drehstromantrieb knackt?", false) if ((! hasItem(Ego, Anleitung)) and (knowsSuriza) and (! surizasolved)) ;
    addChoiceEchoEx(2, "Ich habe da jemanden gefunden, der an einer Option interessiert sein k[nnte.", false) if ((julianCaught) and (ladyDistracted != 1)) ;
    addChoiceEchoEx(3, "Haben Sie nicht zuf#llig so etwas wie eine Nasenbrille?", false) if ((not hasItem(Ego, Nasenbrille)) and (sawDrStrangelove)) ;	    
    addChoiceEchoEx(4, "Ich gehe dann mal.", false) ;
  
  
 
    var c = dialogEx() ;
 
    switch c {  
     case 1: 
	    Ego: "Wissen Sie, wie man ein Stahl-Garagentor mit Drehstromantrieb knackt?"
	    Schlemiel: "Nein."	    
	     "Mit solchen illegalen Gesch#ften habe ich nichts am Hut."
     case 2:
	    Ego: "Ich habe da jemanden gefunden, der an einer Option interessiert sein k[nnte."
	    delay 10 ;
	    Schlemiel: "Tats#chlich?"
	    delay 3 ;
	    Ego: "Ja."
	    delay 3 ;
	    Schlemiel: "Geben Sie mir sofort die Telefon-Nummer und ich k]mmere mich gleich darum!"
	    delay 2 ;
	    if (gotLadysNum) {
              Ego.say("Die Nummer lautet...") ;
	      Ego: saySlow(TelToStr(TelNums[6],MaxTelLen), 9) ;
	      delay 4 ;
	      Schlemiel.say("Die Option ist so gut wie verkauft.") ;
              ladyDistracted = 1 ;		    
	    } else {
	      Ego.say("Ich habe die Nummer nicht!") ;
	      delay 3 ;
	      Schlemiel.say("Dann besorgen Sie sie mir schleunigst!") ;
	      Schlemiel.say("Jeder wartende Kunde ist ein potenzieller verlorener Kunde, Sie Genie.") ;
	      delay 3 ;
	      Ego.say("Ich werde sehen, was sich machen l#sst.") ;
	    }
     case 3: 
	    Ego: "Haben Sie nicht zuf#llig so etwas wie eine Nasenbrille?"
	    Schlemiel: "Nein, sind gestern ausgegangen."
	               "Meine n#chste Lieferung kommt erst in ein paar Monaten."
	    Ego: "Wissen Sie, wo ich eine herbekommen k[nnte?"
	    Schlemiel: "Nein."
		       
     case 4:
	    Ego: "Ich gehe dann mal."
	    if (ladyDistracted != 1) {         // maybe julian does not return
	      Schlemiel: "Sie kommen wieder."
            }
	    return 0 ;
    }
  }

}

