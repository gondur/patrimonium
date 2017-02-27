// ---------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ---------------------------------
//  use together with "interface.s" 
// ---------------------------------
//  implements container, interface 
//      and inventory functions
// ---------------------------------

// Entities refered to as "items" are basically global non-scene objects that can be acquired by any actor
// that was formatted as container. Their only purpose is to be displayed in the inventory bar and be used
// by the user for interaction with the verbs at his/her disposal and for combination with other objects.
//
// Do not call TakeItem() or DropItem() within object initialization scripts or the Main() script,
// because other necessary objects could not yet have been created when the script is being executed.
// e.g. if you call TakeItem(Ego, Bulb) within Ego's initialization script "Object Ego { TakeItem(Ego, Bulb); }",
// object "bulb" could not yet exist, and the call would therefor fail and the game could crash.
// To endow players with items they are to have at the beginning of the game, add those items within 
// the Enter() script of the first room that is being displayed.

// -- container functions --
//
// SetupAsContainer(Container)  - Prepares an object to be used as container and empties it (endows it with own inventory)
// TakeItem(Container,Item)     - Places an item into a container
// DropItem(Container,Item)     - Removes an item from a container
// MoveItem(Src,Dst,Item)       - Moves an item from container src to container dst, same as { drop(src,obj); take(dst,obj); }
// HasItem(Container,Item)      - Tests whether an item is present within a certain container
// GetItem(Container,Index)     - Returns an item identified by its index (0 to itemcount-1)
// GetItemCount(Container)      - Returns the number of items within a container

// -- interaction functions --
//
// clearAction      - Resets interaction system, selects standard verb, calls resume() to return control to user
// PassItem(Item)   - Selects item as first item for 2-item-events, calls resume() to return control to user
// Did(Verb)        - Tests if a certain verb was used to trigger an event, 
//                    handy to obtain the verb that triggered a 2-item-event (e.g. use or give)
// SelectVerb(Verb)      - Resets interaction system and selects a certain verb, does NOT call resume()
// SetStandardVerb(Verb) - Selects a new standard verb. Pass -1 if you do not want a default verb to be used/displayed

// -- interface functions --
//
// SetupAsVerb(Component,Left,Top,Width,Height,NormalSprite,NormalFrame,HoverSprite,HoverFrame,VerbString,SuffixString,AddToInterface)
//                             - Formats a certain component to be used as verb. If the verb should not be displayed as button on the
//                               interface, all position and animation parameters should be zero and AddToInterface must be false.
//                               SetupAsVerb may be called within the initialization script of an verb-object, but INTERFACE_DUMMY must
//                               have been created before these verb-objects - just declare those objects in "Interface.s" at the marked positions.
//
// INTERFACE_CLEAR             - Removes all visual components (Verbs,ScrollButtons,Backgrounds) from the interface.
//                               Verbs that are not shown in the interface can still be manually selected for interaction, 
//                               but the button that belongs to it will no longer be available in the interface.
// INTERFACE_ADD(Component)    - Puts a component on the interface.
//                               Verbs must have been formatted using SetupAsVerb(), ScrollButtons using SetupAsScrollButton().
// INTERFACE_REMOVE(Component) - Removes a single component from the interface.
//
// INTERFACE_SHOW      - Increases visibility variable by 1, interface is being drawn when visibility > 0  
// INTERFACE_HIDE      - Decreases visibility variable by 1, interface is being hidden when visibility <= 0     
// INTERFACE_FORCESHOW - Sets visibility variable to 1, interface is being drawn      
// INTERFACE_FORCEHIDE - Sets visibility variable to 0, interface is being hidden      

// -- statusline functions --
//
// STATUS_SETLAYOUT(Left,Top,Width,Height,Font,TextColor) - Used to alter status bar appearance at runtime.
//                                                          If you are always using the same status line layout, 
//                                                          assign proper initialization values in "interface.s" and don't call this function.
//                                                          Perhaps handy for displaying statusbar only in some scenes...
// STATUS_SHOW      - Increases visibility variable by 1, statusbar is being drawn when visibility > 0  
// STATUS_HIDE      - Decreases visibility variable by 1, statusbar is being hidden when visibility <= 0     
// STATUS_FORCESHOW - Sets visibility variable to 1, statusbar is being drawn      
// STATUS_FORCEHIDE - Sets visibility variable to 0, statusbar is being hidden      
//
// Visibility isn't handled as true/false to make it possible to call STATUS_HIDE before e.g. dialogExs are being displayed
// and to call STATUS_SHOW afterwards, without having to worry about whether statusbar was visible before hiding.

// -- inventory functions --
//
// INV_SETLAYOUT(Left,Top,SlotWidth,SlotHeight,XShift,YShift,Rows,Cols,Mode) 
//                             - Used to alter inventory appearance at runtime, if you are always using the same inventory layout, 
//                               assign proper initialization values to "INV_"-Vars in "interface.s" and don't call this function.
//                               Perhaps handy for displaying the inventory content fullscreen in some choose-an-item scenes...
//
// INV_SETCONTAINER(Container) - Sets the current inventory container, whose content is used to fill the inventory.
//                               Use this function to switch between actors and their inventories. (FOA: Indy/Sophia)
//
// INV_SHOW                    - Increases visibility variable by 1, inventory items are being drawn when visibility > 0  
// INV_HIDE                    - Decreases visibility variable by 1, inventory items are being hidden when visibility <= 0     
// INV_FORCESHOW               - Sets visibility variable to 1, inventory items are being drawn      
// INV_FORCEHIDE               - Sets visibility variable to 0, inventory items are being hidden      
// INV_TAKEITEM(item)          - Adds a certain item to the current inventory container
// INV_DROPITEM(item)          - Removes a certain item from the current inventory container
// INV_HASITEM(item)           - Tests whether a certain item is within the current inventory container
// INV_GETITEM(index)          - Returns an item identified by its index (0 to itemcount-1) from within the current inventory container
// INV_GETITEMCOUNT            - Returns the number of items in current inventory container
// INV_SCROLLTO(Position)      - Scrolls inventory to the desired position (if possible)
// INV_SCROLLBY(Alteration)    - Scrolls inventory relatively to its current row (x items up/down)
//
// INV_UPDATE                  - Used internally to organize rows and align items
//                             > MODIFY TO FEATURE INVENTORY STYLES OTHER THAN SCUMM <

/* CONSTANTS FOR INTERNAL USE ONLY - DO NOT MODIFY */
var INV_MEMBERBASE = 40 ; 
var INV_VISIBLE = 0 ;   
var INV_CONTAINER = -1 ;    
var INV_CURSCROLL = 0 ;
var LightOffObjLabel = "????" ;

const INTERFACE_MEMBERBASE = 40;
var INTERFACE_VISIBLE = 0 ;
var STATUS_VISIBLE = 0 ;
var CV = -1 ; 
var SV = -1 ; 
/* *********************************************** */

script takeItem(Container,Item) {
 var ao = activeObject ;
 if (Container == -1) return false ;
 if (Item == -1) return false ; 
 activeObject = Container ;

 int i = INV_MEMBERBASE ;
 var obj = GetField(i) ;
 while (obj != -1) { 
  i = i + 1; 
  if (obj == Item) { activeObject = ao ; return false ; }
  obj = GetField(i) ; 
 } 
 
 SetField(i,Item) ;
 SetField(i+1,-1) ;
 
 activeObject = Item ;
 visible = false ;
 enabled = false ;
 
 if (INV_CONTAINER == Container) INV_UPDATE ;
 activeObject = ao ;
 return true ;
}

script dropItem(Container,Item) {
 var ao = activeObject ;
 if (Container == -1) return false ;
 if (Item == -1) return false ; 
 activeObject = Container ;

 int pos = -1 ;
 int lst = INV_MEMBERBASE ;
 var obj = GetField(lst) ;
 while (obj != -1) { 
  if (obj == Item) { pos = lst ; }
  lst = lst + 1; 
  obj = GetField(lst) ;
 } 
 if (pos < 0) { activeObject = ao ; return false ; }
 lst = lst - 1 ;
 
 while (pos != lst) {
  SetField(pos, GetField(pos+1)) ;
  pos = pos + 1 ;
 }
 SetField(lst,-1) ;

 activeObject = Item ;
 visible = false ;
 enabled = false ;

 if (INV_CONTAINER == Container) INV_UPDATE ;
 activeObject = ao ;
 return true ;
}

script HasItem(Container,Item) {
 var ao = activeObject ;
 if (Container == -1) return false ;
 if (Item == -1) return false ; 
 activeObject = Container ;

 int i = INV_MEMBERBASE ;
 var obj = GetField(i) ;
 while (obj != -1) and (obj != Item) { 
  i = i + 1; 
  obj = GetField(i) ; 
 } 
 if (obj != Item) { activeObject = ao ; return false ; }
 
 activeObject = ao ;
 return true ;
}

script GetItem(Container, Index) {
 var ao = activeObject ;
 if (Container == -1) return -1 ;
 activeObject = Container ;

 if (Index < 0) { activeObject = ao ; return -1 ; }
 if (Index >= GetItemCount(Container)) { activeObject = ao ; return -1 ; }
 var obj = GetField(INV_MEMBERBASE+Index) ;
 
 activeObject = ao ;
 return obj ;
}

script GetItemCount (Container) {
 var ao = activeObject ;
 if (Container == -1) return 0 ;
 activeObject = Container ;
 
 int i = 0 ;
 while (GetField(INV_MEMBERBASE+i) != -1) { i++; }
 
 activeObject = ao ;
 return i ;
}

script INV_SETCONTAINER(Container) {
 var ao = activeObject ;
 
 int iv = INV_VISIBLE ;
 if (INV_CONTAINER != -1) INV_FORCEHIDE ;
 INV_VISIBLE = iv ;
 
 INV_CONTAINER = Container ;
 if (INV_CONTAINER == -1) return true ;

 INV_UPDATE ;
 activeObject = ao ;
 return true ;	 
}

script INV_SETVISIBLE(vis) {
 var ao = activeObject ;
 INV_VISIBLE = vis ;
 INV_UPDATE ;
 activeObject = ao ;
 return true ;
}

script INV_SHOW { return INV_SETVISIBLE(INV_VISIBLE + 1) ; }
script INV_HIDE { return INV_SETVISIBLE(INV_VISIBLE - 1) ; }
script INV_FORCESHOW { return INV_SETVISIBLE( 1) ; }
script INV_FORCEHIDE { return INV_SETVISIBLE(-1) ; }

script INV_GETITEMCOUNT {
 var ao = activeObject ;
 if (INV_CONTAINER == -1) return 0 ;
 activeObject = INV_CONTAINER ;
 
 int i = 0 ;
 while (GetField(INV_MEMBERBASE+i) != -1) { i++; }
 
 activeObject = ao ;
 return i ;
}

script INV_SCROLLTO (ScrollPos) {
 var ao = activeObject ;
 INV_CURSCROLL = ScrollPos ;
 INV_UPDATE ;
 activeObject = ao ;
}

script INV_SCROLLBY (Alteration) {
 var ao = activeObject ;
 INV_CURSCROLL = INV_CURSCROLL + Alteration ;
 INV_UPDATE ;
 activeObject = ao ;
}

script INV_GETITEM(Index) {
 var ao = activeObject ;
 if (INV_CONTAINER == -1) return -1 ;
 activeObject = INV_CONTAINER ;

 if (Index < 0) { activeObject = ao ; return -1 ; }
 if (Index >= INV_GETITEMCOUNT) { activeObject = ao ; return -1 ; }
 var obj = GetField(INV_MEMBERBASE+Index) ;
 
 activeObject = ao ;
 return obj ;
}

script INV_UPDATE {
 var ao = activeObject ;
 if (INV_CONTAINER == -1) return false ;
 activeObject = INV_CONTAINER ;
 
 if (INV_VISIBLE <= 0) {
  int i = INV_MEMBERBASE ;
  var obj = GetField(i) ;
  while (obj != -1) { 
   i = i + 1 ;
   activeObject = obj ;
   enabled = false ;
   visible = false ;
   activeObject = INV_CONTAINER ;
   obj = GetField(i) ;
  }	
  return true ;  
 }
 
 int ItemCount = INV_GETITEMCOUNT ;
 int MaxScroll = 0 ;
 int s = 0 ;
 switch INV_MODE {
  case 0 : MaxScroll = ( (ItemCount-1) / INV_COLS ) + 1 ;  
           if (INV_CURSCROLL >= MaxScroll) INV_CURSCROLL = MaxScroll-1 ;
           if (INV_CURSCROLL < 0) INV_CURSCROLL = 0 ;
	   s = INV_CURSCROLL * INV_COLS ;
  case 1 : MaxScroll = ( (ItemCount-1) / INV_ROWS ) + 1 ;  
           if (INV_CURSCROLL>= MaxScroll) INV_CURSCROLL = MaxScroll-1 ;
           if (INV_CURSCROLL < 0) INV_CURSCROLL = 0 ;
	   s = INV_CURSCROLL * INV_ROWS ;
  case 2 : if (INV_CURSCROLL >= ItemCount) INV_CURSCROLL = ItemCount - 1;
           if (INV_CURSCROLL < 0) INV_CURSCROLL = 0 ;
	   s = INV_CURSCROLL ;
 } 
 
 int e = (INV_ROWS * INV_COLS) + s ; 
 for (i = 0 ; i < ItemCount ; i++) {
  activeObject = INV_CONTAINER ;
  activeObject = GetField(INV_MEMBERBASE+i) ;
  if (i >= s) and (i < e) {
   absolute = true ;
   
   // SET POSITION FOR ITEM IN SLOT (i-s) OF (e-s) <- MODIFY FOR CUSTOM SLOT POSITIONS
   switch INV_MODE {
    case 0 : PositionX = INV_LEFT + ((i-s) % INV_COLS) * (INV_SLOTW + INV_SHIFTX) ;
             PositionY = INV_TOP + ((i-s) / INV_COLS)  * (INV_SLOTH + INV_SHIFTY) ;
    case 1 : PositionX = INV_LEFT + ((i-s) / INV_ROWS) * (INV_SLOTW + INV_SHIFTX) ;
             PositionY = INV_TOP + ((i-s) % INV_ROWS)  * (INV_SLOTH + INV_SHIFTY) ;
    case 2 : PositionX = INV_LEFT + ((i-s) % INV_COLS) * (INV_SLOTW + INV_SHIFTX) ;
             PositionY = INV_TOP + ((i-s) / INV_COLS)  * (INV_SLOTH + INV_SHIFTY) ;
   }
   ///////////////////////////////////////////////////////////////////////////////////
   
   setPosition(PositionX,PositionY) ;
   setClickArea(0, 0, INV_SLOTW-1, INV_SLOTH-1) ;
   visible = true ;
   enabled = true ;
  } else {
   visible = false ;
   enabled = false ;
  }
 }

 activeObject = ao ;
 return true ; 
}

///////////////////////////////////

object NonInteractiveClass ; // derivates are not being displayed in status bar (e.g. scroll- and verb-buttons)

script SetInterfaceComponentvisible(vis) {
 var ao = activeObject ;
 if (INTERFACE_DUMMY == -1) return false ; 
 activeObject = INTERFACE_DUMMY ;
 
 INTERFACE_VISIBLE = vis ;
 int i = INTERFACE_MEMBERBASE ;
 var obj = GetField(i) ;
 while (obj != -1) { 
  activeObject = obj ;
  enabled = (INTERFACE_VISIBLE > 0) ;
  visible = enabled ;
  i = i + 1 ; 
  activeObject = INTERFACE_DUMMY ;
  obj = GetField(i) ;
 }

 activeObject = ao ;
 return true ; 
}

script INTERFACE_SHOW { return SetInterfaceComponentvisible(INTERFACE_VISIBLE + 1) ; }
script INTERFACE_HIDE { return SetInterfaceComponentvisible(INTERFACE_VISIBLE - 1) ; }
script INTERFACE_FORCESHOW { return SetInterfaceComponentvisible( 1) ; }
script INTERFACE_FORCEHIDE { return SetInterfaceComponentvisible(-1) ; }

script INTERFACE_CLEAR {
 var ao = activeObject ;
 if (INTERFACE_DUMMY == -1) return false ; 
 activeObject = INTERFACE_DUMMY ;
 
 int i = INTERFACE_MEMBERBASE ;
 var obj = GetField(i) ;
 while (obj != -1) { 
  activeObject = obj ;
  enabled = false ;
  SetField(i,-1) ;  
  i = i + 1 ; 
  activeObject = INTERFACE_DUMMY ;  
  obj = GetField(i) ;
 }
 
 activeObject = ao ;
 return true ;
}

script INTERFACE_ADD(Component) {
 var ao = activeObject ;
 if (INTERFACE_DUMMY == -1) return false ; 
 if (Component == -1) return false ; 
 activeObject = INTERFACE_DUMMY ;
 
 int i = INTERFACE_MEMBERBASE ;
 while (GetField(i) != -1) { i++ ; }
 SetField(i,Component) ;
 SetField(i+1,-1) ;
 
 activeObject = Component ;
 enabled = (INTERFACE_VISIBLE > 0)  ;
 visible = enabled ;
 
 activeObject = ao ;
 return true ;	
}

script INTERFACE_REMOVE(Component) {
 var ao = activeObject ;
 if (INTERFACE_DUMMY == -1) return false ; 
 activeObject = INTERFACE_DUMMY ;
 
 int pos = INTERFACE_MEMBERBASE ;
 int fnd = false ;
 var obj = GetField(pos) ;
 while (obj != -1) { 
  if (obj == Component) fnd = true ;
  pos = pos + 1; 
  obj = GetField(pos) ;
  if (fnd) SetField(pos-1,obj) ;
 }  
 SetField(pos,-1) ;
 
 activeObject = Component ;
 enabled = false ;
 
 activeObject = ao ;
 return true ;
}

script SetupAsInterfaceDummy(Dummy) {
 var ao = activeObject ;
 if (Dummy == -1) return false ; 	 

 activeObject = Dummy ; 
 SetField(INTERFACE_MEMBERBASE, -1) ;
 
 activeObject = ao ;
 return true ;
}

script SetupAsInterfaceBackground(TargetObj,X,Y,_Anim,_Frame) {
 var ao = activeObject ;
 if (TargetObj == -1) return false ; 
 activeObject = TargetObj ;

 class = NonInteractiveClass ;
 enabled = false ;
 visible = true ;
 absolute = true ;
 clickable = false ;
 
 autoAnimate = false ;
 setAnim(_Anim) ;
 Frame = _Frame ;
 Priority = 253 ;
 setPosition(X,Y) ;
 
 INTERFACE_ADD(TargetObj) ;
 
 activeObject = ao ;
 return true ;
}

script SetupAsVerb(TargetObj,X,Y,W,H,_StaticAnim,_StaticFrame,_HoverAnim,_HoverFrame,ActionString,ActionSuffix,PutOnInterface) {
 var ao = activeObject ;
 if (TargetObj == -1) return false ; 
 activeObject = TargetObj ;
 
 class = VerbButtonClass ;
 HoverFrame = _HoverFrame ;
 StaticFrame = _StaticFrame ;
 VerbAction = ActionString ;
 VerbSuffix = ActionSuffix ;
  
 enabled = false ;
 visible = true ;
 absolute = true ;
 clickable = true ; 
 
 Priority = 254 ;
 setPosition(X,Y) ;
 setClickArea(0,0,W,H) ;
 autoAnimate = false ;
 setAnim2V(_HoverAnim,_StaticAnim) ;
 Direction = DIR_WEST ;
 Frame = StaticFrame ;
 
 if (PutOnInterface == true) INTERFACE_ADD(TargetObj) ;

 activeObject = ao ;
 return true ;
}

object VerbButtonClass {
 class = NonInteractiveClass ;
 member StaticFrame ;
 member HoverFrame ;
 member VerbAction ;
 member VerbSuffix ; 
 member VerbObject ;
}

event default -> VerbButtonClass {
 selectVerb(activeObject) ;
 resume ;
}

event mouseover VerbButtonClass {
 if (suspended) return ; 
 if (CV == activeObject) return 0 ;  
 Direction = DIR_EAST ;
 Frame = HoverFrame ;
}

event mouseoff VerbButtonClass {
 if (suspended) return ;
 if (CV == activeObject) return 0 ;  
 Direction = DIR_WEST ;
 Frame = StaticFrame ;
}

script SetupAsScrollButton(TargetObj,X,Y,W,H,_StaticAnim,_StaticFrame,_HoverAnim,_HoverFrame,_ScrollBy) {
 var ao = activeObject ;
 if (TargetObj == -1) return false ; 
 activeObject = TargetObj ;
 
 class = ScrollButtonClass ;
 HoverFrame = _HoverFrame ;
 StaticFrame = _StaticFrame ;
 ScrollBy = _ScrollBy ;
 
 enabled = false ;
 visible = true ;
 absolute = true ;
 clickable = true ; 
 
 Priority = 254 ;
 setPosition(X,Y) ;
 setClickArea(0,0,W,H) ;
 autoAnimate = false ;
 setAnim2V(_HoverAnim,_StaticAnim) ;
 Frame = StaticFrame ;
 Direction = DIR_WEST ;
 
 INTERFACE_ADD(TargetObj) ;
 
 activeObject = ao ;
 return true ;	
} 

object ScrollButtonClass {
 class = NonInteractiveClass ;
 member StaticFrame ;
 member HoverFrame ;
 member ScrollBy ;
}

event mouseover ScrollButtonClass {
 if (suspended) return ;
 Direction = DIR_EAST ;
 Frame = HoverFrame ;
}

event mouseoff ScrollButtonClass {
 if (suspended) return ;
 Direction = DIR_WEST ;
 Frame = StaticFrame ;
}

event default -> ScrollButtonClass {
 INV_SCROLLBY(ScrollBy) ;
 Resume() ;
}

object STATUS_LINE {
 enabled = true ;
 visible = true ;
 clickable = false ;
 Priority = 254 ;
} 

event paint STATUS_LINE {
 STATUS_DRAW ;
} 


script STATUS_SETVISIBLE(vis) {
 STATUS_VISIBLE = vis ;
 return true ;
} 

script STATUS_SHOW { STATUS_SETVISIBLE(STATUS_VISIBLE + 1) ; }
script STATUS_HIDE { STATUS_SETVISIBLE(STATUS_VISIBLE - 1) ; }
script STATUS_FORCESHOW { STATUS_SETVISIBLE( 1) ; }
script STATUS_FORCEHIDE { STATUS_SETVISIBLE(-1) ; }

script STATUS_DRAW {
	
 static var STATUS_TEXT = "" ;
 if (STATUS_VISIBLE <= 0) return 0;
 var ao = activeObject ;
 

 StringClear(STATUS_TEXT) ;
 if (CV != -1) { 
  StringAppend(STATUS_TEXT,CV.VerbAction) ;
  StringAppendChar(STATUS_TEXT,32) ;
 } 
 
 if (SelectedObject != -1) and (not IsClassDerivate(SelectedObject,NonInteractiveClass)) {
  activeObject = SelectedObject ;
  
  // StringAppend(STATUS_TEXT, Name) ersetzt durch
  if ((LightIsOn) or (IsClassDerivate(activeObject,InvObj))) { StringAppend(STATUS_TEXT, Name) ; } else { StringAppend(STATUS_TEXT, LightOffObjLabel) ; }  
  ////////////////////
  
  StringAppendChar(STATUS_TEXT,32) ;
  if (CV != -1) {
   StringAppend(STATUS_TEXT, CV.VerbSuffix) ;
   StringAppendChar(STATUS_TEXT,32) ; 
  } 
 } 

 static var lobj = -1 ;
 var obj = ObjectUnderMouse ;
 if (!suspended) {
  if IsClassDerivate(obj,stdEventObject) {
   activeObject = obj.StdEvent ;
   direction = DIR_EAST ; 
   frame = HoverFrame ;
  } 
  if (IsClassDerivate(lobj,stdEventObject)) and (lobj != obj) and (lobj != SV) {
   activeObject = lObj.StdEvent ;
   direction = DIR_WEST ;
   frame = StaticFrame ;  
  } 
 } 
 
 if (suspended) { obj = lobj; } else { lobj = obj; } 
 if (obj != -1) and (not IsClassDerivate(obj,NonInteractiveClass)) {	   
  activeObject = obj ;
  
  // StringAppend(STATUS_TEXT, Name) ersetzt durch
  if ((LightIsOn) or (IsClassDerivate(activeObject,InvObj))) { StringAppend(STATUS_TEXT, Name) ; } else { StringAppend(STATUS_TEXT, LightOffObjLabel) ; }  

  
 } 
 
 int dtc = drawingTextColor ;
 int dtf = drawingFont ;
 
 drawingFont = STATUS_FONT ;
 drawingPriority = STATUS_LINE.Priority ;
 drawingTextColor = STATUS_FONTCOLOR ;
 if (suspended) drawingTextColor = STATUS_CLICKFONTCOLOR ;	 
 
 int x = STATUS_LEFT + STATUS_WIDTH / 2 - GetStatusTextLength(STATUS_TEXT) / 2 ;
 int y = STATUS_TOP + (STATUS_HEIGHT-GetSpriteFrameHeight(STATUS_FONT, 65) / 2) ;
 drawText(x,y,STATUS_TEXT) ; 
 
 //drawingFont = dtf ; <-- don't know why, but if I try to restore the previously selected font, memory usage raises beyond >> 100MB !!!
 drawingTextColor = dtc ; 
 StringClear(STATUS_TEXT) ;
 activeObject = ao ;
 return ;
} 

script SelectVerb(Verb) {
 var ao = activeObject ;
 
 if (CV != -1) {
  activeObject = CV ;
  Direction = DIR_WEST ;
  Frame = StaticFrame ;
 }
 
 CV = Verb ;
 SelectedObject = CV ;
 if (CV != -1) {
  activeObject = Verb ;
  Direction = DIR_EAST ;
  Frame = HoverFrame ;
 }
 
 activeObject = ao ;
 
 return true ;
} 

script isClassDerivate(obj, objclass) {
 var ao = activeobject ;
 if (obj == -1) return false ;
 while (obj != -1) {
  activeobject = obj ;
  if (class == objclass) { activeobject = ao; return true ; }
  obj = class ;
 }
 activeobject = ao ;
 return false ; 
} 

script GetStatusTextLength(Text) {
 var i = 0 ;
 var len = 0 ;
 for (i = 0 ; i < StringLength(Text) ; i++) { len = len + dialogEx_GetFontCharWidth(STATUS_FONT, StringGetChar(Text,i)) ; }
 return len ;
}

script INV_HASITEM(Item) {
 return HasItem(INV_CONTAINER,Item) ;
} 

script INV_TAKEITEM(Item) {
 return takeItem(INV_CONTAINER,Item) ;
} 

script INV_DROPITEM(Item) {
 return dropItem(INV_CONTAINER,Item) ;
} 

script INV_SETLAYOUT(Left,Top,SlotWidth,SlotHeight,XShift,YShift,Rows,Cols,Mode) {
 INV_LEFT = Left ;
 INV_TOP  = Top ;
 INV_SLOTW = SlotWidth ;
 INV_SLOTH = SlotHeight ;
 INV_SHIFTX = XShift ;
 INV_SHIFTY = YShift ;
 INV_ROWS = Rows ;
 INV_COLS = Cols ;
 INV_MODE = Mode ;
 INV_UPDATE ;
} 

script STATUS_SETLAYOUT(Left,Top,Width,Height,Font,TextColor) {
 STATUS_LEFT = Left ;
 STATUS_TOP  = Top ;
 STATUS_WIDTH  = Width ;
 STATUS_HEIGHT = Height ;
 STATUS_FONT   = Font ;
 STATUS_FONTCOLOR = TextColor ;
} 

script setStandardVerb(verb) {
 SV = verb ;
 return true ; 
} 

script clearActionNoResume {
 if (!LightIsOn) SetStandardVerb(Touch) ; else SetStandardVerb(WalkTo) ; ////////
 SelectVerb(SV) ;
} 

script clearAction {
 clearActionNoResume ;
 Resume ;
}

script moveItem(src, dst, item) {
 dropItem(src, item) ;
 takeItem(dst, item) ;
} 

script passItem(item) {
 if (item != -1) selectedObject = item ;
 resume ;
}

script did(verb) {
 if (verb == CV) return true ;
 return false ;
} 
