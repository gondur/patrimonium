// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

const EG_EGO_TALK = 4548888 ;
const EG_PETER_TALK = 4548891 ;
int EgoTextWrapperRunning = 0 ;
int PeterTextWrapperRunning = 0 ;

script EnablePeterTalk {
  killOnExit = false ;
  killEvents(EG_Peter_TALK) ;
  PeterTextWrapperRunning = 1 ;
  start PeterTalk ;
}

script disablePeterTalk {
 PeterTextWrapperRunning = 0 ;
 killEvents(EG_Peter_TALK) ;
 autoAnimate = true ;
}

script PeterTalk {  
  killOnExit = false ;  
  Peter.CaptionWidth = 400 ;
  eventGroup = EG_Peter_TALK ;
  loop {
    if (Peter.visible) and (Peter.enabled) {
    if (Peter.animMode == ANIM_TALK and Peter.Direction != DIR_NORTH) {
    if (Peter.autoAnimate) Peter.autoAnimate = false ;
    switch random(3) {
      case 1 : talkmode = random(2) ;
    }
      switch talkmode {
        case 0 : Peter.frame = 0 ; delay(random(3)+1) ; Peter.frame = 3 ; delay(random(2)+1) ; Peter.frame = 6 ; delay(random(2)+1) ;
	case 1 : Peter.frame = 1 ; delay(random(3)+1) ; Peter.frame = 4 ; delay(random(2)+1) ; Peter.frame = 7 ; delay(random(2)+1) ;
	case 2 : Peter.frame = 2 ; delay(random(3)+1) ; Peter.frame = 5 ; delay(random(2)+1) ; Peter.frame = 8 ; delay(random(2)+1) ;
      }
    } else Peter.autoAnimate = true ;
    }
    delay 1 ;
  }
 PeterTextWrapperRunning = 0 ;
}

script EnableEgoTalk {
  killEvents(EG_EGO_TALK) ;
  EgoTextWrapperRunning = 1 ;
  start EgoTalk ;
}

script DisableEgoTalk {
 EgoTextWrapperRunning = 0 ; 
 killEvents(EG_EGO_TALK) ;
}

script EgoTalk {  
  killOnExit = false ;  
  Ego.CaptionWidth = 400 ;
  eventGroup = EG_EGO_TALK ;
  
  var resetAutoAnimate = 0 ;
  var toWait = 0 ;
  var waited = 0 ;
  var toFlip = 0 ;
  var flipWait = 0 ;
  
  loop {
	  
    return if (EgoTextWrapperRunning == 0) ;
	    
    if (resetautoAnimate and Ego.animMode != ANIM_TALK) {Ego.autoAnimate = true ; resetAutoAnimate = false ; }
        
    if (Ego.enabled) {
	    
      // Position des gesprochenen Textes von Julian anpassen
      
      Ego.captionX = 0 ;	   
      if (Ego.pathAutoScale and (Ego.Path != 0)){
        var floatS = intToFloat(GetPathScale(Ego.PositionX,Ego.PositionY)) ;
        if (floatS < 10) floatS = intToFloat(lastscale) ;
        if (floatS < 10) floatS = intToFloat(500) ;
        floatS = floatDiv(intToFloat(1000),floatS) ;
        floatS = floatDiv(intToFloat(stdcaptionY),floatS) ;       
        Ego.CaptionY = floatToInt(floatS) ; 
	
	// mindestens drei Zeilen anzeigen, falls Julian zu weit am oberen Bildschirmrand steht:
        if (Ego.positionY + Ego.captionY < 80) Ego.captionY = 80 - Ego.positionY ; 
      }
      
      var offset = Ego.PositionX - (Ego.CaptionWidth / 2) ;
      if (offset < 0) { Ego.CaptionX = - Offset ; } else
      if (offset > (GetSpriteFrameWidth(backgroundImage, 0) - (Ego.CaptionWidth / 2))) Ego.CaptionX = Offset ;
 	       
      if (Ego.positionX < Ego.captionWidth / 2) Ego.captionX = - Ego.positionX + Ego.captionWidth / 2 ; 
       else if (GetSpriteFrameWidth(backgroundImage, 0) - Ego.positionX < Ego.captionWidth / 2) Ego.captionX = GetSpriteFrameWidth(backgroundImage, 0) - Ego.positionX - Ego.captionWidth / 2 ; 
	
      // Rede-Animation
	    
      if (Ego.animMode == ANIM_TALK and Ego.Direction != DIR_NORTH) {
	      
        if (Ego.autoAnimate) { Ego.autoAnimate = false ; resetAutoAnimate = true ; }
	
        if (flipWait >= toFlip) {
         switch random(4) {
           case 1 : talkmode = random(4) ; waited = 0 ;	 toWait = 0 ;
         }
	 flipWait = 0 ;
	 toFlip = random(3)+1+random(2)+1 ;
        }
	
	if (waited >= toWait)
		
	 switch talkmode {
		 
           case 0 : if (waited == 0) Ego.frame = 0 ; 
		     else {
		      if (Ego.frame == 0) Ego.frame = 1 ;
		        else Ego.frame = 0 ;
		     }
 		    toWait = random(3)+1 ;  
		    waited = 0 ; 
		   
	   case 1 : if (waited == 0) Ego.frame = 2 ; 
		     else {
		      if (Ego.frame == 2) Ego.frame = 3 ;
		        else Ego.frame = 2 ;
		     }
		    toWait = random(3)+1 ; 
		    waited = 0 ; 
		   
	   case 2 : if (waited == 0) Ego.frame = 4 ; 
		     else {
		      if (Ego.frame == 4) Ego.frame = 5 ;
		        else Ego.frame = 4 ;
		     } 
		    toWait = random(3)+1 ; 
		    waited = 0 ; 
		    
		   
	   case 3 : if (waited == 0) Ego.frame = 6 ; 
		     else {
		      if (Ego.frame == 6) Ego.frame = 7 ;
		        else Ego.frame = 6 ;
		     }
		    toWait = random(3)+1 ; 
		    waited = 0 ; 
         } 
	
        
      } 
      
    }
    
    delay 1 ;
    waited++ ;
    flipWait++ ;
    
  }

}

script EgoStartUse {
 Ego.autoAnimate = false ;
 Ego.animMode = ANIM_PLAY ;
 Ego.frame = 0 ;
 delay 2 ;
 Ego.frame = 1 ;
 delay 1 ;
 Ego.frame = 2 ;
 delay 2 ; 
 //Ego.animMode = ANIM_STOP ;
// Ego.autoAnimate = true ;
}

script EgoStopUse {
 Ego.autoAnimate = false ;	
 Ego.animMode = ANIM_PLAY ;	
 Ego.frame = 2 ;
 delay 2 ;
 Ego.frame = 1 ;
 delay 1;
 Ego.frame = 0 ;
 delay 2 ;
 Ego.animMode = ANIM_STOP ;
 Ego.autoAnimate = true ;
 delay 1 ;
}

script EgoUse {
 EgoStartUse ;
 Ego.autoAnimate = false ;	
 Ego.animMode = ANIM_PLAY ;	
 delay 3 ;
 EgoStopUse ;
}

// Julian Hobler

object Ego {
  name = "Julian Hobler" ;
  SetupAsActor ;
	
  clickable = false ;
  visible = true ;
  enabled = true ;

  pathAutoScale = true ;
  SetupAsContainer(Ego) ; // endow ego with own inventory   
  
  member talkmode = 0 ;
  member stdcaptionY = -200 ;
  
  Ego.CaptionY = -150 ;

  CaptionColor = COLOR_PLAYER ;
  CaptionFont = defaultFont ;

  walkingSpeed = 9 ;
  WalkAnimDelay = 3 ;
  TurnAnimDelay = 3 ;
  TalkAnimDelay = 4 ;

  setStopAnim4(Actors::JulStatUp_sprite, Actors::JulStatRt_sprite, Actors::JulStatDn_sprite, Actors::JulStatLt_sprite) ;
  setTurnAnim4(Actors::JulWalkUp_sprite, Actors::JulWalkRt_sprite, Actors::JulWalkDn_sprite, Actors::JulWalkLt_sprite) ;
  setWalkAnim4(Actors::JulWalkUp_sprite, Actors::JulWalkRt_sprite, Actors::JulWalkDn_sprite, Actors::JulWalkLt_sprite) ;	
  setTalkAnim4(Actors::JulStatUp_sprite, Actors::JulTalkRt_sprite, Actors::JulTalkDn_sprite, Actors::JulTalkLt_sprite) ;
  
  setPlayAnim4(Actors::JulTakeUp_sprite, Actors::JulTakeRt_sprite, Actors::JulTakeDn_sprite, Actors::JulTakeLt_sprite) ;	  
}

script JulianDress {
  disguiseEgo ;
  Ego:
   setStopAnim4(Actors::Jul2StatUp_sprite, Actors::Jul2StatRt_sprite, Actors::Jul2StatDn_sprite, Actors::Jul2StatLt_sprite) ;
   setTurnAnim4(Actors::Jul2WalkUp_sprite, Actors::Jul2WalkRt_sprite, Actors::Jul2WalkDn_sprite, Actors::Jul2WalkLt_sprite) ;
   setWalkAnim4(Actors::Jul2WalkUp_sprite, Actors::Jul2WalkRt_sprite, Actors::Jul2WalkDn_sprite, Actors::Jul2WalkLt_sprite) ;	
   setTalkAnim4(Actors::Jul2StatUp_sprite, Actors::Jul2TalkRt_sprite, Actors::Jul2TalkRt_sprite, Actors::Jul2TalkLt_sprite) ;
   setPlayAnim4(Actors::Jul2TakeLt_sprite, Actors::Jul2TakeRt_sprite, Actors::Jul2TakeRt_sprite, Actors::Jul2TakeLt_sprite) ;	  	
}

script JulianUndress {
  Ego:
   setStopAnim4(Actors::JulStatUp_sprite, Actors::JulStatRt_sprite, Actors::JulStatDn_sprite, Actors::JulStatLt_sprite) ;
   setTurnAnim4(Actors::JulWalkUp_sprite, Actors::JulWalkRt_sprite, Actors::JulWalkDn_sprite, Actors::JulWalkLt_sprite) ;
   setWalkAnim4(Actors::JulWalkUp_sprite, Actors::JulWalkRt_sprite, Actors::JulWalkDn_sprite, Actors::JulWalkLt_sprite) ;	
   setTalkAnim4(Actors::JulStatUp_sprite, Actors::JulTalkRt_sprite, Actors::JulTalkDn_sprite, Actors::JulTalkLt_sprite) ;
   setPlayAnim4(Actors::JulTakeUp_sprite, Actors::JulTakeRt_sprite, Actors::JulTakeDn_sprite, Actors::JulTakeLt_sprite) ;	  	
}


// Peter Wonciek

object Peter {	
  name = "Peter Wonciek" ;
  setupAsActor ;

  clickable = false ;
  visible = false ;
  enabled = false ;

  member talkmode = 0 ;

  lightmapAutoFilter = false ;
  pathAutoScale = true ;

  captionY = -150 ;
  captionColor = COLOR_PROF ;
  captionFont = defaultFont ;

  walkingSpeed = 6 ;
  walkAnimDelay = 4 ;
  turnAnimDelay = 1 ;

  setStopAnim4(Actors::ProfStatUp_sprite, Actors::ProfStatRt_sprite, Actors::ProfStatDn_sprite, Actors::ProfStatLt_sprite) ;
  setTurnAnim4(Actors::ProfWalkUp_sprite, Actors::ProfWalkRt_sprite, Actors::ProfWalkDn_sprite, Actors::ProfWalkLt_sprite) ;
  setWalkAnim4(Actors::ProfWalkUp_sprite, Actors::ProfWalkRt_sprite, Actors::ProfWalkDn_sprite, Actors::ProfWalkLt_sprite) ;	
  setTalkAnim4(Actors::ProfStatUp_sprite, Actors::ProfTalkRt_sprite, Actors::ProfStatDn_sprite, Actors::ProfTalkLt_sprite) ;
}

script mutatedPeter {
 return Peter.getField(0) ;
}

script mutatePeter {
 Peter:
  setStopAnim4(Actors::ProfStatUp_sprite, Actors::ProfStatRt2_sprite, Actors::ProfStatDn2_sprite, Actors::ProfStatLt2_sprite) ;
  setTurnAnim4(Actors::ProfWalkUp_sprite, Actors::ProfWalkRt2_sprite, Actors::ProfWalkDn2_sprite, Actors::ProfWalkLt2_sprite) ;
  setWalkAnim4(Actors::ProfWalkUp_sprite, Actors::ProfWalkRt2_sprite, Actors::ProfWalkDn2_sprite, Actors::ProfWalkLt2_sprite) ;	
  setTalkAnim4(Actors::ProfStatUp_sprite, Actors::ProfTalkRt2_sprite, Actors::ProfTalkDn2_sprite, Actors::ProfTalkLt2_sprite) ;
  setField(0, true) ;
}


// JOHN JACKSON

object John {
  class = actorClass ;
  SetupAsActor ;	

  clickable = true  ;
  visible   = false ;
  enabled   = false ;
  
  name = "John Jackson" ;  

  LightmapAutoFilter = false ;
  pathAutoScale = true ;

  captionY = -150 ;
  captionColor = COLOR_JOHNJACKSON ;
  captionFont = defaultFont ;

  walkingSpeed  = 8 ;
  WalkAnimDelay = 3 ;
  turnAnimDelay = 3 ;
  talkanimdelay = 2 ;

  setStopAnim4(Actors::AgentStatUp_sprite, Actors::AgentStatRt_sprite, Actors::AgentStatDn_sprite, Actors::AgentStatLt_sprite) ;
  setTurnAnim4(Actors::AgentWalkUp_sprite, Actors::AgentWalkRt_sprite, Actors::AgentWalkDn_sprite, Actors::AgentWalkLt_sprite) ;
  setWalkAnim4(Actors::AgentWalkUp_sprite, Actors::AgentWalkRt_sprite, Actors::AgentWalkDn_sprite, Actors::AgentWalkLt_sprite) ;	
  setTalkAnim4(Actors::AgentStatUp_sprite, Actors::AgentTalkRt_sprite, Actors::AgentTalkDn_sprite, Actors::AgentTalkLt_sprite) ;
}

// JACK JOHNSON

object Jack {  
  class = actorClass ;
  SetupAsActor ;	

  clickable = true  ;
  visible   = false ;
  enabled   = false ;
  
  name = "Jack Johnson" ;  

  LightmapAutoFilter = false ;
  pathAutoScale = true ;

  captionY = -150 ;
  captionColor = COLOR_JACKJOHNSON ;
  captionFont = defaultFont ;

  walkingSpeed  = 6 ;
  WalkAnimDelay = 3 ;
  turnAnimDelay = 3 ;
  talkanimdelay = 2 ;

  setStopAnim4(Actors::AgentStatUp_sprite, Actors::AgentStatRt_sprite, Actors::AgentStatDn_sprite, Actors::AgentStatLt_sprite) ;
  setTurnAnim4(Actors::AgentWalkUp_sprite, Actors::AgentWalkRt_sprite, Actors::AgentWalkDn_sprite, Actors::AgentWalkLt_sprite) ;
  setWalkAnim4(Actors::AgentWalkUp_sprite, Actors::AgentWalkRt_sprite, Actors::AgentWalkDn_sprite, Actors::AgentWalkLt_sprite) ;	
  setTalkAnim4(Actors::AgentStatUp_sprite, Actors::AgentTalkRt_sprite, Actors::AgentTalkDn_sprite, Actors::AgentTalkLt_sprite) ;  
}
