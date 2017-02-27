// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var firstRiddleSolved = false ;

event enter {
	
 interruptCaptions ;
 
 John.enabled = false ;
 John.priority = PRIORITY_AUTO ;
 Jack.enabled = false ;
 if ((BunsenStage == 2) and (lastRiddle != RIDDLE_PARADOX)) BunsenStage = 3 ;
	
 Ego:
 enableEgoTalk ;
  enabled = true ;
  visible = true ;
  lightmap = Lightmap_image ;
  lightmapAutoFilter = true ;    
  path = 0 ;
 forceShowInventory ;
 backgroundImage = Securitylab1_image ;
 backgroundZBuffer = Securitylab1_zbuffer ;
 
 if ((chaseStage == 2) and (previousScene == Securitylab2)) {
  John:
   enabled = true ;
   visible = true ;
   setPosition(769,217) ;
   face(DIR_NORTH) ;
   path = Securitylab1j_path ;
   pathAutoScale = true ;
   scale = 773 ;
   priority = 252 ;
 }

 if (previousScene == Securitygang || previousScene == Chefbuero) {
  if (previousScene == Chefbuero) nextScene = 0 ;
  interruptCaptions ;
  scrollX = 725 ;
  Ego:
   pathAutoScale = false ;
   visible = false ;
   setPosition(1071,86) ;
   face(DIR_SOUTH) ;
   scale = 705 ;
  EgoUse ;
  delay 10 ;
  soundBoxStart(Music::Tuerauf2_wav) ;
  Tuergangoffen.enabled = true ;
  visible = true ;
  EgoStopUse ;
  delay 2 ;
   walk(1072,113) ;
   turn(DIR_NORTH) ;
  EgoStartUse ;
  soundBoxStart(Music::Tuerzu4_wav) ;
  Tuergangoffen.enabled = false ;
  EgoStopUse ;
  turn(DIR_SOUTH) ;
  pathAutoScale = true ;
 } else if (previousScene == Securitylab2) {
  scrollX = 470 ;
  Glastuerzu.enabled = true ;
  Ego:
   setPosition(790,138) ;
   pathAutoScale = false ;
   scale = 817 ;
   face(DIR_SOUTH) ;
  delay 5 ;
  EgoStartUse ;
  soundBoxStart(Music::Glasauf_wav) ;
  Glastuerzu.enabled = false ;
  Glastueroffen.enabled = true ;
  delay 2 ;
  EgoStopUse ;
  delay 4 ;
   walk(745,180) ;
   turn(DIR_NORTH) ;
  delay 10 ;
  EgoStartUse ;
  soundBoxStart(Music::Glaszu_wav) ;
  Glastuerzu.enabled = true ;
  Glastueroffen.enabled = false ;
  delay 2 ;
  EgoStopUse ;
   turn(DIR_SOUTH) ;
  delay 3 ;
   pathAutoScale = true ;  
   path = Securitylab1_path ;
  if (chaseStage == 2) {
    hideInventory ;
    delay 7 ;
    catchSecMusic ;
    John:
     "Hab ich Sie!"
     priority = PRIORITY_AUTO ;
    delay 7 ;
    lightmap = 0 ;
    lightmapAutoFilter = false ;  
    doEnter(Securitygef) ;
    finish ;
  }
 } else {  // Julian war am Zentralrechner
  
  if (!wagenMoved) path = Securitylab1_path ;
   else path = Securitylab1m_path ;	 
  setPosition(234,277) ;
  face(DIR_SOUTH) ;
  
  delay transitionTime ;
  
  if ((FaxGra.getField(0) > 0) and (printCutscene)) {
    printCutscene = false ;
    if (FaxGra.getField(0)==1) {
      delay 25 ;
      Ego:
       turn(DIR_WEST) ;
      delay 3 ;
       "Es fehlt Papier."
    } else
    if (FaxGra.getField(0)==2) {
      delay 25 ;
      Ego:
       turn(DIR_WEST) ;
      delay 3 ;
      pujaTipp2 ;
      delay 3 ;
       "Das normale Papier nehme ich wieder mit."
      EgoStartUse ;
      takeItem(Ego, Faxpapier) ;
      FaxGra.frame = 0 ;
      FaxGra.setField(0,1) ;
      EgoStopUse ;
    } else
    if (FaxGra.getField(0)==3) {
      jukeBox_Stop ;	    
      soundBoxStart(Music::Drucken_wav) ;
      ZFrame.frame = 1 ;
      delay 25 ;
      Ego:
       "Die Dokumente werden gedruckt."
       delay 3 ;
       "Endlich."
       delay 20 ;
       firstAgentCutscene ;
    }
    
  }
	  
 }
 
 if (!wagenMoved) path = Securitylab1_path ;
   else path = Securitylab1m_path ;

 // small cutscene after Bunsen solved the first riddle

 if ((BunsenStage == 3) and (firstRiddleSolved == false)) {
   delay 10 ;
   disableScrolling ;
   turn(DIR_WEST) ;
   while (scrollX > 0) {
     scrollX -= 7 ;
     delay 1 ;
   }
   delay 10 ;
   var toX = 470 ;
   if (previousScene == Securitygang) toX = 725 ; 
   while (scrollX < toX) {
     scrollX += 7 ;
     delay 1 ;
   }
   enableScrolling ;
   if (previousScene == Securitylab2) say("Wie macht er das nur?") ;
   suspend ;
   triggerObjectOnObjectEvent(TalkTo, Bunsen) ;
   firstRiddleSolved = true ;
 }

 if (chaseStage == 2) start countDown ; 
 if (chaseStage == 2) start checkPlayerPos ;
 if (Bunsen.enabled) start bunsenSound ;
	 
 clearAction ;
}

/* ************************************************************* */

// cutscene: after Julian locked Jackson in security lab 2:
//           he takes incriminating printout, leaves sec lab 1,
//           gets knocked down by Johnson and locked in the
//           prison, room 2.

object ausdruckDraw { enabled = false ; }

static var alph = 0 ;

event paint ausdruckDraw {
 drawingPriority = 255 ;
 drawingColor = RGBA(255,255,255,255) ;
 drawImage(0,0,Graphics::AusdruckBig1_image) ;
 drawingColor = RGBA(255,255,255,alph) ;
 drawImage(0,0,Graphics::AusdruckBig2_image) ;	
}

script endingCutScene {
 Ego:
  walk(234,277) ;
  turn(DIR_WEST) ;  
 delay 10 ;
 EgoStartUse ;
  FaxGra.frame = 0 ;
  FaxGra.setField(0,1) ;
  takeItem(Ego, Ausdruck) ;
  
 jukeBox_fadeOut(10) ;
 
 backgroundZBuffer = 0 ;
 ausdruckDraw.enabled = true ;
 darkbar.enabled = false ;

 for (alph=0;alph<255;alph+=5) { delay 1 ; }
 delay 23 ;
 Ego.say("Das lese ich mir sp#ter in Ruhe durch.") ;
 Ego.say("Es sollte Peter endg]ltig ]berzeugen.") ;
 
 darkbar.enabled = true ;
 ausdruckDraw.enabled = false ;
 
 backgroundZBuffer = Securitylab1_zbuffer ;
 delay 10 ;
 //EgoStopUse ;
 Ego:
  turn(DIR_SOUTH) ;
  delay 3 ;
  "Jetzt aber nichts wie weg hier!"
  delay 4 ;

 // leave room

 Ego:
  walk(698,272) ;
 start { John.captionY = -50 ; John.captionX = 50 ; John.captionWidth = 200 ; John.say("Sie kommen nicht weit, Sie Narr!") ; }
 delay 2 ;
 Ego.turn(DIR_NORTH) ;
 delay until (John.animMode == ANIM_STOP) ;
 delay 3 ;
 Ego.say("Das sagt ja gerade der richtige...") ;
 Ego.say("Wie f]hlt es sich an, eingesperrt zu sein?") ;
 Ego.say("Das sollte Ihnen eine Lehre sein.") ;
 delay 3 ;
 Ego.say("Bedanken Sie sich bei mir.") ;
 delay ;
 John.say("Das reicht jetzt.") ;
 delay ;
 Ego.say("Schon gut.") ;
 
  walk(1072,113) ;
  turn(DIR_NORTH) ;
 EgoStartUse ;
 soundBoxStart(Music::Tuerauf2_wav) ;
 TuergangOffen.enabled = true ;
 EgoStopUse ;
  scale = 705 ;
  pathAutoScale = false ;
  path = 0 ;
  walk(1071,86) ;
 delay 2 ;
  turn(DIR_SOUTH) ;
  EgoStartUse ;
  visible = false ;
 soundBoxStart(Music::Tuerzu4_wav) ;  
 Tuergangoffen.enabled = false ;
 delay 3 ;
 Ego: 
  visible = true ;
  pathAutoScale = true ;
  lightmap = 0 ;
  lightmapAutoFilter = false ;  
 doEnter(Securitygang) ;   
}

/* ************************************************************* */

var egoTrapped = false ;
var reachedPoint = false ;

script checkPlayerPos {
	
  while (!wagenMoved) {
   delay ;
   if (Ego.positionX < 470) {
     Ego:
     suspend ;
     killEvents(123654) ;     
     forceHideInventory ;
      stop ;
      interruptCaptions ;
     delay 10 ;
     turn(DIR_EAST) ;
     delay 10 ;
     if (secLab2Locked) {
       John:
       if (!johnLooks) {
          setPosition(833,85) ;
          path = 0 ;
          pathAutoScale = false ;
          scale = 650 ;
          face(DIR_SOUTH) ;  
          enabled = true ;   
          visible = true ;
          walk(790,138) ;
          face(DIR_SOUTH) ;
       }
       delay 10 ;
       soundBoxStart(Music::Glasauf_wav) ;
       Glastuerzu.enabled = false ;
       Glastueroffen.enabled = true ; 
       reachedPoint = false ;
	
	start {
	 while (! reachedPoint) {
	   John.scale += 9 ;
	   delay ;
         }
	}
	
	 walk(722,239) ;     
	reachedPoint = true ;
	 turn(DIR_WEST) ;
	John.path = Securitylab1j_path ;
	John.pathAutoScale = true ;
        delay 13 ;
        Ego.say("Verdammt.") ;
        delay 2 ;
        Ego.say("Sackgasse.") ;
        John.walk(586,240) ;	
     } else {
       John:
        path = Securitylab1j_path ;
        pathAutoScale = true ;
        visible = true ;
        enabled = true ;
        setPosition(870,247) ;
        face(DIR_WEST) ;
       delay 13 ;
       Ego.say("Verdammt.") ;
       delay 2 ;
       Ego.say("Sackgasse.") ;
       John.walk(586,240) ;
     }
     delay 23 ;
     catchSecMusic ;
     
     John.say("Hab ich Sie!") ;
     delay 7 ;
     Ego:
      lightmap = 0 ;
      lightmapAutoFilter = false ;  
     doEnter(Securitygef) ;     
     finish ;
   }
  }
}

/* ************************************************************* */

static var JohnLooks = false ;

script countDown {
  eventGroup = 123654 ;
  JohnLooks = false ;
  
  if (secLab2Locked) {
    delay 180 ;
    delay (upcounter(5) * 15) ; // PUJA
    return if egoTrapped ;
    John:
     setPosition(833,85) ;
     path = 0 ;
     pathAutoScale = false ;
     scale = 650 ;
     face(DIR_SOUTH) ;  
     enabled = true ;   
     visible = true ;
     JohnLooks = true ;
     walk(790,138) ;
     face(DIR_SOUTH) ;    
    return if egoTrapped ;     
    delay 100 ;
    return if wagenMoved ;
    return if egoTrapped ;
    suspend ;    
    forceHideInventory ;
    soundBoxStart(Music::Glasauf_wav) ;
    Glastuerzu.enabled = false ;
    Glastueroffen.enabled = true ; 
    John.captionY = 0 ;
    catchSecMusic ;
    return if wagenMoved ;
    John.say("Hab ich Sie!") ;
    John.captionY = -150 ;
    delay 7 ;
    Ego:
     lightmap = 0 ;
     lightmapAutoFilter = false ;  
    return if wagenMoved ;
    doEnter(Securitygef) ;
    finish ;
  } else {    
    delay 180 ;
    delay (upcounter(5) * 15) ; // PUJA
    return if egoTrapped ;
    Ego.stop ;
    suspend ;
    forceHideInventory ;
    John:
     path = 0 ;
     pathAutoScale = false ;
     visible = false ;
     enabled = true ;
     setPosition(1071,86) ;
     face(DIR_SOUTH) ;
     scale = 600 ;     
    delay 10 ;
     soundBoxStart(Music::Tuerauf2_wav) ;
     Tuergangoffen.enabled = true ;
     visible = true ;
    delay 2 ;
    if ((Ego.positionX <= 983) and (Ego.positionX > 480)) Ego.turn(DIR_EAST) ;
    John:
     walk(1072,113) ;
     soundBoxStart(Music::Tuerzu4_wav) ;
     Tuergangoffen.enabled = false ;
     pathAutoScale = true ;
     //priority = 252 ;
     path = Securitylab1j_path ;  
     delay 12 ;
     walk(1072,217) ; 
     turn(DIR_WEST) ;
    if (Ego.positionX > 983) { // catch
      catchSecMusic ;
	    
      John.say("Hab ich Sie!") ;
      delay 7 ;
      Ego:
       lightmap = 0 ;
       lightmapAutoFilter = false ;  
      John.priority = PRIORITY_AUTO ;
      doEnter(Securitygef) ;
      finish ;
    } else if ((Ego.positionX <= 983) and (Ego.positionX > 480)) { // escape automatically
      Ego:
       walk(745,180) ;
       turn(DIR_NORTH) ;

       John:
        walk(830,230) ;
        priority = 252 ;       
      start {
        
        turn(DIR_NORTH) ;
        say("Bleiben Sie stehen!") ;
	John.priority = PRIORITY_AUTO ;
      }      
      
      triggerObjectOnObjectEvent(Open, Tuerlab2) ;
      
    } else if (Ego.positionX <= 480) { // catch
      John:
       walk(528, 234) ;
      Ego:
       turn(DIR_EAST) ;
       delay 10 ;
      catchSecMusic ;
       
      John.say("Hab ich Sie!") ;
      delay 7 ;
      Ego:
       lightmap = 0 ;
       lightmapAutoFilter = false ;        
      John.priority = PRIORITY_AUTO ;	    
      doEnter(Securitygef) ;
      finish ;      
    }
  }
}

script countDown2 {
 if (not JohnLooks) {
   John:
    priority = PRIORITY_AUTO ;
    setPosition(833,85) ;
    path = 0 ;
    pathAutoScale = false ;
    scale = 650 ;
    face(DIR_SOUTH) ;  
    enabled = true ;   
    visible = true ;
    walk(790,138) ;
    face(DIR_SOUTH) ;
    JohnLooks = true ;	 
 }
	
 eventGroup = 123654 ;
 
 delay 70 ;
 delay (upcounter(5) * 9) ; // PUJA
 suspend ;
 delay 7 ;
 hideInventory ;
 soundBoxStart(Music::Glasauf_wav) ;
 Glastuerzu.enabled = false ;
 Glastueroffen.enabled = true ; 
 John.captionY = 0 ;
 catchSecMusic ;
 John.say("Hab ich Sie!") ;
 John.captionY = -150 ; 
 delay 7 ;
 Ego:
  lightmap = 0 ;
  lightmapAutoFilter = false ;   
 doEnter(Securitygef) ;
 finish ;
}

/* ************************************************************* */

script firstAgentCutscene {
 suspend ;
 forceHideInventory ;
 disableScrolling ;
 Ego:
 turn(DIR_EAST) ;
 while (scrollX < 725) {
   scrollX += 25 ;
   delay 1 ;
 }
 delay 10 ;
 John:
  path = 0 ;
  pathAutoScale = false ;
  visible = false ;
  enabled = true ;
  setPosition(1071,86) ;
  face(DIR_SOUTH) ;
  scale = 600 ;
 delay 10 ;
 start { Tuergangoffen.playSound(Music::Tuerauf2_wav) ; }
  Tuergangoffen.enabled = true ;
  visible = true ;
 delay 2 ;
  walk(1072,113) ;
 start { Tuergangoffen.playSound(Music::Tuerzu4_wav) ;  }
  Tuergangoffen.enabled = false ;
  pathAutoScale = true ;
  path = Securitylab1j_path ;  
  delay 12 ;
  walk(1072,217) ;   
  delay 1 ;
  turn(DIR_WEST) ;
  delay 7 ;
  "So sieht man sich wieder, Herr Hobler."
 John.priority = PRIORITY_AUTO ;
  delay 17 ;
 enableScrolling ;  
 
 start {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Rounddrums_mp3) ;       
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;	     
 }  
 
 Ego:
  "Oha!"
 
 walk(745,180) ;
 turn(DIR_NORTH) ;
 John:
   
 John.walk(830,230) ;
 John.priority = 252 ;
 
 start {
   John.turn(DIR_NORTH) ;
   John.say("Das f]hrt doch zu nichts!") ;
   John.priority = PRIORITY_AUTO ; 
 }
 
 chaseStage = 1 ; 
 triggerObjectOnObjectEvent(Open, Tuerlab2) ;
 
}

/* ************************************************************* */

script bunsenSound {
 killOnExit = true ;
 start setBunsenVolume ;
 
 //Bunsen.SoundPan = PAN_LEFT ;
 loop {
  return if (!Bunsen.enabled) ;
  Bunsen.playSound(Music::Bunsentippt_wav) ;
  delay ;
 }
}

script setBunsenVolume {
 killOnExit = true ;
 var dist = 0 ;
 var vol = 0 ;
 
 loop {
   delay 1 ;
   dist = findDistance(245,266,Ego.positionX, Ego.positionY) ;
   dist /= 3 ;
   vol = VOLUME_FULL - dist ;
   if (vol < 0) vol = 0 ;
   Bunsen.soundVolume = vol ;
 }
}

/* ************************************************************* */

object HammerR {
 setupAsStdEventObject(HammerR,LookAt,1182,180,DIR_EAST) ; 				
 setPosition(1229,21) ;
 setClickArea(0,0,44,28) ;
 setAnim(Hammer_image) ;
 absolute = false ;
 enabled = (not hasItem(Ego, Hammer)) ;
 visible = true ;
 clickable = true ;
 name = "Hammer" ; 
}

event Take -> HammerR {
 Ego:
  walkToStdEventObject(HammerR) ;
 suspend ;
 EgoStartUse ;
  takeItem(Ego, Hammer) ;
 HammerR.enabled = false ;
 EgoStopUse ;
 clearAction ;
}

event LookAt -> HammerR {
 Ego:
  walkToStdEventObject(HammerR) ;
  "Hier liegt ein robuster Eisenhammer auf dem Regalbrett."
}

event Use -> HammerR {
 Ego:
  walkToStdEventObject(HammerR) ;
  "Dazu sollte ich ihn erstmal in die Hand nehmen."
}

event TalkTo -> HammerR {
 Ego:
  walkToStdEventObject(HammerR) ;
 suspend ;
  say("Hallo?") ; 
  say("Kannst Du mich verstehen?") ;
 delay 10 ;
 clearAction ;
}

/* ************************************************************* */

object Keil {
 setupAsStdEventObject(Keil,LookAt,883,293,DIR_SOUTH) ; 					
 setPosition(909,317) ;
 setAnim(Keil_image) ;
 setClickArea(0,0,18,18) ;
 visible = true ;
 enabled = (not getField(0)) ;
 absolute = false ;
 clickable = true ; 
 name = "Keil" ;
 priority = 251 ;
}

event LookAt -> Keil {
 Ego:
  walkToStdEventObject(Keil) ;
  "Mit diesem Keil wurde der Wagen vor dem Wegrollen gesichert."
}

event Screwdriver -> Keil {
 Ego:
  walkToStdEventObjectNoResume(Keil) ;
 if (did(give)) {
   say("Ich bezweifle, dass der Keil den Schraubenzieher haben m[chte.") ;
   clearAction ;
   return ;
 }
 if (chaseStage != 2) {
   Ego.say("Lieber nicht.") ;
   Ego.say("Vielleicht f#ngt der Wagen an zu rollen.") ;
   clearAction ;
   return ;
 } else {
   if (not secLab2Locked) {
     Ego.say("Lieber nicht.") ;
     Ego.say("Nacher versperrt mir der Wagen noch meine einzige Fluchtm[glichkeit.") ;
     clearAction ;
     return ;
   }
 }
 suspend ;
 EgoUse ;
 delay 2 ;
  say("Der Keil sitzt zu fest.") ;
  say("Ich brauche ein Werkzeug mit mehr Wucht!") ;
 clearAction ;
}

event Hammer -> Keil {
 Ego:
  walkToStdEventObjectNoResume(Keil) ;
 if (did(give)) {
   say("Ich bezweifle, dass der Keil den Hammer haben m[chte.") ;
   clearAction ;
   return ;
 }  
 if (chaseStage != 2) {
   Ego.say("Lieber nicht.") ;
   Ego.say("Vielleicht f#ngt der Wagen an zu rollen.") ;
   clearAction ;
   return ;
 } else {
   if (not secLab2Locked) {
     Ego.say("Lieber nicht.") ;
     Ego.say("Nacher versperrt mir der Wagen noch meine einzige Fluchtm[glichkeit.") ;
     clearAction ;
     return ;
   }
 }
 suspend ;
 killEvents(123654) ;
 EgoStartUse ;
 soundBoxStart(Music::Keil_wav) ;
 Keil.setField(0, true) ;
 Keil.enabled = false ;
 EgoStopUse ;
 if (JohnLooks) start { John.captionY = -50 ; John.captionWidth = 150 ; John.say("Das wird Ihnen auch nicht weiterhelfen Herr Hobler!") ; John.captionY = -150 ; }
 start countDown2 ;
 clearAction ;
}

event Pull -> Keil {
 triggerObjectOnObjectEvent(Push, Keil) ;
}

event Push -> Keil {
 Ego:
  walkToStdEventObject(Keil) ;
 suspend ;
 EgoUse ;
 Ego.say("Er klemmt fest!") ;
 Ego.say("Mit blo}en H#nden bekomme ich ihn nicht raus.") ;
 clearAction ;
}

event Take -> Keil {
 triggerObjectOnObjectEvent(Push, Keil) ;
}

/* ************************************************************* */

object Bombenwagen {  
 if (wagenMoved) {
   setPosition(670,30) ;
   priority = 22 ;
   scale = 1000 - 260 ;
   setClickArea(49,47,134,158) ;
 } else { 
   setupAsStdEventObject(Bombenwagen,LookAt,883,293,DIR_SOUTH) ; 						 
   setPosition(876,107) ;
   priority = 250 ;
   scale = 1000 ;
   setClickArea(66,63,181+72,213+38) ;
 }
 setAnim(Bombenwagen_image) ;
 absolute = false ;
 visible = true ;
 enabled = true ;
 name = "Wagen" ;
 pathAutoScale = false ; 
}

event LookAt -> Bombenwagen {
 Ego:
  walkToStdEventObject(Bombenwagen) ;
 suspend ;
  "Auf diesem Wagen ist mit zwei B#ndern etwas befestigt, was einer Bombe sehr #hnlich sieht."
  if (Keil.enabled) say("Mit einem Keil ist er vor dem Wegrollen gesichert.") ;
 clearAction ;
}

event Use -> Bombenwagen {
 Ego:
  walkToStdEventObject(Bombenwagen) ;
  "Ich w]sste nicht, wie."	
}

script moveBombenwagen {
 if (wagenMoved) return 0 ;
 if (Keil.enabled) return 1 ;	
 forceHideInventory ;
 wagenMoved = true ;
 killEvents(123654) ;	  
 Ego:
  walk(1140,263) ;	
 Ego:
  walk(1140,263) ;
  pathAutoScale = false ;
  path = 0 ;
  scale = 947 ;
  walk(1105,300) ;
  turn(DIR_WEST) ;
 if (JohnLooks) start { John.captionY = -50 ; John.captionX = 50 ; John.captionWidth = 150 ; John.say("Sie sollten sich das gut ]berlegen!") ; John.captionX = 0 ; John.captionWidth = 0 ; John.captionY = -150 ; }  
 EgoStartUse ;
 soundBoxStart(Music::Bomberollt_wav) ;
 start { Bombenwagen.walk(670,30) ; soundBoxStart(Music::Bombestoppt_wav) ; }
 for (var cnt=0; cnt <= 25 ; cnt++) { delay ; Bombenwagen.scale = Bombenwagen.scale - 10 ;  }
 EgoStopUse ;
  walk(1067,286) ;
  turn(DIR_WEST) ;
  pathAutoScale = true ; 
  path = Securitylab1m_path ;
 Bombenwagen.priority = 22 ;
 Bombenwagen.clickable = false ; 
 FaxGra.frame = 3 ;
 ZFrame.frame = 1 ;
 Ego.say("Das sollte mir etwas Zeit verschaffen.") ;
 delay 3 ; 
 Ego.walk(937,265) ; 
 Ego.walk(718,270) ;
 Ego.walk(234,277) ; 
 turn(DIR_WEST) ;
 
 endingCutScene ;
 
 return 0 ;
}
 
event Pull -> Bombenwagen {
 triggerObjectOnObjectEvent(Push, Bombenwagen) ;
}	
 
event Push -> Bombenwagen {
  if (moveBombenwagen == 1) {
   Ego:
    walk(1140,263) ;
    pathAutoScale = false ;
    path = 0 ;
    scale = 947 ;
    walk(1105,300) ;
    turn(DIR_WEST) ;
    EgoUse ;
    say("Er klemmt!") ;
    walk(1067,263) ;
    turn(DIR_WEST) ;
    pathAutoScale = true ;
    path = Securitylab1_path ;
  }
  clearAction ;
}

/* ************************************************************* */

object Plakat {
 setupAsStdEventObject(Plakat,LookAt,846,191,DIR_NORTH) ; 
 setClickArea(816,24,889,118) ;
 absolute = false ;
 clickable = true ;
 enabled = (!wagenMoved) ;
 visible = false ;
 name = "Plakat" ;
}

event LookAt -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
  "Dieses Plakat illustriert die Funktionsweise eines Fadenstrahlrohrs."
}

event Take -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
  "Ich m[chte es nicht."
}

event Pull -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
  "Ich m[chte es nicht herunterrei}en."
}

event Push -> Plakat {
 Ego:
  walkToStdEventObject(Plakat) ;
 suspend ;
 EgoUse ;
 delay 3 ;
  say("Wie zu erwarten war, ist nichts passiert.") ; 
 clearAction ;
}

/* ************************************************************* */

object TuergangOffen {   
 setPosition(1041,0) ;
 priority = 3 ;
 setAnim(Gangtuer_image) ;
 visible = true ;
 enabled = false ; 
 clickable = false ;
 absolute = false ;
}

object Tuergang {
 setupAsStdEventObject(Tuergang,Open,1072,113,DIR_NORTH) ; 			
 setClickArea(1043,1,1105,98) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event LookAt -> Tuergang {
 Ego:
  walkToStdEventObject(Tuergang) ;
  "Diese T]r f]hrt wieder auf den Gang."
}

event Close -> Tuergang {
 Ego:
  walkToStdEventObject(Tuergang) ;
  "Die T]r ist schon geschlossen."
}

event Use -> Tuergang {
 triggerObjectOnObjectEvent(Open, Tuergang) ;
}

event Hotelkey -> Tuergang {
 triggerObjectOnObjectEvent(Lab2Key, Tuergang) ;
}

event Lab2Key -> Tuergang {
 Ego:
  walkToStdEventObject(Tuergang) ;
 suspend ;
 EgoUse ;
 Ego.say("Der Schl]ssel passt hier nicht.") ;
 clearAction ;
}

event Open -> Tuergang {
 Ego:
  walkToStdEventObject(Tuergang) ;
 killEvents(123654) ;
 suspend ;
  turn(DIR_NORTH) ;
 EgoStartUse ;
 soundBoxStart(Music::Tuerauf2_wav) ;
 TuergangOffen.enabled = true ;
 EgoStopUse ;
  scale = 705 ;
  pathAutoScale = false ;
  path = 0 ;
  walk(1071,86) ;
 delay 2 ;
  turn(DIR_SOUTH) ;
  EgoStartUse ;
  visible = false ;
 soundBoxStart(Music::Tuerzu4_wav) ;
 Tuergangoffen.enabled = false ;
 delay 3 ;
 Ego: 
  visible = true ;
  pathAutoScale = true ;
  lightmap = 0 ;
  lightmapAutoFilter = false ;    
 doEnter(Securitygang) ;
}


/* ************************************************************* */

object Tuerlab2 {
 setupAsStdEventObject(Tuerlab2,Open,745,180,DIR_NORTH) ; 	
 setClickArea(738,8,807,152) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event Hotelkey -> Tuerlab2 {
 triggerObjectOnObjectEvent(Lab2key, Tuerlab2) ;
}

event Lab2Key -> Tuerlab2 {
 Ego:
  walkToStdEventObject(Tuerlab2) ;
  say("Diese T]r hat kein Schl]sselloch.") ;
}

event Use -> TuerLab2 {
 triggerObjectOnObjectEvent(Open, Tuerlab2) ;
}

event LookAt -> Tuerlab2 {
 Ego:
  walkToStdEventObject(Tuerlab2) ;
  "Eine Glast]r."
}

event Close -> Tuerlab2 {
 Ego:
  walkToStdEventObject(Tuerlab2) ;
  "Sie ist schon zu."
}	

event Open -> Tuerlab2 {
 Ego:
  walkToStdEventObject(Tuerlab2) ;
  turn(DIR_NORTH) ;
  
 if (wagenMoved) {
   Ego.say("Der Wagen steht im Weg!") ;
   clearAction ;
   return ;
 }
 
 if (secLab2Locked) {
  Ego.say("Nein, da ist einer dieser Gorillas drin!") ;
  clearAction ;
  return ;
 }
  
 killEvents(123654) ;
 suspend ;
  pathAutoScale = false ;
  path = 0 ;
  scale = 817 ;
 delay 3 ;
 EgoStartUse ;
 soundBoxStart(Music::Glasauf_wav) ;
 Glastuerzu.enabled = false ;
 Glastueroffen.enabled = true ;
 EgoStopUse ;
  walk(790,138) ;
  turn(DIR_SOUTH) ;
 EgoStartUse ;
 soundBoxStart(Music::Glaszu_wav) ;
 Glastueroffen.enabled = false ;
 Glastuerzu.enabled = true ;
 EgoStopUse ;
 delay 3 ;
  turn(DIR_NORTH) ;  
 delay 2 ;
  pathAutoScale = true ;   
  lightmap = 0 ;
  lightmapAutoFilter = false ;
 doEnter(Securitylab2) ;
}

object Glastuerzu {
 setPosition(724,5) ;
 priority = 20 ;
 setAnim(Glaszu_image) ;
 visible = true ;
 enabled = true ;
 absolute = false ;
 clickable = false ; 
}

object Glastueroffen {
 setPosition(746,5) ;
 setAnim(Glasoffen_image) ;

 priority = 10 ;
 visible = true ;
 enabled = false ;
 absolute = false ;
 clickable = false ; 
}

event animate Glastueroffen {
 if (Glastueroffen.enabled) 
   if (Ego.positionY < 180) Glastueroffen.priority = 250 ;
	   else Glastueroffen.priority = 22 ;
}

/* ************************************************************* */

object SamTec {
 setPosition(241,0) ;
 priority = 253 ;
 setAnim(SamTec_image) ;
 visible = true ;
 enabled = true ;
 absolute = false ;
 clickable = false ; 
}

/* ************************************************************* */

object ZFrame {
 setPosition(11,129) ;
 setAnim(Zentralrechner_sprite) ;
 autoAnimate = false ;
 if (!hackedComputer) frame = 3 ;
  else frame = 0 ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 clickable = false ;
 member doAnimate = Bunsen.enabled ;
}

var Fi = 0 ;

event animate ZFrame {
  return if (!ZFrame.doAnimate) ;
  Fi++ ;
  if (Fi > random(8)+7) {
    Fi = 0 ;
    ZFrame.frame = ZFrame.frame + 1 ;
    if (ZFrame.frame >= 3) ZFrame.frame = 0 ;
  }
}

/* ************************************************************* */

object FaxGra {
 setupAsStdEventObject(FaxGra,LookAt,234,277,DIR_WEST) ;  			
 setAnim(Fax_sprite) ;
 setPosition(18,190) ; 
 setClickArea(0,0,54,39) ;
 absolute = false ;
 enabled = (FaxGra.getField(0)>0) ; 
 visible = true ;
 clickable = true ;
 autoAnimate = false ; 
 frame = getField(0)-1 ;
 name = "Faxger#t" ;
}

event LookAt -> FaxGra {
 Ego:
  walkToStdEventObject(FaxGra) ;
  say("Ich habe das Faxger#t an den Zentralrechner angeschlossen.") ;
}

event Take -> FaxGra {
 Ego:
  walkToStdEventObject(FaxGra) ;
  say("Nein, hier erf]llt es doch seinen Zweck.") ;	
}

event Use -> FaxGra {
 Ego:
  walkToStdEventObject(FaxGra) ;
  say("Ich sollte dazu den Computer benutzen.") ;	
}

event TalkTo -> FaxGra {
 Ego:
  walkToStdEventObject(FaxGra) ;
  say("Hallo, Faxger#t!") ;
}

event Faxpapier -> FaxGra {
 walkToStdEventObject(FaxGra) ;
 suspend ;
 Ego:
  "Mal sehen..." ;
 delay 5 ;
  EgoStartUse ;
  dropItem(Ego, Faxpapier) ;
  FaxGra.setField(0,2) ;
  FaxGra.frame = 1 ;
  EgoStopUse ;
 delay 3 ;
 needsCitron = true ;
 triggerObjectOnObjectEvent(Use, Tastatur) ;
}

event Thermopapier -> FaxGra {
 walkToStdEventObject(FaxGra) ;
 suspend ;
 Ego:
  "Dann wollen wir mal..." ;
 delay 5 ;
  EgoStartUse ;
  dropItem(Ego, Thermopapier) ;
  FaxGra.setField(0,3) ;  
  FaxGra.frame = 2 ;
  EgoStopUse ;
 delay 3 ;
 triggerObjectOnObjectEvent(Use, Tastatur) ;
}

/* ************************************************************* */

object Comp {
 setupAsStdEventObject(Comp,Use,234,277,DIR_WEST) ;  		
 setClickArea(11,133,66,200) ;
 absolute = false ;
 clickable = true ;
 enabled = ((BunsenStage == 2) and (lastRiddle == RIDDLE_PARADOX)) ;
 visible = true ;
 name = "Zentralrechner" ;
}

event LookAt -> Comp {
 Ego:
  walkToStdEventObject(Comp) ;
 suspend ;
  say("Das ist der SamTec-Zentralrechner.") ;
 clearAction ;
}

event Hammer -> Comp {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Comp) ;
 suspend ;
 if (used) say("Ich will den Zentralrechner nicht besch#digen.") ;
  else say("Ich denke nicht, dass der Zentralrechner etwas mit dem Hammer anfangen kann.") ;
 clearAction ;
}

event TalkTo -> Comp {
 Ego:
  walkToStdEventObject(Comp) ;
 suspend ;
  say("Hallo Zentralrechner.") ;
 delay 23 ;
  say("Er antwortet nicht.") ;
  say("Man kann ihn nicht per Sprache bedienen.") ;
 clearAction ;
}

event Take -> Comp {
 Ego:
  walkToStdEventObject(Comp) ;
  "Ich kann ihn nicht mitnehmen."	
}

event Use -> Comp {
 triggerObjectOnObjectEvent(Use, Tastatur) ;
}

event Fax -> Comp {
 var gave = did(give) ;
 Ego:
  walkToStdEventObject(Comp) ;
 suspend ;
 if ((gave)) {
  Ego.say("Warum sollte ich das tun?") ;
 } else {
  EgoStartUse ;
  dropItem(Ego, Fax) ;
  FaxGra.enabled = true ;
  FaxGra.setField(0, 1) ;
  installedPrinter = true ;
  EgoStopUse ;
  Ego.say("Der Anschluss passt.") ;
 }
 clearAction ;
}

/* ************************************************************* */

object Tastatur {
 setupAsStdEventObject(Tastatur,Use,234,277,DIR_WEST) ;  	
 setClickArea(65,199,96,237) ;
 absolute = false ;
 clickable = true ;
 enabled = ((BunsenStage == 2) and (lastRiddle == RIDDLE_PARADOX)) ;
 visible = true ;
 name = "Tastatur" ;
}

event Fax -> Tastatur {
 Ego:
  walkToStdEventObject(Tastatur) ;
  say("Ich kann das Faxger#t nicht an eine Tastatur anschlie}en.") ;	
}

event LookAt -> Tastatur {
 Ego:
  walkToStdEventObject(Tastatur) ;
  say("Die Tastatur ist an den SamTec-Zentralrechner angeschlossen.") ;
}

event Take -> Tastatur {
 Ego:
  walkToStdEventObject(Tastatur) ;
  say("Ich m[chte die Tastatur nicht.") ;	
  say("Au}erdem k[nnte man den Rechner dann nicht mehr bedienen.") ;
}

event Use -> Tastatur {
 Ego:
  walkToStdEventObject(Tastatur) ;
 if (hasItem(Ego, Ausdruck)) {
  suspend ;
  Ego.say("Ich habe alles was ich brauche.") ;
  clearAction ;
  return ;
 }
 suspend ;
 if (hackedComputer) {
  if (not FaxGra.enabled) {
    Ego.say("Ich sollte versuchen, so etwas wie einen Drucker aufzutreiben.") ;
    EgoStartUse ;
    delay 2 ;
    visible = false ;
    Juliansitzend:
     visible = true ;
    delay 8 ;  
    Ego:
     lightmap = 0 ;
     lightmapAutoFilter = false ;
    doEnter(Securitycomp) ;    
  } else {
    if (FaxGra.frame == 1) Ego.say("Nachdem ich das Papier eingelegt habe, versuche ich es nochmal.") ;
    if (FaxGra.frame == 2) Ego.say("Mit dem Thermopapier ist es nochmal einen Versuch wert.") ;
    EgoStartUse ;
    delay 2 ;
    visible = false ;
    Juliansitzend:
     visible = true ;
    delay 8 ;  
    Ego:
     lightmap = 0 ;
     lightmapAutoFilter = false ;
    doEnter(Securitycomp) ;
  }
 } else {
  EgoStartUse ;
  delay 2 ;
  visible = false ;
 Juliansitzend:
  visible = true ;
 delay 8 ;  
 Ego:
  lightmap = 0 ;
  lightmapAutoFilter = false ; 
 doEnter(Securitycomp) ;
 }
}

/* ************************************************************* */

object Knopf {
 setupAsStdEventObject(Knopf,Push,257,255,DIR_NORTH) ;  		
 setClickArea(223,148,246,169) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "roter Knopf" ;
}

event LookAt -> Knopf {
 Ego:
  walkToStdEventObject(Knopf) ;
  say("Auf dem Armaturenbrett ist neben weiteren Bedienelementen ein gro}er roter Knopf.") ;
  say("Daneben steht 'Push to fire'.") ;
}

event Use -> Knopf {
 triggerObjectOnObjectEvent(Push, Knopf) ;
}

event Push -> Knopf {
 Ego:
  walkToStdEventObject(Knopf) ;
 suspend ;
 delay 10 ;
  say("Es ist empirisch nachgewiesen, dass das Dr]cken gro}er roter Kn[pfe...") ;
  say("...in vielen F#llen zu unvorhergesehenen Konsequenzen f]hren kann.") ;
 clearAction ;
}

/* ************************************************************* */

object Regler {
 setupAsStdEventObject(Regler,LookAt,341,214,DIR_NORTH) ;  			
 setClickArea(288,101,340,124) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Regler" ;
}

event LookAt -> Regler {
 Ego: 
  walkToStdEventObject(Regler) ;
 suspend ;
  say("Damit l#sst sich wohl irgendwas einstellen.") ;
  say("Ich habe aber keinen blassen Schimmer, was.") ;
 clearAction ;
}

event Push -> Regler {
 triggerObjectOnObjectEvent(Use, Regler) ;
}

event Pull -> Regler {
 triggerObjectOnObjectEvent(Use, Regler) ;
}

event Use -> Regler {
 Ego: 
  walkToStdEventObject(Regler) ;
 suspend ;
  say("Ich verstelle besser nichts.") ;
  say("Ich k[nnte etwas kaputt machen.") ;
 clearAction ;
}

event Take -> Regler {
 Ego: 
  walkToStdEventObject(Regler) ;
 suspend ;
  say("Ich kann sie nicht nehmen.") ;
 clearAction ;	
}

/* ************************************************************* */

object Monitor {
 setupAsStdEventObject(Monitor,LookAt,234,277,DIR_WEST) ;  		
 setClickArea(7,4,57,54) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Monitor" ;
}

event LookAt -> Monitor {
 Ego:
  walkToStdEventObject(Monitor) ;
  say("Auf diesem Monitor wird das Bild der Kamera auf dem Laser da hinter der Scheibe ]bertragen.") ;
}

event default -> Monitor {
 Ego:
  walkToStdEventObject(Monitor) ;
  "Ich komme nicht hin."	
}

/* ************************************************************* */

object Juliansitzend {
 setPosition(110,130) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = false ;
 setAnim(Juliansitzt_image) ;
 captionwidth = 620 ;
 captionX = 25 ;
 captionY = -40 ;
 captionColor = COLOR_PLAYER ;
}

/* ************************************************************* */

object Pinnwand {
 setupAsStdEventObject(Pinnwand,LookAt,847,292,DIR_SOUTH) ;  			
 setClickArea(620,101,707,289) ; 
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Magnetpinnwand" ;
}

event LookAt -> Pinnwand {
 Ego:
  walkToStdEventObject(Pinnwand) ;
 suspend ;
  say("Auf der Magnetpinnwand befinden sich mehrere Magnete, sowie ein Blatt Papier mit einer Gleichung.") ;
  say("Au}erdem wurde etwas eingeritzt, was ich nicht entziffern kann.") ;
 clearAction ;
}

event Use -> Pinnwand {
 Ego:
  walkToStdEventObject(Pinnwand) ;
  "Was soll ich dranheften?"	
}

event Take -> Pinnwand {
 Ego:
  walkToStdEventObject(Pinnwand) ;
  "Ich kann sie nicht nehmen."		
}

/* ************************************************************* */

object Computer {
 setupAsStdEventObject(Computer,LookAt,1157,260,DIR_EAST) ;  				
 setClickArea(1288,159,1361,299) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Computer" ;
}

event Fax -> Computer {
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Nein. Dieser Rechner hier wird mir nicht weiterhelfen.") ;
 clearAction ;
}

event LookAt -> Computer {
 static var firstGAComment = false ;
 Ego:
  walkToStdEventObject(Computer) ;
 suspend ;
  if (!firstGAComment) {
    say("Auf diesem Computer l#uft gerade ein altes Grafikadventure!") ;
    say("Ich liebe diese Spiele...") ;
    firstGAComment = true ;
  } 
  delay 5 ;
  say("Der PC ist etwas alt und au}erdem sehe ich auch keine Netzwerkkabel.") ;
  say("Also handelt es sich wohl nicht um den Zentralrechner.") ;
 clearAction ;
}

event Use -> Computer {
 Ego: 
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Ich w]rde gerne, aber ich habe momentan keine Zeit f]r Spielereien.") ;
 clearAction ;
}

event Pull -> Computer {
 Ego: 
  walkToStdEventObject(Computer) ;
  say("Lieber nicht. Dabei k[nnte er kaputt gehen.") ;
}

event Take -> Computer {
 Ego: 
  walkToStdEventObject(Computer) ;
  say("Ich kann ihn nicht einstecken.") ;
}

event TalkTo -> Computer {
 Ego: 
  walkToStdEventObject(Computer) ;
 suspend ;
  say("Hallo?") ; 
 delay 10 ;
 clearAction ;
}

/* ************************************************************* */

object Fadenstrahlrohr {
 setupAsStdEventObject(Fadenstrahlrohr,LookAt,1184,224,DIR_EAST) ;  					
 setClickArea(1225,95,1295,163) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fadenstrahlrohr" ;
}

event LookAt -> Fadenstrahlrohr {
 Ego:
  walkToStdEventObject(Fadenstrahlrohr) ;
 suspend ;
  say("Ein herk[mmliches Fadenstrahlrohr.") ;
  say("Darin wird ein Elektronenstrahl in einem Glaszylinder durch ein Magnetfeld auf eine Kreis- oder Schraubenbahn gelenkt.") ;
  say("Die Gasatome in dem Zylinder werden dabei zum Strahlen angeregt, was vor allem im Dunklen h]bsch anzusehen ist.") ;
 clearAction ;
}

event Use -> Fadenstrahlrohr {
 Ego:
  walkToStdEventObject(Fadenstrahlrohr) ;
 suspend ;
  say("Ich w]rde gerne, aber ich habe momentan keine Zeit f]r Spielereien.") ;
 clearAction ;	
}

event Take -> Fadenstrahlrohr {
 Ego:
  walkToStdEventObject(Fadenstrahlrohr) ;
 suspend ;
  say("Das hilft mir momentan wirklich nicht weiter.") ;	
 clearAction ;
}

event Pull -> Fadenstrahlrohr {
 Ego:
  walkToStdEventObject(Fadenstrahlrohr) ;
  "Nein, ich m[chte nicht, dass es kaputt geht."	
}

/* ************************************************************* */

object Deckel {
 setupAsStdEventObject(Deckel,LookAt,818,293,DIR_SOUTH) ;  						
 setClickArea(749,251,814,298) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Deckel" ;
}

event LookAt -> Deckel {
 Ego:
  walkToStdEventObject(Deckel) ;
 suspend ;
 delay 3 ;
  say("Das ist wohl ein Teil dieser Bombe da dr]ben.") ;
 clearAction ;
}

event Take -> Deckel {
 Ego:
  walkToStdEventObject(Deckel) ;
 suspend ;
 delay 3 ;
  say("Ich brauche ihn nicht.") ;
 clearAction ;	
}

event Push -> Deckel {
 triggerObjectOnObjectEvent(Pull, Deckel) ;
}

event Pull -> Deckel {
 Ego:
  walkToStdEventObject(Deckel) ;
 suspend ;
 delay 3 ;
  EgoUse ;
  say("Da ist nichts darunter.") ;
 clearAction ;	
}

/* ************************************************************* */

object Netzgeraete {
 setupAsStdEventObject(Netzgeraete,LookAt,1184,224,DIR_EAST) ;  						
 setClickArea(1300,92,1359,155) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Messger#te" ;
}

event LookAt -> Netzgeraete {
 Ego:
  walkToStdEventObject(Netzgeraete) ;
 suspend ;
  say("So wie diese geschalten sind, zeigen sie Spannung und Stromst#rke des Fadenstrahlrohrs an.") ;
 clearAction ;
}

event Take -> Netzgeraete {
 Ego:
  walkToStdEventObject(Netzgeraete) ;
  "Ich brauche sie nicht."
}

event Use -> Netzgeraete {
 Ego:
  walkToStdEventObject(Netzgeraete) ;
  "Ich habe jetzt keine Zeit f]r Spielereien."
}

/* ************************************************************* */

object Kisten {
 setupAsStdEventObject(Kisten,LookAt,1028,136,DIR_WEST) ; 			
 setClickArea(910,19,1025,126) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kisten" ;
}

event LookAt -> Kisten {
 Ego: 
  walkToStdEventObject(Kisten) ;
  say("Hier stehen ein paar Kisten aus Karton in dem Regal.") ;
}

event Open -> Kisten {
 Ego: 
  walkToStdEventObject(Kisten) ;
 suspend ;
 EgoStartUse ;
 delay 14 ;
 EgoStopUse ;
  say("Sie sind leer.") ;
 clearAction ;
}

event Take -> Kisten {
 Ego: 
  walkToStdEventObject(Kisten) ;
  say("Ich will sie nicht.") ;
}

event Push -> Kisten {
 triggerObjectOnObjectEvent(Pull, Kisten) ;
}

event Pull -> Kisten { 
 Ego:
  walkToStdEventObject(Kisten) ;
  "Ich m[chte sie nicht bewegen."
}

/* ************************************************************* */

script pujaTipp1 {
 Ego:
 turn(DIR_SOUTH) ;
 delay 20 ;
 switch upcounter(2) {
    case 0: "Vielleicht kann ich ihn irgendwie lang genug ablenken, um den Zentralrechner benutzen zu k[nnen."  
    default: "Ich sollte ihm ein R#tsel stellen. Eines, das ihn lang genug besch#ftigt, um den Zentralrechner zu benutzen."    
  } 	 
}

script pujaTipp2 { //Thermopapier
 Ego: 
 switch upcounter(4) {
    case 0: "Das Faxger#t scheint zwar zu drucken, allerdings vermute ich..."
            "...dass dieses Modell mit einem Thermodruck-Verfahren arbeitet."
            delay 2 ;
            "Ich ben[tige also spezielles Thermopapier."
    case 1: "Das Faxger#t druckt, aber ich brauche Thermopapier!"
    case 2: "Ich ben[tige immer noch Thermopapier."
	     delay 2 ;
	    "Vielleicht kann ich das Papier, das ich besitze, irgendwie pr#parieren..."
    default: "Ich ben[tige immer noch Thermopapier." 
	    if (knowsCitron) { 
	      if (hasItem(Ego, Zitrone)) {
		say("Ich habe doch eine genmutierte Riesenzitrone dabei.") ;
		say("Vielleicht pr#pariere ich das Papier mit etwas Zitronensaft.") ;		      
	      } else {
	        say("In der Kiste im Gang waren doch auch Zitronen.") ;
	        say("Vielleicht pr#pariere ich das Papier mit etwas Zitronensaft.") ;
	      }
            } else say("Vielleicht finde ich irgendwo noch etwas, mit dem ich das Papier pr#parieren kann.") ;
  } 	 
}

/* ************************************************************* */

script openedAbdeckung {
  return Abdeckung.getField(0) ;
}

script abdeckungFrame {
  return Abdeckung.getField(1) ;
}

object AbdeckungGra {
 setAnim(Abdeckung_sprite) ;
 setPosition(200,308) ;
 enabled = openedAbdeckung and (!shortCircuit) ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 autoAnimate = false ;
 frame = abdeckungFrame ;
}

object LaserLinksGra {
 setAnim(Laserlinks_image) ;	
 setPosition(26,113) ;
 enabled = abdeckungFrame and (!shortCircuit) ;
 enabled = false ; // problems with screen animation
 visible = true ;
 clickable = false ;
 absolute = false ;
}

object LaserRechtsGra {
 setupAsStdEventObject(LaserrechtsGra,LookAt,233,281,DIR_EAST) ;	
 setAnim(Laserrechts_sprite) ;	
 setPosition(359,206) ;
 setClickArea(0,0,43,85) ;
 priority = 254 ;
 enabled = abdeckungFrame and (!shortCircuit) ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Laserstrahl" ;
}

event LookAt -> LaserRechtsGra {
 Ego:
  walkToStdEventObject(LaserRechtsGra) ;
 suspend ;
 delay 2 ;
  "Der Laser scheint mir ganz sch[n intensiv zu sein."
 delay 3 ;
 if (!cactusDestroyed) say("Dir auch, Oscar?") ;
 clearAction ;
}

event Use -> LaserRechtsGra {
 triggerObjectOnObjectEvent(Push, LaserRechtsGra) ;
}

event Pull -> LaserRechtsGra {
 triggerObjectOnObjectEvent(Push, LaserRechtsGra) ;
}

event Push -> LaserRechtsGra {
 Ego:
  walkToStdEventObject(LaserRechtsGra) ;
 suspend ;
  "Ich m[chte mich nicht verletzten."
 clearAction ;
}

event Take -> LaserRechtsGra {
 Ego:
  walkToStdEventObject(LaserRechtsGra) ;
 suspend ;
  "Ich kann den Strahl nicht einfach mitnehmen."
 clearAction ;
}

event Cactus -> LaserRechtsGra {
 Ego:
  walkToStdEventObject(LaserRechtsGra) ;
 suspend ;
 if (cactusDestroyed) {
   say("Nein, ich werde ab jetzt etwas mehr auf ihn Acht geben.") ;
 } else {
   delay 3 ;
   say("Oscar, hast Du schonmal so einen starken Laser gesehen?") ;
   delay 3 ;
   EgoStartUse ;
   start soundBoxStart(Music::Laser1_wav) ;
   destroyCactus ;
   EgoStopUse ;
   delay 3 ;
   say("Oha!") ;
   say("Das hat ihm nicht gut getan.") ;
   say("Pass das n#chste mal besser auf, Oscar!") ;
 }
 clearAction ; 
}

event default -> LaserRechtsGra {	
 if Did(Push) or Did(Pull) or Did(Close) or Did(Open) or Did(Take) or (Did(Give) and SelectedObject == Give) {
   triggerDefaultEvents ;
   return ;
 }
 if (Did(Give) or Did(Use)) {
   Ego:
    walkToStdEventObject(LaserRechtsGra) ;
    suspend ;
    say("Lieber nicht, ich k[nnte das noch brauchen.") ;
 } else triggerDefaultEvents ;
 clearAction ;
}


object Abdeckung {
 if (!openedAbdeckung) setupAsStdEventObject(Abdeckung,Open,233,281,DIR_SOUTH) ;
  else setupAsStdEventObject(Abdeckung,LookAt,233,281,DIR_SOUTH) ;
 setClickArea(200,308,250,338) ;
 absolute = false ;
 clickable = true ;
 enabled = ((bunsenStage==2) and (lastRiddle==RIDDLE_PARADOX) and (!shortCircuit)) ;
 visible = false ;
 if (openedAbdeckung) {
   if (abdeckungFrame == 0) name = "Leitungen mit Anschl]ssen" ;
    else name = "Leitungen mit ]berbr]ckten Anschl]ssen" ;
 } else name = "Abdeckung" ;
}

event LookAt -> Abdeckung {
 Ego:
  walkToStdEventObject(Abdeckung) ;
 suspend ;
 delay 2 ;
 if (AbdeckungGra.enabled) {
  if (AbdeckungGra.frame == 0) say("Hier sind drei Leitungen mit Anschl]ssen.") ;
   else say("Ich habe die Anschl]sse mit Kabeln ]berbr]ckt.") ;
 } else say("Eine Abdeckung wurde hier mit vier Schrauben befestigt. Ich habe keine Ahnung was sich darunter befinden k[nnte.") ;
 clearAction ;
}

event Open -> Abdeckung {
 Ego:
  walkToStdEventObject(Abdeckung) ;
 suspend ;
 delay 2 ;
 if (!openedAbdeckung) {
   EgoUse ;
   delay ;
   say("Mit blo}en H#nden bekomme ich sie nicht auf.") ;
 } else say("Ich kann die Leitungen nicht [ffnen.") ;
 clearAction ;
}

event Screwdriver -> Abdeckung {
 Ego:
  walkToStdEventObject(Abdeckung) ;
 suspend ;
 if (!openedAbdeckung) {
   EgoStartUse ;
   Abdeckung.setField(0, true) ;
   soundBoxStart(Music::Secretmirror_wav) ;
   AbdeckungGra.enabled = true ;
   Abdeckung.name = "Leitungen mit Anschl]ssen" ;
   setupAsStdEventObject(Abdeckung,LookAt,233,281,DIR_SOUTH) ;
   EgoStopUse ;
   say("Hmmmm...") ;
 } else {
   say("Das bringt nichts.") ;
 }
 clearAction ;
}

event Wires -> Abdeckung {
 Ego:
  walkToStdEventObject(Abdeckung) ;
 suspend ;
 if (openedAbdeckung) {
   delay 2 ;	 
   say("Die Anschl]sse sollten passen.") ;
   delay 3 ;
   EgoStartUse ;
   dropItem(Ego, Wires) ;
   Abdeckung.setField(1,1) ;
   AbdeckungGra.frame = abdeckungFrame ;
   Abdeckung.name = "Leitungen mit ]berbr]ckten Anschl]ssen" ;
   EgoStopUse ;
   say("Voila. Das waren die letzten K#belchen.") ;
   delay 3 ;
   start soundBoxStart(Music::Laser2_wav) ;
   delay 7 ;
   LaserlinksGra.enabled = false ;     // problems with screen animation
   LaserrechtsGra.enabled = true ;
   delay 8 ;
   turn(DIR_EAST) ;
   delay 12 ;
   say("Wow. Der Laser funktioniert nun.") ;
   delay 5 ;
 } else say("Das funktioniert so nicht.") ;
 clearAction ;
}

/* ************************************************************* */

object Fadenkreuz {
 setAnim(Fadenkreuz_sprite) ;
 setPosition(28,18) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 autoAnimate = true ;
 stopAnimDelay = 7 ;
}

/* ************************************************************* */

object Schirml {
 priority = 1 ;
 setAnim(Schirml_sprite) ;
 setPosition(85,144) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 autoAnimate = true ;
 stopAnimDelay = 9 ;
}

object Schirmr {
 priority = 1 ;
 setAnim(Schirmr_sprite) ;
 setPosition(122,138) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 autoAnimate = true ;
 stopAnimDelay = 4 ;
}

object Schirmrr {
 priority = 1 ;
 setAnim(Schirmrr_sprite) ;
 setPosition(246,106) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 autoAnimate = true ;
 stopAnimDelay = 2 ;
}

object Bildschirm {
 priority = 1 ;
 setAnim(Bildschirm_sprite) ;
 setPosition(367,0) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 autoAnimate = false ;
 frame = getField(0) ;
}

var Bi = 0 ;

event animate Bildschirm {
  Bi++ ;
  if (Bi > 121) {
    Bi = 0 ;
    Bildschirm.frame = Bildschirm.frame + 1 ;
    if (Bildschirm.frame >= 3) Bildschirm.frame = 0 ;
    Bildschirm.setField(0, Bildschirm.frame) ;
  }	
}

/* ************************************************************* */

object Regal {
 setupAsStdEventObject(Regal,LookAt,1182,180,DIR_EAST) ;
 setClickArea(1174,0,1307,135) ;
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
 if (!hasItem(Ego, Hammer)) say("Ein Hammer liegt auf einem der Regalbretter.") ;
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

object Bunsen {
 setupAsStdEventObject(Bunsen,TalkTo,245,266,DIR_WEST) ; 		
 setPosition (69,137) ;
 setAnim(Bunsen_sprite) ;
 setClickArea(0,0,122,156) ;
 stopAnimDelay = 4 ;
 talkAnimdelay = 4 ;
 autoAnimate = true ;
 clickable = true ;
 enabled =  not ((BunsenStage == 2) and (lastRiddle == RIDDLE_PARADOX)) ;
 absolute = false ;
 visible = true ;
 name = "Wissenschaftler" ;
 captionwidth = 400 ;
 captionX = 200-69+10  ;
 captionY = -50 ;
 captionColor = COLOR_WHITE ;
}

event LookAt -> Bunsen {
 Ego: 
  walkToStdEventObject(Bunsen) ;
 suspend ;  
  if (talkBunsenFirst) { 
    if (knowsMainframe) say("Das ist Doktor Bunsen, der gerade am Zentralrechner arbeitet.") ;
      else say("Doktor Bunsen bearbeitet wie wild Kn[pfe, Hebel und Tastaturen.") ;
  } else say("Ein glatzk[pfiger Wissenschaftler bearbeitet wie wild Kn[pfe, Hebel und Tastaturen.") ;
 clearAction ;
}

event Use -> Bunsen {
 triggerObjectOnObjectEvent(Take, Bunsen) ;
}

event Take -> Bunsen {
 Ego:
  walkToStdEventObject(Bunsen) ;
 suspend ;
  say("Nicht mein Typ.") ;
 clearAction ;
}

event Push -> Bunsen {
 Ego:
  walkToStdEventObject(Bunsen) ;
 suspend ;
 EgoUse ;
  delay 3 ;
 Bunsen: "Lassen Sie das!"
 clearAction ;
}

event Cactus -> Bunsen {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Bunsen) ;
 suspend ;
 if (!used) {
  say("Ich m[chte Oscar nicht hergeben.") ;
  clearAction ;
  return ;
 }
 delay 3 ;
 EgoUse ;
 delay 2 ;
 Bunsen:
  if (cactusMutated and (!cactusBurned)) {
    say("AUTSCH!") ;
    say("Was f]r ein Killer-Kaktus!") ;
  } else say("Autsch!") ;
 say("Lassen Sie das!") ;
 clearAction ;
}

event Raetselbuch -> Bunsen {
 Ego:
  walkToStdEventObject(Bunsen) ;
 suspend ; 
 if (knowsAskRiddle==false) {
   EgoUse ;	 
   Bunsen:
    "Ein R#tselbuch?"
    "Ich liebe R#tsel!"
    "Wo haben Sie das her?"
    delay 3 ;
   Ego:
    "Ich habe es gefunden."
   Bunsen:
    "Suchen Sie mir ein sch[nes raus und ich l[se es ihnen."
    "Machen Sie mir es aber nicht zu leicht!"
   knowsAskRiddle = true ;
 } else {
  Ego.say("Ich sollte ihm lieber direkt ein bestimmtes R#tsel aus dem Buch stellen.") ;
  Ego.say("Wenn ich ihm das Buch ]berlasse, hat er es wom[glich in null Komma nichts durch.") ;  
 }
 clearAction ;
}

static var TalkBunsenFirst = true ;

event TalkTo -> Bunsen {
 suspend ;
 Ego:
  walk(245,266) ;
  turn(DIR_WEST) ;
 if (TalkBunsenFirst) {
  BDfirst() ;
  TalkBunsenFirst = false ;
 } else
 switch random(3) {
   case 0 : Ego.say("Hallo nochmal.") ;
   case 1 : Ego.say("Hi!") ;
   case 2 : Ego.say("Da bin ich wieder.") ;
 }  
 if (BunsenStage == 1) {
  Ego: 
   "Haben Sie mein R#tsel schon gel[st?"
  Bunsen:
   "Nein, aber ich k]mmere mich sofort darum."
 } else if (BunsenStage == 3) {
  BDsolve() ;
 } else BD ;
 if ((bunsenStage!=1) and (knowsMainframe) and (knowsAskRiddle)) pujaTipp1 ;
 clearAction ;
}

/* ************************************************************* */

script BDfirst() {
 Ego:
  "Hey."
 Bunsen:
  "Wie bitte?"
  "Ich kann gerade nicht."
  "Moment..."
  "Ja?"
  delay 2 ;
 Ego:
  "Sie scheinen sehr besch#ftigt."
 Bunsen:
  "Das ist wohl wahr."
  "Wer sind Sie eigentlich?"
  delay 2 ;
 Ego:
  "|hm..."
  "Mein Name ist H]bler, ich bin der Neue hier."
 Bunsen:
  "Na das wurde aber auch langsam mal Zeit!"
  "Ich bin Dr. Bunsen."
  "Willkommen im Team."
 Ego:
  delay 2 ;
  "Danke."
}

script BDsolve() {
 Ego:
  switch random(3) {
    case 0 : "Sie haben das R#tsel schon gel[st?"
    case 1 : "Sie sind schon wieder hier?"
    case 2 : "Haben Sie das R#tsel schon gel[st?"
  }  
 Bunsen:
  "Das war ein Kinderspiel."
 printRiddleSolution (lastRiddle) ;
 solvedRiddles.bit[lastRiddle] = true ;
 delay 3 ;
 Ego:
  switch random(2) {
    case 0 : "Nicht ]bel."
    case 1 : "Respekt."    
  }  
 lastRiddle = RIDDLE_NONE ;
 BunsenStage = 0 ;
}

script BDask() {
 Bunsen:
  "Immer her damit!"
  var pRiddle = pickRiddle() ;
 if (pRiddle != RIDDLE_NONE) {
   if (solvedRiddles.bit[pRiddle]) { // Rätsel wurde bereits gelöst
     Ego:
      printRiddle(pRiddle) ;
     Bunsen:
      "Soll das ein Witz sein?"
      "Das R#tsel haben Sie mir bereits gestellt."
      printRiddleSolution(pRiddle) ;
      "Stellen Sie mir ein Anspruchsvolleres!"
      "Eines, das mich so richtig herausfordert!"
   } else {
     Ego:
      printRiddle(pRiddle) ;
     Bunsen:
      "Interessant!"
      "Ich k]mmere mich darum, sobald ich diese Daten hier fertig ausgewertet habe."
     lastRiddle = pRiddle ;
     BunsenStage = 1 ;
   }
 } else {
   Bunsen:
    "Schade, dann nicht."
 }
}

script BD() {
 static var bda = false ;
 static var bdb = false ;
 static var bdc = false ; 

 loop {
  Ego:
  AddChoiceEchoEx(1, "Was machen Sie hier?", false) if (bda==false) ;
  AddChoiceEchoEx(1, "Was machen Sie nochmal hier?", false) if (bda) ;	  
  AddChoiceEchoEx(2, "Kennen Sie einen Peter Wonciek?", false) if (bdb==false) ;	  
  AddChoiceEchoEx(2, "Nochmal wegen Peter Wonciek...", false) if (bdb) ;
  AddChoiceEchoEx(3, "K[nnte ich mal kurz Ihren Computer benutzen?", false) if ((bdc==false) and (knowsMainframe)) ;
  AddChoiceEchoEx(3, "K[nnte ich vielleicht jetzt mal kurz an Ihren Computer?", false) if ((bdc) and (knowsMainframe)) ;
  AddChoiceEchoEx(4, "Ich habe hier ein R#tsel f]r Sie.", true) if (knowsAskRiddle and hasItem(Ego, Raetselbuch)) ;
  AddChoiceEchoEx(5, "Man sieht sich.", false) ;
   
  var c = dialogEx () ;
  
  switch c {
   case 1: 
    if (bda) Ego.say("Was machen Sie nochmal hier?") ;
     else {
       Ego.say("Was machen Sie hier?") ;
       bda = true ;
     }
    Bunsen.say("Ich erforsche die Eigenschaften eines neuen Kristalls.") ;
    BDwork() ;
   case 2:
    if (bdb) {
        Ego.say("Nochmal wegen Peter Wonciek...") ;
        switch random(2) {
         case 0 : Bunsen.say("Ja?") ;
         case 1 : Bunsen.say("Was ist mit ihm?") ;
        }  	
    } else {
        Ego.say("Kennen Sie einen Peter Wonciek?") ;
	Bunsen.say("Wonciek? Aber nat]rlich.") ;
	Bunsen.say("Er arbeitet mit mir.") ;
        bdb = true ;
    }
    BDwonciek() ;
          
   case 3:
    if (bdc) Ego.say("K[nnte ich vielleicht jetzt mal kurz an Ihren Computer?") ;
     else Ego.say("K[nnte ich mal kurz Ihren Computer benutzen?") ;
    Bunsen: "Ausgeschlossen!"
            "Ich muss hier arbeiten."
	    "Sehen Sie das nicht?"
            "Warten Sie ab, bis meine Schicht zu Ende ist."	    
    bdc = true ;
   case 4: // Rätsel stellen
    BDask() ;
    return ;
   case 5:
    Ego: "Man sieht sich."
    Bunsen: 
    switch random(3) {
      case 0 : "Bis dann."
      case 1 : "Bis bald."
      case 2 : "Ade."
    }  
    return ;
  }
 }
}

script BDwork() {
 static var bdwoa = false ;
 static var bdwob = false ;
 static var bdwoc = false ;
 static var bdwod = false ;
 static var bdwoe = false ;
 
 loop { 
  Ego:
   AddChoiceEchoEx(1, "Welche Methoden wenden Sie an?", true) if (bdwoa==false) ;
   AddChoiceEchoEx(1, "Mit welchen Methoden arbeiten Sie nochmal?", true) if (bdwoa) ;	   
   AddChoiceEchoEx(2, "Was ist an diesem Kristall so besonders?", true) if (bdwob==false) ;	   
   AddChoiceEchoEx(2, "Wie k[nnte man den Kristall nutzen?", true) if (bdwob) ;	   
   AddChoiceEchoEx(3, "Wie lang sind Sie damit schon besch#ftigt?", true) if ((bdwoc==false) and (bdwob)) ;	   
   AddChoiceEchoEx(3, "Wie lange denken Sie, werden Sie noch brauchen?", true) if ((bdwoc) and (bdwob)) ;	   
   AddChoiceEchoEx(4, "Was ist das f]r ein Kristall?", true) if (bdwod==false) ;
   AddChoiceEchoEx(5, "Was ist das f]r ein Computer?", true) if (bdwoe==false) ;
   AddChoiceEchoEx(5, "Was k[nnen Sie mir nochmal ]ber diesen Computer erz#hlen?", true) if (bdwoe) ;
   AddChoiceEchoEx(6, "Reden wir ]ber etwas anderes.", true) ;
  var e = dialogEx() ;
  
  switch (e) {
   case 1:
       Bunsen:        
	"Wir verwenden M[}bauer-, Raman-, Infrarot- und Absorptionsspektroskopie..."
	"...sowie kalorimetrischen Untersuchungen und Neutronenbeugungsexperimente."
        bdwoa = true ;
   case 2:
       if (bdwob==false) {
        Bunsen:
         "Das Interessante an dem Kristall ist..."
	 "...dass er nicht die komplette Energie der einfallenden Strahlung wieder emittiert."
         "Wie Sie wissen, relaxieren die angeregten Atome normalerweise ]ber Emission elektromagnetischer..."
         "...Strahlung wieder mehr oder weniger direkt in ihren energetischen Grundzustand."
         "Bei diesem Kristall ist es anders."
         "Er scheint sich immer weiter 'aufzuladen'."
         "Es wird zwar wieder Energie abgegeben, aber nur ein Bruchteil."	
	 "Vermutlich sind unglaublich viele angeregte elektronische Zust#nde stabil."
	 "Aktuellen Erkenntnissen nach ist dies auf eine Wechselwirkung des Kristalls mit Neutrinos zur]ckzuf]hren."
	 "Das wird aber momentan noch woanders erforscht."
        Ego:
	 delay 3 ;
         "Faszinierend!"
	 "In jeder Sekunde durchqueren etwa 70 Milliarden Neutrinos einen Quadratzentimeter der Erdoberfl#che..."
	 "...und es passiert nahezu nichts."
	 "Aber mit dem Kristall sollen sie wechselwirken?"
	 "Wie?"
	Bunsen:
	 "Genau das wird noch erforscht."
	 "Das Resultat dieser Wechselwirkung scheint jedenfalls das schon angesprochene Aufladen des Kristalls zu sein."
         "Wenn man ihn beispielsweise nur mit harter R[ntgenstrahlung beschiesst emittiert er irgendwo..."
         "...im unteren, nicht sichtbaren Spektralbereich, und wird praktisch unsichtbar!"	 
         "Haben Sie so etwas schonmal gesehen?"
        Ego:
	 delay 3 ;
         "Nein."
        Bunsen:
         "HAHAHA!"
         "Nat]rlich nicht! Wie denn auch?"
	 "Sie Scherzbold."
	bdwob = true ;
       } else {
	Bunsen:
	 "Da sind wir uns noch nicht so sicher."
	 "Fakt ist, dass sobald der Kristall mit Dihydrogenmonoxid in Kontakt gebracht wird, sich dieses erhitzt..."
	 "...bis sich der Kristall vollst#ndig entladen hat."
	 "Die Anwendungsgebiete sind entsprechend vielseitig."
	 "Was wir letztenlich mit dieser wissenschaftlichen Errungenschaft anfangen werden, steht noch nicht fest."
       }
   case 3:
       if (bdwoc==false) {
	Bunsen.say("Seit cirka einem Monat.") ;
	Bunsen.say("Seitdem SamTec aber vor drei Wochen noch mehr Experimentalphysiker eingestellt hat...") ;
	Bunsen.say("...beschleunigte sich der Prozess wenigstens etwas.") ;
	Bunsen.say("Ich kann es nicht leiden, wenn sich Aufgaben so lange hinziehen.") ;
	Bunsen.say("Ich liebe kurze und pr#gnant gestellte Herausforderungen.") ;
	Bunsen.say("R#tsel und Knobeleien zum Beispiel.") ;
	Bunsen.say("Ich l[se Ihnen jedes Sudoku in f]nf Minuten!") ;
	knowsAskRiddle = true ;
	if (hasItem(Ego, Raetselbuch)) {
	 delay 5 ;
	 Ego.say("R#tsel, sagten Sie?") ;
	 Bunsen.say("In der Tat.") ;
	}
	bdwoc = true ;
       } else {
        Bunsen.say("Das kann ich noch nicht sagen. Aber die Grundlagenforschung ist bald abgeschlossen.") ;
	Bunsen.say("Danach folgen die Anwendungsm[glichkeiten.") ;
	Bunsen.say("Und bei deren Facettenreichtum werden wir bestimmt noch Jahre besch#ftigt sein.") ;
       }
   case 4:
	Bunsen:
	 "Ich wei}, dass das jetzt komisch klingt, aber ich habe keine Ahnung."
	 "Er soll synthetisch hergestellt worden sein."
	 "Aus welchen Elementen und in welcher Zusammensetzung ist allerdings streng geheim."
	 "Der Kristall stammt aus einer anderen Samtec-Forschungseinrichtung in Frankreich."
	 "Mehr kann ich Ihnen leider nicht dazu sagen."
	 "Wie sie bestimmt auch schon mitbekommen haben, ist es uns untersagt, weitere Informationen einzuholen."
	 "Wir sollen hier nur unseren Job machen."
	 "Und das tun wir."
	bdwod = true ;
   case 5:
	Bunsen:
	if (bdwoe==false) {
	 knowsMainframe = true ;
         "Das ist der SamTec-Zentralrechner." 
	 "Er ist ]ber Netzwerk mit allen anderen Rechnern hier im Geb#ude verbunden."
	 "Hier werden alle wichtigen Daten gespeichert."
         "Emails, Briefe, Gesch#ftsdokumente, Forschungsergebnisse..."
	 "Jeden Tag werden die Daten mehrmals auf externe Wechselfestplatten vollautomatisch gebackupt."
	 "Aber das werden Sie ja noch fr]h genug erfahren."
	 "Au}erdem scheint irgendwas an dem Rechner defekt zu sein."
	 "Nichtmal eine Verbindung zum Laser kann er aufbauen!"
	 
	 bdwoe = true ;
	} else {
	 "Das ist der SamTec-Zentralrechner." 	
	 "Hier sind alle wichtigen Daten gespeichert."
	 "Aber irgendwas an dem Rechner scheint defekt zu sein."
	 "Nichtmal eine Verbindung zum Laser kann er aufbauen!"
	}
   case 6: return ;
      
  }
 }
}

script BDwonciek() {
 static var bdwa = false ;
 static var bdwb = false ;
 static var bdwc = false ;
 
 loop {
  Ego:
   AddChoiceEchoEx(1, "Seit wann arbeiten Sie zusammen?", true) if (bdwa==false) ;
   AddChoiceEchoEx(1, "Seit wann arbeiten Sie nochmal zusammen?", true) if (bdwa) ;
   AddChoiceEchoEx(2, "Wann haben Sie ihn das letzte mal gesehen?", true) if (bdwb==false) ;	  
   AddChoiceEchoEx(2, "Wann meinten Sie, haben Sie Wonciek das letzte mal gesehen?", true) if (bdwb) ;	  	   
   AddChoiceEchoEx(3, "Worin bestehen seine Aufgaben hier genau?", true) if (bdwc==false) ;
   AddChoiceEchoEx(3, "Was waren hier nochmal seine Aufgaben?", true) if (bdwc) ;	   
   AddChoiceEchoEx(4, "Genug ]ber Wonciek.", true) ;
  var d = dialogEx () ;
  
  switch d {
   case 1: 
     if (bdwa==false) {
       Bunsen:
        "Ich arbeite bereits ]ber ein Jahr hier, und Peter seit etwa drei Wochen."
	"Wir haben allerdings nicht viel miteinander zu tun."
	"Das, was ich von ihm mitkriege, sind meist seine Messergebnisse, die ich weiterverwerte."
	"Und umgekehrt."
	delay 2 ;
       Ego:
        "Hatten Sie privaten Kontakt?"
       Bunsen:
        "Nein."
	"Unser Arbeitgeber sieht sowas nicht gerne."
	"Wurden Sie dar]ber gar nicht aufgekl#rt?"
	delay 4 ;
       Ego:
        "Nat]rlich wurde ich das."
       Bunsen:
        "Gut."
       bdwa = true ;
     } else Bunsen.say("Wie ich schon sagte, wir arbeiten seit etwa drei Wochen hier zusammen.") ;
   case 2:   
     Bunsen: "Vorhin, beim Schichtwechsel."
             "Er hat hier gute Arbeit geleistet."
	     "Wie immer."
     bdwb = true ;
   case 3: 
     if (bdwc==false) {
      Bunsen:
       "Wonciek und ich erforschen hier die Eigenschaften eines neuen, synthetisch hergestellten Kristalls."
      Ego:       
       "Synthetisch hergestellt sagten Sie?"
      Bunsen:
       "Ja."
      Ego:
       "Aha."
       "Zur]ck zu Wonciek."
      bdwc = true ;
     } else Bunsen.say("Wonciek und ich erforschen hier die Eigenschaften eines neuen, synthetisch hergestellten Kristalls.") ;
   case 4: return ;
  }
 }
}


