// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var AgentLookArround = 0 ;

event enter {
  backgroundImage  = vorhaus_image ;
  path             = vorhaus_path ;  
  enableEgoTalk ;
  
  if (JumpToIntro == 1) {  
  currentAct = 1 ;
  backgroundImage = vorhaus3_image ;
  backgroundZBuffer = vorhaus3_zbuffer ;
  Briefkasten.visible = false ;
  Jack:
   caption = null ;
   pathAutoScale = false ;
   captionY = -210 ;   
   scale = 690 ;      
   setPosition(302,277) ;   
   enabled = true ;
   face(DIR_NORTH) ;
   visible = true ;
  JulianClimbing:
   caption = null ;
   visible = false ;
   enabled = false ; 
  John: 
   caption = null ;
   pathAutoScale = false ;
   scale = 600 ;      
   captionY = -150 ;
   setPosition(450,220) ;   
   face(DIR_EAST) ;
   visible = true ;
   enabled = true ;	
  Ego:
   caption = null ;
   pathAutoScale = true ;
   path = vorhaus_path ;
   setPosition(170,350) ;
   visible = true ;
   enabled = true ;   
   face(DIR_EAST) ;
   captionY = -200 ;
   INV_SETCONTAINER(Ego) ;
   takeItem(Ego,Wallet) ;
   takeItem(Ego,Envelope) ;
   takeItem(Ego,Letter) ;  
   forceShowInventory ;   
   StartTonneAni ;
   StartRandomEvent ;  
   StartAgentAni ;   
   EnableEgoTalk ;
   
//   jukeBox_Shuffle(true) ;
//   jukeBox_Stop ;
   jukeBox_Stop ;
   jukeBox_shuffle(true) ;
   jukeBox_Enqueue(Music::BG_Homebase_mp3) ;
   jukeBox_Start ;

   
   installSystemInputHandler(&SystemInput_Handler) ; 
   clearAction ;   
   
  } else  
    
  switch intro_phase {
    case 1 : DoIntroPhaseOne ;    
    case 2 : DoIntroPhaseTwo ;
    default : doEnter(GameMenu) ;
  } 
 
}

script DoIntroPhaseOne {
	
  backgroundZBuffer = vorhaus_zbuffer ;		
   
  StartRandomEvent ;

  JulianClimbing.visible = false ;    
  Ego:
   path = 0 ;
   pathAutoScale = false ;
   scale = 640 ;
   visible = false ; 
   enabled = true ;
   positionX = 217 ; 
   positionY = 200 ; 
  
  delay(50) ;
  soundBoxStart(Music::opendoor_wav) ;
  backgroundImage = vorhaus2_image ;
  backgroundZBuffer = vorhaus2_zbuffer ;
  Ego:
   visible = true ;   
   walk(355,214) ;
   walk(540,216) ;
   face(DIR_NORTH) ;
   delay(5) ;
   "Mal sehen..." 
   EgoStartUse ;
  Briefkasten.visible = true ;
  soundBoxStart(Music::Secretmirror_wav) ;
   EgoStopUse ; 
   delay(20) ;  
  Ego:
   "Rechnungen, Rechnungen, nichts als Rechnungen..." ;   
   "Halt, was ist denn das?" ;
   EgoStartUse ;
  soundBoxStart(Music::Pageturn_wav) ;   
  Briefkasten.frame = 0 ;
   EgoStopUse ;
  Ego:
   "Ein Brief von Professor Wonciek..." ;   
  EgoStartUse ;
  soundBoxStart(Music::Secretmirror_wav) ;
  Briefkasten.visible = false ;
  EgoStopUse ;
  Ego:
   delay(3) ;
   turn(DIR_SOUTH) ;
   delay(3) ;
   walk(540,230) ;
   delay(3) ;
   "Wer braucht schon Rechnungen?"
   captionWidth = 0 ;
   walk(422,191) ;
   face(DIR_NORTH) ;
   EgoStartUse ;
   soundBoxStart(Music::Tropf_wav) ;   
   "Macht's gut, ihr Blutsauger!" ;
   EgoStopUse ;
  StartTonneAni ;
  
  Ego:
   face(DIR_SOUTH) ;
   walk(positionX, positionY + 40) ;
   "Den Brief werde ich drinnen lesen."
  soundBoxStart(car_wav) ;
  delay(10) ;

  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Alchemist_mp3) ;
  jukeBox_Start ;
  
   face(DIR_EAST) ;
  delay(23) ;
   "Oha!"
   "Sind das etwa schon wieder die Schuldeneintreiber?"
  delay(15);
   "Die werden mich auch diesmal nicht erwischen."
  Ego:   
   walk(217,200) ;
   visible = false ;
   
  soundBoxStart(Music::closedoor_wav) ;
  backgroundImage = vorhaus_image ;
  backgroundZBuffer = vorhaus_zbuffer ;
  
  Jack:
   pathAutoScale = false ;
   captionY = -180 ;
   scale = 600 ;   
   setPosition(639,241) ;
   enabled = true ;
   face(DIR_WEST) ;
   visible = true ;  
   start {
     delay(23) ;
     John:
      pathAutoScale = false ;
      scale = 560 ;      
      setPosition(639,241) ;   
      face(DIR_WEST) ;
      visible = true ;
      enabled = true ;  
      walk(345,223) ;   	   
      delay(20) ;
      AgentKnock ;
      "Herr Hobler!"  
      "Wir wissen, dass Sie da drin sind!"
   }   
   walk(450,249) ;
  delay(23) ;
   face(DIR_SOUTH) ;
  delay(23) ;
   face(DIR_EAST) ;
  delay(23) ;
   face(DIR_NORTH) ;
  delay(23) ;
   face(DIR_WEST) ;
  delay(10) ;     
   walk(380,257) ;   
   
  delay(69) ;
    
  start {
    delay(20) ;
    AgentKnock ;
    delay(20) ;
    AgentKnock ;  
    delay(20) ;
  }
  
  delay(92) ;
  
  John:  
   "Machen Sie auf der Stelle die T]r auf!"   
  delay 23 ;
  
   
  delay(23) ;
   "Wir werden Ihnen auch ganz bestimmt nicht weh tun!"   

  delay 20 ;
  Jack:
   "HEHEHEHEHEHEHEHEHE..."
  start PlayerAction ;
  start {
    John:
    "HAHAHAHAHAHAHAHAHAHA"
    AgentKnock ;
  }
    
  delay 70 ;
  
  John: 
   "Psst!"
  delay 10 ;
   "Ich habe etwas geh[rt." ;
  delay 30 ;
   "Er muss zuhause sein!" ;
  delay 30 ;

  start AgentKnock ;
  John:
  "|ffnen Sie endlich die T]r, Herr Hobler!"
    
  delay 60 ;
  Jack:
   "Vielleicht ist er ja gar nicht zu Hause..."
  John:
   "Doch - das hab ich im Urin."
   "Gib mir das Brecheisen."
   
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Ambush_mp3) ;
  jukeBox_Start ;
   
   
  doEnter(Introleer) ;
}

script DoIntroPhaseTwo {   
  backgroundImage = vorhaus3_image ;
  backgroundZBuffer = vorhaus3_zbuffer ;
  Jack:
   pathAutoScale = false ;
   captionY = -210 ;   
   scale = 690 ;      
   setPosition(302,277) ;   
   enabled = true ;
   face(DIR_NORTH) ;
   visible = true ;
  StartRandomEvent ;   
  JulianClimbing:
   frame = 18 ;
   visible = true ;
   enabled = true ; 
  John:
   pathAutoScale = false ;
   scale = 600 ;      
   captionY = -150 ;
   setPosition(251,210) ;   
   face(DIR_EAST) ;
   visible = true ;
   enabled = true ;
   start {     
     delay(13) ;
     Jack:
      "Und, hast du ihn erwischt?"	   
   }
  StartTonneAni ;
  John:
   walk(370,220) ;   
   walk(450,220) ;
   face(DIR_SOUTH) ;  
   delay(23) ;
  delay(5) ;  
  backgroundZBuffer = vorhaus2_zbuffer ;  
  JulianClimbing:
   frame = 0 ;
   visible = true ;
   enabled = true ;
  start {
    delay(30) ;
    John:
    "Nein. Er ist nicht da."
    delay(15) ;
    Jack:
    "Dann warten wir hier eben noch ein wenig."
    delay(15) ;    
    John:
    "Einverstanden."
    delay(15) ;    
  } 
  Ego:
   pathAutoScale = true ;
   path = vorhaus_path ;
   enabled = true ;
   setPosition(517,92) ;   
   face(DIR_EAST) ;
   visible = true ;
  delay(23) ;
   face(DIR_SOUTH) ;
  delay(23) ;
   "Huch?!"
   delay(3) ;
   face(DIR_WEST) ;
   delay(23) ;
   JulianClimbing.visible = false ;
   JulianClimbing.enabled = false ;
   backgroundZBuffer = vorhaus3_zbuffer ;
   face(DIR_NORTH) ;
   walk(490,46) ;
  delay 30 ;
  start {
    delay(100) ;
    John:
     face(DIR_EAST) ;        
    delay 30 ;
    StartAgentAni ;  
  }
  delay(150) ;
  Ego:
   setPosition(1,340) ;
   face(DIR_EAST) ;
   walk(170,350) ;
   face(DIR_SOUTH) ;
   captionY = -200 ;
   INV_SETCONTAINER(Ego) ;
   takeItem(Ego,Wallet) ;
   takeItem(Ego,Envelope) ;
   takeItem(Envelope, Letter) ;  
   forceShowInventory ;   
   delay(26) ;
   InstallSystemInputHandler(&SystemInput_Handler) ;
   start {
     EnableEgoTalk ;
     "Ich werde mich einfach an diesen Idioten vorbeischleichen und mit ihrem Auto abhauen."
     "Die werden sich noch wundern!"
     "Aber wohin dann?"
     "Vielleicht hilft mir der Brief von Peter weiter."
     
     turn(DIR_NORTH);
     EgoStartUse ;
     soundBoxStart(Music::Pageturn_wav) ;   
     MoveItem(Envelope,Ego,Letter) ;
     EgoStopUse ;
     
     EgoStartUse ;
     delay(50);
     EgoStopUse ;
     turn(DIR_SOUTH) ;
     "Darin stand etwas von einem Flug nach @gypten."
     "Au}erdem liegt dem Brief eine Reservierung f]r ein Flugticket bei."
     "Ich sollte machen, dass ich zum Flughafen komme."
     turn(DIR_EAST) ;      

  jukeBox_Stop ;
  jukeBox_shuffle(true) ;
  jukeBox_Enqueue(Music::BG_Homebase_mp3) ;
  jukeBox_Start ;
  
  


     clearAction ;
   }
}

/* ************************************************************* */

// Julian falls out of the window

script PlayerAction {
 soundBoxStart(window_wav) ;
 JulianClimbing :
 frame = 0 ;
 visible = true ;
 enabled = true ;
 delay 10 ;
 frame = 1 ;
 delay 3 ;
 frame = 2 ;
 delay 2;
 frame = 3 ;
 delay 2;
 frame = 4 ;
 delay 2 ;
 frame = 5 ;
 delay 2 ;
 frame = 6 ;
 delay 3 ;
 frame = 7 ;
 soundBoxPlay(punch_wav) ; 
 delay 10 ;
 start { "Autsch!" ; }
 delay 2 ;
 frame = 8 ;
 delay 2 ;
 frame = 9 ;
 delay 2 ;
 frame = 10 ;
 delay 2 ;
 frame = 11 ;
 delay 1 ;
 frame = 12 ;
 delay 1 ;
 frame = 13 ;
 delay 1 ;
 frame = 14 ;
 delay 1 ;
 frame = 15 ;
 delay 1 ;
 frame = 16 ;
 delay 1 ;
 frame = 17 ;
 delay 1 ;
 frame = 18 ;
 soundBoxStart(birds_wav) ;
}  

// Agents Johnson & Jackson knock on Julians door

script AgentKnock { 
 John.visible = false ;
 JohnKnock:
 frame = 0 ;
 visible = true ;
 delay 1 ;
 start {
   delay 2 ;
   soundBoxPlay(Music::doorknock_wav) ;	
 }
 frame = 1 ;
 delay 1 ;
 frame = 2 ;	
 delay 1 ;
 frame = 3 ;	  
 delay 1 ;
 start EggBounce ;
 frame = 4 ;	
 delay 1 ;
 frame = 5 ;	
 delay 1 ;
 start EggBounce ; 
 frame = 6 ;	
 delay 1 ;
 frame = 5 ;
 delay 1 ;
 start EggBounce ; 
 frame = 6 ;
 delay 1 ;
 frame = 7 ;	
 delay 1 ;
 delay 1 ;
 frame = 8 ;	
 delay 1 ;
 frame = 9 ;
 delay 1 ;
 visible = false ; 
 John.visible = true ;
}

script EggBounce {
  Ei:
   frame = 1 ;
   delay 2 ;
   frame = 0 ;
}

/* ************************************************************* */

object JohnKnock {
  enabled = true ;
  visible = false ;
  absolute = true ;
  clickable = false ;
  autoAnimate = false ;
  frame = 0 ;
  setPosition(299,80) ;
  setAnim(agentklopf_sprite) ;  
  captionColor = COLOR_JOHNJACKSON ;  
}

/* ************************************************************* */

object JulianClimbing {
 autoAnimate = false ;  	
 setAnim(julfall_sprite) ;
 priority = PRIORITY_AUTO ;
 setPosition(475,118) ;
 if (intro_phase == 2)  {
   visible = true ;
   Frame = 0 ;
 } else visible = false ;
 enabled = true ;
 clickable = false ;
 absolute = true ;
 Priority = 2 ;
 CaptionY = -50 ;
 captionColor = COLOR_PLAYER ;
}

/* ************************************************************* */

object Vogelhaus {
 setupAsStdEventObject(Vogelhaus,LookAt,38,343,DIR_NORTH) ; 		
 setClickArea(0,32,56,102);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Vogelh#uschen" ;
}

event LookAt -> Vogelhaus {
 Ego: 
  walkToStdEventObject(Vogelhaus) ;
  "Das Vogelhaus geh]rt meinem Nachbarn."  
}

event Take -> Vogelhaus {
 Ego: 
  walkToStdEventObject(Vogelhaus) ;	
  switch random(3) {
   case 0 : "Ich bin zu klein."
   case 1 : "Es h#ngt zu weit oben."
   case 2 : "Ich komme nicht ran."
  }
}

event Push -> Vogelhaus {
 TriggerObjectOnObjectEvent(Take, Vogelhaus) ;
}

event Pull -> Vogelhaus {
 TriggerObjectOnObjectEvent(Take, Vogelhaus) ;
}

event TalkTo -> Vogelhaus {
 Ego: 
  walkToStdEventObject(Vogelhaus) ;
 suspend ;	
  "Hallo da oben!"
 delay 5 ;
 clearAction ;
}

/* ************************************************************* */

object Kompost {
 setupAsStdEventObject(Kompost,LookAt,60,344,DIR_NORTH) ; 			
 setClickArea(0,208,119,329);
 absolute  = false ;
 clickable = true ;
 enabled   = true ;
 visible   = false ;
 name = "Kompost" ;
}

event LookAt -> Kompost {
 Ego: 
  walkToStdEventObject(Kompost) ;	
  switch random(2) {
    case 0 : "Das ist der Kompost meines Nachbarn."
    case 1 : "Ich will gar nicht wissen, was darin alles verrotet."
  }
}

event Take -> Kompost {
 Ego: 
  walkToStdEventObject(Kompost) ;	
  "Es gibt absolut nichts darin, was ich haben m[chte."
}

event Pull -> Kompost {
 Ego: 
  walkToStdEventObject(Kompost) ;
  "Ich bin zwar stark, aber nicht SO stark."
}

event Push -> Kompost {
 TriggerObjectOnObjectEvent(Pull, Kompost) ;
}

event TalkTo -> Kompost {
 Ego: 
  walkToStdEventObject(Kompost) ; 
 suspend ;
  say("Hallo?") ;
 delay 10 ;
  say("Keine Antwort.") ;
 clearAction ;
}

/* ************************************************************* */

object Ei {
 setPosition(99,36) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 autoAnimate = false ;
 setAnim(ei_sprite) ;
 frame = 0 ;
}

/* ************************************************************* */

script StartRandomEvent {
  start {
    killOnExit = true ;
    loop {
      delay(23*(random(6)+5)+random(200)+random(100)+250) ;
      switch random(6) {
        case 0 : Ei.startSound(bark_wav) ;
		   
	         
	case 1 : start {
		   Vogel:
		    frame = 2 ;
		    delay(2) ;
		    frame = 1 ;
		    delay(69) ;
		    frame = 2 ;
		    delay(10) ;
		    frame = 1 ;
		    delay(69) ;
		    frame = 2 ;
		    delay(2) ;
		    frame = 0 ;
	         }
		 
	case 2 : start PlayKompostAni ;
        case 3 : Ei.startSound(Music::Airplane_wav) ;
        case 4 : Ei.startSound(Carhorn_wav) ;	
        case 5 : Ei.startSound(bird_wav) ;
      }
    }
  }
}

script StartTonneAni {	
  start {
    Regentonne:
    visible = true ;
    enabled = true ;
    killOnExit = true ;
    loop {
      delay 23 ;
      frame = 0 ; 
      delay 23 ;
      frame = 1 ;
    }
  }
}

script PlayKompostAni {
  KompostAni:
  frame = 0 ;
  delay 2 ;
  frame = 1 ;
  delay 2 ;
  frame = 2 ;
  delay 2 ;
  frame = 3 ;
  delay 2 ;
  frame = 4 ;
  delay 2 ;
  frame = 5 ;
  delay 2 ;
  frame = 0 ;
  delay 23 ;
  frame = 6 ;
  delay 2 ;
  frame = 7 ;
  delay 2 ;
  frame = 8 ;
  delay 2 ;
  frame = 9 ;
  delay 2 ;
  frame = 10 ;
  delay 2 ;
  frame = 11 ;
  delay 2 ;
  frame = 12 ;
  delay 2 ;
  frame = 13 ;
  delay 2 ;
  frame = 0 ; 
}


script CheckPlayerPos {
  if (Ego.positionX > 213 and Ego.positionX < 585) {
    start {  
      Ego.walk(170,350) ;
      Ego.face(DIR_SOUTH) ;
      if (John.direction == DIR_WEST and Ego.positionX > 170-10 and Ego.positionX < 170+10) { delay until (John.direction == DIR_SOUTH) ; }
      Ego:
      switch random(5) {
        case 0 : "Ich sollte vorsichtig sein!"
        case 1 : "Das war knapp!"
        case 2 : "Fast h#tte er mich gesehen."
	case 3 : "Wenn er mich sieht, ist es aus!"
        case 4 : "Er sollte mich besser nicht sehen!"
      }
     clearAction ;
    }
  }	
}

script StartRandomTalk {
  static var lasttalk = -1 ;
  switch random(12) {
    case 0 :
      if (lasttalk == 0) { StartRandomTalk ; return 1 ; }
      lasttalk = 0 ;
      Jack:
       "Wei}t du was die in Holland auf die Fritten tun?"  
      John:
       "Was?" 
      Jack:
       "Mayonnaise... die ertr#nken die in der Tunke!" 
      John:
       "W]rg!"
    case 1 :
      if (lasttalk == 1) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 1 ;	    
      Jack:
       "Hamburger! Der Grundstein eines jeden nahrhaften Fr]hst]cks!"
    case 2 :
      if (lasttalk == 2) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 2 ;	    
      Jack:
       "Wei}t Du, wie die einen Viertelpf]nder mit K#se in Paris nennen?"
      John:
       "Die nennen ihn nicht Viertelpf]nder mit K#se?" 
      Jack:
       "Nein, Mann, die haben dieses metrische System."
       "Die wissen garnicht, was ein Viertelpf]nder ist." 
      John:
       "Wie sagen die denn dazu?" 
      Jack:
       "Die sagen Royal mit K#se." 
    case 3 :
      if (lasttalk == 3) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 3 ;	    
      Jack:
       "Ich hatte drei Gr]nde zur Bundeswehr zu gehen..." 
       "Erstens bin ich Patriot..." 
       "...zweitens liebe ich mein Land..."
       "...und drittens wurde ich eingezogen!"
    case 4 :
      if (lasttalk == 4) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 4 ;	    
      John:
       "Mathematik ist die einzige wirklich universelle Sprache."
      Jack: 
       "Unsinn!"
    case 5 :
      if (lasttalk == 5) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 5 ;	    
      Jack:
       "Wer zuviel Korn trinkt, hat am Ende nur noch Stroh im Kopf. "
      John:
       "Das ist wohl wahr."
    case 6 :
      if (lasttalk == 6) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 6 ;	    
      John:
       "Wenn er kommt, mach ich ein Sieb aus ihm."
       "Es wird wie Selbstmord aussehen."
    case 7 :
      if (lasttalk == 7) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 7 ;	    
      Jack:
       "Das ist das Problem von heute : ... "
       "Keiner will sich mehr Zeit f]r ein richtig finsteres Verh[r nehmen!"
    case 8 :
      if (lasttalk == 8) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 8 ;	    
      Jack:
       "Sicher dass er sich nicht irgendwo versteckt hat?"
      John:
       "Ja."
    case 9 :
      if (lasttalk == 9) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 9 ;	    
      Jack:
       "Was, wenn er hier irgendwo versteckt ist und uns beobachtet?"
      John:
       "Unsinn!"
    case 10 :
      if (lasttalk == 10) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 10 ;	    
      Jack:
       "Was sollen wir dem Boss sagen?"
      John:
       "Das lass mal meine Sorge sein."
    case 11 :
      if (lasttalk == 11) { StartRandomTalk ; return 1 ; }	    
      lasttalk = 11 ;	    
      John:
       "Hast du eigentlich das Auto abgeschlossen?"
      Jack:
       "F]r wie dumm h#lst Du mich eigentlich?"
      delay(46) ;       
      John:
       "Das m[chtest Du nicht wissen."
  }
 return 1 ;
}

script StartAgentAni {
  AgentLookArround = 1 ;  
  start {
    while (AgentLookArround == 1) {
      delay(1) ;
      if (John.direction == DIR_WEST || John.direction == DIR_SOUTH) {
        CheckPlayerPos ;
//	resume ;
      }
    }
    AgentLookArround += 2 ;    
  }
  start {
    while (AgentLookArround == 1) {
      if (AgentLookArround == 1) { delay(5*23) ; }
      if (AgentLookArround == 1) { delay(random(10)*23) ; }
      if (AgentLookArround == 1) { var a = StartRandomTalk ; if (! a) { StartRandomTalk ; } }
    }
  AgentLookArround += 2 ;
  }
  start {
    while (AgentLookArround == 1) {
      delay(50) ;      
      John.turn(DIR_NORTH) ;
      delay(50) ;
      John.turn(DIR_WEST) ;
      delay(50) ;
      John.turn(DIR_SOUTH) ;
      delay(50) ;
      John.turn(DIR_EAST) ;      
    }
    AgentLookArround += 2 ;
    John.face(DIR_WEST) ;
  }
}

/* ************************************************************* */

object Briefkasten {
 setPosition(523,112) ;
 setAnim(briefkasten_sprite) ;
 autoAnimate = false ;
 frame = 1 ;
 setClickArea(528,113,564,153);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Briefkasten" ;
}

/* ************************************************************* */

object Regentonne {
 setClickArea(393,110,453,170);
 setPosition(403,111) ;
 setAnim(tonne_sprite) ;
 autoAnimate = false ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Regentonne" ;
}

/* ************************************************************* */

object Vogel {
 setPosition(16,75) ;
 autoAnimate = false ;
 setAnim(vogel_sprite) ;
 frame = 0 ;
 enabled = true ;
 visible = true ;
 clickable = false ;
 absolute = false ;
}

/* ************************************************************* */

object KompostAni {
 setPosition(39,216) ;
 autoAnimate = false ;
 setAnim(kompost_sprite) ;
 frame = 0 ;
 enabled = true ;
 visible = true ;
 clickable = false ;
 absolute = false ;
}

/* ************************************************************* */

object Strasse {
 setClickArea(540,0,639,359) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "zum Auto der Schuldeneintreiber" ;
}

event LookAt -> Strasse {
 Ego:
 clearAction ;
  turn(DIR_EAST) ;
  "Dort hinten steht das Auto der Schuldeneintreiber."
}

object agentfire {
 setPosition(16,75) ;
 enabled = true ;
 visible = false ;
 clickable = false ;
 absolute = false ;
 setAnim(agentfire_sprite) ;
 autoAnimate = false ;
 Priority = 30 ;
 frame=0 ; 
}

object agentcigar {
 setPosition(247,121) ;
 enabled = true ;
 visible = false ;
 clickable = false ;
 absolute = false ;
 setAnim(agentcigar_sprite) ;
 autoAnimate = false ;
 Priority = 255 ;
 frame=0 ; 
}

object rauchwolke {
 setPosition(288,75) ;
 enabled = true ;
 visible = false ;
 clickable = false ;
 absolute = false ;
 setAnim(agentrauch_sprite) ;
 autoAnimate = false ;
 Priority = 255 ;
 frame=0 ; 
}

script rauch {
     start {
      jack.visible=false ;
      agentcigar.visible=true ;
      agentcigar.frame = 1 ;
      delay(2) ;
      agentcigar.frame = 2 ;
      delay(2);
      start {
       rauchwolke.visible=true ;
       rauchwolke.frame=0;
       delay(2) ;
       rauchwolke.frame=1;
       delay(2) ;
       rauchwolke.frame=2;
       delay(2) ;
       rauchwolke.frame=3;
       delay(2) ;
       rauchwolke.frame=4;
       delay(2) ;
       rauchwolke.frame=5;
       delay(3) ;      
       rauchwolke.visible=false ;
      }
      delay(15) ;
      agentcigar.frame = 3 ;
      delay(2) ;
      agentcigar.frame = 4 ;
      delay(1) ;
      jack.visible=true ;
      agentcigar.visible=false ;
    } 
} 

event WalkTo -> Strasse {
 if (John.Direction == DIR_SOUTH) {
   Ego:
   "Jetzt nicht! Er w]rde mich sehen!"
   clearAction ;
 } else {
   Ego:
   walk(599,353) ;
   if (! (positionX > 585 and positionX < 605)) { return 0 ; }
     Ego.path = 0 ;
     Ego.walk(680, 400) ;
          
     visible = false ;
     delay 5 ;
     HideInventory ;
     InstallSystemInputHandler(&IntroPartTwo_Handler) ;
     AgentLookArround = 0 ;  
     delay until (AgentLookArround == 6) ; // wait until conversation is finished, 
                                           // john stopped turning, 
					   // and checking for player position is disabled
     jukeBox_Shuffle(false) ;
     jukeBox_Fadeout(5) ;     
					   
     John:
      face(DIR_WEST) ;
      "Ich habe keine Lust mehr zu warten." 
      "Verschwinden wir von hier."
      "Fr]her oder sp#ter wird er hier aufkreuzen, und dann..."
     Jack:
      "Was dann?"
     John:
     start {
      delay 20 ;
      jukeBox_Shuffle(false) ;
      jukeBox_Stop ;
      jukeBox_Enqueue(Music::BG_Action_mp3) ;      
      jukeBox_Start ;   
     }
     
      "Dann wartet eine bombige {berraschung auf ihn."
      "HEHEHEHEHEHEHEHEHE!"
     Jack:
      "HAHAHAHAHAHAHAHAHAHA!"
     delay(23) ;

      "@hmm.."
     delay(5) ;
     John:
      "Was ist?"
      delay(23) ;
     Jack:
      "Nichts."
      
     Jack.visible = false ;
     agentcigar.visible = true ;
     agentcigar.frame = 4 ;
     delay(12) ;
     agentcigar.frame = 1 ;
     delay(8) ;
     agentcigar.frame = 4 ;
     delay(16) ;     
     agentcigar.frame = 1 ;
     delay(3) ;
     agentcigar.frame = 4 ;
     delay(8) ;
     Jack.visible = true ;
     agentcigar.visible = false ;
     delay(1) ;
     Jack.face(DIR_EAST) ;
     Jack.say("Gib mir mal Feuer.") ;
          
     delay(12) ;
     John:
      walk(Jack.positionX + 35, Jack.positionY-40) ;//69
      Face(DIR_SOUTH) ;
      Jack.Face(DIR_NORTH) ;
      delay(5) ;
        
      Jack.visible = false ;
      agentcigar.visible = true ;
      agentcigar.frame = 4 ;
      delay(2) ;
      
      agentfire : 
       visible = true ;
       positionX = 291 ;
       positionY = 91 ;
       frame = 0 ;
       visible = true ;
      
       delay 2 ;
       frame = 1 ;
      delay 5 ;
      
 frame = 2 ;
 delay 1 ;
 frame = 3 ;
 delay 2 ;
 frame = 4 ;
 delay 3 ;
 frame = 5 ;
 John.playSound(Music::Feuerzeug_wav) ;
 delay 4 ;
 frame = 6 ;
 delay 5 ;
 John.say("Hier."); 
 
 SmokeWarning ;
 
 agentcigar.frame = 1 ;
 delay(4) ;
 agentcigar.frame = 2 ;
 delay(15) ;
 agentcigar.frame = 3 ;
 delay(5) ;
 agentcigar.frame = 4 ;
 delay(3) ;
 agentfire.visible = false ;  
 John.visible = true ;
 rauch ;
 
 frame = 5 ;
 delay 4 ;
 frame = 4 ;
 delay 3 ;
 frame = 3 ;
 delay 2 ;
 frame = 2 ;
 delay 2 ;
 frame = 1 ;
 delay 1 ;

     
     delay(18) ;
     Jack:
      "Danke."
      visible = true ;
      agentcigar.visible=false ;
     delay(46) ;
    rauch ;
     John:
      walk(positionX+80, positionY) ;   
      "Hmmmm..."
      "Ich glaube ich habe das Brecheisen im Haus vergessen."; rauch ;
      "Ich geh es eben holen."
      walk(351,217) ; 
      start {
       while (John.Scale > 550) {
       John.Scale = John.Scale - 8 ;
       delay(1) ;
	}      
      }
      delay(1);
      walk(251,210) ;      
      
      visible = false ; 
     delay(18*3) ; rauch ; delay(2*18);
     Jack:
      
      "Warte, ich komme mit."
      setWalkAnim4(Actors::AgentWalkUp_sprite, Actors::AgentWalkRt_sprite, Actors::AgentWalkDn_sprite, agentwalkleftzig_sprite) ;	
      
      walk(351,217) ;

      start {
       while (Jack.Scale > 575) {
       Jack.Scale = Jack.Scale - 15 ;
       delay(1) ;
	}      
      }
      delay(1);
      
      walk(251,210) ;
      visible = false ;
     delay 15 ;
     Vogel.playSound(Music::Opencar_wav) ;
     delay 5 ;        
     Jack.setWalkAnim4(Actors::AgentWalkUp_sprite, Actors::AgentWalkRt_sprite, Actors::AgentWalkDn_sprite, Actors::AgentWalkLt_sprite) ;	
     doEnter(Introauto) ;   
 }
}

object warningtext {
 enabled = false ;
 visible = false ;
 positionx = 640 ;
 positiony = 440 ;
 Priority = 255 ;
}

event paint warningtext {
 drawingTextColor = RGB(255,255,255) ;
 drawingFont = defaultFont ;
 drawText(PositionX,PositionY,"HINWEIS: RAUCHEN GEF@HRDET DIE GESUNDHEIT!") ;
} 

script SmokeWarning {
 start {
  warningtext.enabled = true ;
  warningtext.visible = true ;
  
  while (warningtext.PositionX > -500) {
    warningtext.PositionX = warningtext.PositionX - 5 ;
    delay 1 ;
  } 
  
  warningtext.enabled = false ;
  warningtext.visible = false ;
 } 
} 
