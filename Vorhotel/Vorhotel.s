// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
  Peter:
   visible = false ;
   enabled = false ;

  Ego:	
  
  backgroundImage   = vorhotel2_image ;
  backgroundZBuffer = vorhotel_zbuffer ;
  path              = vorhotel_path ;  
  
  if (GuestEvicted != 2) forceShowInventory ; 
	  
  InstallSystemInputHandler(&SystemInput_Handler) ;	
  
  if (! SeenWonciek) {
   SeenWonciek = true ;
   WonciekCutscene ;
   InstallSystemInputHandler(&SystemInput_Handler) ;	
  } else
  
  if (PreviousScene == hotelrezeption) {
    positionX = 520 ;
    positionY = 285 ;  
    face(DIR_SOUTH) ;
    visible = true ;
  } else {
    positionX = 123 ;
    positionY = 293 ;
    face(DIR_EAST) ;
    visible = true ;
    if (previousScene==Leer) {
      delay transitionTime ;
      delay 10 ;
      Ego.say("Was f]r ein Spektakel!") ;
    }
  }
  
  
  if (GuestEvicted == 2) { GuestCutScene ; InstallSystemInputHandler(&SystemInput_Handler) ; }
   else clearAction ;
}

/* ************************************************************* */

script Cutscene_Handler(key) {
  switch key {
    case <ESC>: 
      caption = "" ;
      setObjectExclusive ; 
      
      doEnter(Vorhotel) ;

      
    case <MOUSE1>, <ENTER>, <SPACE>:
      if (suspended) InterruptCaptions ;
        else return false ;
  }
}

script WonciekCutscene {
   InstallSystemInputHandler(&Cutscene_Handler) ;	
   backgroundImage = vorhotel_image ;
   backgroundZBuffer = vorhotel2_zbuffer ;
   forceHideInventory ;
   Taxiani : visible = false ;
   Ego: visible = false ;
   Peter:
    path = 0 ;
    setPosition(520,250) ;
    face(DIR_SOUTH) ;
    delay 50 ;
    start soundBoxPlay(Music::Tuerauf_wav) ;
    delay 5 ;
    Tueroffen.enabled = true ;
    Tuer.name = "Hotelrezeption" ;
    opendoor = true ;
    Peter:
     visible = true ;
     enabled = true ;
    delay 10 ;
     walk(520,285) ;
     turn(DIR_NORTH) ;    
    delay 10 ;
    start soundBoxPlay(Music::Tuerzu_wav) ;
    delay 6 ;
    opendoor = false ;
    Tueroffen.enabled = false ;
    Tuer.name = "Hotelt]r" ;
    delay 10 ;
     turn(DIR_SOUTH) ;
     walk(460,310) ;
     walk(200,300) ;
     turn(DIR_WEST) ;
    delay 20 ;
     turn(DIR_EAST) ;
     enablePeterTalk ;
     "Wo ging es nochmal lang?"
     disablePeterTalk ;
    delay 10 ;
     turn(DIR_EAST) ;
    delay 5 ;
    InstallSystemInputHandler(&SystemInput_Handler) ;	         
     walk(460,310) ;
    
     start {             // Auto herfahren lassen
       start soundBoxPlay(Music::Taxifahren_wav) ;	     
       walk(700,310) ;       
       visible = false ;
       enabled = false ;
     }
    Taxiani:
     setPosition(-159,360+85) ;
     visible = true ;
     walk(0,275) ;
    delay 13 ;
    soundBoxPlay(Music::Aussteigen_wav) ;
    delay 10 ;
    Ego:      
     path = 0 ;
     pathAutoScale = false ;
     scale = 854 ;
     setPosition(-100,300) ;  
     visible = true ;     
     walk(43,278) ;
     path = vorhotel_path ;
     pathAutoScale = true ;
    forceShowInventory ;     
    backgroundImage = vorhotel2_image ;
    backgroundZBuffer = vorhotel_zbuffer ;	
}

script GuestCutscene {
 GuestEvicted = 1 ; 	
 InstallSystemInputHandler(&Cutscene_Handler) ;		
 Ego:	
 start {
  jukeBox_Fadeout(20) ;
  soundBoxPlay(Music::Alarm_wav) ;
  Tuer.PlaySound(Music::Alarm_wav) ; 
  UnMarkResource(Music::Alarm_wav) ;
 }
 delay 30 ;
 turn(DIR_NORTH) ;
 EgoStartUse ;
 delay 10 ;
 start soundBoxPlay(Music::Tuerzu_wav) ;
 delay 6 ; 
 opendoor = false ;
 Tueroffen.visible = false ;
 Tuer.name = "Hotelt]r" ;    
 EgoStopUse ;
 Ego: 
  turn(DIR_SOUTH) ;
  walk(123, 293) ;
  "Hehehe..."
 delay 5 ;
  "Er wird es nicht nochmal wagen, das Hotelzimmer von JULIAN HOBLER zu belegen!"
 delay 25 ;
  
  soundBoxPlay(Music::Sirene_wav) ;
   
 doEnter(leer) ;
}



/* ************************************************************* */

object Taxiani {
 setAnim(Taxi_image) ;
 visible = true ;
 enabled = true ;
 absolute = false ;
 clickable = false ;
 setPosition(0,275) ;
 walkingSpeed = 2 ;
}

object Taxi {
 setClickArea(0,272,164,366); 
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Taxi" ;
}

event WalkTo -> Taxi {
 clearAction ;
 Ego:
  walk(173, 305) ;
  turn(DIR_WEST) ;
} 

event LookAt -> Taxi {
 clearAction ;
 Ego:
  walk(173, 305) ;
  turn(DIR_WEST) ; 
  "Ein #gyptisches Taxi." 
  "Der Fahrer liest Zeitung."
}

event Wallet -> Taxi {
 triggerObjectOnObjectEvent(Use, Taxi) ;
}

event Take -> Taxi {
 triggerObjectOnObjectEvent(Use, Taxi) ;
}

event Battery -> Taxi {
 clearAction ;
 Ego:
  walk(173,305) ;
  turn(DIR_WEST) ;
  say("Das Taxi hat bereits eine Autobatterie.") ;
}

event Use -> Taxi {
 Ego:
  walk(43,278) ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 854 ;
  walk(-100,300) ;  
  pathAutoScale = true ;
 doEnter(Taxikarte) ;
}

event TalkTo -> Taxi {
 TriggerObjectOnObjectEvent(Use, Taxi) ;
}

event Picklock -> Taxi {
 clearAction ;
 Ego:
  walk(173, 305) ;
  turn(DIR_WEST) ;
  say("Der Dietrich w]rde hier nicht passen. Au}erdem sitzt der Fahrer im Auto und die T]ren sind nicht abgeschlossen.") ;
}

/* ************************************************************* */

object Muelleimer {
 setClickArea(206,168,263,260);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "M]lleimer" ;
}

event WalkTo -> Muelleimer {
 clearAction ;
 Ego:
  walk(232, 277) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Muelleimer {
 Ego:
  walk(232, 277) ;
  turn(DIR_NORTH) ;  
  "Ein M]lleimer..." 
  EgoUse ;
  "Er ist leer."
 clearAction ;
}

event Take -> Muelleimer {
 Ego:  
  walk(232, 277) ;
  turn(DIR_NORTH) ;   
  "Ich will keinen M]lleimer mit mir herumtragen." 
  if (HasItem(Ego, Shoe)) say("Ich habe so oder so schon das Gef]hl, dass ich selbst einer bin.") ;
 clearAction ;
}

event Use -> Muelleimer {
 Ego: 
  walk(232, 277) ;
  turn(DIR_NORTH) ;    
  "Was soll ich denn damit anstellen?" ;
 clearAction ;
}

event default -> Muelleimer {
 Ego: 
  walk(232, 277) ;
  turn(DIR_NORTH) ;    	
 if isClassDerivate(SourceObject, InvObj) {
  "Vielleicht brauche ich diesen Gegenstand sp#ter noch..."
 } else triggerDefaultEvents ;
 clearAction ;
}

/* ************************************************************* */

object Telefonzelle {
 setClickArea(32,62,195,251);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Telefonzelle" ;
}

event WalkTo -> Telefonzelle {
 clearAction ;
 Ego: 
  walk(62,266) ;
  turn(DIR_EAST) ;
}

event Shoe -> Telefonzelle {
 Ego: 
  walk(62,266) ;
  turn(DIR_EAST) ;
  "Obwohl ich ein gro}er Fan exzessiver Sachbesch#digung bin..."	
  "...halte ich das f]r keine gute Idee."
 clearAction ;
}


event LookAt -> Telefonzelle {
 Ego: 
  walk(62,266) ;
  turn(DIR_EAST) ;
  "Eine erfreulicherweise gut erhaltene Telefonzelle mit Telefon und Telefonbuch." 
  "Ein Schild weist darauf hin, dass sie au}er Betrieb ist."
 clearAction ;
}

event Open -> Telefonzelle {
 Ego:
  walk(62,266) ;
  turn(DIR_EAST) ;
  delay 2 ;
  EgoUse ;
  delay 2 ;
  "Verschlossen."
 clearAction ;
}

event Use -> Telefonzelle {
  TriggerObjectOnObjectEvent(Open, Telefonzelle) ;
}

/* ************************************************************* */

object Tuer {
 setClickArea(484,90,561,270);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Hotelt]r" ;
 class = StdEventObject ;	 
 StdEvent = Use ;
 SoundVolume = -MASTERVOLUME ;
 SoundPan = PAN_STEREO ; 
}

event Masterkey -> tuer {
 Ego: 
  walk(520,285) ;
  turn(DIR_NORTH) ;  
  if (opendoor) {
   "Die T]r ist ge[ffnet."
  } else {
   "Nein."  
  }
 clearAction ;
}

event LookAt -> tuer {
 Ego: 
  walk(520,285) ;
  turn(DIR_NORTH) ;  
  if (opendoor) {
    "Hier geht es zur Rezeption des Hotels."
  } else {
    "Die T]r die in das Hotel f]hrt." 
    "Sie ist geschlossen."    
  }
  clearAction ;
}

static var opendoor = false ;

event Open -> tuer {
  if (opendoor == false) {
    Ego:
    walk(520,285) ;
    turn(DIR_NORTH) ;
    EgoStartUse ;
    start soundBoxPlay(Music::Tuerauf_wav) ;
    Tueroffen.enabled = true ;
    Tuer.name = "Hotelrezeption" ;
    opendoor = true ;
    EgoStopUse ;
  } else {
    Ego:
    "Sie ist schon offen."
  }
  clearAction ;
}

event Close -> tuer {
  if (opendoor == true) {
   Ego:    
    walk(520,285) ;
    turn(DIR_NORTH) ;
    EgoStartUse ;
    start soundBoxPlay(Music::Tuerzu_wav) ;
    delay 6 ;
    opendoor = false ;
    Tueroffen.enabled = false ;
    Tuer.name = "Hotelt]r" ;    
    EgoStopUse ;
  } else {
    Ego:
    "Sie ist schon geschlossen."
  }
  if (GuestEvicted != 2) clearAction ;
}

event Use -> tuer {
  if (opendoor == true)
   TriggerObjectOnObjectEvent(close, tuer) ;
  else
   TriggerObjectOnObjectEvent(open, tuer) ;
}

event WalkTo -> tuer {
 clearAction ;
 Ego:
  walk(520,285) ;
  turn(DIR_NORTH) ;
 if (opendoor) doEnter(hotelrezeption) ;
}

event Picklock -> Tuer {
 clearAction ;
 Ego:
  walk(520, 285) ;
  turn(DIR_NORTH) ;
  say("Diese T]r ist nicht abgeschlossen.") ;
}

/* ************************************************************* */

object Tueroffen {
 setPosition(462,102) ;
 setAnim(tueroffen_image) ;
 absolute = false ;
 clickable = false ;
 enabled = opendoor ;
 visible = true ;
}

/* ************************************************************* */

object Zigarettenautomat {
 setClickArea(273,106,375,198);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Zigarettenautomat" ;
}

event WalkTo -> Zigarettenautomat {
 clearAction ;
 Ego:
  walk(300,281) ;
  turn(DIR_NORTH) ;
}

event Wallet -> Zigarettenautomat {
 clearAction ;
 Ego:
  walk(300,281) ;
  turn(DIR_NORTH) ;	
  say("In meinem Geldbeutel herrscht g#hnende Leere was M]nzen angeht.") ;
}


event LookAt -> Zigarettenautomat {
 Ego:
  walk(300,281) ;
  turn(DIR_NORTH) ;
  "Der Zigarettenautomat ist an der Wand des Hotels befestigt."
  switch upcounter(1) { 
   case 0:  "Es liegt keine M]nze im Schacht."              
   case 1:  "Es liegt immernoch keine M]nze im Schacht." 
  }
 clearAction ;  
}

event Open -> zigarettenautomat {
  Ego:
   walk(300,281) ;
   turn(DIR_NORTH) ;
  delay(20) ;
   "Abgeschlossen."
  clearAction ;
}

event Shim -> Zigarettenautomat {
 Ego:
  walk(300,281) ;
  turn(DIR_NORTH) ; 
  "Die Unterlegscheibe ist zu dick f]r den Automaten."
 clearAction ;
}

event Use -> Zigarettenautomat {
	
 if (HasItem(Ego, Coins)) {
   Ego:
    walk(300,281) ;
    turn(DIR_NORTH) ;
   EgoStartUse ;
   delay 10 ;
   dropItem(Ego, Coins) ;
   soundBoxPlay(Music::Muenze_wav) ;   
   EgoStopUse ;
   delay 3 ;
   EgoStartUse ;   
   soundBoxStart(Music::Pushcig_wav) ;   
   delay 5 ;
   takeItem(Ego, Cigarettes) ;
   EgoStopUse ;
   Ego:
    turn(DIR_SOUTH) ;
   clearAction ;
 } else {
   clearAction ;	
   Ego: 
    walk(300,281) ;
    turn(DIR_NORTH) ;   
    "Ich rauche nicht."
    "Rauchen gef#hrdet die Gesundheit."
 }
}

event Coins -> Zigarettenautomat {
 if (Did(Give)) Ego.say("Ich versuche es besser mit BENUTZE...") ;
 TriggerObjectOnObjectEvent(Use, Zigarettenautomat) ;
}

/* ************************************************************* */

object Rose {
 setClickArea(274,96,318,107);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Rose" ;
}

event WalkTo -> Rose {
 clearAction ;
 Ego:
  walk(290,280) ;
  turn(DIR_NORTH) ; 
}

event LookAt -> Rose {
 Ego:
  walk(290,280) ;
  turn(DIR_NORTH) ; 
  "Hier hat wohl jemand seine Rose auf dem Zigarettenautomat..." 
  "...abgelegt, und sie danach vergessen."
 clearAction ;
}

event Take -> Rose {
 Ego: 
  walk(290,280) ;
  turn(DIR_NORTH) ;  
  "Nicht meine Farbe."
  clearAction ;
}

/* ************************************************************* */

object Preisliste {
 setClickArea(397,118,448,174);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Preisliste des Hotels" ;
}

event WalkTo -> Preisliste {
 clearAction ;
 Ego:
  walk(422,285) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Preisliste {
 Ego:
  walk(422,285) ;	      
  turn(DIR_NORTH) ;
 delay 33 ;
  "Ein Zimmer kostet 45 Pfund die Nacht." 
 clearAction ;
}

event Take -> Preisliste {
 Ego:
  walk(422,285) ;
  turn(DIR_NORTH) ; 
  "Ich glaube damit w#re der Hotelbesitzer nicht einverstanden." 
 clearAction ;
}


