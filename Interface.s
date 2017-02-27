// ---------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ---------------------------------
// configures interfaces implemented
//    within "InterfaceSystem.s"
// ---------------------------------

/* SETUP INVENTORY SLOTS */
var INV_MODE   = 0 ;   // Scroll-Mode (0=Row-wise, 1=Col-wise, 2=Item-wise)
                       // Modify INV_UPDATE() in "InterfaceSystem.s" to feature other inventory styles
var INV_ROWS   = 2 ;   // number of rows
var INV_COLS   = 5 ;   // number of columns ( = item slots per row )
var INV_LEFT   = 328 ; // leftmost x-coordinate of upper-left slot
var INV_TOP    = 388 ; // topmost y-coordinate of upper-left slot
var INV_SLOTW  = 58 ;  // width of each slot
var INV_SLOTH  = 42 ;  // height of each slot
var INV_SHIFTX = 4;    // vertical gap between each slot
var INV_SHIFTY = 4;    // horizontal gap between each slot row
// Use "INV_SETLAYOUT" to alter at runtime

/* SETUP STATUS BAR */
var STATUS_LEFT   = 0 ;
var STATUS_TOP    = 360 ;
var STATUS_WIDTH  = 640 ;
var STATUS_HEIGHT = 28 ;
var STATUS_FONT   = Fonts::AgastSmall_font ;
var STATUS_FONTCOLOR = COLOR_GREEN ;
var STATUS_CLICKFONTCOLOR = COLOR_LIGHTGREEN ;
// Use "STATUS_SETLAYOUT" to alter at runtime

/* DEFINE INTERFACE COMPONENTS */

object stdEventObject { member StdEvent = LookAt ; member StdWalkX=-1; member StdWalkY=-1; member StdTurn=-1; }

script WalkToStdEventObjectNoResume(obj) {
if (!obj) return ;
 if (!Ego.enabled) return ;
 if (!isclassderivate(obj,stdEventObject)) return ;
	
 if ((obj.StdWalkX != -1) and (obj.StdWalkY != -1)) {
  Ego.walk(obj.StdWalkX,obj.StdWalkY) ;
  if (obj.StdTurn != -1) Ego.turn(obj.StdTurn) ;
 }
} 

script WalkToStdEventObject(obj) {
 clearAction ; 
 WalkToStdEventObjectNoResume(obj) ;
} 

script setupAsStdEventObject(obj,_stdevent,_stdwalkx,_stdwalky,_stdturn) {
 obj.class = stdEventObject ;
 obj.stdevent = _stdevent ;
 obj.stdwalkx = _stdwalkx ;
 obj.stdwalky = _stdwalky ;
 obj.stdturn = _stdturn ; 
}

// I - Verb-Buttons and Non-Button-Verbs
// usage: object VerbName { SetupAsVerb( VerbName, Left, Top, Width, Height, NormalSprite, NormalFrame, HoverSprite, HoverFrame, VerbStatusString, SuffixStatusString, AddToInterface); }
object WalkTo{ SetupAsVerb( WalkTo ,0   ,0   ,0  ,0  ,0 ,0 ,0                          ,0 ,"Gehe zu"   ,"durch"  ,false ); SetStandardVerb(WalkTo) ; } 
object LookAt{ SetupAsVerb( LookAt ,98  ,446 ,89 ,28 ,0 ,0 ,Graphics::interface_sprite ,9 ,"Schau an"  ,"mit"    ,true  ); }  
object Give  { SetupAsVerb( Give   ,5   ,389 ,91 ,30 ,0 ,0 ,Graphics::interface_sprite ,2 ,"Gib"       ,"an"     ,true  ); } 
object TalkTo{ SetupAsVerb( TalkTo ,97  ,419 ,91 ,24 ,0 ,0 ,Graphics::interface_sprite ,6 ,"Rede mit"  ,"durch"  ,true  ); } 
object Take  { SetupAsVerb( Take   ,97  ,389 ,91 ,28 ,0 ,0 ,Graphics::interface_sprite ,3 ,"Nimm"      ,"aus/von",true  ); } 
object Use   { SetupAsVerb( Use    ,189 ,389 ,92 ,28 ,0 ,0 ,Graphics::interface_sprite ,4 ,"Benutze"   ,"mit"    ,true  ); }  
object Push  { SetupAsVerb( Push   ,189 ,419 ,91 ,27 ,0 ,0 ,Graphics::interface_sprite ,7 ,"Dr]cke"    ,"nach"   ,true  ); }  
object Pull  { SetupAsVerb( Pull   ,189 ,446 ,92 ,29 ,0 ,0 ,Graphics::interface_sprite ,10,"Ziehe"     ,"nach"   ,true  ); } 
object Open  { SetupAsVerb( Open   ,7   ,420 ,88 ,24 ,0 ,0 ,Graphics::interface_sprite ,5 ,"|ffne"     ,"mit"    ,true  ); } 
object Close { SetupAsVerb( Close  ,6   ,446 ,91 ,27 ,0 ,0 ,Graphics::interface_sprite ,8 ,"Schliesse"  ,"mit"    ,true  ); } 
object Touch { SetupAsVerb( Touch  ,0   ,0   ,0  ,0  ,0 ,0 ,0                          ,0 ,"Taste nach","mit"    ,false ); } 

// II - Inventory Scroll-Buttons 
// usage: object ObjName { SetupAsScrollButton( ObjName, Left, Top, Width, Height, NormalSprite, NormalFrame, HoverSprite, HoverFrame, Scroll-Alteration); }
object ScrollUp   { SetupAsScrollButton( ScrollUp   ,291 ,387 ,26 ,41 ,0 ,0 ,Graphics::interface_sprite ,11 ,-1 ) ; } 
object ScrollDown { SetupAsScrollButton( ScrollDown ,291 ,435 ,26 ,40 ,0 ,0 ,Graphics::interface_sprite ,12 ,1  ) ; }

// III - Interface Background(s)
// usage: object ObjName { SetupAsInterfaceBackground( ObjName, Left, Top, Sprite, Frame); }
object InterfaceBG { clickable = false ; SetupAsInterfaceBackground( InterfaceBG, 0, 360, Graphics::interface_sprite, 0 ) ; }


//*****************************************************************************************************************************
//* OBJECT INTERFACE_DUMMY MUST BE CREATED !!BEFORE!! ALL OTHER INTERFACE COMPONENTS OR THE WHOLE SYSTEM WILL MALFUNCTION!    *
//* WHEN I DECLARED INTERFACE_DUMMY BELOW ALL OTHER COMPONENTS IT WORKED FINE, SO I GUESS AGAST CREATES LAST OBJECTS FIRST    *
//* HOWEVER, IF IT DOESNT WORK FOR YOU (SIGN: ODD INTERFACE) TRY MOVING THE NEXT LINE TO GAME.S, THAT SHOULD DO THE TRICK.    *
//*****************************************************************************************************************************
object INTERFACE_DUMMY { SetupAsInterfaceDummy(INTERFACE_DUMMY) ; } 
//*****************************************************************************************************************************


// some functions for this scumm-interface demo
script ShowInventory { // increment visibility
 SelectVerb(SV) ;
 INTERFACE_SHOW ;
 STATUS_SHOW ;
 INV_SHOW ;
} 

script HideInventory { // decrement visibility
 SelectVerb(SV) ;
 INTERFACE_HIDE ;
 STATUS_HIDE ;
 INV_HIDE ;
} 

script forceShowInventory { // set visibility = 1
 SelectVerb(SV) ;
 DarkBar.enabled = false ;
 INTERFACE_FORCESHOW ;
 STATUS_FORCESHOW ;
 INV_FORCESHOW ;
} 

script forceHideInventory { // set visibility = 0
 SelectVerb(SV) ;
 DarkBar.enabled = true ;
 INTERFACE_FORCEHIDE ;
 STATUS_FORCEHIDE ;
 INV_FORCEHIDE ;
} 

object DarkBar {
  enabled = false ;
  visible = true ;
  absolute = true ;
  clickable = false ;
  autoAnimate = false ;
  setAnim(Graphics::interface_sprite) ;
  Frame = 15 ;
  Priority = 254 ;
  setPosition(0,360) ; 
} 