// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {	
	
 static int first = 1 ; 
 hideInventory ;
 backgroundImage  = MenuBackD_image;

  if (fileExists(SLOT_FILENAME)) readSlotFile ;
    else createSlotNames ;
	    
 ResGameButton.enabled = (lastUsedSavegame!=-1) ;
 ResGameButton.visible = (lastUsedSavegame!=-1) ;
 
 if (previousScene == Credits) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Menu_ogg) ;  
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;	 
 }
 
 if (lastScene == Finaleende) ResGameButton.enabled = false ;

 delay transitionTime ;
 
 resume ;
} 

object NewGameImage {  
  setAnim(Highlight_sprite) ;
  autoAnimate = false ;
  frame = 0 ;
  setPosition(204,160) ;
  absolute = true ;
  clickable = true ;
  enabled = false ;
  visible = true ;
}

object NewGameButton {
  setClickArea(204,160,433,199) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
}

event animate NewGameButton {
  if (mouseIn(204,160,433,199) and (!suspended)) NewGameImage.enabled = true ;
    else NewGameImage.enabled = false ;
}


object ResGameImage {  
  setAnim(Highlight_sprite) ;
  autoAnimate = false ;
  frame = 1 ;
  setPosition(204,198) ;
  absolute = true ;
  clickable = true ;
  enabled = false ;
  visible = true ;
}

object ResGameButton {
  setClickArea(204,200,433,243) ;
  absolute = true ;
  clickable = true ;
  enabled = (lastUsedSavegame != -1) ;
  visible = true ;
}


event animate ResGameButton {
  if (mouseIn(204,200,433,243) and (!suspended) and (lastUsedSavegame!=-1)) ResGameImage.enabled = true ;
    else ResGameImage.enabled = false ;
}

object LoadGameImage {
  setAnim(Highlight_sprite) ;
  autoAnimate = false ;
  frame = 2 ;
  setPosition(204,236) ;
  absolute = true ;
  clickable = true ;
  enabled = false ;
  visible = true ;
}

object LoadGameButton {
  setClickArea(204,244,433,282) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
}

event animate LoadGameButton {
  if (mouseIn(204,244,433,282) and (!suspended)) LoadGameImage.enabled = true ;
    else LoadGameImage.enabled = false ;
}

object CreditsImage {
  setAnim(Highlight_sprite) ;
  autoAnimate = false ;
  frame = 3 ;
  setPosition(204,279) ;
  absolute = true ;
  clickable = true ;
  enabled = false ;
  visible = true ;
}

object CreditsButton {
  setClickArea(204,283,433,318) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
}

event animate CreditsButton {
  if (mouseIn(204,283,433,318) and (!suspended)) CreditsImage.enabled = true ;
    else CreditsImage.enabled = false ;
}

object QuitImage {
  setAnim(Highlight_sprite) ;
  autoAnimate = false ;
  frame = 4 ;
  setPosition(204,319) ;
  absolute = true ;
  clickable = true ;
  enabled = false ;
  visible = true ;
}

object QuitButton {
  setClickArea(204,319,433,365) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
}

event animate QuitButton {
  if (mouseIn(204,319,433,365) and (!suspended)) QuitImage.enabled = true ;
    else QuitImage.enabled = false ;
}

event default -> NewGameButton { 
 jukeBox_Fadeout(12) ;
 doenter(intrologo) ;

}

event default -> ResGameButton {
  jukeBox_fadeOut(12) ;	
  restoreGame(lastUsedSavegame) ;	
  resume ;
}

event default -> CreditsButton {
  doenter(credits) ;
} 

event default -> LoadGameButton {
  mainMenu ;
  resume ;
}

event default -> QuitButton {
  jukeBox_Fadeout(10) ;
  quitGame ;
}
