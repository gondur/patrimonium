// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 backgroundImage = telefon_image ; 
 backgroundZBuffer = null ; 
 
 Ego.visible = false ;
 Ego.caption = null ;
 
 forceHideInventory ; 
 darkbar.enabled = false ;
 
 InstallGameInputHandler(&GameInput_TeleHandler) ;
 
 static int setup = false ;
 if (!setup) {
  for (int i=0; i<10; i++) { activeObject = Tasten[i]; class = Taste; KeyCode = i; }
  activeObject = Tasten[0] ; name = "Null" ;   setClickArea(413,275,477,336) ;
  activeObject = Tasten[1] ; name = "Eins" ;   setClickArea(283,101,345,161);
  activeObject = Tasten[2] ; name = "Zwei" ;   setClickArea(209,117,270,177);
  activeObject = Tasten[3] ; name = "Drei" ;   setClickArea(156,168,217,227);
  activeObject = Tasten[4] ; name = "Vier" ;   setClickArea(131,234,196,297) ;
  activeObject = Tasten[5] ; name = "F]nf" ;   setClickArea(148,302,209,364) ;
  activeObject = Tasten[6] ; name = "Sechs" ;  setClickArea(192,362,253,423) ;
  activeObject = Tasten[7] ; name = "Sieben" ; setClickArea(258,389,319,450) ;
  activeObject = Tasten[8] ; name = "Acht" ;   setClickArea(325,378,389,439) ;
  activeObject = Tasten[9] ; name = "Neun" ;   setClickArea(386,338,448,400) ;  
 }
 
 resetTelNum ;
 delay transitionTime ;
 clearAction ; 
}

script GameInput_TeleHandler(key) {
  switch key {
    case <LBUTTON>: TriggerMouseClickEvent();
    case <F5>, <ESC>: MainMenu();
	    
    case <NUMPAD0>,<0>: start waehle(0) ;
    case <NUMPAD1>,<1>: start waehle(1) ;
    case <NUMPAD2>,<2>: start waehle(2) ;
    case <NUMPAD3>,<3>: start waehle(3) ;
    case <NUMPAD4>,<4>: start waehle(4) ;
    case <NUMPAD5>,<5>: start waehle(5) ;
    case <NUMPAD6>,<6>: start waehle(6) ;
    case <NUMPAD7>,<7>: start waehle(7) ;
    case <NUMPAD8>,<8>: start waehle(8) ;
    case <NUMPAD9>,<9>: start waehle(9) ;
    case <R>: ResetTelNum ;
    case <A>: TelStage = 1 ; doEnter(vorflughafen) ;
  } 
}

object Tasten[10] ;

object Taste {
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 member KeyCode ;
}

event default  -> Taste { waehle(KeyCode) ; }

script waehle(num) {
 suspend ;
 TelNum = TelNum + Pot(10,CurTelLen)*num ; 
 CurTelLen++; 
 Ausgabe.caption = TelToStr(TelNum,CurTelLen) ; 
 soundBoxStart(klick_wav) ; 
 if (CurTelLen >= MaxTelLen) { delay 10 ; TeleCall(TelNum) ; return 0 ; } 
 clearAction ;
} 

script ResetTelNum {
 CurTelLen = 0 ;
 TelNum = 0 ;
 Ausgabe.caption = null ;
} 

object Ausgabe {
 positionX = 270 ;
 positionY = 66 ;
 captionY = 0 ;
 captionX = 0 ;
 captionWidth = 400 ;	
 captionColor = RGBA(203,255,121,255) ;
 captionJustify = JUSTIFY_LEFT ;
 captionBase = BASE_CENTER ;
 caption = null ; 
}

script restorePreviousConfig {
 forceShowInventory ;
 InstallGameInputHandler(&GameInput_Handler) ;  
} 

script TeleCall(nr) {
 LastTelNum = TelNum ;
 TelStage = 0 ; 
 Ausgabe.caption = null ;
  
 // Auskunft 
 if (TelNum == TelNums[5]) TelStage = 1 ;   

 // Hotels
 for (int i=0; i<5; i++) { if (TelNum == TelNums[i]) { TelStage = i+2 ; } }

 // Chefbuero
 if (LastTelNum == TelNums[8]) { TelStage = 11 ; }  

 // SamTec Headquarters
 if (TelNum == TelNums[6]) TelStage = 8 ;

 // Otherwise... 
 if (TelStage == 0) { if (Quersumme(TelNum) % 2 == 0) { TelStage = 9 ; } else { TelStage = 7 ; } if (! KnowsHotel) TelStage = 7 ; }
 
 RestorePreviousConfig ;
 doEnter(VorFlughafen) ;	 	 
} 

object Reset {
 setClickArea(421,188,532,267) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "auflegen" ;
}

event default -> reset { resetTelNum ; resume ; }

object zurueck {
 setClickArea(0,0,80,480) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

event default -> zurueck { 
 RestorePreviousConfig ;
 doEnter(VorFlughafen) ;
}

event animate zurueck {
 drawingTextColor = RGB(180,180,180) ;
 if ((PointInRect(mouseX,mouseY,0,0,80,480)) or (PointInRect(mouseX,mouseY,560,0,640,480))) drawText (mouseX+10, mouseY-5, "zur]ck") ;
 var dobj = ObjectUnderMouse ;
 if (dobj and (!suspended)) {
   var dText = "" ;
   stringClear(dText) ;
   stringAppend(dText,dobj.name) ;
   drawText(mouseX+10, mouseY-5, dText);	 
 }
}

object zurueck2 {
 class = Zurueck ;
 setClickArea(560,0,640,480) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
} 
