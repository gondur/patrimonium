// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

const offsetX = 116 ;
const offsetY = 34 ;        
const wiresWidth = 18 ;
const panelsWidth = 80 ;

static var firstHint = false ;
static var firstWireHint = false ;

event enter { 
 scrollX = 0 ;

 
 Ego:
  setPosition(320,500) ;
  enabled = false ;
  
 backgroundZBuffer = null ;
 path = 0 ;
 
 forceHideInventory ;	 
 Darkbar.enabled = false ;
 STATUS_FORCEHIDE ;
 
 if (doOpenPanel == 0) backgroundImage = SurizaZu_image ;
  else if (doOpenPanel == 1) {
	 backgroundImage = SurizaZu_image ;	  
	 openPanelCutscene ;
  } else {
	 backgroundImage = Suriza_image;
	 initSuriza ;
	 knowsSuriza = true ;
	 if (!firstHint) firstHintCutscene ;
	 if (hasItem(Ego, Wires)) if (!firstWireHint) firstHintWireCutscene ;
  }
 

 clearAction ;
}

script openPanelCutscene {
 delay transitionTime ;
 delay 48 ;
 doOpenPanel = 2 ;
 doEnter(Suriza) ;
}

script firstHintCutscene {
 delay transitionTime ;
 delay 20 ;
 Ego:
  "Na da schau an..."
 delay 10 ;
  "Das ist eine Anordnung aus unterschiedlichen Schaltelementen."
  "Auf einigen befinden sich verschieden viele LEDs."
 if (surizaPuzzle==0) say("Und auf einem Schaltelement ist eine Art Schl]sselloch.") ;
  "Zwischen diesen Schaltelementen sind L]cken und Anschl]sse."
 delay 10 ;  
 firstHint = true ;
}


script firstHintWireCutscene { 
 delay transitionTime ;
  Ego: 
  "Vielleicht helfen mir hier diese kleine Kabel weiter."
 delay 10 ;
  "Ich versuche mal eines anzuschlie}en..."
 delay 10 ;
 var testHorz ;
 switch (surizaPuzzle) {
   case 0:  testHorz = 0 ;
   case 1:  testHorz = 2 ;
   case 2:  testHorz = 1 ;
   default: testHorz = 0 ;
 } 
 triggerObjectOnObjectEvent(WalkTo, Horz[testHorz]) ;
 suspend ;
 delay 5 ;
 suspend ;
  "Interessant."
  "Eine LED f#ngt zu leuchten an."
 delay 10 ;
  "Ich entferne das Kabel wieder."
 triggerObjectOnObjectEvent(WalkTo, Horz[testHorz]) ;
 suspend ;
 delay 10 ;	
 firstWireHint = true ;
}

script setPanel(nsprite) {
  setAnim(nsprite) ;
  switch (nsprite) {
    case panel_damaged_image:  name = "Loch" ;                  maxlcount = 0 ;
    case panel_light1_sprite:  name = "Diode" ;                 maxlcount = 1 ; frame = 0 ;
    case panel_light2_sprite:  name = "Zwei Dioden" ;           maxlcount = 2 ; frame = 0 ;
    case panel_light3_sprite:  name =  "Drei Dioden" ;          maxlcount = 3 ; frame = 0 ;
    default: maxlcount = -1 ; frame = random(3) ;
  }  
}

script updatePanel {
  return if ((maxlcount == -1) or (maxlcount == 0)) ;
  static var exceededCountHint = false ;
  if (lcount > maxlcount) { 
    frame = 0 ; 
    if ((!exceededCountHint) and (maxlcount > 0)) {
      suspend ;
	 
      delay 7 ;
      Ego.say("Hmmmm...") ;
      delay 3 ;
      if (maxlcount==1) Ego.say("Die LED auf diesem Schaltelement ist ausgegangen.") ;
      if (maxlcount>1)  Ego.say("Die LEDs auf diesem Schaltelement sind alle auf einmal ausgegangen.") ;	      
      delay 4 ;
      clearAction ;
      exceededCountHint = true ;
	 
    }
  } else frame = lcount ;
}

script incPanelCount(panelID) { 	
  if ((panelID>=0) and (panelID<16)) {
     activeObject = Panel[panelID] ;
     lcount = lcount+1 ;
     updatePanel ;
   }	
}

script decPanelCount(panelID) { 
  if ((panelID>=0) and (panelID<16)) {
    activeObject = Panel[panelID] ;
    lcount = lcount-1 ;
    updatePanel ;
  }
}

object panelClass {
  member posX ;
  member posY ;
  member lcount = 0 ;
  member maxlcount = 0 ;
}

object wireClassHorz {
  member id ;
  member posX ;
  member posY ;
  member on = false ;
}

object wireClassVert {
  member id ;
  member posX ;  
  member posY ;
  member on = false ;
}

event WalkTo -> PanelClass {
 Ego:
 // say("Das kann ich nicht ]berbr]cken.") ;
 clearAction ;
}

event LookAt -> wireClassVert {
	 	
 if (on) Ego.say("Diese L]cke habe ich mit einem Kabel ]berbr]ckt.") ;
  else Ego.say("Eine L]cke, mit zwei Anschl]ssen.") ;
 clearAction ;
 
}

event LookAt -> wireClassHorz {
	 	
 if (on) Ego.say("Diese L]cke habe ich mit einem Kabel ]berbr]ckt.") ;
  else Ego.say("Eine L]cke, mit zwei Anschl]ssen.") ;
 clearAction ;
	 
}

event LookAt -> Panelclass {
	 	
  switch (getAnim(ANIM_STOP, 0)) {
    case panel_damaged_image:  
	    Ego.say("Sieht nach einem kaputten Kondensator aus.") ; 
    case panel_light1_sprite:  
	    Ego.say("Hier befindet sich eine Diode.") ; 
	    delay 3 ;
	    if (lcount==1) Ego.say("Sie leuchtet.") ;
	      else if (hasItem(Ego, Wires)) Ego.say("Sie leuchtet nicht.") ;
    case panel_light2_sprite:  
	    Ego.say("Auf diesem Schaltelement sind zwei Dioden.") ;
	    delay 3 ;
	    if (lcount==1) Ego.say("Eine davon leuchet.") ;
	    if (lcount==2) Ego.say("Beide leuchten.") ;
	    if (hasItem(Ego, Wires)) if (lcount==0) Ego.say("Keine leuchtet.") ;
    case panel_light3_sprite:  
	    Ego.say("Hier sind drei Dioden") ;
	    delay 3 ;
	    if (lcount==1) Ego.say("Eine davon leuchet.") ;
	    if (lcount==2) Ego.say("Zwei leuchten.") ;
	    if (lcount==3) Ego.say("Alle drei leuchten.") ;
	    if (hasItem(Ego, Wires)) if (lcount==0) Ego.say("Keine davon leuchtet.") ;		    
    default:
	    Ego.say("Auf diesem Schaltelement ist nichts besonderes.") ;
  }  
 clearAction ;
 
}

event WalkTo -> wireClassHorz {
 if (!hasItem(Ego, Wires)) {
  Ego.say("Hier muss ich vorraussichtlich die {berbr]ckungskabel anschlie}en.") ;
  Ego.say("Leider habe ich keine bei mir.") ;
  clearAction ;
  return ;
 }
 on = not on ;
 setField(0, on) ;
 if (on) {
   frame = 1 ;
   // increase panel counters
   incPanelCount(id-4) ;
   incPanelCount(id) ;   
   name = "Kabel" ;
 } else { 
   frame = 0 ;
   // decrease panel counters
   decPanelCount(id-4) ;
   decPanelCount(id) ;      
   name = "L]cke" ;
 }
 
 if (checkPuzzle) solvePuzzle ;
  else if (firstWireHint) clearAction ;
}

event WalkTo -> wireClassVert {
 if (!hasItem(Ego, Wires)) {
  Ego.say("Hier muss ich vorraussichtlich die {berbr]ckungskabel anschlie}en.") ;
  Ego.say("Leider habe ich keine bei mir.") ;
  clearAction ;
  return ;
 }	
 var myid = id ;
 on = not on ;
 setField(0, on) ;
 if (on) {
   frame = 1 ;
   name = "Kabel" ;
   if (id == 0)        incPanelCount(0) ;
    else if (id == 4)  incPanelCount(3) ;
    else if (id == 5)  incPanelCount(4) ;
    else if (id == 9)  incPanelCount(7) ;
    else if (id == 10) incPanelCount(8) ;
    else if (id == 14) incPanelCount(11) ;
    else if (id == 15) incPanelCount(12) ;
    else if (id == 19) incPanelCount(15) ;
   else {
     if (id > 4)  myid-- ;
     if (id > 9)  myid-- ;
     if (id > 14) myid-- ;
     incPanelCount(myid) ;
     incPanelCount(myid-1) ;
   }
 } else { 
   frame = 0 ;
   name = "L]cke" ;
   if (id == 0)        decPanelCount(0) ;
    else if (id == 4)  decPanelCount(3) ;
    else if (id == 5)  decPanelCount(4) ;
    else if (id == 9)  decPanelCount(7) ;
    else if (id == 10) decPanelCount(8) ;
    else if (id == 14) decPanelCount(11) ;
    else if (id == 15) decPanelCount(12) ;
    else if (id == 19) decPanelCount(15) ;
   else {
     if (id > 4)  myid-- ;
     if (id > 9)  myid-- ;
     if (id > 14) myid-- ;
     decPanelCount(myid) ;
     decPanelCount(myid-1) ;
   }   
 }
 if (checkPuzzle) solvePuzzle ;
  else clearAction ;
}

script initPanel(pX,pY) {
  class = panelClass ;
  posX = pX ;
  posY = pY ;
                
  setPosition(offsetX+(wiresWidth+panelsWidth)*(pX-1)+wiresWidth,offsetY+wiresWidth*posY+panelsWidth*(posY-1)) ;
  setClickArea(0,0,80,80) ;  
  visible = true ;
  enabled = true ;
  clickable = true ;
  absolute = false ;
  autoAnimate = false ;
  frame = 0 ;
  setPanel(panel_free_sprite) ;
}

object Panel[16] ;
object Horz[20]  ;
object Vert[20]  ;

script initWireHorz(pX,pY,tid) {
  class = wireClassHorz ;
  id = tid ;
  posX = pX ;
  posY = pY ;
  setPosition(offsetX+(wiresWidth+panelsWidth)*(pX-1)+wiresWidth,offsetY+(wiresWidth+panelsWidth)*(pY-1)) ;
  setClickArea(0,0,80,18) ;
  setAnim(wire_hor_sprite) ;  
  autoAnimate = false ;  
  frame = 0 ;
  name = "L]cke" ;
  visible = true ;
  enabled = true ;
  clickable = true ;
  absolute = false ;  
}

script initWireVert(pX,pY,tid) {
  class = wireClassVert ;
  id = tid ;
  posX = pX ;
  posY = pY ;
  setPosition(offsetX+(wiresWidth+panelsWidth)*(pX-1),offsetY+(wiresWidth+panelsWidth)*(pY-1)+wiresWidth) ;
  setClickArea(0,0,18,80) ;
  setAnim(wire_ver_sprite) ;
  autoAnimate = false ;  
  frame = 0 ;
  name = "L]cke" ;
  visible = true ;
  enabled = true ;
  clickable = true ;
  absolute = false ;
}


script initSuriza {
 
 var current = 0 ;
 for (int y=1; y<5; y++) {
   for (int x=1; x<5; x++) {
     activeObject = Panel[current] ;
     initPanel(x,y) ;
     current++ ;
   }
 }
 
 current = 0 ;
 for (y=1; y<6; y++) { 
   for (x=1; x<5; x++) {
     activeObject = Horz[current] ;
     initWireHorz(x,y,current) ;
     if (getField(0)) triggerObjectOnObjectEvent(Walkto, Horz[current]) ;
     current++ ;
   }
 }
 
 current = 0 ;
 for (y=1; y<5; y++) {
   for (x=1; x<6; x++) {
     activeObject = Vert[current] ;
     initWireVert(x,y,current) ;
     if (getField(0)) triggerObjectOnObjectEvent(Walkto, Vert[current]) ;
     current++ ;
   }
 }
 
 switch (surizaPuzzle) {
   case 0: activeObject = Panel[0] ;   setPanel(panel_light1_sprite) ;
	   activeObject = Panel[3] ;   setPanel(panel_damaged_image) ;
	   activeObject = Panel[8] ;   setPanel(panel_light1_sprite) ;
	   activeObject = Panel[10] ;  setPanel(panel_light2_sprite) ;
	   activeObject = Panel[11] ;  setPanel(panel_light1_sprite) ;
	   activeObject = Panel[13] ;  setPanel(panel_light2_sprite) ;
	   activeObject = Panel[14] ;  setPanel(panel_light3_sprite) ;
	   
   case 1: activeObject = Panel[2] ;   setPanel(panel_light3_sprite) ;
	   activeObject = Panel[3] ;   setPanel(panel_light1_sprite) ;
	   activeObject = Panel[4] ;   setPanel(panel_light1_sprite) ;
	   activeObject = Panel[8] ;   setPanel(panel_light3_sprite) ;
	   activeObject = Panel[11] ;  setPanel(panel_light3_sprite) ;
	   activeObject = Panel[12] ;  setPanel(panel_light1_sprite) ;
	   activeObject = Panel[13] ;  setPanel(panel_light2_sprite) ;
	   
   case 2: activeObject = Panel[1] ;   setPanel(panel_light2_sprite) ;
	   activeObject = Panel[2] ;   setPanel(panel_light3_sprite) ;
	   activeObject = Panel[5] ;   setPanel(panel_light1_sprite) ;
	   activeObject = Panel[6] ;   setPanel(panel_light1_sprite) ;
	   activeObject = Panel[7] ;   setPanel(panel_light2_sprite) ;
	   activeObject = Panel[9] ;   setPanel(panel_light1_sprite) ;
	   activeObject = Panel[12] ;  setPanel(panel_light1_sprite) ;
	   activeObject = Panel[13] ;  setPanel(panel_light3_sprite) ;
	   activeObject = Panel[15] ;  setPanel(panel_light1_sprite) ;
	   
   default: activeObject = Panel[0] ;  setPanel(panel_light1_sprite) ;
	    activeObject = Panel[1] ;  setPanel(panel_light1_sprite) ;
	    activeObject = Panel[7] ;  setPanel(panel_light3_sprite) ;
	    activeObject = Panel[9] ;  setPanel(panel_light2_sprite) ;
	    activeObject = Panel[11] ; setPanel(panel_light3_sprite) ;
	    activeObject = Panel[13] ; setPanel(panel_light2_sprite) ;
	    activeObject = Panel[15] ; setPanel(panel_light2_sprite) ;
	   
 }
  
  
}
 
script checkPuzzle {
 var nogoh = false ;
 var   goh = true ;
 var nogov = false ;
 var   gov = true ;
 var outp = "" ;
 int i ;
 
 StringClear(outp) ;

 switch (surizaPuzzle) {
   case 0: 
     for (i=0; i<20; i++) {
       activeObject = Horz[i] ;
       
       if ((i==1)or(i==10)or(i==13)or(i==18)) goh = goh and on ;
	 else nogoh = nogoh or on ;
		 
       activeObject = Vert[i] ;
       
       if ((i==1)or(i==2)or(i==6)or(i==7)or(i==11)or(i==13)or(i==17)or(i==18)) gov = gov and on ;
	 else nogov = nogov or on ;
     }
     
   case 1: 
     for (i=0; i<20; i++) {
       activeObject = Horz[i] ;
       
       if ((i==2)or(i==8)or(i==9)or(i==11)or(i==12)or(i==13)or(i==15)or(i==18)) goh = goh and on ;
	 else nogoh = nogoh or on ;
		 
       activeObject = Vert[i] ;
       
       if ((i==2)or(i==3)or(i==7)or(i==8)or(i==10)or(i==14)or(i==17)or(i==18)) gov = gov and on ;
	 else nogov = nogov or on ;
     }
     
   case 2:
     for (i=0; i<20; i++) {
       activeObject = Horz[i] ;
       
       if ((i==2)or(i==4)or(i==5)or(i==8)or(i==11)or(i==14)or(i==15)or(i==17)) goh = goh and on ;
         else nogoh = nogoh or on ;
		 
       activeObject = Vert[i] ;
       
       if ((i==2)or(i==3)or(i==5)or(i==8)or(i==11)or(i==14)or(i==16)or(i==17)) gov = gov and on ;
	 else nogov = nogov or on ;
     }
     
   default:
     for (i=0; i<20; i++) {
       activeObject = Horz[i] ;
       
       if ((i==2)or(i==3)or(i==4)or(i==7)or(i==9)or(i==11)or(i==12)or(i==13)or(i==15)or(i==18)) goh = goh and on ;
         else nogoh = nogoh or on ;
		 
       activeObject = Vert[i] ;
       
       if ((i==2)or(i==4)or(i==5)or(i==6)or(i==7)or(i==8)or(i==10)or(i==14)or(i==17)or(i==18)) gov = gov and on ;
	 else nogov = nogov or on ;
     }
	  
	  
}
 
 for (i=0; i<20; i++) {
   activeObject = vert[i] ;
   if (on) stringAppendChar(outp, 'x') ;
	   else stringAppendChar(outp, '_') ;
 }

 //print "vertical: (%s)", outp ; 

 
 if ((not nogoh) and (not nogov) and goh and gov) return true ;
   else return false ;
 
}

script solvePuzzle {
 	
 delay 10 ;
 soundBoxStart(Garage_wav) ;
 delay 20 ;
 Ego.say("Das Garagentor hat sich ein St]ck weit ge[ffnet!") ;
 delay 4 ;
 Ego.say("Das sollte reichen um hereinzukommen.") ;
 delay 5 ;
 surizaSolved = true ;
 doEnter(Dott) ;
}



/* ************************************************************* */

object dt {
 setClickArea(550,0,640,480) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
}

event animate dt {
 drawingTextColor = RGB(180,180,180) ;
 if (PointInRect(mouseX,mouseY,550,0,640,480)) drawText (mouseX+10, mouseY-5, "zur]ck") ;
 var dobj = ObjectUnderMouse ;
 if (dobj and (!suspended)) {
   var dText = "" ;
   stringClear(dText) ;
   stringAppend(dText,dobj.name) ;
   drawText(mouseX+10, mouseY-5, dText);	 
 }
}

event default -> dt {
 doEnter(Dott) ;	
}
