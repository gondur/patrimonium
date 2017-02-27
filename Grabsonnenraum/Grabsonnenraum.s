// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

// StatueBG.getField(0) == true -> Statue wurde zur Seite geschoben
// AbsperrungBG.getField(0) == true -> Absperrung weggelegt

var inRad = false ;

event enter {
 inRad = false ;
 Geheim.caption = null ;
 
 Ego:	
 backgroundImage = Grabsonnenraum_image;
 backgroundZBuffer = Grabsonnenraum_zbuffer ;
 enabled = true ;
 visible = true ;    
 pathAutoScale = true ;
 
 path = Grabsonnenraum_path ;
 
// absperrungBG.setField(0, true) ;
// Absperrung.enabled = false ;
// absperrungBG.enabled = false ;
 
 if (AbsperrungBG.getField(0)) path = Grabsonnenraum2_path ;
 if (StatueBG.getField(0)) path = Grabsonnenraum3_path ; 

 DarknessEffect.enabled = !SolvedAtonPuzzle ;
 FlashLightEffect.enabled = false ;
 if ((Flashlight.getField(0)) and (!SolvedAtonPuzzle)) FlashLightOn ; // Taschenlampe an  
 
 if (previousScene == Grabeingang) {
  setPosition(552,168) ;
  face(DIR_SOUTH) ;
  walk(492,239) ;
 } else if (previousScene == ChefBuero) {
  Ego:
  setPosition(312,280) ;
  face(DIR_WEST) ;
 } else if (previousScene == Grabschiebe) {
  setPosition(312,280) ;
  face(DIR_WEST) ;
  PlatteZwei.visible = false ;
  if (solvedAtonPuzzle) { // Julian das Aton-Rätsel gelöst:
   forceHideInventory ;
   FlashLightOff ;
   DarknessEffect.enabled = false ;
   PlattenAktiviert = false ;     // Platten wieder deaktivieren
   fadeIn ;
   delay 18 ;
   Ego.turn(DIR_WEST) ;
   
   if (CactusInPot.enabled) {
    "Der Sockel f#ngt an stark zu vibrieren..."
    "...ich habe wohl irgendetwas in Gang gesetzt..."
    EgoUse ;
    takeItem(Ego,Cactus) ;
    CactusInPot.enabled = false ;
    CactusInPot.SetField(0,false) ;
    if (OscarTableTalk < 1) {
     "...komm lieber wieder mit."
    } else {
     "...auch wenn du mich tief verletzt hast, Oscar..."
     "...ich lasse dich nicht zur]ck."
    }
   } 
   
   Ego.turn(DIR_NORTH) ;
   Ego.turn(DIR_SOUTH) ;
   Ego.say("Wo kommt auf einmal das ganze Licht her?") ; 
   delay(8) ;
   Ego.say("Huch!") ;
   Ego.walk(380,280) ; Ego.turn(DIR_WEST) ; 
   
   delay 10 ; 
   moveStatue ;
   delay 10 ;
   Ego.say("Gut, besser, JULIAN HOBLER!") ; 

   delay(50) ;    
   doEnter(Abbuero);
   finish ;
  } else {
   if (KartuscheChanged) pujaTipp ; // wenn nicht, wird ein Puja-Tipp angezeigt, sofern er aus der Kiste schon die Steinquader genommen hat.
  }
 } else {
  setPosition(80,215) ;
  face(DIR_SOUTH) ;
  walk(130,260) ;
 }
 
 if (!SolvedAtonPuzzle) start checkSensor ; 
  else Geheim.enabled = true ;
	  
 if PlattenAktiviert { start plattenSound ; }

 clearAction ;
 forceShowInventory ;
} 

/* ************************************************************* */

script fadeIn {
 soundBoxStart(Music::AnubisLichtan_wav) ;
 for (var iAlpha = 255; iAlpha>0; iAlpha -= 3) {
  drawingColor = RGBA(0,0,0,iAlpha) ;
  drawRectanglePri(0,0,SCREEN_WIDTH,360,255) ; 
  delay ;
 }
}

/* ************************************************************* */

object SpiegelStein {
 setupAsStdEventObject(SpiegelStein,LookAt,478,245,DIR_WEST) ;
 setPosition(433,197) ;
 setAnim(SpiegelStein_image) ;
 enabled = getField(0) ;
 visible = true ;
 clickable = true ;
 setClickArea(0,0,31,42) ;
 Priority = 28 ;
 absolute = false ;
 name = "spiegelnder Schl]ssel" ;
}

event Touch -> SpiegelStein {
 Ego: 
  WalkToStdEventObject(SpiegelStein) ;
  if (FackelSchein.visible) {
   "Das ist der spiegelnde Schl]ssel, den ich auf den Stein gelegt habe."
   "Ich kann ihn durch den matten Lichtwurf aus dem Nebenraum erkennen."
  } else {
   "F]hlt sich an wie der Schl]ssel, den ich auf dem Stein abgelegt habe."
  } 
} 

event CarpetScrap -> SpiegelStein {
 Ego:
  WalkToStdEventObject(SpiegelStein) ;
  "Ich habe den Schl}ssel bereits auf Hochglanz poliert."
}

event LookAt -> SpiegelStein {
 Ego: 
  WalkToStdEventObject(SpiegelStein) ;
  "Ich habe den Spiegel auf den Stein gelegt, so dass er das einfallende Licht aus dem Eingangsraum auf den Detektor an der Wand lenkt."
} 

event Take -> SpiegelStein {
 Ego: 
  WalkToStdEventObject(SpiegelStein) ;
  suspend ;
  "Ich nehme den Schl]ssel wieder an mich."
  EgoUse ;
  takeItem(Ego,EchKey) ;
  SpiegelStein.enabled = false ;
  SpiegelStein.setField(0, false) ;
 clearAction ; 
} 

event Push -> SpiegelStein {
 Ego: 
  WalkToStdEventObject(SpiegelStein) ;
  "Der Spiegel erf]llt seinen Zweck, es gibt keinen Grund ihn anders auszurichten."
} 

event Pull -> SpiegelStein { TriggerObjectOnObjectEvent(Push,SpiegelStein); }

/* ************************************************************* */

object SpiegelSchein {
 class = NonInteractiveClass ;
 setPosition(442,135) ;
 setAnim(SpiegelSchein_image) ;
 enabled = (SpiegelStein.getField(0) and torchLight) ;
 visible = true ;
 priority = 223 ;
 clickable = false ;
 absolute = false ;
 path = SpiegelSchein_path ;
} 

event Paint SpiegelSchein {
 drawingPriority = SpiegelSchein.Priority ;
 drawingColor = RGBA(255,255,255,Fackelschein.BGAlpha) ;
 drawImage(SpiegelSchein.PositionX,SpiegelSchein.PositionY,SpiegelSchein_image) ;
} 

object Fackelschein {
 class = NonInteractiveClass ;
 setPosition(430,125) ;
 setAnim(FackelSchein_image) ;
 enabled = TorchLight ; 
 visible = true ;
 priority = 250;
 clickable = false ;
 absolute = false ;
 path = FackelSchein_path ;
 member BGAlpha = 200 ;
}

event Paint Fackelschein {
 static int timer = 0 ;
 if (timer > 2) and (Random(6)==0) {
  timer = 0 ;
  Fackelschein.BGAlpha = 150 - Random(65) ;
 } else timer ++ ; 
 
 drawingPriority = FackelSchein.Priority ;
 drawingColor = RGBA(255,255,255,Fackelschein.BGAlpha) ;
 if (SpiegelStein.enabled) { 
  drawImage(FackelSchein.PositionX,FackelSchein.PositionY,FackelSchein2_image) ;
 } else {
  drawImage(FackelSchein.PositionX,FackelSchein.PositionY,FackelSchein_image) ;
 } 
} 

event animate Fackelschein {
 if (FackelSchein.InsidePath(Ego.PositionX,Ego.PositionY)) {
  Spiegelschein.enabled = false ;
  Fackelschein.visible = false ;
 } else {
  Fackelschein.visible = true ;
  if (SpiegelSchein.InsidePath(Ego.PositionX,Ego.PositionY)) {
   Spiegelschein.enabled = false ;
  } else {
   Spiegelschein.enabled = (TorchLight and SpiegelStein.enabled) ;
  } 
 } 
} 


/* ************************************************************* */

object Geheim {
 setupAsStdEventObject(Geheim,LookAt,150,335,DIR_SOUTH) ;
 setAnim(Geheim_sprite) ;
 setPosition(124,276) ;
 enabled = (SpiegelStein.getField(0)) or (SolvedAtonPuzzle) ;
 setClickArea(0,0,22,43) ;
 autoAnimate = false ;
 visible = true ; 
 frame = getField(0) ;
 priority = 45 ;
 clickable = true ; 
 absolute = false ;
 name = "|ffnung" ;
 captionwidth = 100 ;
 captionX = 15 ;
 captionY = 0 ;
 captionColor = COLOR_WHITE ;
 captionBase = BASE_ABOVE ;
}

event LookAt -> Geheim {
 Ego:
  WalkToStdEventObject(Geheim) ;
  "Eine geheime |ffnung, die aufgeht, wenn Licht auf die Linse an der gegen]berliegenden Wand f#llt."
  if (Geheim.getField(0)==0) say("Darin befindet sich ein kleiner Steinquader.") ;
   else say("Sie ist leer.") ;
}

event Take -> Geheim {
 Ego:
  WalkToStdEventObject(Geheim) ;
  
 if (Geheim.getField(0)==0) {
  suspend; 
  delay 2 ;
  "In der |ffnung befindet sich ein kleiner Steinquader."
  "Ich nehme ihn an mich."
  EgoStartUse ;
  takeItem(Ego, ScheibeSonnenscheibe) ;
  Geheim:
   frame++ ;
   setField(0,1) ;
  EgoStopUse ;
  clearAction ; 
 } else say("Hier gibt es nichts mehr.") ;	
}

event Touch -> Geheim {
 Ego:
  WalkToStdEventObject(Geheim) ;
  "Ich ertaste eine schmale rechteckige |ffnung in der S#ule." 
  if (Geheim.getField(0)==0) {
   "In ihr scheinen sich mehrere Gegenst#nde zu befinden, die ich nicht genau ertasten kann."
  } else {
   "Sie scheint leer zu sein."
  }
}

event Open -> Geheim {
 Ego:
  WalkToStdEventObject(Geheim) ;
  EgoUse ;
  "Ich finde keinen Angriffspunkt."
  "Die |ffnung l#sst sich wohl nur mit dem Lichtdetektor [ffnen und schlie}en."
}
event Close -> Geheim { TriggerObjectOnObjectEvent(Open,Geheim); }

// ************************************************************

object Sensor {
 setupAsStdEventObject(Sensor,LookAt,508,238,DIR_EAST) ;
 setAnim(Sensor_image) ;
 setPosition(546,135) ;
 enabled = true ;
 visible = getField(0) ;
 clickable = true ;
 if (!getField(0)) name = "br[ckelige Wand" ;
  else name = "Konstruktion" ;
 absolute = false ;
 priority = 33 ; 
 setClickArea(0,0,32,26) ;
}

event Touch -> Sensor {
 Ego:
  WalkToStdEventObject(Sensor) ;
  if (Sensor.getField(0)) {
   "Ich ertaste eine kleine runde Vertiefung in der Wand."
  } else {
   "An dieser Stelle f]hlt sich die Wand sehr br]chig an."
  }
}

event AbsperrStange -> Sensor { TriggerObjectOnObjectEvent(ScrewDriver,Sensor) ; }

event Screwdriver -> Sensor {
 Ego:
  WalkToStdEventObject(Sensor) ;
  
 if (Sensor.getField(0)) say("Lieber nicht. Ich k[nnte etwas kaputt machen.") ;
  else {
   suspend ; 
   EgoStartUse ;
   soundBoxPlay(Music::Sensor_wav) ;
   Sensor:
    visible = true ;
    name = "Konstruktion" ;
    setField(0, true) ;
   EgoStopUse ;
   Ego.say("Hoppla! Das hat das Ausgrabungssteam wohl ]bersehen.") ;
   clearAction ;
  }
}

event Echkey -> Sensor {
 Ego:
  WalkToStdEventObject(Sensor) ;
  if (!Sensor.getField(0)) { say("Ich w]sste nicht, was das bringen sollte.") ; return ; } 
  if (! torchLight) { say("Ich w]sste nicht, wie mir das momentan weiterhelfen k[nnte.") ; return ; }

 suspend ; 
 WalkToStdEventObjectNoResume(Stein2) ;	
  say("Ich befestige den Schl]ssel mit dem Spiegel am besten so,...") ;
  say("...dass er das Licht aus dem anderen Raum auf die Linse reflektiert!") ;
 delay 10 ;
  walk(478,234) ;
  turn(DIR_WEST) ;
 EgoStartUse ;
 dropItem(Ego, EchKey) ;
 SpiegelStein.enabled = true ;
 SpiegelStein.setField(0, true) ;
 EgoStopUse ;
 clearAction ;
}

event LookAt -> Sensor {
 Ego:
  WalkToStdEventObject(Sensor) ;
  if (!Sensor.getField(0)) say("Die Wand sieht an dieser Stelle ziemlich br[ckelig aus.") ;
   else say("Das ist eine Art Linse aus einem mir unbekannten, schwarzen Material.") ;
}

event Push -> Sensor {
 Ego:
  WalkToStdEventObject(Sensor) ;
  EgoUse ;
  if (!Sensor.getField(0)) {
   "Die Wand ist an dieser Stelle sehr leicht br]chig."
   "Mit der blossen Hand kann ich allerdings nur einige kleine Kr]mel aus der Wand l[sen."
  } else {
   "Die Linse ist vollst]ndig freigelegt." 	  
  }
} 

event Pull -> Sensor { TriggerObjectOnObjectEvent(Push,Sensor); }


script checkSensor {
 killOnExit = true ;
 loop {
  if (sensor.visible) {
   if ((SpiegelSchein.enabled) or (SolvedAtonPuzzle) or ((FlashlightEffect.enabled) and (floatToInt(dist(mouseX,mouseY,562,148)) < 50))) {
    Geheim.enabled = true ;
    if (inRad == false) start {  soundBoxStart(Music::Secret_wav) ;  Geheim: say("* klick *") ; }
    inRad = true ;
   } else if (inRad) { 
    Geheim.enabled = false ; 
    start {  soundBoxStart(Music::Secret_wav) ;  Geheim: say("* klick *") ; }
    inRad = false ; 
   } else inRad = false ;
  }
  delay 1 ;
 } 
}

/* ************************************************************* */

object Durchgang {
 setupAsStdEventObject(Durchgang,WalkTo,500,220,DIR_EAST) ;
 setClickArea(483,122,535,195);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Durchgang" ;
}

event Use -> Durchgang {
 triggerObjectOnObjectEvent(WalkTo, Durchgang) ;
}

event WalkTo -> Durchgang {
 clearAction ;
 Ego:
  walk(480,215) ;
 suspend ;
  walk(553,168) ;
 doEnter(Grabeingang) ;
}

event Touch -> Durchgang {
 Ego:
  WalkToStdEventObject(Durchgang) ;
 suspend ;
  "Ich ertaste eine |ffnung in der Wand..."
  "...hier muss sich ein Durchgang in einen anderen Teil des Grabes befinden."
  if (TorchLight) "Ein schmaler Lichtstrahl f#llt durch die |ffnung in den Raum."
 clearAction ;
} 

event LookAt -> Durchgang {
 Ego:
  WalkToStdEventObject(Durchgang) ;
 suspend ;
  "Der Durchgang f]hrt zur]ck in die erste Kammer des Grabes."
  "Er wurde mit roher Gewalt aus der Wand gebrochen."
  if (TorchLight) "Ein schmaler Lichtstrahl f#llt durch die |ffnung in den Raum."
 clearAction ;
}

/* ************************************************************* */ 

object AbsperrungBG {
 class = NonInteractiveClass ;
 absolute = false ;
 enabled = (!getField(0)) ;
 visible = true ;
 Priority = 2 ;
 setPosition(355,155) ;
 setAnim(AbsperrungBG_image) ;
 clickable = false ;
} 

object Absperrung {
 setupAsStdEventObject(Absperrung,LookAt,343,288,DIR_WEST) ;
 enabled = (!AbsperrungBG.getField(0)) ;
 visible = true ;
 Priority = 6 ;
 absolute = false ;
 clickable = true ;
 setPosition(287,146) ; 
 setAnim(Absperrung_image) ;
 setClickArea(0,0,140,62) ; 
 name = "Absperrung" ;
}

event Take -> Absperrung {
 Ego:
  WalkToStdEventObject(Absperrung) ;
  
  suspend ;
  "Ich lege das Absperrband zur Seite."
  "Die Stange behalte ich, sie kann mir sicher noch von Nutzen sein."
  path = GrabSonnenRaum2_path ;
 EgoStartUse ;  
 AbsperrungBG.setField(0, true) ;
 AbsperrungBG.enabled = false ;
 Absperrung.enabled = false ;
 takeItem(Ego,AbsperrStange) ;
 EgoStopUse ;
 clearAction ;
}

event Touch -> Absperrung {
 Ego:
  WalkToStdEventObject(Absperrung) ;
  "F]hlt sich an wie eine eiserne Stange..."
  "...und eine Art Band das an ihr befestigt ist."
} 

event Push -> Absperrung { triggerObjectOnObjectEvent(Take, Absperrung) ; }
event Pull -> Absperrung {triggerObjectOnObjectEvent(Take, Absperrung) ; }
event Open -> Absperrung {triggerObjectOnObjectEvent(Take, Absperrung) ; }
event Use -> Absperrung {triggerObjectOnObjectEvent(Take, Absperrung) ; }

event LookAt -> Absperrung {
 Ego:
  WalkToStdEventObject(Absperrung) ;
  "Die Absperrung ist zwischen Stab und S#ule befestigt und versperrt den Zugang zur Statue."
} 

/* ************************************************************* */ 

object RankeInPot {
 setupAsStdEventObject(RankeInPot,LookAt,300,268,DIR_WEST) ;
 enabled = GetField(0) ;
 visible = true ;
 clickable = true ;
 setAnim(PflanzeStirbt_sprite) ;
 autoAnimate = false ;
 setAnimFrameDelay(0,4) ;
 setAnimFrameDelay(1,4) ;
 setAnimFrameDelay(2,4) ;
 setAnimFrameDelay(3,4) ;
 setAnimFrameDelay(4,4) ; 
 setClickArea(0,0,42,20) ; 
 Priority = 8 ;
 setPosition(239,183) ;
 name = "Gew#chs" ;
}

event Take -> RankeInPot {
 Ego:
  WalkToStdEventObject(RankeInPot) ;
  suspend ;	  
  "Ich nehme die Ranke wieder an mich."
  EgoUse ;
  takeItem(Ego,RankenGewaechs) ;
  RankeInPot.enabled = false ;
  RankeInPot.SetField(0,false) ;
  clearAction ; 
} 

event LookAt -> RankeInPot {
 Ego:
  WalkToStdEventObject(RankeInPot) ;
  "Das ist ein rankiges Gew#chs."
  "Ich habe es vor die Statue des Anubis gelegt."   
} 

event Touch -> RankeInPot {
 Ego:
  WalkToStdEventObject(RankeInPot) ;
  "F]hlt sich an wie die Ranke die ich vor die Statue des Anubis gelegt habe."
} 

script RunRankeAnim { 
 Ego: 
  if (!PlattenAktiviert) { 
   EgoStartUse ; 
   "Das Halsband f]hlt sich eigenartig warm an..." 
   "...und es wird immer w#rmer." 
   "Nein, hei}!" 
   "Autsch!" 
   EgoStopUse ; 
   // Soundeffekt 
   "Huch!" 
   walk(380,280) ; 
   turn(DIR_WEST) ; 
   "Was passiert hier?" 
  } else { 
   walk(380,280) ; 
   turn(DIR_WEST) ; 
  } 
  start soundBoxPlay(Music::Opfer_wav) ;
  RankeInPot.autoAnimate = true ; 
  start { Ego.say("WOW!"); Ego.say("Die Ranke scheint in sekundenschnelle zu zerfallen."); } 
  delay while (RankeInPot.Frame < 4) ; 
  RankeInPot.autoAnimate = false ; 
  
  delay(30) ;   
  PlattenAktiviert = true ; 
  start plattenSound ;
   
  WalkToStdEventObjectNoResume(RankeInPot) ; 
  EgoStartUse ; 
  "Es ist nur noch ein H#uflein Asche ]brig." 
  RankeInPot.enabled = false ; 
  RankeInPot.SetField(0,false) ; 
  EgoStopUse ; 
  delay 10 ;
} 

/* ************************************************************* */

object CactusInPot {
 setupAsStdEventObject(CactusInPot,TalkTo,300,268,DIR_WEST) ;
 enabled = GetField(0) ;
 visible = true ;
 clickable = true ;
 setAnim(KaktusStirbt_sprite) ;
 setAnimFrameDelay(0,4) ;
 setAnimFrameDelay(1,4) ;
 setAnimFrameDelay(2,4) ;
 setAnimFrameDelay(3,4) ;
 setAnimFrameDelay(4,4) ; 
 setAnimFrameDelay(5,4) ; 
 autoAnimate = false ;
 setClickArea(0,0,41,40) ; 
 Priority = 8 ;
 setPosition(237,164) ;
 name = "Oscar" ; 
}

event Take -> CactusInPot {
 Ego:
  WalkToStdEventObject(CactusInPot) ;
  if (OscarTableTalk < 1) {
   suspend ; 
   "Ich nehme Oscar wieder an mich."
   EgoUse ;
   takeItem(Ego,Cactus) ;
   CactusInPot.enabled = false ;
   CactusInPot.SetField(0,false) ;
   clearAction ; 
  } else {
   "Oscar will nichts mehr von mir wissen..."
   "...von nun an gehen wir getrennte Wege."
  }   
} 

event LookAt -> CactusInPot {
 Ego:
  WalkToStdEventObject(CactusInPot) ;
  "Das ist mein Kaktus Oscar."
  "Ich habe ihn vor die Statue des Anubis gestellt."   
} 

event Touch -> CactusInPot {
 Ego:
  WalkToStdEventObject(CactusInPot) ;
  "Autsch!"
  "Lass das Oscar."
} 

event TalkTo -> CactusInPot {
 Ego:
  WalkToStdEventObject(CactusInPot) ;
  suspend ; 
  switch OscarTableTalk {
   case 0 : "Hey Oscar!"
            "Ich sehe du hast einen neuen Freund gefunden."
            delay(20) ;
            turn(DIR_SOUTH) ;
            "Er antwortet mir nicht..."
            "...jetzt wo er neue Freunde gefunden hat, bin ich ihm wohl nicht mehr gut genug."
	    OscarTableTalk = 0 ;
   case 1 : "Ich war immer f]r dich da Oscar..."
	    "...und jetzt verleugnest du mich."
	    "Rede doch wieder mit mir!"
   case 2 : "Bedeutet dir unsere gemeinsame Zeit denn garnichts mehr?"
   case 3 : "Du hast mich tief verletzt Oscar."
   case 4 : if (PlattenAktiviert) {
	     "Wenn ich dich nicht haben kann..."
	     WalkToStdEventObjectNoResume(AnubisHalsband) ;
	     "...dann soll dich auch niemand anders haben!"
	     triggerObjectOnObjectEvent(Push, Anubishalsband) ;
	     return ;
            } else {
             "Leb wohl Oscar..."
	     "...von nun an gehen wir getrennte Wege."
	    }		    
   default : "Ich will nichts mehr von ihm wissen."
  }
  OscarTableTalk++ ;
 clearAction ; 
} 

event Push -> CactusInPot {
 Ego:
  WalkToStdEventObject(CactusInPot) ;
  "Autsch!"
  "Oscar will nicht herumgeschubst werden."
} 

event Pull -> CactusInPot { TriggerObjectOnObjectEvent(Push,CactusInPot) ; }

script RunCactusAnim { 
 Ego: 
  if (!PlattenAktiviert) {
   EgoStartUse ; 
   "Das Halsband f]hlt sich eigenartig warm an..." 
   "...und es wird immer w#rmer." 
   "Nein, hei}!" 
   "Autsch!" 
   EgoStopUse ; 
   "Huch!" 
   walk(380,280) ; 
   turn(DIR_WEST) ; 
   "Was passiert hier?" 
   start soundBoxPlay(Music::Opfer_wav) ;  
   delay(10) ; 
  } else {
   EgoUse ;
   walk(380,280) ; 
   turn(DIR_WEST) ; 
   delay(10) ; 
   start soundBoxPlay(Music::Opfer_wav) ;
   "OSCAR!" 
  }   
  CactusInPot.autoAnimate = true ; 
  if (PlattenAktiviert) {
   start { delay(5) ; Ego.say("Das hast du davon!"); } 	  
  } else {
   start { delay(5) ; Ego.say("NEEEEEEIIIIINNNNNN!"); } 
  }
   
  delay while (CactusInPot.Frame < 5) ; 
  CactusInPot.autoAnimate = false ;   
  delay(30) ;
 
  if (!PlattenAktiviert) {    
   "Ich habs vorhin nicht so gemeint!" 
   "Es tut mir leid!" 
   delay(20) ;
  } 
   
  WalkToStdEventObjectNoResume(CactusInPot) ; 
  EgoStartUse ; 
  delay(15) ;
  "Das ist alles was von ihm ]brig ist..." 
  CactusInPot.enabled = false ; 
  CactusInPot.SetField(0,false) ; 
  takeItem(Ego,CactusPot) ;  
  EgoStopUse ; 
  
  delay(15) ; 
  if ((OscarTableTalk < 1) and (!PlattenAktiviert)) {
   "...ich werde dich niemals vergessen Oscar." 
   turn(DIR_SOUTH) ; 
   "Ich hoffe, er ist nun in einer besseren Welt."   
   delay 10 ;
   turn(DIR_NORTH) ;
  }
  
  PlattenAktiviert = true ; 
  start plattenSound ;
} 

/* ************************************************************* */ 

object StatueBG {
 enabled = true ;
 visible = true ;
 Priority = 1 ;
 absolute = false ; 
 clickable = false ;
 setAnim(Statue_sprite) ;
 autoAnimate = false ;
 setPosition(137,0) ;
 if (getField(0)) { frame = 11 ; } else { frame = 0 ; }
}

script MoveStatue {  
 Gang.enabled = true ;
 AnubisKartuschen.enabled = false ;
 AnubisKartuschen.setField(0,true) ;
 StatueBG.setField(0,true) ;
 AnubisStatue.enabled = false ;
 AnubisHalsband.enabled = false ;
 AnubisSockel.enabled = false ;
 AnubisKartuschen.enabled = false ;
 soundBoxStart(Music::Anubis_wav) ;
 delay(35) ;
 AnimateStatue ; 
 delay(10) ;
}

script AnimateStatue {
 for (var i=0; i<StatueBG.getSpriteFrameCount(Statue_sprite); i++) {
  StatueBG.frame = i ;
  delay 2 ;
 }
}

/* ************************************************************* */ 

object AnubisKartuschen {
 setupAsStdEventObject(AnubisKartuschen,LookAt,312,280,DIR_WEST) ;
 enabled = (!StatueBG.getField(0)) ;
 visible = true ;
 Priority = 6 ;
 absolute = false ; 
 clickable = true ;
 setClickArea(260,209,296,252) ;
 name = "Symbole" ;
}

event Use -> AnubisKartuschen { triggerObjectOnObjectEvent(LookAt, AnubisKartuschen) ; }

event LookAt -> AnubisKartuschen {
 Ego:
  WalkToStdEventObject(AnubisKartuschen) ;
  
 if (! AbsperrungBG.getField(0)) {
  "Hier sind verschiedene kleine Steinquader angeordnet."
  "Die Absperrung ist im Weg, sonst k[nnte ich einen genaueren Blick darauf werfen."
  return ;
 } else {
  suspend ; 
  delay 10 ;
  if (upcounter(2) == 0) say("Ich schau mir das mal genauer an...") ;
  EgoUse ;
  doEnter(Grabschiebe) ;
  clearAction ; 
 }
}

event Take -> AnubisKartuschen {
 Ego:
  WalkToStdEventObject(AnubisKartuschen) ;
  if (! AbsperrungBG.getField(0)) {
   "Die Absperrung ist im Weg."
  } else {
   EgoUse ;
   "Die Kartuschen lassen sich nicht einfach so herausl[sen."
  }
}

event Pull -> AnubisKartuschen { TriggerObjectOnObjectEvent(Take,AnubisKartuschen); }

event Push -> AnubisKartuschen {
 Ego:
  WalkToStdEventObject(AnubisKartuschen) ;

 if (! AbsperrungBG.getField(0)) {
  "Die Absperrung ist im Weg."
 } else {
  EgoUse ;
  "Dr]cken bringt nichts."
 }
}

event default -> AnubisKartuschen {	
 if IsClassDerivate(SelectedObject,InvObj) {  
   if (IsScheibe(SelectedObject)) {
    Ego:	
     WalkToStdEventObject(AnubisKartuschen) ;		   
    suspend ; 
    delay 10 ;    
    EgoUse ;
    doEnter(Grabschiebe) ;	   
   } else Ego.say("Das passt doch nicht.") ;
 } else triggerDefaultEvents ; 
 clearAction ;
}

/* ************************************************************* */

object AnubisSockel {
 setupAsStdEventObject(AnubisSockel,LookAt,300,268,DIR_WEST) ;
 enabled = (!StatueBG.getField(0)) ;
 visible = true ;
 Priority = 5 ;
 absolute = false ; 
 clickable = true ;
 setClickArea(146,173,301,273) ;
 name = "Sockel" ;
}

event Touch -> AnubisSockel {
 Ego:
  WalkToStdEventObject(AnubisSockel) ;
  "F]hlt sich an wie ein steinerner Tisch oder Sockel."
} 

event Cactus -> AnubisSockel { 
 Ego: 
  WalkToStdEventObject(AnubisSockel) ; 
   
  if (! AbsperrungBG.getField(0)) { 
   "Die Absperrung ist im Weg." 
   return ; 
  } 
   
 if (RankeInPot.GetField(0)) { 
  "Ich habe bereits die Ranke daraufgelegt." 
  return ; 
 } 
  
 suspend ; 
  "Ich stelle Oscar vor die Statue." 
  dropItem(Ego,Cactus) ; 
  EgoUse ; 
  CactusInPot.enabled = true ; 
  CactusInPot.SetField(0,true) ;   
 if (hasItem(Ego, RankenGewaechs)) {
   delay 23 ;
   Ego.say("Jetzt, wo ich Oscar da so allein stehen sehe...") ;
   Ego.say("Sollte ich nicht doch lieber dieses rankige Gew#chs vor die Statue legen?") ;
 }
 clearAction ; 
} 

event RankenGewaechs -> AnubisSockel { 
 Ego: 
  WalkToStdEventObject(AnubisSockel) ; 
   
  if (! AbsperrungBG.getField(0)) { 
   "Die Absperrung ist im Weg." 
   return ; 
  } 
   
 if (CactusInPot.GetField(0)) { 
  "Ich habe bereits Oscar daraufgestellt." 
  return ; 
 } 
  
 suspend ; 
  
 if (PlattenAktiviert) { 
  "Oscar ist tot!" 
  "Nun ist mir alles egal..." 
  "...Ranke..." 
  "...du musst sterben!" 
  delay(10) ; 
 }  
  
  "Ich lege die Ranke vor die Statue." 
  dropItem(Ego,RankenGewaechs) ; 
  EgoUse ; 
  RankeInPot.enabled = true ; 
  RankeInPot.SetField(0,true) ;   
   
    
 if (PlattenAktiviert) { 
  delay(20) ; 
  "Sag Oscar es tut mir Leid!" 
  TriggerObjectOnObjectEvent(Push,AnubisHalsband) ; 
  return ; 
 } 
   
 clearAction ; 
} 

event InvObj -> AnubisSockel {
 Ego:
  WalkToStdEventObject(AnubisSockel) ;
 
  if (! AbsperrungBG.getField(0)) {
   "Die Absperrung ist im Weg."
   return ;
  }
 
  "Ich sehe keinen Grund das vor die Statue zu stellen."
}

event LookAt -> AnubisSockel {
 Ego:
  WalkToStdEventObject(AnubisSockel) ;
  
  if (! AbsperrungBG.getField(0)) {
   "Die Absperrung ist im Weg."
   return ;
  }  
  
  switch upcounter(2) {
    case 0 : "Ein gewaltiger, rechteckiger Sockel aus Stein."
	     "Auf ihm ruht eine gro}e, steinerne Statue des Anubis."
	     "Zwischen den Pfoten der Statue ist ein seltsames Symbol in den Sockel graviert."
    default : "Ein gro}er, steinerner Sockel auf dem die Statue des Anubis ruht."
	      "Auf dem Symbol zwischen den Pfoten liegt ]berproportional viel Staub und sogar etwas Asche."
   }  
}

event Push -> AnubisSockel {
 Ego:
  WalkToStdEventObject(AnubisSockel) ;
  
  if (! AbsperrungBG.getField(0)) {
   "Die Absperrung ist im Weg."
   return ;
  }  
  
  "Der Sockel bewegt sich um keinen Millimeter."
} 

event Pull -> AnubisSockel { TriggerObjectOnObjectEvent(Push,Anubissockel); }

/* ************************************************************* */ 

object AnubisHalsband {
 setupAsStdEventObject(AnubisHalsband,LookAt,240,294,DIR_NORTH) ;
 enabled = (!StatueBG.getField(0)) ;
 visible = true ;
 Priority = 7 ;
 absolute = false ; 
 clickable = true ;
 setClickArea(222,120,256,143) ;
 name = "goldenes Halsband" ;
}

event LookAt -> AnubisHalsband {
 Ego:
  WalkToStdEventObject(AnubisHalsband) ;
  "Die Anubisstatue tr#gt um ihren Hals ein goldenes Halsband."
  "In ihm sind Schriftzeichen eingraviert, deren Bedeutung ich nicht verstehe..."
} 

event Push -> AnubisHalsband { 
 Ego:
  WalkToStdEventObjectNoResume(AnubisHalsband) ;
  
 suspend ; 
  if (RankeInPot.enabled) { RunRankeAnim ; } else
  if (CactusInPot.enabled) { 
   if (PlattenAktiviert) { 
    if (OscarTableTalk < 1) {	   
     "Nein!" 
     "Ich m[chte nicht das Oscar das gleich Schicksal ereilt..." 
     "...wie diese arme unschuldige Ranke."
    } else {
     "Leb wohl, Oscar."
     RunCactusAnim ;    
    }
   } else RunCactusAnim ;
  } else {
   EgoStartUse ;   
   "Das Halsband f]hlt sich eigenartig warm an..."
   "...und die Luft scheint elektrisch zu knistern."
   "Der Sockel vibriert etwas, aber nichts weiteres passiert."
   EgoStopUse ;
  } 
 clearAction ;
}

event Touch -> AnubisHalsband {
 Ego:
  WalkToStdEventObject(AnubisHalsband) ;
  EgoUse ;
  "F]hlt sich an wie ein breiter Ring aus Metall."
  "Er ist sonderbar warm."
}

event Use -> AnubisHalsband { TriggerObjectOnObjectEvent(Push, AnubisHalsband) ; }

event Pull -> AnubisHalsband {
 Ego:
  WalkToStdEventObject(AnubisHalsband) ;
  
  EgoUse ;
  "Ich kann das Halsband nicht von der Statue l[sen."
}

event Take -> AnubisHalsband { TriggerObjectOnObjectEvent(Pull,AnubisHalsband) ; }

/* ************************************************************* */ 

object AnubisStatue {
 setupAsStdEventObject(AnubisStatue,LookAt,210,290,DIR_NORTH) ;
 enabled = (!StatueBG.getField(0)) ;
 visible = true ;
 Priority = 6 ;
 absolute = false ; 
 clickable = true ;
 setClickArea(177,73,285,179) ;
 name = "Anubis-Statue" ;
}

event LookAt -> AnubisStatue {
 Ego:
  WalkToStdEventObject(AnubisStatue) ;
  switch upcounter(3) { // Puja
    case 0 : "Eine gewaltige Statue aus Stein."
	     "Ich glaube sie stellt den #gyptischen Gott Anubis dar."
	     "Hinter ihr glaube ich einen Durchgang zu erkennen,..."
	     "...welcher allerdings von der Statue v[llig versperrt ist."
	     static var first = true ;
             if (first) { 
	      turn(DIR_SOUTH) ;
	      "Ich dachte das w#re ein Tempel des Aton..."
	      "...warum stellt die Statue dann Anubis dar?"
	      first = false ;
	     }  
    case 1 : "Eine gewaltige Anubisstatue aus Stein."
	     "Sie versperrt den dahinter befindlichen Durchgang."
    default : "Ich muss die Statue irgendwie aus dem Weg schaffen, um den Gang betreten zu k[nnen."
	      "Vielleicht sollte ich diese Symbole auf der Vorderseite genauer anschauen."
   }  
}

event Push -> AnubisStatue {
 clearAction ;
 Ego: 
  walk(164,278) ;
  turn(DIR_NORTH) ;
  
 suspend ; 
  EgoStartUse ;
  delay(10) ;
  "Unm[glich."
  EgoStopUse ;
  turn(DIR_SOUTH) ;  
  "Die Statue ist tonnenschwer und bewegt sich kein St]ck."
 clearAction ;
} 

event Pull -> AnubisStatue { TriggerObjectOnObjectEvent(Push, Anubisstatue) ; }

event Take -> AnubisStatue {
 Ego: 
  WalkToStdEventObject(AnubisStatue) ;
  "Die Statue ist viel zu schwer um sie mitzunehmen."
} 

event Touch -> AnubisStatue {
 Ego: 
  WalkToStdEventObject(AnubisStatue) ;
  "F]hlt sich an wie eine riesige steinerne Statue..."
  "...ich denke sie stellt ein Tier dar."
} 

event Use -> AnubisStatue { 
 if (!StatueBG.getField(0)) { TriggerObjectOnObjectEvent(Use,Gang) ; return; }
 
 Ego: 
  WalkToStdEventObject(AnubisStatue) ;
  "Ich m[chte nicht auf die Statue klettern."
}  

// **********************************************************

object Stein1 { 
 setupAsStdEventObject(Stein1,LookAt,377,270,DIR_NORTH) ;
 enabled = true ;
 visible = false ;
 setClickArea(360,208,412,248) ;
 clickable = true ;
 absolute = false ;
 name = "Stein" ;
} 

event LookAt -> Stein1 {
 Ego:
  WalkToStdEventObject(Stein1) ;
  "Ein gro}er, dunkler Steinbrocken."
  "Wahrscheinlich von dem Mauerdurchbruch."
}

event Take -> Stein1 {
 Ego:
  WalkToStdEventObject(Stein1) ;
  "Der Stein ist viel zu schwer."
}

event Push -> Stein1 {
 Ego:
  WalkToStdEventObject(Stein1) ;
  "Ich m[chte mich nicht sinnlos abm]hen."
}
event Pull -> Stein1 { TriggerObjectOnObjectEvent(Push,Stein1); }

// ************************************************************

object Stein2 { // angeleuchteter stein
 setupAsStdEventObject(Stein2,LookAt,487,236,DIR_WEST) ;
 enabled = true ;
 visible = false ;
 setClickArea(428,201,462,235) ;
 clickable = true ;
 absolute = false ;
 name = "Stein" ;
}

event EchKey -> Stein2 { TriggerObjectOnObjectEvent(EchKey,Sensor) ; } 

event LookAt -> Stein2 {
 Ego:
  WalkToStdEventObject(Stein2) ;
  "Ein mittelgro}er, dunkler Steinbrocken."
  "Wahrscheinlich von dem Mauerdurchbruch."
  if (TorchLight) "Die Fackel im Nebenraum wirft einen schmalen Lichtstreifen auf ihn..."
}

event Take -> Stein2 {
 Ego:
  WalkToStdEventObject(Stein2) ;
  "Ich m[chte den schweren Stein nicht mit mir herumtragen."
}

event Push -> Stein2 {
 Ego:
  WalkToStdEventObject(Stein2) ;
  "Ich m[chte mich nicht sinnlos abm]hen."
}

event Pull -> Stein2 { TriggerObjectOnObjectEvent(Push,Stein2) ; }

// ************************************************************

object Stein3 { 
 setupAsStdEventObject(Stein3,LookAt,35,337,DIR_NORTH) ;
 enabled = true ;
 visible = false ;
 setClickArea(3,282,55,325) ;
 clickable = true ;
 absolute = false ;
 name = "Stein" ;
} 

event LookAt -> Stein3 {
 Ego:
  WalkToStdEventObject(Stein3) ;
  "Ein gro}er, dunkler Steinbrocken."
}

event Take -> Stein3 {
 Ego:
  WalkToStdEventObject(Stein3) ;
  "Der Stein ist viel zu schwer."
}

event Push -> Stein3 {
 Ego:
  WalkToStdEventObject(Stein3) ;
  "Ich m[chte mich nicht sinnlos abm]hen."
}
event Pull -> Stein3 { TriggerObjectOnObjectEvent(Push, Stein3) ; }

// ************************************************************

object Saeule1 {
 setupAsStdEventObject(Saeule1,LookAt,166,353,DIR_WEST) ;
 enabled = true ;
 visible = false ;
 setClickArea(52,0,152,360) ;
 clickable = true ;
 absolute = false ;
 name = "S#ule" ;
} 

event LookAt -> Saeule1 {
 Ego:
  WalkToStdEventObject(Saeule1) ;
  "Eine steinerne runde S#ule die vom Boden bis an die Decke reicht."
}

event Take -> Saeule1 {
 Ego:
  WalkToStdEventObject(Saeule1) ;
  "Die S#ule ist viel zu gro} und schwer."
}

event Push -> Saeule1 {
 Ego:
  WalkToStdEventObject(Saeule1) ;
  EgoUse ;
  "Sie bewegt sich keinen Millimeter."
}

event Pull -> Saeule1 { TriggerObjectOnObjectEvent(Push,Saeule1) ; }

event Open -> Saeule1 {
 Ego:
  WalkToStdEventObject(Saeule1) ;
  EgoUse ;
  if (sensor.visible) {
   if (Geheim.enabled) {
    "Die geheime Klappe ist bereits ge[ffnet..."
    "...dahinter befindet sich ein kleiner Hohlraum."
   } else {
    "Der rechteckige Umriss an der S#ule scheint eine Art geheime Klappe zu sein..."
    "...die durch den Sensor an der gegen]berliegenden Wand gesteuert wird."
    "Ich kann sie nicht von Hand [ffnen."
   }
  } else {
   "Ich finde an der S#ule nichts das sich [ffnen lie}e..."
   static int first = true ;
   if (first) {
    suspend ; 
    "...allerdings kann ich schwach einen rechteckigen Umriss erkennen,..."
    "...so als ob sich dort eine Art Klappe bef#nde..."
    EgoUse ;
    "...Die Umrisse sind jedoch so fein,..."
    "...dass ich sie mit meinen blossen Fingerspitzen nicht ertasten kann."
    turn(DIR_SOUTH) ;
    "Wahrscheinlich handelt es sich nur um sehr d]nne Kratzer."
    first = false ;
    clearAction ; 
   }
  }
} 

// ************************************************************

object Saeule2 {
 setupAsStdEventObject(Saeule2,LookAt,480,230,DIR_WEST) ;
 enabled = true ;
 visible = false ;
 setClickArea(360,0,428,236) ;
 clickable = true ;
 absolute = false ;
 name = "S#ule" ;
}

event LookAt -> Saeule2 {
 Ego:
  WalkToStdEventObject(Saeule2) ;
  "Eine steinerne runde S#ule die vom Boden bis an die Decke reicht."
}

event Take -> Saeule2 {
 Ego:
  WalkToStdEventObject(Saeule2) ;
  "Die S#ule ist viel zu gro} und schwer."
}

event Push -> Saeule2 {
 Ego:
  WalkToStdEventObject(Saeule2) ;
  EgoUse ;
  "Sie bewegt sich keinen Millimeter."
}
event Pull -> Saeule2 { TriggerObjectOnObjectEvent(Push,Saeule2); }

event Open -> Saeule2 {
 Ego:
  WalkToStdEventObject(Saeule2) ;
  EgoUse ;
  "Ich finde an der S#ule nichts das sich [ffnen lie}e."
} 

/* ************************************************************* */

object Gang {
 setupAsStdEventObject(Gang,LookAt,160,235,DIR_NORTH) ;
 enabled = true ;
 visible = false ;
 Priority = 2 ;
 setClickArea(142,93,189,227);
 absolute = false ;
 clickable = true ;
 name = "Gang" ;
}

event Use -> Gang {
 triggerObjectOnObjectEvent(WalkTo, Gang) ;
}

event WalkTo -> Gang {
 clearAction ;
 Ego: 
 walk(160,235) ;
 turn(DIR_NORTH) ;
 
 suspend ; 
 static int first = true ;
 if ((Ego.PositionX==160) and (Ego.PositionY==235)) {
  walk(121,218) ;
  doEnter(GrabKristallraum) ;
 } else if (first) {
  turn(DIR_NORTH) ;
  delay(10) ;
  EgoUse ;
  delay(10) ;
  turn(DIR_EAST) ;   
  "Die Statue versperrt mir den Weg."
  first = false ;
 } 
 clearAction ; 
}

event LookAt -> Gang {
 Ego: 
 WalkToStdEventObject(Gang) ;
 if (!StatueBG.getField(0)) {
  "Hinter der Statue scheint ein weiterer Durchgang tiefer ins Grab zu f]hren..."
  "...ich kann ihn aber nicht betreten, da die Statue den Weg versperrt."
 } else {
  "Die Statue hat einen Durchgang freigelegt, welcher tiefer ins Grab hinein f]hrt..."
  "...von dem Durchgang scheint eine starke Energie auszugehen, die den ganzen Raum durchflutet und in Licht taucht."
 }
} 

event Use -> Gang {
 Ego: 
  WalkToStdEventObject(Gang) ;
  static int first = true ;
  
  if (!StatueBG.getField(0)) {
   suspend ;
   if (first) {
    "Vielleicht gelingt es mir ]ber die Statue hinweg zu klettern."
    EgoStartUse ;
    delay(15) ;
    "Nanu, das f]hlt sich eigenartig an..."
    EgoStopUse ;
    delay(15) ;
    EgoStartUse ;   
    "Wenn ich meine Hand nach dem Durchgang ausstrecke, stellen sich meine Armhaare auf"
    "...und ein leises, bedrohlichen Summen wird h[rbar."
    EgoStopUse ;
    first = false ;
   } 
   
   turn(DIR_EAST) ;
   "Ich klettere lieber nicht ]ber die Statue hinweg."
   "Der Professor sprach von einem t[dlichen Unfall im Grab..."
   "...weil die Wissenschaftler die Energie des Kristalls untersch#tzt hatten." 
   "Es muss eine andere M[glichkeit geben, den Gang zu erreichen."   
   clearAction ; 
  } else {
   "Es gibt keine T]r die ich [ffnen m]sste."
   "Ich kann einfach hindurchgehen." 
  }  
} 

/* ************************************************************* */

object Kiste {
 setupAsStdEventObject(Kiste,LookAt,555,293,DIR_NORTH) ;
 setClickArea(520,196,601,274);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kiste" ;
}

object KisteBild {
 class = NonInteractiveClass ;
 clickable = false ;
 enabled = false ;
 visible = true ;
 absolute = false ;
 priority = 34 ;
 setAnim(KisteOffen_image) ;
 setPosition(509,184) ;
}

event Touch -> Kiste {
 Ego:
  WalkToStdEventObject(Kiste) ;
  "F]hlt sich an wie eine Kiste aus Holzplanken."
} 

event LookAt -> Kiste {
 clearAction ;	
 Ego:
  WalkToStdEventObject(Kiste) ;
  "Eine Holzkiste."
  "Vermutlich haben sie die Wissenschaftler hier hereingebracht,..."
  "...das Holz w#re sonst sicher l#ngst verfault."
}

event Use -> Kiste { triggerObjectOnObjectEvent(Open, Kiste) ; }

event Open -> Kiste {
 Ego:
  WalkToStdEventObject(Kiste) ;

 suspend ; 
 EgoStartUse ;
 KisteBild.enabled = true ;
 soundBoxStart(Music::Schublade_wav) ;
 EgoStopUse ;
 if (Kiste.getField(0)) {
  "Sie ist leer."
 } else {
  "Mal sehen..."
  "In der Kiste befindet sich ein Schraubenzieher und ein Seil..."
  "...ich nehme alles mit."
  Kiste.setField(0,true) ;
  EgoStartUse ;
  takeItem(Ego, Screwdriver) ;  
  takeItem(Ego, Rope) ;
  EgoStopUse ;
 }
 EgoStartUse ;
 soundBoxStart(Music::Schublade_wav) ;
 KisteBild.enabled = false ;
 EgoStopUse ;
 clearAction ; 
}

event Take -> Kiste {
 Ego:
  WalkToStdEventObject(Kiste) ;
  "Die Kiste ist viel zu schwer."
} 

/* ************************************************************* */ 

script pujaTipp {
  Ego:
  switch upcounter(3) {
    case 0 : "Das hat nichts gebracht."  
    case 1 : "Auch dieses mal ist nichts passiert."
    case 2 : "Nichts." 
	     "Ich glaube ich muss mit den Steinquadern irgendwas darstellen."
    default : "Nichts."
	      "Vielleicht sollte ich einen Blick in das Tagebuch des Professors riskieren."
   }  	
}

/* ************************************************************* */ 

script PlattenKommentar {
 suspend ;
 Ego.Stop ;
 Ego.say("Huch!") ;
 Ego.turn(DIR_SOUTH) ;
 Ego.say("Die Bodenplatte gibt etwas nach wenn ich darauf trete...") ;
 Ego.say("...und ein leises Klickger#usch ert[nt.") ;
 Ego.say("Meine ''Opfergabe'' hat wohl einen weiteren Mechanismus in Gang gesetzt...") ;
 Ego.say("...ich frage mich, was es damit auf sich hat.") ;
 clearAction ;
} 

script plattenSound {
 killOnExit = true ;
 var p2 = false ;
 var p4 = false ;
 loop {
  delay while (!PlattenAktiviert) ; 
	  
  if (PlatteZwei.visible) {
   if (p2==false) {soundBoxStart(Music::Platte_wav) ; p2 = true ; } 
  } else if (p2)  {soundBoxStart(Music::Plattehoch_wav) ; p2 = false ; } 
  
  if (PlatteVier.visible) {
   if (p4==false) {soundBoxStart(Music::Platte_wav) ; p4 = true ; } 
  } else if (p4)  {soundBoxStart(Music::Plattehoch_wav) ; p4 = false ; }
  
  if ( ((p2) or (p4)) and (!KenntPlatten) ) { KenntPlatten = true ; start PlattenKommentar ; }
  
  delay ;
 } 
}

/* ************************************************************* */ 

object PlatteZwei { 
 setupAsStdEventObject(PlatteZwei,LookAt,326,323,DIR_WEST) ;
 setPosition(202,290) ;
 setAnim(Platte2_image) ;
 name = "Bodenplatte" ;
 visible = PlattenAktiviert and (!PlatteGedrueckt)  ;
 visible = false ;
 enabled = true ;
 clickable = false ; 
 setClickArea(0,0,185,70) ;
 path = Platte2_path ;
}

event animate PlatteZwei {
 platteZwei.clickable = platteZwei.insidePath(mouseX+scrollX, mouseY+scrollY) ;
 if ((!PlattenAktiviert) or PlatteGedrueckt) return ;
  platteZwei.visible = platteZwei.insidePath(Ego.positionX, Ego.positionY) ;
  if (platteZwei.visible) 
   if ((lastPlatte == 1) or (lastPlatte == 2)) { 
    lastPlatte = 2 ;
   } else lastPlatte = 0 ;   
}

event LookAt -> PlatteZwei {
 Ego:
  WalkToStdEventObject(PlatteZwei) ;
  "Auf der Bodenplatte befinden sich drei ]bereinander angeordnete Symbole,"
  "ein gef]llter Halbkreis, eine Wellenlinie und ein Vollkreis mit einem Loch in der Mitte."
  "Das kommt mir irgendwie bekannt vor."
  "Ich glaube, ich habe diese Symbole schon einmal im Tagebuch des Professors gesehen."
  if (PlattenAktiviert) ClickHint ;
} 

event Push -> PlatteZwei {
 Ego:
  WalkToStdEventObject(PlatteZwei) ;
  if (PlattenAktiviert) {
   "Ich muss die Platte nur betreten und sie wird heruntergedr]ckt."
  } else {
   EgoUse ;
   "Solider Steinboden."
  } 
} 

event Use -> PlatteZwei { TriggerObjectOnObjectEvent(Push,PlatteZwei) ; }

event Pull -> PlatteZwei {
 Ego:
  WalkToStdEventObject(PlatteZwei) ;
  "Es macht keinen Sinn an der Platte zu ziehen..."
  "...vorallem nicht solange ich daraufstehe."
}

event invobj -> PlatteZwei {
 Ego:
  WalkToStdEventObject(PlatteZwei) ;
  "Ich m[chte meine Besitzt]mer nicht sinnlos auf dem Boden verstreuen."
} 

/* ************************************************************* */ 

object PlatteVier { 
 setupAsStdEventObject(PlatteVier,LookAt,520,315,DIR_EAST) ;
 setPosition(470,264) ;
 setAnim(Platte4_image) ;
 name = "Bodenplatte" ;
 visible = PlattenAktiviert and (!PlatteGedrueckt) ;
 enabled = true ;
 clickable = false ;
 setClickArea(0,0,135,90) ;
 path = Platte4_path ;
}

event animate PlatteVier {
 platteVier.clickable = platteVier.insidePath(mouseX+scrollX,mouseY+scrollY) ;
 if ((!PlattenAktiviert) or PlatteGedrueckt) return ;
  PlatteVier.visible = platteVier.insidePath(Ego.positionX, Ego.positionY) ;
  if (platteVier.visible) 
   if ((lastPlatte == 3) or (lastPlatte == 4)) { 
    lastPlatte = 4 ;
   } else lastPlatte = 0 ;
}

event LookAt -> PlatteVier {
 Ego:
  WalkToStdEventObject(PlatteVier) ;
  "Auf der Bodenplatte befinden sich das Symbol eines Vogels mit einem langen schmalen Schnabel."
  "Das kommt mir irgendwie bekannt vor."
  "Ich glaube, ich habe dieses Symbol schon mal im Tagebuch des Professors gesehen."
  if (PlattenAktiviert) ClickHint ;
} 

event Push -> PlatteVier {
 Ego:
  WalkToStdEventObject(PlatteVier) ;
  if (PlattenAktiviert) {
   "Ich muss die Platte nur betreten und sie wird heruntergedr]ckt."
  } else {
   EgoUse ;
   "Solider Steinboden."
  } 
} 

event Use -> PlatteVier { TriggerObjectOnObjectEvent(Push,PlatteVier) ; }

event Pull -> PlatteVier {
 Ego:
  WalkToStdEventObject(PlatteVier) ;
  "Es macht keinen Sinn an der Platte zu ziehen..."
  "...vorallem nicht solange ich daraufstehe."
}

event invobj -> PlatteVier {
 Ego:
  WalkToStdEventObject(PlatteVier) ;
  "Ich m[chte meine Besitzt]mer nicht sinnlos auf dem Boden verstreuen."
} 