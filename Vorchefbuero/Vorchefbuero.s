// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {  
 backgroundImage   = Vorchefbuero_image ; 
 backgroundZBuffer = Vorchefbuero_zbuffer ; 
 path              = Vorchefbuero_path ;
 
 outsideChefCount++ ;
 
 forceHideInventory ; 

 Ego:
  reflection = true ; 
  reflectionOffsetY = 185 ; 
  reflectionTopColor = RGBA(128,128,255,64) ; 
  reflectionBottomColor = RGBA(128,128,255,64) ; 
  reflectionAngle = 0.0 ; 
  reflectionStretch = 1.0 ;
 
 if (previousScene == Aufzug) { // (PreviousScene == Aufzug)
    pathAutoScale = false ;
    scale = 843 ;
    path = 0 ;
    setPosition(503,242) ;
    face(DIR_WEST) ;
   delay transitionTime ;
   delay 10 ;
   soundBoxPlay(Music::Aufzug_wav) ;
   delay 6 ;
   aufzugAuf ;
    walk(372,242) ;
    path = Vorchefbuero_path ;
    pathAutoScale = true ;
   aufzugZu ;
 } else { // Chefbuero
    setPosition(147,254) ;	 
    face(DIR_EAST) ;
 }
 
 if (OutsideChefCount == 1) ChefAgentsTalk ;
  else clearAction ;
}

/* ************************************************************* */

object Aufzugtuer {  
  setPosition(407,25) ; 
  setAnim(Aufzug_sprite) ;
  StopAnimDelay = 5 ;
  autoAnimate = false ;
  frame = 0 ;
  visible = true ;
  enabled = true ;
  clickable = true ;
  absolute = false ;
  //setClickArea(411,32,536,299) ;
  setClickArea(4,7,129,274) ;
  name = "Aufzug" ;
}

event WalkTo -> Aufzugtuer {
 clearAction ;
 Ego:
  walk(372,242) ;
}

event Use -> Aufzugtuer {
 Ego:
  walk(372,242) ;
  turn(DIR_EAST) ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 843 ;
 aufzugAuf ;
 Ego:
  walk(503,242) ;  
 aufzugZu ;
 delay 23 ;
 Ego:
  pathAutoScale = true ;
  reflection = false ;
 doEnter(Aufzug) ; 
}

script aufzugAuf {
 start {
   delay 2 ;
   Aufzugtuer:
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
 }
 soundBoxPlay(Music::Aufzugauf_wav) ;
}

script aufzugZu {
 start {
   delay 2 ;
   Aufzugtuer:
    frame = 5 ;
    delay 2 ;
    frame = 4 ;
    delay 2 ;
    frame = 3 ;
    delay 2 ;
    frame = 2 ;
    delay 2 ;
    frame = 1 ;
    delay 2 ;
    frame = 0 ;
    delay 2 ;  
  }
  soundBoxPlay(Music::Aufzugzu_wav) ;
}

/* ************************************************************* */

object ChefVoice {
 positionX = 200 ;
 positionY = 80 ;
 captionY = 0 ; 
 captionX = 0 ; 
 clickable = false ;
 captionWidth = 400 ;	
 captionColor = COLOR_CHEF ;
}

object JohnVoice {
 positionX = 200 ;
 positionY = 80 ;
 captionY = 0 ;
 captionX = 0 ;
 clickable = false ;
 captionWidth = 400 ;	
 captionColor = COLOR_JOHNJACKSON ;
}

object JackVoice {
 positionX = 200 ;
 positionY = 80 ;
 captionY = 0 ;
 captionX = 0 ;
 clickable = false ;
 captionWidth = 400 ;	
 captionColor = COLOR_JACKJOHNSON ;
}

script ChefAgentsTalk {
 jukeBox_FadeOut(12) ;
 ChefVoice: "So etwas wird nie wieder passieren."
            "Haben wir uns verstanden?"
 JohnVoice: "Jawohl, Chef!" 
            "Du auch, Johnson?" 
 JackVoice: "Jawohl, Chef!" 

 jukeBox_Enqueue(Music::BG_TheReveal_mp3) ;
 jukeBox_Shuffle(false) ;
 jukeBox_Start ;	
 
  Ego: "Das sind doch die Stimmen der zwei Kerle, die mich zuhause besucht haben!"
       "Vielleicht waren das ja gar keine Schuldeneintreiber..."


 delay 10 ;
 ChefVoice: "Ab jetzt werde ich f]r euch zwei denken..."
            "...und Ihr werdet nur noch das..."
	    "...und damit meine ich GENAU das machen, was ich euch SAGE."
 JohnVoice: "Jawohl, Chef!" 
 ChefVoice: "Auch wenn Ihr zwei nicht in der Lage seid, das zu begreifen, ..."
            "...haben wir in unserem eigenen Interesse die Pflicht, ..."
	    "...nichts an die |ffentlichkeit durchsickern zu lassen."
	    "Das w#re durchaus nicht gut f]rs Gesch#ft."
	    "Und Hobler ist insofern ein Problem, ..."
	    "...als dass er Woncieks Freund ist."
	    "Und Wonciek k[nnte ihm etwas erz#hlen, oder sogar schon erz#hlt haben..."
	    "Versteht Ihr die Dringlichkeit dieses Problems?"
 JackVoice: "Jawohl, Chef!" 
 Chefvoice: "Hobler hat bereits einen Flieger hierher genommen."
            "Wir m]ssen auf jeden Fall verhindern, ..."
	    "...dass durch Hobler unsere Pl#ne gest[rt werden."
	    "Auch wenn Ihr meinen Ausf]hrungen eben nicht folgen konntet..."
	    "...werde ich euch jetzt Anweisungen geben."
	    "Ihr werdet euch nun im Hintergrund halten, und Wonciek beobachten."
	    "Ich wiederhole: BEOBACHTEN."
	    "Wenn er sich mit Hobler trifft, bringt Ihr Hobler zu mir."
	    "Sorgt daf]r, dass Wonciek davon NICHTS mitbekommt."
	    delay 4 ;
	    "Habt Ihr das verstanden?"
	    delay 6 ;
 JohnVoice: "Ja, das haben wir verstanden, Chef!" 	    
 ChefVoice: "Ausgezeichnet. Ihr wisst, dass Ihr meine besten M#nner seid."
            "Wenn Ihr Erfolg habt, wartet eine kleine {berraschung auf euch."
	    delay 6 ;
 JackVoice: "Hehehehehehe!" 
            delay 10 ; 
 JohnVoice: "Hahahahahahaha!" 	    	    
 Ego:       "Oha. Ich sollte schleunigst weg hier."
            "Besser ich bleibe den zwei Gorillas aus den Augen."
 TriggerObjectOnObjectEvent(Use, Aufzugtuer) ;
}


