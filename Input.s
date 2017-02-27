// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
//    Input.s - handles user input
//   adapted from AGAST sample game
// ----------------------------------

script InitInput() {
  InstallSystemInputHandler(&SystemInput_Handler);
  InstallGameInputHandlerEx(&GameInput_Handler);  
}

script IntroPartOne_Handler(key) {
  switch key {
    case <ESC>: 
      JumpToIntro = 1 ;
      setObjectExclusive ; 
      doEnter(Introvorhaus) ;
    case <MOUSE1>, <ENTER>, <SPACE>:
      if (suspended) InterruptCaptions ;
        else return false ;
  }
}

script IntroPartTwo_Handler(key) {
  switch key {
    case <ESC>: 
      JumpToIntro = 2 ;      
      setObjectExclusive ;     
      doEnter(Flughafen) ;      
    case <MOUSE1>, <ENTER>, <SPACE>:
      if (suspended) InterruptCaptions ;
        else return false ;
  }
}

script IntroPartThree_Handler(key) {
  switch key {
    case <ESC>: 
      interruptCaptions ;   
      setObjectExclusive ;     
      doEnter(Intrologo) ;      
    case <MOUSE1>, <ENTER>, <SPACE>:
      if (suspended) InterruptCaptions ;
        else return false ;
  } 
}

script GameInput_Handler(key) {
  switch key {
    case <LBUTTON>: LeftButtonClick ; 

    case <RBUTTON>: RightButtonClick ; 
	    
    case <F5>, <ESC>: MainMenu() ;

/*    case <F7>: cycleTime             = 1000 / 3 ;  
    case <F8>: cycleTime             = 1000 / 30 ;  //Ego.walkingSpeed = 9 ;
    case <F9>: cycleTime             = 1000 / 300 ; // Ego.walkingSpeed = 99 ; 
	    	    
    case <F6>: start jukeBox_FadeOut(10) ;
    case <F1>: start catchSecMusic ;
 
    case <I>:
      Ego.PutInsidePath() ;



    case <P>:
      Move(ClickX, ClickY) ;

    case <W>:
      start {
        print "Ego: (%d, %d)", positionX, positionY ;
      }
      
    case <X>:
      start {
        print "Ego.priority (%d)", Ego.priority ;
      }
      

    case <F>:
	start {
         print "mouse zb priority (%d)", GetZBufferPriority(backgroundZBuffer, MouseX+ScrollX, MouseY+ScrollY) ;
        }
    case <G>: start { print "Verb: %s", cv.verbaction ; }

    case <S>:
      jukebox.shuffle = !jukebox.shuffle ; 

    case <T>:
      start {
        static var fps;
        static var lastCycle;
        static var inc;
        Print("Beginning framerate check.");
        fps = 0;
        inc = 0;
        for (inc; inc < 100; inc++) {
	  lastCycle = LastCycleLength() ;
          lastCycle = 1000 / (LastCycleLength() + 1) ;
          fps = fps + lastCycle ;
          delay;
        }
        fps /= 100;
        Print("Over the last 100 cycles, the approximate framerate was %d frames per second.", fps);
        Resume();
      }
    
    case <R>:
      Resume(); 
     */ 
      
    case <CTRL P>: start cheatDialog ;
    
      
    case <NUMPAD7>: 
      SelectVerb(Give) ;
      resume ; 
      
    case <NUMPAD8>: 
      SelectVerb(Take) ;
      resume ; 
      
    case <NUMPAD9>: 
      SelectVerb(Use) ;
      resume ; 
      
    case <NUMPAD4>: 
      SelectVerb(Open) ;
      resume ; 
      
    case <NUMPAD5>: 
      SelectVerb(TalkTo) ;
      resume ; 
      
    case <NUMPAD6>: 
      SelectVerb(Push) ;
      resume ; 
      
    case <NUMPAD1>: 
      SelectVerb(Close) ;
      resume ; 
      
    case <NUMPAD2>: 
      SelectVerb(LookAt) ;
      resume ; 
      
    case <NUMPAD3>: 
      SelectVerb(Pull) ;
      resume ; 
    }
    
}

script SystemInput_Handler(key){
  switch key {
	  
 /*   case <D>:
      ShowDebugLines = ! ShowDebugLines ;
      ShowDebugInfo = ! ShowDebugInfo ;	  */
	  
    case <MOUSE1>, <ENTER>, <SPACE>:
      if suspended {
        InterruptCaptions ;
      }
      else {
        return false ; // input not handled
      }
  
    case <ESC>:
      if (! suspended) MainMenu ;
	      
    case <CTRL F8>: cycleTime             = 1000 / 30 ;  
    case <CTRL F9>: cycleTime             = 1000 / 300 ;  	      

    case <CTRL C>:
      AskMenu("Spiel beenden?", ASK_QUIT) ;

    default:
      return false ;  // input not handled
  }

  return true ;  // input handled
}

script cheatDialog {
 loop {
  Ego:
   AddChoiceEchoEx(1, "Inventory items...", false) ;   
   AddChoiceEchoEx(2, "Game vars...", false) ;	  
   AddChoiceEchoEx(3, "Jump to...", false) ;	
 //  AddChoiceEchoEx(4, "Game speed...", false) ;   
   AddChoiceEchoEx(5, "Close", false) ;	     

   
   
  var d = dialogEx ;
  
  switch d {
   case 1: cheatDialogInv ;
   case 2: cheatDialogVars ;
   case 3: cheatDialogJump ;
   case 4: cheatDialogSpeed ;
   case 5: return ;
  }
 }	
}

script cheatDialogSpeed {
loop {
  Ego:
   AddChoiceEchoEx(1, "Default game speed", false) ;   
   AddChoiceEchoEx(2, "High game speed", false) ;   
   
   AddChoiceEchoEx(4, "Back", false) ;	     

   
   
  var c = dialogEx ;
  
  switch c {
   case 1: cycleTime             = 1000 / 30 ; return ;
   case 2: cycleTime             = 1000 / 300 ; return ;
   
   case 4: return ;
  }
}		
	
}

script cheatDialogInv {
loop {
  Ego:
   AddChoiceEchoEx(1, "Ticket", false) ;   
   AddChoiceEchoEx(2, "Map", false) ;  
   AddChoiceEchoEx(3, "Echnaton's key and discs", false) ;
   AddChoiceEchoEx(4, "ID Card", false) ;
   AddChoiceEchoEx(5, "Fingerprint", false) ;
   
   AddChoiceEchoEx(6, "Back", false) ;	     

   
   
  var c = dialogEx ;
  
  switch c {
   case 1: takeItem(Ego, Ticket) ; cheated = true ;
   case 2: takeItem(Ego, Landkarte) ; cheated = true ;
   case 3: takeItem(Ego, Echkeydirty) ;	takeItem(Ego, ScheibeBrotlaib) ; takeItem(Ego, ScheibeSonnenscheibe) ; cheated = true ;
   case 4: takeItem(Ego, IDCard) ; cheated = true ;
   case 5: takeItem(Ego, SFormularF) ; cheated = true ;
   
   case 6: return ;
  }
}		
}

script cheatDialogVars {
loop {
  Ego:
   AddChoiceEchoEx(1, "EvictGuest", false) ;   
   AddChoiceEchoEx(2, "HasTruck", false) ;   
   AddChoiceEchoEx(3, "KnowsLab", false) ;
   AddChoiceEchoEx(4, "Back", false) ;	     

   
   
  var d = dialogEx ;
  
  switch d {
   case 1: guestEvicted = true ; cheated = true ;
   case 2: takeItem(Ego, Petrolcan) ; hasTruck = true ; cheated = true ;
   case 3: knowsDott = true ; cheated = true ;
   case 4: return ;
  }
}		
	
}

script cheatDialogJump {
loop {
  Ego:
   AddChoiceEchoEx(1, "Act 2", false) ;   
   AddChoiceEchoEx(2, "Act 3", false) ;   
   AddChoiceEchoEx(3, "Act 4", false) ;   
   AddChoiceEchoEx(4, "Act 5", false) ;	     
   AddChoiceEchoEx(5, "Back", false) ;   

   
   
  var d = dialogEx ;
  
  switch d {
   case 1: setupAct2 ; doEnter(Vorflughafen) ; cheated = true ; finish ;
   case 2: setupAct3 ; doEnter(Ausgrabungsstelle) ; cheated = true ; finish ;
   case 3: setupAct4 ; doEnter(Ausgrabungsstelle) ; cheated = true ; finish ;
   case 4: setupAct5 ; doEnter(Finaledavor) ; cheated = true ; finish ;
   case 5: return ;
  }
}	
}

script setupAct2 {
 currentAct = 2 ;
 setUpAsContainer(Ego) ;
 John.visible = false ; Jack.visible = false ; Peter.visible = false ;
 takeItem(Ego, Wallet) ; 
 takeItem(Ego, Envelope) ;
 takeItem(Envelope, Letter) ;
 takeItem(Ego, Cactus) ;
 takeItem(Ego, Carpetscrap) ;
 takeItem(Ego, Membercard) ;
}

script setupAct3 {
  John.visible = false ; Jack.visible = false ; Peter.visible = false ;
  currentAct = 3 ;
  knowsHotel = true ;
  escapedEchnaton = false ;
  knowsBrander = true ;
  knowsHeadquarters = true ;
  hasTruck = true ;
  hasRoom = true ;
  knowsExcavation = true ;
  wonciekAtHotel = true ;
  talkedToWonciek = true ;
  guestEvicted = 1 ;
  seenWonciek = true ;
  takeItem(Ego, Shim) ;
  Shim:
   setField(0, 1) ;
   setAnim(Graphics::Shimlace_image) ;
   name = "Schn]rsenkel an Unterlegscheibe" ;
  takeItem(Ego, Newspaper) ;  
  takeItem(Ego, Shoe) ;  
  takeItem(Ego, Carpetscrap) ;
  takeItem(Ego, Petrolcan) ;
  takeItem(Ego, DiaryInv) ;
  takeItem(Ego, Cactus) ;
}

script setupAct4 {
  John.visible = false ; Jack.visible = false ; Peter.visible = false ;	
  currentAct = 4 ;
  knowsHotel = true ;
  escapedEchnaton = true ;
  knowsBrander = true ;
  knowsHeadquarters = true ;
  hasTruck = true ;
  hasRoom = true ;
  knowsExcavation = true ; 
  WonciekAtHotel = true ;
  talkedToWonciek = true ;
  guestEvicted = 1 ;
  seenWonciek = true ;
  takeItem(Ego, Shim) ;
  Shim:
   setField(0, 1) ;
   setAnim(Graphics::Shimlace_image) ;
   name = "Schn]rsenkel an Unterlegscheibe" ;
  takeItem(Ego, Newspaper) ;  
  takeItem(Ego, Shoe) ;  
  takeItem(Ego, Flashlight) ;
  takeItem(Ego, Screwdriver) ;
  takeItem(Ego, Cactus) ;
}

script setupAct5 {
  John.visible = false ; Jack.visible = false ; Peter.visible = false ;	
}