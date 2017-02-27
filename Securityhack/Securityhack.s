// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 backgroundImage = Securityhack_image ; 
 backgroundZBuffer = 0 ;
 forceHideInventory ;
 Darkbar.enabled = false ;
 
 scrollX = 0 ;
 scrollY = 0 ;
 
 Ego:
  enabled = false ;
  path = 0 ;
  positionX = 320 ;
  positionY = 210 ;

 delay transitionTime ;
 
 start animateLampe ;
 
 if (updateDeviceFreq) {
   delay 5 ;
   soundBoxPlay(Music::Freq_wav) ;
   delay 10 ;   
   Ego.say("Zuf#llig ist wohl schon die richtige Frequenz eingestellt.") ;
   Ego.say("Was f]r ein Gl]ck.") ;
   Ego.say("Ich bet#tige die Taste.") ;
   delay 20 ;
   doEnter(Securitygang) ;
   return ;
  }

 clearAction ;
}

/* ************************************************************* */

object deviceLED {
 setPosition(74,245) ;
 setClickArea(0,0,117,119) ;
 setAnim(Led_sprite) ;	
 clickable = true ;
 absolute = false ;
 enabled = true ;
 visible = true ; 
 stopAnimDelay = 0 ;
 autoAnimate = false ;
 frame = 0 ;
}

event default -> deviceLED {
 Ego:
  say("Das kann ich nicht dr]cken.") ;
 clearAction ;
}

event LookAt -> deviceLED {
 Ego:
  say("Eine blinkende LED.") ;
 clearAction ;
}

/* ************************************************************* */

script updateDeviceFreq {
 int deviceFreq = 0 ;
 
 switch deviceMode {
  case 0:  deviceFreq.bit[0] = schalter1.on ; deviceFreq.bit[1] = schalter2.on ; deviceFreq.bit[2] = schalter3.on ;
  case 1:  deviceFreq.bit[0] = schalter1.on ; deviceFreq.bit[1] = schalter3.on ; deviceFreq.bit[2] = schalter2.on ;
  case 2:  deviceFreq.bit[0] = schalter2.on ; deviceFreq.bit[1] = schalter1.on ; deviceFreq.bit[2] = schalter3.on ;
  case 3:  deviceFreq.bit[0] = schalter2.on ; deviceFreq.bit[1] = schalter3.on ; deviceFreq.bit[2] = schalter1.on ;
  case 4:  deviceFreq.bit[0] = schalter3.on ; deviceFreq.bit[1] = schalter1.on ; deviceFreq.bit[2] = schalter2.on ;
  default: deviceFreq.bit[0] = schalter3.on ; deviceFreq.bit[1] = schalter2.on ; deviceFreq.bit[2] = schalter1.on ;
 }
 
 deviceLED:
  autoAnimate = true ;
  frame = Lampe.frame ;
  stopAnimDelay = (deviceFreq+1) * 2 ;
 
 return (deviceFreq==panelFrequency) ;
}

object schalter {
 setAnim(Schalter_sprite) ;	
 autoAnimate = false ;
 setClickArea(0,0,83,67) ;
 frame = 0 ;
 clickable = true ;
 absolute = false ;
 enabled = true ;
 visible = true ; 
 member on = false ;
}

event default -> schalter {
 on = !on ;
 if (on) frame = 1 ;
  else frame = 0 ;
 if (!updateDeviceFreq) clearAction ;
  else {
   delay 5 ;
   soundBoxPlay(Music::Freq_wav) ;
   if (not (upCounter(4) >= 3)) {
     delay 10 ;   
     Ego.say("Das muss die richtige Frequenz sein.") ;
     Ego.say("Ich bet#tige die Taste.") ;
   }
   delay 20 ;   
   doEnter(Securitygang) ;
  }
}

event LookAt -> Schalter {
 Ego:
  "Ein Schalter auf der Elektronik Frequenzmultiplext]r[ffners."
  clearAction ;
}

object Schalter1 {
 class = schalter ;
 setAnim(Schalter1_sprite) ;	 
 setPosition(1,413) ;
 setClickArea(0,0,40,53) ;
}

object Schalter2 {
 class = schalter ;	
 setAnim(Schalter2_sprite) ;
 setPosition(40,429) ;
 setClickArea(0,0,50,50) ;
}

object Schalter3 {
 class = schalter ;	
 setAnim(Schalter3_sprite) ;
 setPosition(114,430) ;
 setClickArea(0,0,60,50) ;
}

/* ************************************************************* */

object dt {
 setClickArea(450,0,640,480) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

event animate dt {
 drawingTextColor = RGB(180,180,180) ;
 if ((PointInRect(mouseX,mouseY,500,0,640,480)) and (!suspended)) drawText (mouseX-50, mouseY-3, "zur]ck") ;
}

event default -> dt {
 doEnter(Securitygef) ;	
}

/* ************************************************************* */

event paint Lampe {
 drawingPriority = 3 ;
 drawingColor = COLOR_WHITE ;
 drawImage(0,0,Lampe_image) ;	
}

object Lampe {
 absolute = false ;	
 setPosition(0,0) ;
 setAnim(Lampe_image) ;
 clickable = false ;
 enabled = true ;
 visible = true ; 
 priority = 1 ;
 stopAnimDelay = (panelFrequency+1) * 2 ;
}

event default -> Lampe { doEnter(Securitygef) ; }

script animateLampe {
 killOnExit = true ;
 
 loop {
   delay ((panelFrequency+1) * 2)-1 ;	 
   Lampe.visible = ! Lampe.visible ;
 }
}



