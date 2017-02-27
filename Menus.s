// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// Menus.s - our menu which appears
//        by pressing <ESC>.
// ----------------------------------

// Savegame variables

var    SLOT_FILENAME = "Savegame.data" ;   // name of savegame file

const  MAX_SLOTS = 32 ;                    // maximum number of saved games
const  SCREEN_SLOTS = 11 ;                 // number of slots that fit on the screen
var    slotUsed[MAX_SLOTS] ;               // tells whether a slot has been used already
string slotName[MAX_SLOTS] ;               // user-defined savegame name
int    slotScroll;                         // top slot on the menu
int    slotOffset;                         // top slot + this offset = current position on menu
int    lastUsedSavegame = -1 ;

script InitMenus() {  
  drawingFont = defaultFont ; //Fonts::Akt1_font ;
  drawingJustify = JUSTIFY_CENTER ;  
}

object FixLoadingErrors { enabled = false ; member SceneToRestore = -1; member ZBufferToRestore = -1; } 

event animate FixLoadingErrors { 
 if (!FixLoadingErrors.enabled) return ; 
 backgroundZBuffer = zBufferToRestore ;  
 if (jukeBox.current != -1) and (GetMusicPosition(jukeBox.CurRes)==0) {   markResource(jukeBox.CurRes) ;   StartMusic(jukeBox.CurRes) ;      } 
 FixLoadingErrors.enabled = false ; 
} 
 
script SaveGameEx(slot) { // we have to reload the zbuffer after a game is restored due to a bug in AGAST
 fixLoadingErrors.enabled = true ; 
 fixLoadingErrors.SceneToRestore = currentScene ; 
 fixLoadingErrors.ZBufferToRestore = backgroundZBuffer ; 
 saveGame(slot) ;
 fixLoadingErrors.enabled = false ; 
} 

script fileExists(filename) {
  var file = fileOpen(filename, "rb");
  if file {
    fileClose(file);
    return true ;
  } else return false ;
}

script createSlotNames {
  int i;
  for (i = 0; i < MAX_SLOTS; i++) {
    StringCopy(SlotName[i], "<leer>");
    SlotUsed[i] = false ;
  }
}

script readSlotFile {
  var f = fileOpen(SLOT_FILENAME, "rb");
  int i;
  for (i = 0; i < MAX_SLOTS; i++) {
      fileReadString(f, slotName[i], 0, 200) ;
      slotUsed[i] = fileReadChar(f) ;      
  }
  lastUsedSavegame = fileReadInt(f) ;
  fileClose(f);
}

script getNextSlot {
  if (not fileExists(SLOT_FILENAME)) return 0 ;
  var f = fileOpen(SLOT_FILENAME, "rb");
  int i;	
  for (i = 0; i < MAX_SLOTS; i++) {	
      FileReadString(f, slotName[i], 0, 200) ;
      SlotUsed[i] = fileReadChar(f) ;
      if (not slotUsed[i]) return i ;      
  }
  fileClose(f);
}

script akt3Save {
  static var madeAkt3Save = false ;
  if (!madeAkt3Save) {
    var a = getNextSlot ;
    stringCopy(slotName[a], "Akt 3 Sicherungsspielstand") ;
    SlotUsed[a] = true ;    
    lastUsedSavegame = a ;
    WriteSlotFile;
    madeAkt3Save = true ;
    SaveGameEx(a) ;	
  }
}

script mouseIn(x1, y1, x2, y2) {       
  return (MouseX >= x1 and MouseX <= x2 and MouseY >= y1 and MouseY <= y2) ;
}

script writeSlotFile {
  var file = fileOpen(SLOT_FILENAME, "wb");
  int i;
  for (i = 0; i < MAX_SLOTS; i++) {
      fileWriteString(file, slotName[i]) ;
      fileWriteChar(file, 0) ;
      fileWriteChar(file, slotUsed[i]) ;
  }
  fileWriteInt(file, lastUsedSavegame) ;
  fileClose(file);
}

/* ************************************************************* */

script MainMenu() {
  if (FileExists(SLOT_FILENAME)) readSlotFile ;
    else createSlotNames ;
  Menu(&MainMenu_Handler) ;
}

script MainMenu_Handler(key) {
  
  switch key {
    case <INIT>: InitMenus() ;
    case <DRAW>:
      var odc = drawingColor ;
      drawingPriority = 256 ;
      drawingColor = RGBA(255,255,255,255) ;
      drawImage(0,0,Graphics::menu_image) ;                   // draw background
      drawHighlight ;                                         // draw mouseover captions  
      int i ;      
      for (i = 0; i < SCREEN_SLOTS; i++) {                    // draw slot names
        if (i == SlotOffset) {
          drawingTextColor = RGB(187,220,253) ;                 // highlight selected slot with another drawing color
        } else {
          drawingTextColor = RGB(95,143,191) ;          
        }          
	drawingFont = defaultFont ;
        drawText(113-i, 160 + i*23, SlotName[SlotScroll + i]) ;
      }
      drawingColor = odc ;

    case <-MOUSEWHEEL>, <DOWN>:
      MainMenu_ScrollDown() ;

    case <MOUSEWHEEL>, <UP>:
      MainMenu_ScrollUp() ;

    case <PGDN>:
      MainMenu_PageDown() ;
      
    case <PGUP>: 
      MainMenu_PageUp() ;
    
    case <HOME>:
      SlotScroll = 0 ;
      SlotOffset = 0 ;
      
    case <END>:
      SlotScroll = MAX_SLOTS - SCREEN_SLOTS - 1 ;
      SlotOffset = SCREEN_SLOTS - 1 ;
    
    case <LBUTTON>:
      if MouseIn(411,157,597,198) {                 // save
	if (currentscene != GameMenu) SaveMenu() ;
      } else if MouseIn (411,199,597,238) {         // load
        if SlotUsed[SlotScroll + SlotOffset] {
          AskMenu("Spiel laden?", ASK_RESTORE) ;
        }
      } else if MouseIn (411,239,597,277) {         // minimize
        MinimizeGame() ;        
      } else if MouseIn (411,320,597,359) {         // back        
        drawingFont = Fonts::AgastSmall_font ; return 1 ;        
      } else if MouseIn (411,278,597,319) {         // quit      
        AskMenu("Spiel beenden?", ASK_QUIT) ;                
      } else if MouseIn(48,109,94,142) {            // up
        MainMenu_PageUp() ;
      } else if MouseIn(50,392,90,427) {            // down
        MainMenu_PageDown() ;
      } else if MouseIn (110, 160-23, 360, 400) {
        SlotOffset = (MouseY-160+23) / 23 ;
        if SlotOffset > SCREEN_SLOTS - 1 {
          SlotOffset = SCREEN_SLOTS - 1 ;
        }
      }

    case <ESC>, <F5>:
      return 1;
  }  
}

script drawHighlight {
 if MouseIn (411,157,597,198) and (currentscene != GameMenu) { drawSprite(411,157,Graphics::menuhl_sprite,0) ; } // save
 if MouseIn (411,199,597,238) and (SlotUsed[Slotscroll + SlotOffset]) { drawSprite(411,199,Graphics::menuhl_sprite,1) ; } // load
 if MouseIn (411,239,597,277) { drawSprite(411,239,Graphics::menuhl_sprite,2) ; } // minimize
 if MouseIn (411,278,597,319) { drawSprite(411,277,Graphics::menuhl_sprite,3) ; } // quit 
 if MouseIn (411,320,597,359) { drawSprite(411,321,Graphics::menuhl_sprite,4) ; } // back

 
 if MouseIn (48,109,94,142)   { drawSprite(54,111,Graphics::menuhl_sprite,5)  ; } // up
 if MouseIn (50,392,90,427)   { drawSprite(51,389,Graphics::menuhl_sprite,6)  ; } // down
}

script MainMenu_ScrollUp {
  if SlotOffset > 0 {
    SlotOffset--;
  }
  else if SlotScroll > 0 {
    SlotScroll--;
  }
}

script MainMenu_ScrollDown {
  if SlotOffset < SCREEN_SLOTS - 1 {
    SlotOffset++;
  }
  else if SlotScroll < MAX_SLOTS - SCREEN_SLOTS - 1 {
    SlotScroll++;
  }
}

script MainMenu_PageUp {
  int i;
  SlotOffset = 0;
  for (i = 0; i < 8; i++) {
    MainMenu_ScrollUp();
  }
}

script MainMenu_PageDown {
  int i;
  SlotOffset = 7;
  for (i = 0; i < 8; i++) {
    MainMenu_ScrollDown();
  }
}

/* ************************************************************* */

var AskMenu_Message ;
var AskMenu_Mode ;

const ASK_SAVE = 0 ;
const ASK_RESTORE = 1 ;
const ASK_RESTART = 2 ;
const ASK_QUIT = 3 ;

script AskMenu(message, mode) {
  AskMenu_Message = message ;
  AskMenu_Mode = mode ;
  Menu(&AskMenu_Handler) ;
}

script AskMenu_Yes() {
  switch AskMenu_Mode {
    case ASK_SAVE: ;
     // lastUsedSavegame = SlotScroll + SlotOffset ;
     // WriteSlotFile ;
     // SaveGameEx(SlotScroll + SlotOffset) ;
    case ASK_RESTORE:
       RestoreGame(SlotScroll + SlotOffset) ;          
    case ASK_RESTART:
      RestartGame() ;
    case ASK_QUIT:
      QuitGame() ;
  }  
  return 1 ;
}

script AskMenu_Handler(key) {
  switch key {
    case <INIT>: 
      InitMenus() ;
    case <DRAW>:
      var odc = drawingColor ;
      drawingPriority = 256 ;
      drawingColor = RGBA(255,255,255,255) ;
      drawImage(0,0,Credits::credits_image) ;	    
      var x = 640 / 2 - GetStatusTextLength(AskMenu_Message) / 2 ;
      drawingTextColor = RGB(187,220,253) ;
      drawingFont = defaultFont ;
      drawText(x, 240, AskMenu_Message) ;
      drawingTextColor = RGB(95,143,191) ;
      if (MouseIn(150, 280-30, 160+25, 280+2)) drawingTextColor = RGB(187,220,253) ;
      drawingFont = defaultFont ;
      drawText(160, 280, "Ja") ;
      if (MouseIn(430, 280-30, 440+40, 280+2)) drawingTextColor = RGB(187,220,253) ;
       else drawingTextColor = RGB(95,143,191) ;	            
      drawText(440, 280, "Nein") ;
      drawingTextColor = RGB(187,220,253) ;
      if (AskMenu_Mode == ASK_RESTORE) {
	//var hint = "Hinweis: Es kann nur einmal pro Spielstart geladen werden." ;
	drawText(150, 360,  "Hinweis: Es kann aufgrund eines Fehlers") ;
	drawText(145, 380,  "nur einmal pro Spielstart geladen werden.") ;
      }
      drawingColor = odc ;

    case <LBUTTON>:
      if MouseIn(150, 280-30, 160+25, 280+2) {      // JA 
        AskMenu_Yes() ;
      }
      else if MouseIn(430, 280-30, 440+40, 280+2) { // NEIN  
        MainMenu() ;       
	return 1 ;
      }

    case <ESC>, <RBUTTON>, <N>:
      return 1 ;
      
    case <Y>:
      AskMenu_Yes() ;
  }
}

/* ************************************************************* */

string StringInputMenu_InputString ;
var StringInputMenu_PromptString ;
var StringInputMenu_UserCancelled ;

script StringInputMenu_Handler(key) {
  switch key {
    case <INIT>:
      InitMenus() ;
      
    case <DRAW>:
      var odc = drawingColor ;
      drawingPriority = 256 ;
      drawingColor = RGBA(255,255,255,255) ;
      drawImage(0,0,Credits::credits_image) ;      
      drawingColor = odc ;
      
      var x = 640 / 2 - GetStatusTextLength(StringInputMenu_PromptString) / 2 ;
      drawingTextColor = RGB(187,220,253) ;
      drawingFont = defaultFont ;
      drawText(x, 240, StringInputMenu_PromptString) ;
      drawText(70, 270, ">") ;            
      drawingTextColor = RGB(95,143,191) ;
      drawText(85, 270, StringInputMenu_InputString) ;
      if (MouseIn(400, 300-30, 440, 300+2)) drawingTextColor = RGB(187,220,253) ;
      drawingFont = defaultFont ;
      drawText(410, 300, "OK") ;
      drawingTextColor = RGB(95,143,191) ;
      if (MouseIn(460, 300-30, 570, 300+2)) drawingTextColor = RGB(187,220,253) ;
      drawText(470, 300, "Abbrechen") ;

    case <LMOUSE>:
      if MouseIn(400, 300-30, 440, 300+2) {              // OK
        StringInputMenu_UserCancelled = false ;
        return true ;
      }
      if MouseIn(460, 300-30, 570, 300+2) {              // Abbrechen
        StringInputMenu_UserCancelled = true ;
        MainMenu() ;
        return true ;
      }

    case <ENTER>:
      StringInputMenu_UserCancelled = false ;
                return true ;

    case <ESC>:
            StringInputMenu_UserCancelled = true ;      
                  return true ;

    case <BACKSPACE>:
            if StringLength(StringInputMenu_InputString) >= 1 {
              StringStripChar(StringInputMenu_InputString) ;
            }

    case <SPACE>:
      StringInputMenu_InsertChar(0x20) ;
            
    default:
      if key > 0 {
        int ch = KeyToChar(key);
        StringInputMenu_InsertChar(ch) if ch ;
      }
        }
}

script StringInputMenu_InsertChar(ch) {
  return if (StringLength (StringInputMenu_InputString) > 20) ;
  StringAppendChar(StringInputMenu_InputString, ch) ;
}

script SaveMenu() {         
  StringInputMenu_PromptString = "Gib einen Namen f]r den Spielstand ein!" ;
  if SlotUsed[SlotScroll + SlotOffset] {
    StringCopy(StringInputMenu_InputString, SlotName[SlotScroll + SlotOffset]) ;  
  } else {
    StringCopy(StringInputMenu_InputString, "") ;
  }  
  start {
    return if StringInputMenu_UserCancelled ;    
    StringCopy(SlotName[SlotScroll + SlotOffset], StringInputMenu_InputString) ;
    SlotUsed[SlotScroll + SlotOffset] = true ;    
    lastUsedSavegame = Slotscroll + SlotOffset ;
    WriteSlotFile;
    SaveGameEx(SlotScroll + SlotOffset) ;
  }  
  Menu(&StringInputMenu_Handler) ;
}