// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 scrollX = 0 ;
 Ego:
  enableEgoTalk ;
  enabled = true ;
  visible = true ;
 John.enabled = false ;
 Jack.enabled = false ;
 backgroundImage = Securitygef2_image;
 backgroundZBuffer = Securitygef2_zbuffer ;
 path = Securitygef2_path ;
 
 if (previousScene==Securitygef) {
   setPosition(380,297) ;
   face(DIR_SOUTH) ;
 } else {
   setPosition(307,269) ;
   face(DIR_SOUTH) ;
 }

 firstCutScene ;
 clearAction ;	 
}

/* ************************************************************* */

script firstCutScene {
 static var firstEnter = true ;	
 DarknessEffect.enabled = true ;	 
 if (firstEnter) {   
   delay 50 ;
   Ego:
    "Uff."
   delay 10 ;
    "Was ist passiert?"
   delay 5 ;
    "Wo bin ich denn hier gelandet?"
   delay 10 ;
   firstEnter = false ; 
 }
 forceShowInventory ;
}

/* ************************************************************* */

object Hammer {
 setupAsStdEventObject(Hammer,LookAt,316,261,DIR_WEST) ; 	
 setClickArea(283,248,309,267) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "H#mmerchen" ;
}

event LookAt -> Hammer {
 Ego:
  walkToStdEventObject(Hammer) ;
 suspend ;
  say("Ein H#mmerchen. Es ist bis auf den Stiel abgewetzt.") ;
 clearAction ;
}

event Take -> Hammer {
 Ego:
  walkToStdEventObject(Hammer) ;
 suspend ;
  say("Es ist bis auf den Stiel abgewetzt, also nutzlos.") ;
 clearAction ;
}

/* ************************************************************* */

object Rohr {
 setupAsStdEventObject(Rohr,LookAt,260,265,DIR_NORTH) ; 	
 setClickArea(238,147,256,256) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Rohr" ;
}

event LookAt -> Rohr {
 Ego:
  walkToStdEventObject(Rohr) ;
 suspend ;
  say("Durch die |ffnung str[mt ein wenig Luft in den Raum.") ;
 clearAction ;
}

event Push -> Rohr {
 triggerObjectOnObjectEvent(Take, Rohr) ;
}

event Pull -> Rohr {
 triggerObjectOnObjectEvent(Take, Rohr) ;
}

event Take -> Rohr {
 Ego:
  walkToStdEventObject(Rohr) ;
 suspend ;
 EgoUse ;
 delay 3 ;
  say("Ich kann es nicht bewegen.") ;
 clearAction ;
}

/* ************************************************************* */

object Leiter {
 setupAsStdEventObject(Leiter,Use,380,297,DIR_NORTH) ; 	
 setClickArea(364,106,397,283) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Leiter" ;
}

event LookAt -> Leiter {
 Ego:
  walkToStdEventObject(Leiter) ;
 suspend ;
  say("Eine rote Leiter, die nach oben f]hrt.") ;
 clearAction ;
}

event Use -> Leiter {
 walkToStdEventObject(Leiter) ;
 suspend ;
 EgoStartUse ;
 delay 4 ;
 doEnter(Securitygef) ;
}

/* ************************************************************* */

object Bild {
 setupAsStdEventObject(Bild,LookAt,380,297,DIR_EAST) ; 		
 setClickArea(408,153,464,247) ;
 absolute = false ;
 clickable = true ;
 enabled = ! getField(0) ;
 visible = false ;
 name = "Poster" ;
}

event LookAt -> Bild {
 Ego:
  walkToStdEventObject(Bild) ;
 suspend ;
  say("Ein Poster von Rita Hayworth.") ;
  say("Es erinnert mich an einen Film, in dem ein Str#fling durch ein Loch entkommt, das er hinter dem Pin-up-Girl an seiner Wand...") ;
  say("...]ber viele Jahre hinweg mit seinem H#mmerchen gegraben hat.") ;  
  say("Das Poster wurde mit Klebeband an der Wand befestigt.") ;
 clearAction ;
}

event Pull -> Bild {
 triggerObjectOnObjectEvent(Take, Bild) ;
}

event Take -> Bild {
 Ego:
  walk(380,297) ;
  turn(DIR_EAST) ;
  say("Ich rei}e das Poster herunter.") ;
 EgoStartUse ;
 soundBoxStart(Music::Abreissen_wav) ;
 delay 4 ;
 Bild.enabled = false ;
 Bild.setField(0, 1) ;
 OhneBildGra.enabled = true ;
 NightGoggles.enabled = true ;
 EgoStopUse ;
 clearAction ;
}

object OhneBildGra {
 setPosition(402,140) ;
 setAnim(OhnePoster_sprite) ;
 autoAnimate = false ;
 if (hasItem(Ego, Nachtsicht)) frame = 1 ;
  else frame = 0 ;
 absolute = false ;
 clickable = false ;
 visible = true ;
 enabled = Bild.getField(0) ;
}

object NightGoggles {
 setupAsStdEventObject(NightGoggles,LookAt,380,297,DIR_EAST) ; 			
 setClickArea(440,197,460,218) ;
 absolute = false ;
 clickable = true ;
 enabled = ((Bild.getField(0)) and (! hasItem(Ego, Nachtsicht))) ;
 visible = false ;
 name = "Ger#t" ;
}

event Take -> NightGoggles {
 Ego:
  walk(380,297) ;
  turn(DIR_EAST) ;
 EgoStartUse ;
 NightGoggles.enabled = false ;
 takeItem(Ego, Nachtsicht) ;
 OhneBildGra.frame = 1 ;
 EgoStopUse ;
 clearAction ;
}

event LookAt -> NightGoggles {
 Ego:
  walkToStdEventObject(NightGoggles) ;
 suspend ;
  say("Sieht nach einem Nachtsichtger#t aus.") ;
  say("Ob das dieser Wissenschaftler hier versteckt hat, dessen Aufzeichnungen ich gefunden habe?") ;
 clearAction ;
}


/* ************************************************************* */

object Matratze {
 setupAsStdEventObject(Matratze,LookAt,304,287,DIR_SOUTH) ; 		
 setClickArea(224,293,354,346) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Matratze" ;
}

event LookAt -> Matratze {
 Ego:
  walkToStdEventObject(Matratze) ;
 suspend ;
  say("Eine alte versiffte Matratze.") ;  
 clearAction ;	
}

event Use -> Matratze {
 Ego:
  walkToStdEventObject(Matratze) ;
 suspend ;
  say("Ich habe sie schon lang genug benutzt, als ich ohnm#chtig war.") ;  
  say("Jetzt sollte ich sehen, dass ich hier rauskomme.") ;
 clearAction ;		
}
