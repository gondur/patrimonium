// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------


event enter {
 Ego:
  enabled = true ;
  visible = true ;
  lightmap = Lightmap_image ;
  lightmapAutoFilter = true ;
 enableEgoTalk ;
 forceShowInventory ;
 backgroundImage = Dott_image;
 backgroundZBuffer = Dott_zbuffer ;
 path = Dott_path ;
 
 
 
 if (previousScene == Dottrohre) {
  scrollX = 535 ;
  setPosition(855,247) ;
  face(DIR_WEST) ;
  delay transitionTime ;
  start birdsFly ;
 } else if (previousScene == Dottgarage) {
  scrollX = 326 ;	 
  setPosition(644,219) ;
  face(DIR_SOUTH) ;
  delay transitionTime ;
  start birdsFly ;
 } else if (previousScene == Suriza) {
  scrollX = 314 ;
  setPosition(632,214) ;  
  face(DIR_NORTH) ;
  delay transitionTime ;
  start birdsFly ;
  if (not surizaSolved) pujaTipp ;
 } else {
  scrollX = 0 ;
  setPosition(272,346) ;
  face(DIR_NORTH) ;
  start birdsFly ;
  if (firstEnter) firstEnterCutscene ;
   else delay transitionTime ;
 }
    
 start playSounds ;
 
 clearAction ;
}

/* ************************************************************* */

script playSounds {
 killOnExit = true ; 
 delay transitionTime ;
 loop {
   delay 69 ;
   delay random(69) ;
   delay (23)*(random(4)+4)+(23)*(random(5)+1) ;
   if (random(2)==0)
   switch random(3) {
     case 0:  ast.playSound(Music::Vogel1_wav) ;      
     case 1:  ast.playSound(Music::Vogel2_wav) ;      
     default: ast.playSound(Music::Frosch_wav) ;      
   }
 }
}

object bird {
 setAnim2H(Vogelr_sprite, Vogell_sprite) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 
 walkAnimDelay = 6 ;
}

object bird1 {
 class = bird ;
 scale = 250 ;
 walkingSpeed = 1 ;
}

object bird2 {
 class = bird ;
 scale = 220 ;
 walkingSpeed = 1 ;
}

object bird3 {
 class = bird ;
 scale = 200 ;
 walkingSpeed = 1 ;
}


script birdsFly {
 killOnExit = true ;
 bird1.setPosition(random(1370),45) ;
 bird1.face(DIR_EAST) ;
 bird2.setPosition(1390,50) ;
 bird3.setPosition(-45,35) ;
 
 start { loop { bird1.walk(1380,45) ; random(300) ; bird1.walk(-50,45) ;  delay random(100)+random(300) ;} }
 start { loop { delay random(100)+20+random(400) ;  bird2.walk(-55,50) ;  random(300) ; bird2.walk(1390,50) ; delay ; } }
 start { loop { delay random(100)+50+random(500) ;  bird3.walk(1385,35) ; random(300) ; bird3.walk(-45,35) ; delay ; } }
	 
}

/* ************************************************************* */

script firstEnter {
 return !Wolke.getField(0) ;
}

script firstEnterCutscene {
 Wolke.setField(0,1) ;
 // scrollX = 1332 - 640 ;
 forceHideInventory ;
 disableScrolling ;
 delay 50 ;
 Ego.say("Ahhhhh...") ;
 delay 4 ;
 Ego.say("Das Wunder des Wassers.") ;
 delay 4 ;
 Ego.say("Ein kleiner Seitenarm des Nil reicht aus, um mitten in der W]ste eine fruchtbare Oase entstehen zu lassen...") ;
 delay 7 ;
 Ego.turn(DIR_EAST) ;
 delay 50 ;
 
 do {
   scrollX += 6 ;
   delay ;
 } until (scrollX >= 1332 - 640) ;
 
 delay 54 ;

 do {
   scrollX -= 12 ;
   delay ;
 } until (scrollX <= 20) ;


 enableScrolling ;
 
 Ego.say("...nur um sie gleich wieder zu verpesten!?") ;
 delay 4 ;
 Ego.say("Da haben wohl andere als Mutter Natur ihre Finger im Spiel!") ;
 Ego.turn(DIR_NORTH) ;
 
 forceShowInventory ;
}

/* ************************************************************* */

script pujaTipp { // suriza puzzle
 delay transitionTime ;
 Ego:
  if (!openedPanel) {
    if (!readAnleitung) { 
      say("Sieht so aus, als ben[tige man einen Schl]ssel, um das Garagentor zu [ffnen.") ;
      say("Ich sollte mich hier mal danach umsehen. Vielleicht liegt ja irgendwo einer rum.") ;
    } else say("Ich sollte die Abdeckung entfernen, wie es in der Anleitung steht.") ;
  } else {
	  if (!hasItem(Ego, Wires)) { 
	    say("M[glicherweise kann ich mit dieser Platine das Garagentor [ffnen...") ;
	    say("...aber ich vermute, mir fehlen noch die {berbr]ckungskabel.") ;
          }
	   else
	  switch upcounter(4) {
	    case 0: "Das hat wohl nichts gebracht."  
	    case 1: "Es ist immer noch nichts passiert."
	    case 2: "Nach dieser Anleitung kann ich das Garagentor ]ber die Platine kurzschlie}en."
		    "Diese Einstellung hat aber nichts gebracht."
	    default : "Vielleicht sollte ich die Anleitung noch genauer studieren."
	  }  		
   }
}

/* ************************************************************* */

object Rechts {
 setClickArea(1332-375,0,1332,360) ;
 enabled = true ;
 visible = false ;
 clickable = true ;
 absolute = false ;
 name = "Rechts" ;
}

event default -> Rechts {
 forceHideInventory ;
 Ego:
  walk(872,257) ;
  turn(DIR_EAST) ;
 disableScrolling ;
 do {
   scrollX += 6 ;
   delay ;
 } until (scrollX >= 1332 - 640) ;
 
 delay 64 ;

 do {
   scrollX -= 12 ;
   delay ;
 } until (scrollX <= 872-320) ;
 
 enableScrolling ;
 forceShowInventory ;
 clearAction ;
}

/* ************************************************************* */

object Wolke {
 setPosition(876,198) ;
 setAnim(Wolke_sprite) ;
 enabled = !stopWater ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 stopAnimDelay = 4 ;
 Priority = 20 ;
} 

object backgr {
 setPosition(281,270) ;
 setAnim(Weg_image) ;
 enabled = true ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 Priority = 255 ;
}

event animate backgr {
 backgr.visible = (Ego.positionX > 328) ;
}

object Teichani {
 setPosition(86,125) ;
 setAnim(Teich_sprite) ;
 enabled = true ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 Priority = 2 ;
 stopAnimDelay = 2 ;
}

object Rohreani {
 setPosition(896,143) ;
 setAnim(Rohre_sprite) ; 
 enabled = true ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 Priority = 2 ;
 stopAnimDelay = 2 ;
}

object Ast {
 setPosition(0,0) ;
 setAnim(Ast_image) ;
 enabled = true ;
 visible = true ;
 absolute = false ;
 clickable = false ;
 priority = 255 ;
 soundVolume = 230 ;
}

object Rohr {
 setPosition(888,191) ; 
 setAnim(Rohr_sprite) ;
 enabled = !stopWater ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 stopAnimDelay = 3 ;
 priority = 5 ;
}


/* ************************************************************* */

object Panel {
 setupAsStdEventObject(Panel,LookAt,632,214,DIR_NORTH) ; 			
 setClickArea(630,188,639,199) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 if (doOpenPanel == 2) name = "Platine" ;
  else name = "Abdeckung" ;
}

event Take -> Panel {
 triggerObjectOnObjectEvent(Use, Panel) ;
}

event TalkTo -> Panel {
 Ego:
  walkToStdEventObject(Panel) ;
 suspend ;
  "Hallo?"
  "Kann mich jemand h[ren?"
 delay 7 ;
 clearAction ;
}

event LookAt -> Panel {
 Ego:
  walkToStdEventObject(Panel) ;
 suspend ;
 if (doOpenPanel == 2) Ego.say("Die Elektrik des Garagentors.") ;
  else Ego.say("Eine Abdeckung, die wohl die Elektrik des Garagentors sch]tzt.") ;
 delay 4 ;
 if (surizaSolved) {
   "Ich habe sie kurzgeschlossen."
   "Das Garagentor ist ein St]ck ge[ffnet."
 } else {
  "Ich werfe einen n#heren Blick darauf..."
   delay 6 ;
   doEnter(Suriza) ;
 }
   clearAction ;
}

script openedPanel {
 return Panel.getField(0) ;
}

event Open -> Panel {
  triggerObjectOnObjectEvent(Use, Panel) ;
}

event Use -> Panel {
  Ego:
   walkToStdEventObject(Panel) ;
  suspend ;
  if (!openedPanel) {
   say("Mit blo}en H#nden bekomme ich die Abdeckung nicht ab.") ;
   clearAction ;
   return ; 
  }
  if (surizaSolved) {
    "Das Garagentor ist bereits offen."
    clearAction ; 
    return ;
  } else {
    lightmap = null ;
    lightmapAutoFilter = false ;
    doEnter(Suriza) ;
  }
}

event Screwdriver -> Panel {
  Ego:
   walkToStdEventObject(Panel) ;
  if (surizaSolved) {
    "Das Garagentor ist bereits offen."
  } else {
    if (readAnleitung) {
      suspend ;
      if  (!openedPanel) {
        say("Ich entferne mal die Schrauben, wie es in der Anleitung steht.") ;
        Panel.setField(0, true) ;
        doOpenPanel = 1 ;
      }
      lightmap = null ;
      lightmapAutoFilter = false ;
      doOpenPanel = true ;
      doEnter(Suriza) ;
    } else {
      "Wozu soll das gut sein?" 
      "Es sieht so aus, dass ich zum |ffnen des Tors einen Schl]ssel brauche."
    }
  }
}

event Pull -> Panel {
 triggerObjectOnObjectEvent(Push, Panel) ;
}

event Wires -> Panel {
 if (openedPanel) { triggerObjectOnObjectEvent(Use, Panel) ; return ; }
 Ego:
  walkToStdEventObject(Panel) ;
 suspend ;
 Ego.say("Ich wei} nicht, wie das funktionieren soll.") ;
clearAction ; 
}

event Push -> Panel {
 Ego:
  walkToStdEventObject(Panel) ;
 suspend ;
 if (!openedPanel) Ego.say("Mit blo}en H#nden kann ich die Abdeckung nicht bewegen.") ;
  else Ego.say("Die Platine l#sst sich nicht so einfach bewegen.") ;
 clearAction ;	
}

/* ************************************************************* */

object Garageoffen {
 setPosition(637,181) ;
 setAnim(Garagentoroffen_image) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = surizaSolved ; 
}

/* ************************************************************* */

object Zurueck {
 setClickArea(212,330,361,359) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Taxi" ;
}

event Take -> Zurueck {
 triggerObjectOnObjectEvent(WalkTo, Zurueck) ;
}

event Use -> Zurueck {
 triggerObjectOnObjectEvent(WalkTo, Zurueck) ;
}

event WalkTo -> Zurueck {
 Ego:
  walk(265,357) ;
  visible = false ;
  lightmap = null ;
  lightmapAutoFilter = false ;  
 suspend ;
 doEnter(Taxikarte) ;
}


/* ************************************************************* */

object Schild {
 setupAsStdEventObject(Schild,LookAt,232,343,DIR_WEST) ; 	
 setClickArea(10,238,158,332) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event Take -> Schild {
 Ego:
  walkToStdEventObject(Schild) ;
  "Ich m[chte es nicht."
}

event LookAt -> Schild {
 Ego:
  walkToStdEventObject(Schild) ;
  "Ein Schild mit der Aufschrift 'SamTec' wurde an den Baum genagelt."
  "Hier bin ich richtig."
}

/* ************************************************************* */

object Schranke {
 setupAsStdEventObject(Schranke,LookAt,580,241,DIR_WEST) ; 		
 setClickArea(550,167,570,248) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schranke" ;
}

event LookAt -> Schranke {
 Ego:
  walkToStdEventObject(Schranke) ;
  "Eine Schranke."
  "Sie ist ge[ffnet."
}

event Push -> Schranke {
 triggerObjectOnObjectEvent(Use, Schranke) ;
}

event Pull -> Schranke {
 triggerObjectOnObjectEvent(Use, Schranke) ;
}

event Close -> Schranke {
 triggerObjectOnObjectEvent(Use, Schranke) ;
}

event Open -> Schranke {
 Ego:
  walkToStdEventObject(Schranke) ;
  "Sie ist doch schon offen."
}

event Use -> Schranke {
 Ego:
  walkToStdEventObject(Schranke) ;
 suspend ;
 EgoUse ;
  "Ich kann sie nicht bewegen."
  "Vermutlich wird sie ferngesteuert."
 clearAction ;
}

/* ************************************************************* */

object Garage {
 setupAsStdEventObject(Garage,LookAt,640,220,DIR_EAST) ; 		
 setClickArea(629,160,679,217) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Garage" ;
}

event WalkTo -> Garage {
 Ego:
  walkToStdEventObject(Garage) ;
  if (surizaSolved) {
    suspend ;
    lightmap = null ;
    lightmapAutoFilter = false ;
    doEnter(Dottgarage) ;
  }
}

event Use -> Garage {
 if (surizaSolved) triggerObjectOnObjectEvent(Close, Garage) ;
  else triggerObjectOnObjectEvent(Open, Garage) ;
}

event Open -> Garage {
 Ego:
  walkToStdEventObject(Garage) ;
  if (surizaSolved) say("Das Tor ist bereits offen.") ;
   else { 
     suspend ;
     EgoUse ;
     delay 3 ;
     say("Das Tor ist viel zu schwer f]r mich.") ;
     say("Es scheint au}erdem elektrisch ge[ffnet zu werden.") ;
     clearAction ;
   }
}

event Close -> Garage {
 Ego:
  walkToStdEventObject(Garage) ;
 if (surizaSolved) say("Lieber nicht.") ;
  else say("Das Tor ist bereits geschlossen.") ;	 
}

 

event LookAt -> Garage {
 Ego:
  walkToStdEventObject(Garage) ;
  say("Wer kennt ihn nicht: den Garage-o-Mat der Firma 'Garagentore und Mehr'.") ;
  say("Wahrlich ein Meisterst]ck der modernen Technik. Ein Stahl-Garagentor mit Drehstromantrieb.") ;
  if (surizaSolved) {
    say("Ich habe es kurzgeschlossen und nun ist es ein St]ck weit ge[ffnet.") ;    
  }
}

event Push -> Garage {
 Ego:
  walkToStdEventObject(Garage) ;
 suspend ;
 EgoUse ;
 delay 4 ; 
  say("Bewegt sich kein St]ck.") ;
 clearAction ;
}

event Pull -> Garage {
 triggerObjectOnObjectEvent(Push, Garage) ;
}

event Screwdriver -> Garage {
 var didGive = did(give) ;
 Ego:
  walkToStdEventObject(Garage) ;
 if (didGive) {
  say("Den will sie nicht.") ;
  return ;
 }
 suspend ;
  say("Damit werde ich das Garagentor wohl kaum aufstemmen k[nnen.") ;
 clearAction ;
}

event default -> Garage {
 if (Did(Push) or Did(Pull) or Did(Take) or (Did(Give) and SelectedObject == Give)) {
   triggerDefaultEvents ;
   return ;
 }
 Ego:
  walkToStdEventObject(Garage) ;
  
 if (!surizaSolved) say("Damit bekomme ich sie nicht auf.") ;
  else say("Ich w]sste nicht, was das bringen soll.") ;
  
}

/* ************************************************************* */

object Rohre {
 setupAsStdEventObject(Rohre,WalkTo,855,247,DIR_EAST) ;
 setClickArea(845,174,1005,247) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Abflussrohre" ;
}

event default -> Rohre {
 triggerObjectOnObjectEvent(walkTo, Rohre) ;
}

event LookAt -> Rohre {
 Ego:
  walkToStdEventObject(Rohre) ;
  say("Das sind Abflussrohre die aus dem Labor kommen.") ;
  if (!stopWater) say("Es schie}t eine ekelhafte Br]he heraus.") ;
   else say("Daraus tropft es etwas.") ;
}

event WalkTo -> Rohre {
 clearAction ;
 Ego:
  walk(855,247) ;
  turn(DIR_EAST) ;
 suspend ;
 lightmap = null ;
 lightmapAutoFilter = false ;
 doEnter(Dottrohre) ;
}

/* ************************************************************* */

object Schuesseln {
 setupAsStdEventObject(Schuesseln,LookAt,730,260,DIR_NORTH) ;	
 setClickArea(771,3,905,98) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "gigantische Satellitensch]sseln" ;
}

event LookAt -> Schuesseln {
 Ego:
  walkToStdEventObject(Schuesseln) ;
  "Gigantisch."   
}
 
/* ************************************************************* */ 

object Aufkleber {
 setupAsStdEventObject(Aufkleber,LookAt,730,260,DIR_NORTH) ;	
 setClickArea(684,177,758,201) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schriftzug" ;
}

event LookAt -> Aufkleber {
 Ego:
  walkToStdEventObject(Aufkleber) ;
  "'Zu verkaufen'." 
  "Die Lage ist ja nicht schlecht. Nur das obere Gescho} m]sste saniert werden."
}

event Take -> Aufkleber {
 Ego:
  walkToStdEventObject(Aufkleber) ;
  "Ich komme nicht ran." 
}

event Pull -> Aufkleber {
 triggerObjectOnObjectEvent(Take, Aufkleber) ;
}


/* ************************************************************* */

object Fenster {
 setupAsStdEventObject(Fenster,LookAt,730,260,DIR_NORTH) ;	
 setClickArea(670,160,833,214) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fenster" ;
}

event LookAt -> Fenster {
 Ego:
  walkToStdEventObject(Fenster) ;
 suspend ;
 delay 5 ;
  say("Von hier drau}en kann ich nur eine gro}e Pendeluhr erkennen.") ;
  say("Der Rest scheint ziemlich leer ger#umt.") ;
 if (!surizaSolved) {
   say("Ich kann nur hoffen, dass hier noch brauchbare Beweise zu finden sind.") ;
   say("Auf jeden Fall sollte ich mich da drinnen mal umsehen.") ;
 }
 delay 3 ;
 clearAction ;
}

event Open -> Fenster {
 Ego:
  walkToStdEventObject(Fenster) ;
  "Ich komme von hier aus nicht ran."
}

event Close -> Fenster {
 triggerObjectOnObjectEvent(Open, Fenster) ;
}

event TalkTo -> Fenster {
 Ego:
  walkToStdEventObject(Fenster) ;
 suspend ;
  say("HALLO?") ;
  say("KANN MICH JEMAND H|REN?") ;
 delay 23 ;
  say("Scheint niemand da zu sein.") ;
 clearAction ;
}


 
/* ************************************************************* */ 

object Labor {
 setupAsStdEventObject(Labor,LookAt,730,260,DIR_NORTH) ;	
 setClickArea(680,79,846,246) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Geb#ude" ;
}

event LookAt -> Labor {
 Ego:
  walkToStdEventObject(Labor) ;
 suspend ;
 delay 5 ;
  say("Das ist ein Labor von Samtec.") ; 
  say("Das Geb#ude kommt mir irgendwie bekannt vor...") ;
  say("Wahrscheinlich von irgendeinem Star-Architekten aus den 90ern.") ;
 delay 2 ;
  say("Die Garage scheint der einzige Eingang zu sein.") ;
 delay 3 ;
 clearAction ;
}

event Open -> Labor {
 Ego:
  walkToStdEventObject(Labor) ;
  "Ich sollte es mit der Garage versuchen."
}

event Close -> Labor {
 triggerObjectOnObjectEvent(Open, Labor) ;
}

event TalkTo -> Labor {
 Ego:
  walkToStdEventObject(Labor) ;
 suspend ;
  say("HALLO?") ;
  say("KANN MICH JEMAND H|REN?") ;
 delay 23 ;
  say("Scheint niemand da zu sein.") ;
 clearAction ;
}

/* ************************************************************* */

object Seitenarm {
 setupAsStdEventObject(Seitenarm,LookAt,250,300,DIR_NORTH) ;		
 setClickArea(248,135,431,247) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Seitenarm des Nils" ;
}


event LookAt -> Seitenarm {
 Ego:
  walkToStdEventObject(Golf) ;
  "Hier ist die Welt noch in Ordnung." 
  "Das kristallklare Wasser macht die Erde fruchtbar und gr]n." 
  "Und das mitten in der W]ste."	
}

event Reagenzglas -> Seitenarm {
 Ego:
  walkToStdEventObject(Golf) ;
 "Nein, dieses Wasser hier scheint mir kristallklar und rein."	
}

/* ************************************************************* */

object Golf {
 setupAsStdEventObject(Golf,LookAt,250,300,DIR_NORTH) ;		
 setClickArea(129,137,147,160) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Golfstange" ;
}

event LookAt -> Golf {
 Ego:
  walkToStdEventObject(Golf) ;
  "Der 'Kairo International Golf Club'." 
  "Bekannt f]r ein besonders t]ckisches achtzehntes Loch." 
  "In den Wasserhindernissen lauern gefr#}ige Krokodile."
}

event Use -> Golf {
 Ego:
  walkToStdEventObject(Golf) ;
  "Lieber nicht, ich bin gerade etwas aus der {bung."	
}

event Take -> Golf {
 Ego:
  walkToStdEventObject(Golf) ;
  "Ich brauche sie nicht."
}

event TalkTo -> Golf {
 Ego:
  walkToStdEventObject(Golf) ;
 suspend ;
  "HALLO DA DR{BEN!"
 delay 10 ;
 clearAction ;
}

/* ************************************************************* */

object Laborschild {
 setupAsStdEventObject(Laborschild,LookAt,630,250,DIR_NORTH) ;			
 setClickArea(575,10,682,76) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "gro}es Schild" ;
}

event WalkTo -> Laborschild {
 Ego: 
  walkToStdEventObject(Laborschild) ;
}

event LookAt -> Laborschild {
 Ego:
  walkToStdEventObject(Laborschild) ;
  say("Darauf steht: 'SamTec - Lab 51'.") ;
}

event TalkTo -> Laborschild {
 Ego:
  walkToStdEventObject(Laborschild) ;
 suspend ;
  say("HALLO DA OBEN!") ;	
 delay 10 ;
 clearAction ;
}

event default -> Laborschild {
 Ego:
  walkToStdEventObject(Laborschild) ;
  say("Ich komme nicht ran.") ;	
}

