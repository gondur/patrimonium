// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter { 
  backgroundImage = credits_image ;
  backgroundZBuffer = 0 ;
  forceHideInventory ;
  DarkBar.enabled = false ;
  transitionTime = 24 ;
  Ego.enabled = false ;
  
  delay (24) ;
  if (previousScene != Finaleende) installSystemInputHandler(&CreditsInput_Handler) ;  

  runCredits () ;
  installSystemInputHandler(&SystemInput_Handler) ;  
  enter GameMenu ;
}

script CreditsInput_Handler(key) {
switch key {
    case <MOUSE1>, <ENTER>, <SPACE>, <ESC> :       
      installSystemInputHandler(&SystemInput_Handler);
      installGameInputHandler(&GameInput_Handler);  
      Task.Caption = null ;
      Names.Caption = null ;
      doEnter(GameMenu) ;    
    default:
      return false ;  
  }
  return true ;
}

object Task {
 setPosition(320, 240) ;
 captionY = 0 ;
 captionX = 0 ;
 captionWidth = 620 ;
 captionColor = RGB(187,220,253) ;		
}

object Names { 
 setPosition(320, 280) ;
 captionY = 0 ;
 captionX = 0 ;
 captionWidth = 640 ;
 captionColor = RGB(95,143,191) ;	
 captionBase = BASE_CENTER ;
}

script runCredits() {
  delay 23 ;
  showCredit("Patrimonium", "") ;  
  delay 23 ;
  
  showCredit("Hintergrundgrafiken, Story, Programmierung, PR, Qualit#tssicherung, Projektkoordination", "Jonas Jelli") ;	     
  delay 23 ;
  showCredit("Charakterdesign", "Thorsten 'Krawuttke' Kraemer") ;	     
  delay 23 ;
  showCredit("Hintergrundgrafiken", "Philipp Lauthner") ;	     
  delay 23 ;  
  showCredit("AGAST Engine", "Todd Zankich, Russell Bailey") ;	     
  delay 40 ;  
  showCredit("Hintergrundmusik", "Alan Smithee") ;	       
  delay 40 ;
  showCredit("Hintergrundmusik \n 'Serpentine Trek', 'Gustav Sting', 'Passing Action', 'Round Drums', 'Desert City', 'Ambush', 'Interloper', 'Smoking Gun'...", "Kevin MacLeod (incompetech.com)") ;
  delay 40 ;
  showCredit("Hintergrundmusik \n 'The Reveal', 'Alchemist's Tower', 'Just As Soon', 'Home Base Groove', 'Dangerous', 'Crisis', 'Grave Blow'...", "Kevin MacLeod (incompetech.com)") ;
  delay 40 ;
  showCredit("Hintergrundmusik \n 'To the Ends', 'Feral Chase', 'Some Amount of Evil', 'Long Note One', 'Long Note Two'", "Kevin MacLeod (incompetech.com)") ;
  delay 40 ;  
  showCredit("Dank geb]hrt auch...","") ;
  delay 23 ;  
  showCredit("zus#tzliche Programmierung, Story", "Stefan Pfl]ger") ;	     
  delay 23 ;
  showCredit("zus#tzliche Grafiken, Story", "Bernhard Altaner") ;	     
  delay 23 ;
  showCredit("Gewidmet allen Adventure-Fans...", "...never stop trying to catch the rainbow!") ;	     
  if (previousScene == Finaleende) {
    delay 40 ;
    if (cheated) {
      showCredit("Deine Oscar-Punktzahl", "0/4 - Cheater") ;
    } else {
      var OS = 0 ;
      if (cactusDestroyed) OS++ ;
      if (cactusBurned) OS++ ;
      if (cactusDrowned) OS++ ;	    
      if (cactusMutated) OS++ ;	    
      switch OS {
        case 0: showCredit("Deine Oscar-Punktzahl", "0/4 - miserabel") ;
        case 1: showCredit("Deine Oscar-Punktzahl", "1/4 - schwach") ;
        case 2: showCredit("Deine Oscar-Punktzahl", "2/4 - passabel") ;
        case 3: showCredit("Deine Oscar-Punktzahl", "3/4 - gut") ;
        case 4: showCredit("Deine Oscar-Punktzahl", "4/4 - ausgezeichnet") ;
      }
    }
  }
}

script showCredit(taskStr, namesStr) {
  
  task.caption = taskStr ;
  names.caption = namesStr ;
  
  int i;
  
  for i = 1 ; i < 255 ; i+= 10 {  
    task.captionColor = RGBA(getR(task.captionColor), getG(task.captionColor), getB(task.captionColor), i) ;
    names.captionColor = RGBA(getR(names.captionColor), getG(names.captionColor), getB(names.captionColor), i) ;
    delay 1 ;
  }  
  
  names.captionColor = RGBA(getR(names.captionColor), getG(names.captionColor), getB(names.captionColor), 255) ;
  task.captionColor = RGBA(getR(task.captionColor), getG(task.captionColor), getB(task.captionColor), 255) ;
  
  delay (30) ;

  for i = 255; i > 0 ; i -= 10  {    
    task.captionColor = RGBA(getR(task.captionColor), getG(task.captionColor), getB(task.captionColor), i) ;
    names.captionColor = RGBA(getR(names.captionColor), getG(names.captionColor), getB(names.captionColor), i) ;
    delay 1 ;
  }  
  
  names.captionColor = RGBA(getR(names.captionColor), getG(names.captionColor), getB(names.captionColor), 0) ;
  task.captionColor = RGBA(getR(task.captionColor), getG(task.captionColor), getB(task.captionColor), 0) ;
  
  names.caption = null ;
  task.caption = null ;  
}
