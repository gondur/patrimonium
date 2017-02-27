// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

const dialogEx_MaxLines = 6 ; // Maximum number of lines arranged at screen bottom
const dialogEx_MaxLineWidth = 600 ; // Maximum line width before wrapping occurs
var dialogEx_Font = STATUS_FONT ; // Font used to draw lines
var dialogEx_AutoResetChoices = true ;

object dialogEx_ClickLines[dialogEx_MaxLines] ;
string dialogEx_TextLines[dialogEx_Maxlines] ;
var dialogEx_FontHeight = 0 ;
var dialogEx_HoverLine = -1 ;
var dialogEx_LineToSay = -1 ;
var dialogEx_Scroll = 0 ;

script setupDialogEx { 
 dialogEx_FontHeight = 0 ;
 for (int i=0;i<=GetSpriteFrameCount(dialogEx_Font);i++) {
  int fh = GetSpriteFrameHeight(dialogEx_Font, i) ;
  if (fh > dialogEx_FontHeight) dialogEx_FontHeight = fh ;
 }	 
 
 for (i=0; i<dialogEx_MaxLines; i++) { 
  activeObject = dialogEx_ClickLines[i] ; 
  class = dialogEx_ClickTextLineClass; 
  enabled = false ; 
  PositionY = ScreenHeight - ( fh / 2) - (dialogEx_MaxLines - i) * (fh + fh / 2) ; 
  PositionX = 5; 
  Priority = 255 ;
  setClickArea(0,0,dialogEx_MaxLineWidth,dialogEx_FontHeight-2);   
 }

 SetupAsContainer(dialogEx_ClickTextLineClass) ; // Echo
 SetupAsContainer(dialogEx_ScrollDown) ;         // Strings
 SetupAsContainer(dialogEx_ScrollUp) ;           // Indices
}

script InstallGameInputHandlerEx(ScriptIndex) {
 static var CurrentGameInputHandler = -1 ; 
 var old = CurrentGameInputHandler ;
 InstallGameInputHandler(ScriptIndex) ;
 CurrentGameInputHandler = ScriptIndex ;
 return old ;
} 

script dialogEx_GetFontCharWidth(Font,Char) {
 if (char <= 33) return 5 ;
 return GetSpriteFrameWidth(Font,char-33) ;	 
} 

object dialogEx_ObjectClass { enabled = false ; }

object dialogEx_ClickTextLineClass {
 class = dialogEx_ObjectClass ;
 enabled = false ;
 visible = true ;
 clickable = true ;
 absolute = true ;
 Priority = 255 ;
 member TextLine = 0 ;
 member LineID = 0 ;
}

event animate dialogEx_ClickTextLineClass {
  if (mouseIn(positionX+clickAreaX1,positionY+clickAreaY1,positionX+clickAreaX2,positionY+clickAreaY2)) dialogEx_HoverLine = lineID ;
  if (!mouseIn(5,360,605,475)) dialogEx_HoverLine = -1 ;
}

// Stefahn, das funktioniert so doch nicht richtig bei Zeilenumbrüchen!!!

//event mouseover dialogEx_ClickTextLineClass { dialogEx_HoverLine = LineID ; }
//event mouseoff dialogEx_ClickTextLineClass { if (dialogEx_HoverLine == LineID) dialogEx_HoverLine = -1 ; }

event default -> dialogEx_ClickTextLineClass { dialogEx_LineToSay = lineID ; resume ; } 

event paint dialogEx_ClickTextLineClass {	
 drawingPriority = 255 ;
 drawingTextColor = captionColor ;
 drawingColor = captionColor ; 
 drawingFont = dialogEx_Font ;
 
 static int indentwidth = dialogEx_GetFontCharWidth(dialogEx_font,94) + 2;
 static int LastLineID = -1 ;
 
 if (TextLine == 0) LastLineID = -1 ;
 if (LineID == dialogEx_HoverLine) { CaptionColor = COLOR_YELLOW ; } else { CaptionColor = COLOR_WHITE ; }
 if (LastLineID != LineID) drawText(PositionX,PositionY+dialogEx_FontHeight,"^") ;
 drawText(PositionX + indentwidth,PositionY+dialogEx_FontHeight,dialogEx_TextLines[TextLine]) ;
 LastLineID = LineID ;
} 

object dialogEx_Background {
  enabled = false ;
  visible = true ;
  absolute = true ;
  clickable = false ;
  autoAnimate = false ;
  setAnim(Graphics::Interface_sprite) ; 
  frame = 1 ;
  Priority = 254 ;
  setPosition(0,360) ; 
} 

object dialogEx_ScrollUp {
 class = dialogEx_ObjectClass ;
 enabled = false ;
 visible = true ;
 absolute = true ;
 clickable = true ;  
 setClickArea(0,0,27,42) ;
 Priority = 255 ;
 
 member StaticFrame = 11 ;
 member HoverFrame = 13 ;
 member ScrollBy = -1 ;

 setPosition(610,364) ;
 autoAnimate = false ;
 setAnim2V(Graphics::Interface_sprite,Graphics::Interface_sprite) ;
 Frame = StaticFrame ;
 Direction = DIR_WEST ;
} 

object dialogEx_ScrollDown {
 class = dialogEx_ScrollUp ;
 setPosition(610,435) ;
 
 StaticFrame = 12 ;
 HoverFrame = 14 ;
 ScrollBy = 1 ;
 Frame = StaticFrame ;
}	 

event mouseover dialogEx_ScrollUp { 
 if (suspended) return ;
 Direction = DIR_EAST ;
 Frame = HoverFrame ;
}

event mouseoff dialogEx_ScrollUp {
 if (suspended) return ;
 Direction = DIR_WEST ;
 Frame = StaticFrame ;
}

event default -> dialogEx_ScrollUp {
 dialogEx_Scroll = dialogEx_Scroll + ScrollBy ;
 dialogEx_Update ;
 resume ;
}

script dialogEx_Update {
 int LineCount = GetContainerSize(dialogEx_ScrollDown) ;
 if (dialogEx_Scroll < 0) { dialogEx_Scroll = 0 ; }
 if (dialogEx_Scroll > LineCount) { dialogEx_Scroll = LineCount - 1 ; }
 dialogEx_ScrollUp.enabled = (dialogEx_Scroll > 0) ;
 dialogEx_ScrollDown.enabled = false ;	 
 
 var curtext = 0 ;
 var StrPos = 0 ;
 var StrLine = 0 ;
 for (int i=0;i<dialogEx_MaxLines;i++) { activeObject = dialogEx_ClickLines[i] ; enabled = false; }
 for (int Line = 0; Line < dialogEx_MaxLines; Line++) {
  if (StrLine+dialogEx_Scroll >= LineCount) return 0 ;
  
  activeObject = dialogEx_ClickLines[Line] ;
  LineID = StrLine + dialogEx_Scroll ;
  CurText = GetFromContainer(dialogEx_ScrollDown, LineID) ;
  enabled = true ;
  TextLine = Line ; 
  
  int Len = StringLength(CurText) ;
  StrPos = dialogEx_FillClickLine(CurText,StrPos,Len,Line,dialogEx_MaxLineWidth) ;
  if (StrPos >= Len) { StrLine = StrLine + 1 ; StrPos = 0; } 
 } 
 if ((StrPos != 0) or (dialogEx_Scroll < LineCount - StrLine)) dialogEx_ScrollDown.enabled = true ;
} 

script dialogEx_FillClickLine(str,char,Len,line,width) {
 var startchar = char ; 
 var lastchar = char ;
 var curwidth = 0 ; 
 
 while (char < len) and (curwidth < width) {
  if (StringGetChar(str,char) == 32) { lastchar = char; }
  CurWidth = CurWidth + dialogEx_GetFontCharWidth(dialogEx_FONT, StringGetChar(str,char)) ;
  char = char + 1 ;
 } 
 
 if (char >= len) lastchar = char ;
 StringClear(dialogEx_TextLines[Line]) ;
 for (int i=startchar; i<lastchar; i++) { StringAppendChar(dialogEx_TextLines[Line],StringGetChar(str,i)) ; }
 if (char < len) for (i=0;i<3;i++) { StringAppendChar(dialogEx_TextLines[Line],46) ; } 
 return lastchar + 1 ;
} 

script AddChoiceEx(ID, Text) { AddChoiceEchoEx(ID,Text,true); }

script AddChoiceEchoEx(ID, Text, Echo) {
 /*int s = GetContainerSize(dialogEx_ScrollDown) ;
 if (s > 0) {
  int i = 0 ;
  int cid = GetFromContainer(dialogEx_ScrollUp,i) ;
  while (cid <= id) and (i+1 < s) { i += 1 ; cid = GetFromContainer(dialogEx_ScrollUp,i) ; }
  if (i+1 <= s) {
   InsertIntoContainer(dialogEx_ScrollUp,i,ID) ;
   InsertIntoContainer(dialogEx_ScrollDown,i,Text) ;
   InsertIntoContainer(dialogEx_ClickTextLineClass,i,Echo) ;   
   return 0 ;
  }
 }*/
 
 AppendToContainer(dialogEx_ScrollUp,ID) ;
 AppendToContainer(dialogEx_ScrollDown,Text) ;
 AppendToContainer(dialogEx_ClickTextLineClass,Echo) ;
} 

script dialogEx_Handler(key) {
 switch key {
    case <LBUTTON>:
      if (isClassDerivate(ObjectUnderMouse,dialogEx_ObjectClass)) { TriggerMouseClickEvent() ; } 
      
    case <-MOUSEWHEEL>, <DOWN>: if (dialogEx_ScrollDown.enabled) { dialogEx_Scroll = dialogEx_Scroll +1 ; dialogEx_Update ; resume ; }
    
    case <MOUSEWHEEL>, <UP>: if (dialogEx_ScrollUp.enabled) { dialogEx_Scroll = dialogEx_Scroll -1 ; dialogEx_Update ; resume ; }
      
    }
}

script RemoveChoiceEx(OriginalCode) {
 var pos = LocateInsideContainer(dialogEx_ScrollUp, OriginalCode) ;
 while (pos >= 0) {
  RemoveFromContainerByIndex(dialogEx_ClickTextLineClass, pos) ;
  RemoveFromContainerByIndex(dialogEx_ScrollDown, pos) ;
  RemoveFromContainerByIndex(dialogEx_ScrollUp, pos) ;
  pos = LocateInsideContainer(dialogEx_ScrollUp, OriginalCode) ;
 }
}

script ResetdialogEx {
 ResetContainer(dialogEx_ScrollUp) ;
 ResetContainer(dialogEx_ScrollDown) ;
 ResetContainer(dialogEx_ClickTextLineClass) ;
}

script ReplaceChoiceEx(OriginalCode, ReplaceCode, ReplaceText, Echo) {
 var pos = LocateInsideContainer(dialogEx_ScrollUp, OriginalCode) ;
 if (pos < 0) return false ;
 ReplaceContainerItemByIndex(dialogEx_ScrollUp, pos, ReplaceCode) ;
 ReplaceContainerItemByIndex(dialogEx_ScrollDown, pos, ReplaceText) ;
 ReplaceContainerItemByIndex(dialogEx_ClickTextLineClass, pos, Echo) ;
} 

script dialogEx {
 activeObject = Ego ;
 var size = GetContainerSize(dialogEx_ScrollDown) ;
 if (size <= 0) return -1 ;
 if (size == 1) {
  if (GetFromContainer(dialogEx_ClickTextLineClass,0)) say(GetFromContainer(dialogEx_ScrollDown,0));
  var ret = GetFromContainer(dialogEx_ScrollUp, 0) ;
  if (dialogEx_AutoResetChoices) ResetdialogEx ;
  return ret ;
 } 
 
 var oldactive = activeObject ;
 var oldstate = suspended ;
 if (suspended) resume ;  
 var oldhandler = InstallGameInputHandlerEx(&dialogEx_Handler);  
 
 dialogEx_Background.enabled = true ;
 dialogEx_HoverLine = -1 ;
 dialogEx_Scroll = 0 ;
 dialogEx_Update ;
 dialogEx_LineToSay = -1 ; 
 
 HideInventory ;
 while (dialogEx_LineToSay < 0) { delay(1) ; }
 for (int i=0; i<dialogEx_MaxLines; i++) { activeObject = dialogEx_ClickLines[i]; enabled = false ; } 
 ShowInventory ;
 
 dialogEx_Background.enabled = false ; 
 dialogEx_ScrollDown.enabled = false ;
 dialogEx_ScrollUp.enabled = false ;
 
 InstallGameInputHandlerEx(oldhandler) ;
 if (oldstate) suspend ;
	 
 activeObject = oldactive ;
 if (GetFromContainer(dialogEx_ClickTextLineClass,dialogEx_LineToSay)) say(GetFromContainer(dialogEx_ScrollDown,dialogEx_LineToSay));
 ret = GetFromContainer(dialogEx_ScrollUp, dialogEx_LineToSay) ;
 if (dialogEx_AutoResetChoices) ResetdialogEx ;
 return ret ;
} 