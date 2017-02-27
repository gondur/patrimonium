// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
//   adapted from AGAST sample game    
// ----------------------------------

script saySlow(text, factor) {
 captionClick = false ;
 caption = text ; 
 delay StringLength(text) * factor ;
 caption = null ; 	
 captionClick = true ;
}

script Pot(Base,Exp) {
 int res = Base ;
 if (exp <= 0) return 1 ;
 for (int i=1;i<Exp;i++) { res = res * Base ; }
 return res ;
} 

script AbsToRelX(value) {
  return value - positionX ;
}

script AbsToRelY(value) {
  return value - positionY ;
}

script abs(value) {
  if(value < 0) value = (0-value) ;    
  return(value) ;
}

script CallScript(scriptIndex) {
  return <(scriptIndex)> ;
}

script captionTrackScale {  
  var savedCaptionY ;
  var s ;
  var floatS ;
  savedCaptionY = CaptionY ;
  
  while(savedCaptionY < 1000) {
    if(pathAutoScale and (Path != 0)){
      floatS = intToFloat(GetPathScale(PositionX,PositionY)) ;
      floatS = floatDiv(inttofloat(1000),floatS) ;
      floatS = floatDiv(inttofloat(savedCaptionY),floatS) ;
      s = floatToInt(floatS) ;
      CaptionY = s ;
    }
    delay(1) ;
  }
  CaptionY = savedCaptionY ;
}

script setObjectExclusive {
  eventGroup = activeObject + 1000000 ;
  killEvents(eventGroup) ;
}

script setExclusive(code) {
  eventGroup = code ;
  killEvents(code) ;
}

script walk(x,y) {
  setObjectExclusive ;
  deleteRoute ;
  
  if findDistance(x, y, positionX, positionY) < 15 {
    stop() ;
    return ;
  }
  
  return if walkingSpeed == 0 ;

  findRoute(x, y) ;
  int currSegment ;
  var aAni = false ;
  if (activeObject==Ego) { 
    aAni = Ego.autoAnimate ;
    Ego.autoAnimate = true ;
  }
  frame = 0 ;

  while currSegment < routeSegments {

    int bx = positionX ;
    int by = positionY ;
    int ex = routeSegmentX(currSegment) ;
    int ey = routeSegmentY(currSegment) ;
    int dx = ex - bx ;
    int dy = ey - by ;
    
    turn(findDirection(dx, dy)) ;
    
    int dist = findDistance(bx, by, ex, ey) ;
    int numSteps = dist / walkingSpeed ;
    
    int currStep = 0 ;
    animMode = ANIM_WALK ;
    
    while currStep <= numSteps {
      if (routeSegments) {
        positionX = bx + floatToInt(floatMul(floatDiv(intToFloat(dx), intToFloat(numSteps)), intToFloat(currStep))) ;        
        positionY = by + floatToInt(floatMul(floatDiv(intToFloat(dy), intToFloat(numSteps)), intToFloat(currStep))) ;
	
	// hack: adjust reflection in the mirror at Finale_Toilette
	
	if (currentScene == Finaletoilette) {
         Ego.reflectionOffsetX = -2*(Ego.positionX-131) ;	
         Ego.reflection = (Ego.positionY < 280) ;
	}
	delay ;
      }            
      finish unless routeSegments ;
      currStep++ ;
    }
    currSegment++ ;
  }
  animMode = ANIM_STOP ;
  if (activeObject==Ego) Ego.autoAnimate = aAni ;
  deleteRoute ;

}

const turnDelay = 1 ;

script turn(DIR) {
  int d = direction ;
  int incr ;

  animMode = ANIM_TURN ;

  if d >= 0 and d < 6 {
    incr = (dir >= d and dir <= d + 6) ? 1 : -1 ;
  } else {
    incr = (dir >= d - 6 and dir <= d) ? -1 : 1 ;
  }

  while d != dir {
    d = d + incr ;
    if d == 12 {
      d = 0 ;
    } else if d < 0 {
      d = 11 ;
    }
    direction = d ;
    delay turnDelay ;
  }
  animMode = ANIM_STOP ;
}

script play(begin, end, cyclesPerFrame) {
  return if (begin==end) || (cyclesPerFrame==0) ;

  int t1 = autoAnimate ;
  int t2 = animMode ;

  autoAnimate = false ;
  animMode = ANIM_PLAY ;

  if begin > end {
    while begin >= end {
      frame = begin ;
      begin-- ;
      delay cyclesPerFrame ;
    }
  } else {
    while begin <= end {
      frame = begin ;
      begin++ ;
      delay cyclesPerFrame ;
    }
  }

  autoAnimate = t1 ;
  animMode = t2 ;
}  

script face(dir) {
  stop() ;
  direction = dir ;
}

script move(x, y) {
  stop() ;
  setPosition(x, y) ;
}

script say(str) {
  var saveactiveObject = activeObject ;
  __say(str) ;
  activeObject = saveactiveObject ;
}

script stop() {
  setObjectExclusive ;
  deleteRoute() ;
  animMode = ANIM_STOP ;
  frame = 0 ;
}

script PlaySound(res) {
  StartSound(res) ;
  delay while SoundIsPlaying() ;
}

script PlayMusic(res) {
  StartMusic(res) unless MusicIsPlaying(res) ;
  delay while MusicIsPlaying(res) ;
}
