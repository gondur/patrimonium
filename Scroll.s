// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// Scroll.s - scroll backgrounds >
//            640 px.
//   adapted from AGAST sample game    
// ----------------------------------

const SCROLL_GROUP = 110000 ;

script EnableScrolling() {
  DisableScrolling() ;
  start {
    killOnExit = false ;
    eventGroup = SCROLL_GROUP ;
        
    loop {
      activeObject = PlayerObject ;
      
      if PositionX > ScrollX + 340 {
        ScrollX = ScrollX + ((PositionX - (ScrollX + 340)) / 4) ;
      } else if (PositionX < ScrollX + 300) {
        ScrollX = ScrollX - (((ScrollX + 300) - PositionX) / 4) ;
      }
	   
      static var bgWidth ;
      static var bgHeight ;
	   
      bgWidth = GetSpriteFrameWidth(backgroundImage, 0);
      bgHeight = GetSpriteFrameHeight(backgroundImage, 0);
           
      if ((ScrollX + ScreenWidth) > bgWidth) ScrollX = bgWidth - ScreenWidth ;
      if ((ScrollY + ScreenHeight) > bgHeight) ScrollY = bgHeight - ScreenHeight ;
      if (ScrollX < 0) ScrollX = 0 ;
      if (ScrollY < 0) ScrollY = 0 ;

      delay ;
    }
  }
}

script DisableScrolling() {
  killEvents(SCROLL_GROUP) ;
}


