// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var HitWithScrewDriver = false ;
static var triedToIgnite = false ;

event enter {	
 backgroundImage = Grabeingang_image ;
 backgroundZBuffer = Grabeingang_zbuffer ;	  
 Ego.path = Grabeingang_path ;
 Ego.Priority = PRIORITY_AUTO ;
 
 FlashLightEffect.enabled = false ;
 TorchLightEffect.enabled = false ;
 MatchLightEffect.enabled = false ;
 DarknessEffect.enabled = false ;

 Ego:
  enabled = true ;
  visible = true ;  
  pathAutoScale = true ;
  Lightmap = test_image ;
  LightmapAutoFilter = true ;
  Reflection = false ;
  ReflectionOffsetY = 185 ; 
  ReflectionTopColor = RGBA(0,0,0,120) ; 
  ReflectionBottomColor = RGBA(0,0,0,10) ;
  ReflectionAngle = FloatMul(inttofloat(-1),0.8) ;
  ReflectionStretch = 1.0 ;
 
 if (hasItem(Ego, Flashlight)) { forceShowInventory; } else { forceHideInventory ; }
    
 // Lichtquellen
 if (escapedEchnaton == 0) { ShadowOverlay.enabled = true ; } else // Erstmaliges Betreten 
 if ((!Flashlight.getField(0)) and (!torchLight)) { DarknessEffect.enabled = true ; } else // Taschenlampe aus, Fackel aus	  
 if (torchlight) { TorchEffectOn ; } else // Fackel
 if (Flashlight.getField(0)) {	FlashLightOn ; } // Taschenlampe an  
   
 // Startpositionen
 if (previousScene == Ausgrabungsstelle) {
  setPosition(550,218) ;
  face(DIR_SOUTH) ;
  walk(445,290) ;
 } else {
  setPosition(80,215) ;
  face(DIR_SOUTH) ;
  walk(130,260) ;
 }
 
 start PlattenSound ;
 
 if (EscapedEchnaton == 0) { AgentenVersperrenEingang ; } else
 if ((previousScene == Ausgrabungsstelle) and (! hasItem(Ego, Flashlight))) { JulianFindetTaschenlampe ; } else
 clearAction ;

} 

/* ************************************************************* */

script TorchSound {
 killOnExit = true ;
 loop {
   Fackel.playSound(Music::Torch_wav) ; 
   return if (currentScene != Grabeingang) ;
 }	 
}

script AgentenVersperrenEingang {	
 EscapedEchnaton = 2 ;
 forceHideInventory ;
 
 MarkResource(Music::smash_wav) ;
 MarkResource(Music::Abdeckung_wav) ;
 MarkResource(Music::schublade_wav) ;
 MarkResource(Music::TuerZu_wav) ;
 MarkResource(Music::Hammer_wav) ; 
 
 delay 10 ;
 soundBoxStart(Music::smash_wav) ;
 Holz : "*rumms*"
 Ego.turn(DIR_EAST) ;
 
 delay(10) ;
 soundBoxStart(Music::smash_wav) ;
 Holz : "*rumms*"
 
 Ego:
  turn(DIR_WEST) ;
  turn(DIR_EAST) ;
  "Was ist das?"
 delay(10) ;
 
 Holz.visible = true ;
 soundBoxPlay(Music::Abdeckung_wav) ;
 
 delay(10) ;
 soundBoxStart(Music::schublade_wav) ;
 soundBoxPlay(Music::TuerZu_wav) ;
 ShadowOverlay.Darkness = 50 ;
 Ego.say("Moment mal!") ;
 Ego.turn(DIR_NORTH) ;
 
 delay(10) ;
 soundBoxStart(Music::schublade_wav) ;
 soundBoxPlay(Music::TuerZu_wav) ;
 ShadowOverlay.Darkness = 130 ;
 
 delay(20) ; 
 soundBoxStart(Music::schublade_wav) ;
 ShadowOverlay.Darkness = 150 ;
 delay(20) ;
 
 soundBoxStart(Music::Hammer_wav) ;
 ShadowOverlay.FadeToBlack = true ;
 
 delay(10) ;
 Ego.turn(DIR_NORTH) ; 
 Ego.walk(437,281) ;  
 Ego.walk(550,218); 
 
 delay while (ShadowOverlay.Darkness < 255) ;
 
 UnMarkResource(Music::smash_wav) ;
 UnMarkResource(Music::Abdeckung_wav) ;
 UnMarkResource(Music::schublade_wav) ;
 UnMarkResource(Music::TuerZu_wav) ;
 UnMarkResource(Music::Hammer_wav) ; 
 
 doEnter(Ausgrabungsstelle) ;
}

script AddNode2(X,Y) {AddNode(X+300,Y+300); }

script JulianFindetTaschenlampe {
 forceHideInventory ;
 delay(20) ;	
 
 Ego: "Diese verdammten Kerle haben mich hier unten eingesperrt!"
 delay(15) ;
 "Was mache ich jetzt?"
 delay(10) ;
 "Denk nach Julian..."
 "denk nach..."
 delay(10) ;
 "Moment!"
 "Ich habe noch die Streichh[lzer aus dem Hotel."
 delay(5) ; 
 delay(5) ;
 "Zwei sind noch ]brig..."
 "...das muss gen]gen."
 
 soundBoxStart(music::abreissen_wav) ;
 DarknessEffect.enabled = false ;
 FlashLightOnGround.enabled = true ;
 
 MatchLightEffect :
  enabled = true ;
  Rel = true ;
  PositionY = -100+300 ;
  PositionX = 0+300 ;
  FormatAsRouteMovingObject(MatchLightEffect) ;
  drawOverlay = -1 ;
  
 MatchLightEffect:
  MoveSpeed = 4.0 ;
  TurnSpeed = 6.0 ; 
  AddNode2(0,-100) ;
  AddNode2(-15,-20) ;
  AddNode2(-20,-10) ;
  AddNode2(-25,0) ;
  AddNode2(-20,10) ;
  AddNode2(-10,20) ;
  Moving = true ;
  delay while ((MatchLightEffect.PositionX != -20+300) or (MatchLightEffect.PositionY !=-10+300)) ;
  AddNode2(-20,0) ;
  Moving = true ;
  delay(10) ;
  
 Ego:
  "Ich taste mich vorsichtig voran."
  walkingSpeed = 3 ;
  walk(105,330) ;
  "Nanu, was ist das denn?"
 
 MatchLightEffect:
  ClearNodes ;
  MoveSpeed = 5.0 ;
  AddNode2(-45,-20) ;
  AddNode2(-58,-120) ;
  Moving = true ;  
  delay while ((MatchLightEffect.PositionX != -58+300) or (MatchLightEffect.PositionY !=-120+300)) ;
 
 Ego: 
  
  
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Short2_mp3) ;  
  jukeBox.shuffle = false ;
  jukeBox_Start ;
  
  delay 10 ;  

  "AAAAAAHHHHH!"
  MatchLightEffect.enabled = false ;
  DarkNessEffect.enabled = true ;

  delay(30) ;
  "*tast*"
  delay(10) ;
  "Verdammte Statue."
  delay(15) ;
  "Ein Streichholz ist noch ]brig..."
 
 soundBoxStart(music::abreissen_wav) ;
 DarkNessEffect.enabled = false ;
 
 jukeBox_Stop ;
 jukeBox_Enqueue(Music::BG_Grab1_ogg) ;  
 jukeBox_Enqueue(Music::BG_Grab2_ogg) ;
 jukeBox.shuffle = true ;
 jukeBox_Start ;
  
 MatchLightEffect:
  enabled = true ;
  ClearNodes ;
  AddNode2(-78,-135) ;
  AddNode2(-35,-135) ;
  AddNode2(-50,-40) ;
  
  Moving = true ;
  delay while ((MatchLightEffect.PositionX != -50+300) or (MatchLightEffect.PositionY !=-40+300)) ;
  
  AddNode2(20,-10) ;
  Moving = true ;
 
 Ego:  
  Ego.say("Hier komme ich nicht weiter.") ;
  turn(DIR_NORTH) ;
  turn(DIR_EAST) ;
  walk(497,318) ;
  turn(DIR_EAST) ;
  
 MatchLightEffect:
  enabled = true ;
  ClearNodes ;
  AddNode2(-5,-30) ;
  AddNode2(0,-25) ;
  AddNode2(15,-15) ;
  AddNode2(20,-5) ;
  AddNode2(15,5) ;
  AddNode2(-5,20) ;
  Moving = true ;
  delay while ((MatchLightEffect.PositionX != -5+300) or (MatchLightEffect.PositionY !=20+300)) ;
 
 Ego: 
  "Moment mal."

 MatchLightEffect:
  AddNode2(30,0) ;
  Moving = true ;
  delay while ((MatchLightEffect.PositionX != 30+300) or (MatchLightEffect.PositionY !=0+300)) ;
 
 Ego:
  "Eine Taschenlampe!"
  walk(515,350) ;
  turn(DIR_EAST) ;
  EgoStartUse ;
  FlashlightOnGround.enabled = false ;
  takeItem(Ego,Flashlight) ;
  delay(10) ;
  EgoStopUse ;
  MatchLightEffect.enabled = false ;
  DarknessEffect.enabled = true ;
  "Hoffentlich funktioniert sie."
  delay(10) ;
  FlashLightOn ;
  delay(10) ;
  turn(DIR_WEST) ;
  "Gl]ck gehabt."
  "Vermutlich hat sie einer der Wissenschaftler hier unten vergessen."
  "Diese fiesen Kerle werden sie mir bestimmt nicht hinterlassen haben."
  turn(DIR_SOUTH) ;
  delay(10) ;
  "Ich muss unbedingt einen Weg finden hier herauszukommen."
  walkingSpeed = 8 ;
  
 forceShowInventory ;
 clearAction ;
}

object FlashLightOnGround {
 class = NonInteractiveClass ;
 enabled = false ;
 visible = true ;
 setAnim(Grabeingang::FlashlightOnGround_image) ; 
 setPosition(536,324) ;
 priority = PRIORITY_AUTO ; 
 name ="Taschenlampe" ;
} 

object MatchLightEffect {
 class = NonInteractiveClass ;
 enabled = false ;
 visible = true ;
 clickable = false ;
 Priority = 255 ;
 PositionX = 290 ;
 PositionY = 115 ;
 MarkResource(Graphics::TorchFrame_image) ;
 member rel = true ;
} 

event paint MatchLightEffect {
 if (rel) { PaintLight(PositionX+Ego.PositionX-300,PositionY+Ego.PositionY-300,50); } else
          { PaintLight(PositionX,PositionY,50); } 
}

/* ************************************************************* */

object ShadowOverlay {
 class = NonInteractiveClass ;
 enabled = false ;
 visible = true ;
 Priority = 250 ;
 member Darkness = 0 ;
 member FadeToBlack = false ;
} 

event paint ShadowOverlay {
 static int second = 0 ;
 TransparencyMode = TRANSPARENCY_ALPHA ;
 BlendImage2(303, 109, 254, 251, Priority, 255, GrabEingang::DarkOverlay_image) ;
 drawingColor = RGBA(0,0,0,255) ;
 drawingPriority = Priority ;
 drawRectangle(0,0,SCREEN_WIDTH,109) ;
 drawRectangle(0,109,303,251+109) ;
 drawRectangle(303+254,109,SCREEN_WIDTH,109+251) ; 
 if (Darkness > 0) { 
  drawingPriority = Priority + 1 ;
  drawingColor = RGBA(0,0,0,Darkness) ; 
  drawRectangle(303,109,303+254,109+251) ;  
  if ((FadeToBlack) and (Darkness < 255) and (second==0)) Darkness = min(Darkness + 1 + ((Darkness) / 30),255) ;
  second = (second+1) % 3 ;
 }
} 

/* ************************************************************* */

object Holz {
 class = NonInteractiveClass ;
 enabled = true ;
 visible = false ;
 positionX = 330 ;
 positionY = 50 ;
 captionY = 0 ;
 captionX = 0 ;
 Priority = 255 ;
 captionWidth = 400 ;	
 captionColor = COLOR_WOOD ;
 captionClick = false ;
}

event paint Holz {
 drawingJustify = 0 ;
 drawingTextColor = COLOR_WOOD ;
 drawingPriority = 255 ;
 drawingFont = defaultFont ;
 drawText(PositionX,PositionY,"*#chz*") ;
 PositionX = PositionX + 3 ;
 if (!soundBox.soundIsPlaying) visible = false ;
}

/* ************************************************************* */

object Fackel {
 setupAsStdEventObject(Fackel,LookAt,300,260,DIR_NORTH) ;
 setClickArea(280,105,320,185) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fackel" ;
}

object FackelBild {
 class = NonInteractiveClass ;
 setPosition(264,32) ;
 setAnim(Fackel_sprite) ;
 autoAnimate = false ;
 clickable = false ;
 absolute = false ;
 Priority = 15 ;
 enabled = torchLight ;
 visible = true ;
}

event Animate FackelBild {
 static int timer = 0 ;
 static int next = 4 ;
 if (timer > next) { 
  next = 3 + Random(3) ;
  FackelBild.Frame = (FackelBild.Frame + 1)  ;
  timer = 0 ;
 } 
 timer = timer + 1 ;
} 

event LookAt -> Fackel {
 Ego: 
  WalkToStdEventObject(Fackel) ;
  "Eine alte Fackel."
  if (PetrolCan.GetField(0)) "Ich habe sie mit Benzin getr#nkt."
  "Sie ist durch eine Halterung an der Wand festgemacht."
  static int first = true ;
  if (first) { Ego.turn(DIR_SOUTH); Ego.say("Vielleicht finde ich etwas um sie zu entz]nden."); first = false ; }
} 

event Push -> Fackel {
 Ego:
  WalkToStdEventObject(Fackel) ;
  EgoUse ;
 suspend ;
  "Sie l#sst sich nicht bewegen."
  static int first = true ;
  if (first) { Ego.turn(DIR_SOUTH); Ego.say("Das funktioniert wohl nur im Film oder in zweitklassigen Adventurespielen."); first = false ; }  
 clearAction ;
} 

event Pull -> Fackel { TriggerObjectOnObjectEvent(Push,Fackel) ; }

event Take -> Fackel { 
 Ego:
  WalkToStdEventObject(Fackel) ;
  EgoUse ;
  "Sie ist durch eine Halterung fest in der Wand verankert."
} 

event Stone -> Fackel {
 Ego:
  WalkToStdEventObject(Fackel) ;
 if (Fackelbild.enabled) { 
  "Steine brennen nicht." 
 } else {
  "Stein auf Fackel ist gleich Feuer? Ich glaube nicht."
  if (upcounter(2) >= 2) "Vielleicht sollte ich versuchen, mit dem Stein auf etwas Hartes zu schlagen."
 }
}

event Use -> Fackel {
 Ego:
  WalkToStdEventObject(Fackel) ;
 if (Fackelbild.enabled) {
  EgoUse ;
  static int first = true ;
  if (first) { Ego.say("Autsch!"); Ego.say("Ja, die Fackel brennt."); first = false ; } else 
             { Ego.say("Nochmal fasse ich nicht ins Feuer."); }
 } else {
  EgoUse ;
  if (PetrolCan.GetField(0)) "Die Fackel f]hlt sich feucht an."
  if (!PetrolCan.GetField(0)) "Die Fackel f]hlt sich trocken und spr[de an."
  "Ich sollte versuchen sie irgendwie anzuz]nden."
 } 
} 

event TalkTo -> Fackel {
 Ego:
  WalkToStdEventObject(Fackel) ;
  
  if (FackelBild.enabled) {
   "Du bist ganz sch]n hei}!"
  } else {
   switch upcounter(6) {
    case 0 : "Brenne!"
    case 1 : "Nun brenn doch endlich!"
    case 2 : "BRENN VERDAMMT!"
    case 3 : "Bitte brenn doch!"
    case 4 : "Brenn f]r mich!"
    case 5 : "Du k[nntest so hei} sein..."
    default : "Sie h[rt nicht auf mich."   
   }
  }
} 

event ScrewDriver -> Fackel {
 Ego:
  WalkToStdEventObject(Fackel) ;
  
  if (!Fackelbild.enabled) { 
   suspend ; 
   EgoStartUse ;
   SelectVerb(Use) ;
   HitWithScrewDriver = true ;
   "Ich halte den Schraubenzieher an die Fackel."
   "Und nun?"
   PassItem(Screwdriver) ;
  } else {
   "Ich m[chte den Schraubenzieher nicht ins Feuer halten."
  }
}

event Animate Fackel { // Checken ob woanders hin geklickt
 if ((HitWithScrewDriver) and (CV != Use)) HitWithScrewDriver = false ;
} 

event ScrewDriver -> Stone {
 Ego:
  if HitWithScrewDriver {
   WalkToStdEventObject(Fackel) ;
   suspend ;
   delay(15) ;
    
   if (PetrolCan.GetField(0)) {
    "Ich schlage mit dem Stein auf den Schraubenzieher um einen Funken zu erzeugen."
    if (TriedToIgnite) "Vielleicht klappt es mit dem Benzin nun besser."
    EgoStartUse ;
    soundBoxPlay(Music::Flintstone_wav) ;   
    start soundBoxStart(Music::Burn_wav) ;
    FlashLightOff ;
    TorchEffectOn ;
    EgoStopUse ;
    turn(DIR_SOUTH) ;
    switch random(4) {
     case 0,1,2 : "JULIAN HOBLER - Herr der Flammen!" ;
     case 3 : "Glut, Feuer, Asche!"
    } 
    "Die Taschenlampe ben[tige ich hier nicht mehr."
    "Ich schalte sie aus um Batterie zu sparen."
   } else {
    TriedToIgnite = true ;
    switch upcounter(5) {
     case 0 : EgoUse ; EgoUse ;
              "Fang endlich an zu brennen."
              EgoUse ; EgoUse ;    
              turn(DIR_SOUTH) ;
              "Die Fackel ist einfach zu alt."
              "So schaffe ich es nicht sie zu entz]nden."
     case 1 : "Vielleicht klappt es ja diesmal..."
	      EgoUse ; EgoUse ;
	      turn(DIR_SOUTH) ;
	      "Keine Chance."
	      "Die Fackel ist v[llig ausgetrocknet."
     case 2 : "Aller guter Dinge sind drei."
	      EgoUse; EgoUse;
	      "Nichts."
	      "Anscheinend ist das Pech, Teer oder Wachs oder womit auch immer die @gypter ihre Fackeln tr#nkten bereits vertrocknet..."
     default : "Und noch ein Versuch."
	       EgoUse; EgoUse ;   
               "Wieder kein Gl]ck."
    }
   } 
   
  } else {
    makeSpark ;
    if (Petrolcan.getField(0) and (!Fackelbild.enabled)) {
      Ego:
       turn(DIR_SOUTH) ;
       "Jetzt nachdem ich die Fackel mit dem Benzin getr#nkt habe, versuche ich sie mal zu entz]nden..."
       delay 2 ;
       walk(300,260) ;
       turn(DIR_NORTH) ;
       EgoStartUse ;
       soundBoxPlay(Music::Flintstone_wav) ;   
       start soundBoxStart(Music::Burn_wav) ;
       FlashLightOff ;
       TorchEffectOn ;
       EgoStopUse ;
       turn(DIR_SOUTH) ;
       switch random(4) {
        case 0,1,2 : "JULIAN HOBLER - Herr der Flammen!" ;
        case 3 : "Glut, Feuer, Asche!"
       } 
       "Die Taschenlampe ben[tige ich hier nicht mehr."
       "Ich schalte sie aus um Batterie zu sparen."       
    } 
  }
 
 clearAction ;
}  

event Stone -> ScrewDriver { TriggerObjectOnObjectEvent(ScrewDriver,Stone); }
event ScheibeBrotlaib -> ScrewDriver { TriggerObjectOnObjectEvent(ScrewDriver,Stone); }
event ScrewDriver -> ScheibeBrotlaib { TriggerObjectOnObjectEvent(ScrewDriver,Stone); }

event InvObj -> ScrewDriver {
 Ego:
  if HitWithScrewDriver {
   suspend ;
   WalkToStdEventObjectNoResume(Fackel) ;   
   "Wenn ich versuche damit auf den Schraubenzieher zu schlagen,..."
   "...werde ich es niemals schaffen einen Funken zu erzeugen."
   HitWithScrewDriver = false ;
   clearAction ;
  } else {
   "Das kann und will ich nicht aufschrauben."
   clearAction ;
  } 
}
 
event petrolcan -> Fackel {
 Ego:
  WalkToStdEventObject(Fackel) ;
  
  if (!PetrolCan.GetField(0)) {
   suspend ;
   EgoStartUse ;
   "Ich habe die alte Fackel mit dem restlichen Benzin aus dem Kanister getr#nkt."
   if (triedtoignite) "Vielleicht schaffe ich es nun sie zu entz]nden."
   PetrolCan.SetField(0,true) ;
   EgoStopUse ;
   clearAction ;
  } else {
   "Ich habe die Fackel bereits mit Benzin getr#nkt."
  } 
}

event Rope -> Fackel {
 Ego:
  WalkToStdEventObject(Fackel) ;
  
  if (Fackelbild.enabled) {
   "Das Seil ist zwar aus Hanf gekn]pft..."
   "...allerdings gibt es im Moment wichtigere Dinge..."
   "...um die ich mich k]mmern sollte..."
   "...zum Beispiel meine Flucht aus diesem Grab."
   "Vielleicht sp]ter."
  } else {
   "Es macht keinen Sinn das Seil an die Fackel zu knoten."
  } 
 clearAction ;	
}

event Matches -> Fackel {
 Ego:
  walkToStdEventObject(Fackel) ;
  "Sie sind alle."
}

/* ************************************************************* */

object TorchLightEffect {
 class = NonInteractiveClass ;
 enabled = torchLight ;
 visible = true ;
 clickable = false ;
 Priority = 210 ;
 PositionX = 290 ;
 PositionY = 115 ;
 MarkResource(Graphics::TorchFrame_image) ;
} 

event paint TorchLightEffect {
 var dx = abs(PositionX - Ego.PositionX) ;
 var dy = PositionY - Ego.PositionY ;
 var w = FloatDiv(inttofloat(dx),inttofloat(dy)) ;
 if (PositionX < Ego.PositionX) w = floatmul(inttofloat(-1),w) ;
  
 Ego.ReflectionAngle = FloatSub(FloatArcTangent(w),0.1) ;
 Ego.ReflectionStretch = FloatDiv( FloatMul( FloatSub(2.0,StretchX),dist(positionx,positiony+100,Ego.positionx,Ego.positiony)) ,200.0) ;
 
 PaintLight(PositionX,PositionY,350) ;
}

script TorchEffectOn { 
 DarknessEffect.enabled = false ;
 FlashLightEffect.enabled = false ;
 TorchLightEffect.enabled = true ;
 TorchLight = true ;
 Fackelbild.enabled = true ;  
 Ego.Reflection = true ; 
 Ego.reflectionOffsetY = 185 ; 
 Ego.reflectionTopColor = RGBA(0,0,0,120) ; 
 Ego.reflectionBottomColor = RGBA(0,0,0,10) ; 
 start TorchSound ;
}

/* ************************************************************* */

object Saeule {
 setupAsStdEventObject(Saeule,LookAt,508,348,DIR_EAST) ;
 setClickArea(535,0,640,360);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "S#ule" ;
}

event LookAt -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  "Eine gro}e S#ule die ]ber und ]ber mit #gyptischen Symbolen verziert ist."
  "Leider wei} ich nicht was sie bedeuten."
} 

event LookAt -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  "Eine gro}e S#ule die ]ber und ]ber mit #gyptischen Symbolen verziert ist."
  "Leider wei} ich nicht was sie bedeuten."
} 

event Take -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  "Sie ist viel zu gro} und schwer."
  "Au}erdem, was will ich mit einer S#ule."
}

event Push -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  EgoUse ;
  "Die S#ule bewegt sich um keinen Millimeter."
  "Auch die Symbole lassen sich weder ziehen noch dr]cken."
}

event Pull -> Saeule { TriggerObjectOnObjectEvent(Push,Saeule); }

event Use -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  "Ich habe im Moment nicht das Bed]rfnis mich gegen die S#ule zu lehnen..."
  "...noch mich hinter ihr zu erleichtern." 
}

event Open -> Saeule {
 Ego:
  WalkToStdEventObject(Saeule) ;
  EgoUse ;
  "An der S#ule gibt es nichts, das sich [ffnen lie}e."
}

/* ************************************************************* */

object Ausgang {
 setupAsStdEventObject(Ausgang,LookAt,437,281,DIR_EAST) ;
 setClickArea(445,107,519,238);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Ausgang" ;
}

event WalkTo -> Ausgang {
 clearAction ;
 Ego:
  walk(437,281) ; 
 suspend ;
  walk(550,218) ;
 delay 10 ;
 doEnter(Ausgrabungsstelle) ;
}

event LookAt -> Ausgang {
 Ego:
  WalkToStdEventObject(Ausgang) ;
  "W]re er an der Oberfl#che nicht mit Brettern zugenagelt, w]rde dieser Durchgang aus dem Grab heraus f]hren."
} 

event Open -> Ausgang {
 Ego:
  WalkToStdEventObject(Ausgang) ;
  "Es gibt keine T]r, die ich [ffnen oder schlie}en k[nnte."
} 

event Close -> Ausgang { TriggerObjectOnObjectEvent(open,Ausgang); }

/* ************************************************************* */

object Durchgang {
 setupAsStdEventObject(Durchgang,LookAt,130,260,DIR_WEST) ;
 setClickArea(95,163,153,249);
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
  walk(130,260) ;
 suspend ;
  walk(80,215) ;
  pathAutoScale = false ;
  lightmap = 0 ;  
  Reflection = false ;
 doEnter(Grabsonnenraum) ;
}

event LookAt -> Durchgang {
 Ego:
  WalkToStdEventObject(LookAt) ;
  "Dieser Durchgang f]hrt tiefer ins Grab hinein."
  "Er scheint mit Gewalt durch die Wand gebrochen worden zu sein."
} 

event Open -> Durchgang {
 Ego:
  WalkToStdEventObject(LookAt) ;
  "Es gibt keine T]r, die ich [ffnen oder schlie}en k[nnte."
} 
event Close -> Ausgang { TriggerObjectOnObjectEvent(open,Ausgang); }

/* ************************************************************* */

object Statue {
 setupAsStdEventObject(Statue,LookAt,93,325,DIR_SOUTH) ;
 enabled = true ;
 visible = false ;
 absolute = false ;
 setClickArea(0,140,90,360) ;
 clickable = true ;
 name = "Statue" ;
}

event LookAt -> Statue {
 Ego:
  WalkToStdEventObject(Statue) ;
  "Eine alte #gyptische Statue aus Stein."
  "Sie stellt eine Art Wildkatze mit spitzer Schnauze und langen schmalen Ohren dar."
  static int first = true ;
  if first { turn(DIR_EAST); say("Diese verdammte Statue hat mich vorhin fast zu Tode erschreckt."); first = false ; }
} 

event Take -> Statue {
 Ego:
  WalkToStdEventObject(Statue) ;
  "Die Statue ist viel zu schwer um sie mitzunehmen."
} 

event Push -> Statue {
 Ego:
  WalkToStdEventObject(Statue) ;
  "Die Statue bewegt sich keinen Millimeter."
} 

event Pull -> Statue { TriggerObjectOnObjectEvent(Push,Statue); }

event Use -> Statue {
 Ego:
  WalkToStdEventObject(Statue) ;
  "Ich w]sste nicht was ich mit der Statue anstellen sollte."
} 

event TalkTo -> Statue {
 Ego:
  WalkToStdEventObject(Statue) ;
  switch upcounter(6) {
   case 0: "Braves K#tzchen."
   case 1: "Sitz!"
   case 2: "Mach M#nnchen!"
   case 3: "Gib Pfote!"
   case 4: "Was kannst du ]berhaupt?"
   default: "Ich verschwende meine Zeit nicht an hoffnungslose Amateure."
  } 
} 

/* ************************************************************* */

object Ranke {
 setupAsStdEventObject(Ranke,LookAt,168,311,DIR_WEST) ;
 setPosition(102,294);
 absolute = false ;
 clickable = true ;
 enabled = (!GetField(0)) and (!solvedAtonPuzzle) ;
 visible = true ;
 setAnim(Ranke_image) ; 
 setClickArea(0,0,54,25) ;
 name = "rankiges Gew#chs" ;
} 

event Take -> Ranke {
 Ego:
  WalkToStdEventObject(Ranke) ;
  
 suspend ;
  EgoUse ;
  Ranke.enabled = false ;
  Ranke.SetField(0,true) ;
  takeItem(Ego,RankenGewaechs) ;
  "Ich habe die Ranke ausgerissen."
 clearAction ;
} 

event Touch -> Ranke {
 Ego:
  WalkToStdEventObject(Ranke) ;
  "F]hlt sich an wie eine Pflanze."
} 

event Pull -> Ranke { TriggerObjectOnObjectEvent(Take,Ranke); }

event LookAt -> Ranke {
 Ego:
  WalkToStdEventObject(Ranke) ;
  "Ein rankiges Gew#chs das in einer Spalte zwischen den Bodenplatten hervorwuchert."
} 

/* ************************************************************* */

object Steine {
 setupAsStdEventObject(Steine,LookAt,227,279,DIR_WEST) ;
 setClickArea(104,247,214,304);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Steine" ;
}

object Steinboden {
 setupAsStdEventObject(Steinboden,LookAt,227,279,DIR_WEST) ;
 enabled = (!getField(0)) and (!solvedAtonPuzzle) ;
 visible = true ;
 absolute = false ;
 setAnim(Steinboden_image) ;
 setClickArea(0,0,14,12) ; 
 clickable = true ;
 setPosition(165,288) ;
 name = "Steine" ;
}

event WalkTo -> Steinboden { TriggerObjectOnObjectEvent(WalkTo,Steine); }
event LookAt -> Steinboden { TriggerObjectOnObjectEvent(LookAt,Steine); }
event Take -> Steinboden { TriggerObjectOnObjectEvent(Take,Steine); }
event Push -> Steinboden { TriggerObjectOnObjectEvent(Push,Steine); }
event Pull -> Steinboden { TriggerObjectOnObjectEvent(Pull,Steine); }
event TalkTo -> Steinboden { TriggerObjectOnObjectEvent(TalkTo,Steine); }

event LookAt -> Steine {
 Ego:
  WalkToStdEventObject(Steine) ;
  "Ein Haufen Steine."
  "Gro}e und Kleine."
  "Vermutlich stammen sie von dem Mauerdurchbruch."
 clearAction ;
} 

event Take -> Steine { 
 Ego:
  WalkToStdEventObject(Steine) ;
  if (Steinboden.getField(0)) {
   "Ich brauche keinen Stein mehr."
   return ;
  } 
 
  suspend ;	
  "Ich nehme diesen Kleinen hier."
  EgoStartUse ;
  takeItem(Ego,Stone) ;
  Steinboden.setField(0,true) ;
  Steinboden.enabled = false ;
  EgoStopUse ;
 clearAction ;
}

event TalkTo -> Steine {
 Ego:
  Ego:
  WalkToStdEventObject(Steine) ;
  "Ich spreche nicht mit Steinen."
} 

event Push -> Steine {
 Ego:
  WalkToStdEventObject(Steine) ;
  EgoUse ;
  "Die Steine sind schwer und globig."
  "Ich lasse sie am besten wo sie sind."
} 

event Pull -> Steine { TriggerObjectOnObjectEvent(Push,Steine); }

/* ************************************************************* */

object AbsperrImage {
 enabled = false ;
 visible = true ;
 absolute = false ;
 setAnim(Absperr_sprite) ; 
 clickable = false ;
 setPosition(335,212) ;	
}

script PlattenKommentar {
 suspend ;
 Ego.Stop ;
 Ego.say("Huch!") ;
 Ego.turn(DIR_SOUTH) ;
 Ego.say("Die Bodenplatte gibt etwas nach wenn ich darauf trete...") ;
 Ego.say("...und ein leises Klickger#usch ert[nt.") ;
 Ego.say("Meine ''Opfergabe'' hat wohl einen weiteren Mechanismus in Gang gesetzt...") ;
 Ego.say("...ich frage mich was es damit auf sich hat.") ;
 clearAction ;
} 

script distanceToPlatte(myX, myY) {return floatToInt(floatSquareRoot(IntToFloat(pot(500-myX,2)+pot(260-myY,2)))) ; }

script plattenSound {
 killOnExit = true ;
 var p1 = false ;
 var p3 = false ;
 var p5 = false ;
 MarkResource(Music::Platte_wav) ;
 MarkResource(Music::Plattehoch_wav) ; 
 
 loop {
  delay while (!PlattenAktiviert) ;
  if (PlatteEins.visible) {
   if (p1==false) {soundBoxStart(Music::Platte_wav) ; p1 = true ; } 
  } else if (p1)  {soundBoxStart(Music::Plattehoch_wav) ; p1 = false ; }
  
  if (PlatteDrei.visible) {
   if (p3==false) {soundBoxStart(Music::Platte_wav) ; p3 = true ; } 
  } else if (p3)  {soundBoxStart(Music::Plattehoch_wav) ; p3 = false ; }
  
  if (PlatteFuenf.visible) {
   if (p5==false) {soundBoxStart(Music::Platte_wav) ; p5 = true ; } 
  } else if (p5)  {soundBoxStart(Music::Plattehoch_wav) ; p5 = false ; }
  
  if ( ((p1) or (p3) or (p5)) and (!KenntPlatten)) { KenntPlatten = true ; start PlattenKommentar ; }
  delay ;
 }
}

script throwStone {
 Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
 EgoStartUse ;
 dropItem(Ego, Stone) ;
 SteinAni:
  enabled = true ;
  SetField(0,true) ;
  setPosition(338,202) ;
  walk(413,161) ;
  walk(462,270) ;
  PlatteDrei.SetField(0,true) ;
  PlatteGedrueckt = true ; 
 EgoStopUse ;	
}

script throwShoe {
 Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
 EgoStartUse ;
 dropItem(Ego, Shoe) ;
 ShoeAni:
  enabled = true ;
  SetField(0,true) ;
  setPosition(338,202) ;
  walk(416,161) ;
  walk(470,260) ;
 SchuhGeworfen = true ;
 EgoStopUse ;	
}

script throwShoeStone {
 Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
 EgoStartUse ;
 dropItem(Ego, ShoeStone) ;
 ShoeStoneAni:
  enabled = true ;
  SetField(0,true) ;
  setPosition(338,202) ;
  walk(416,161) ;
  walk(470,260) ;
  PlatteDrei.SetField(0,true) ;
 PlatteGedrueckt = true ; 
 SchuhGeworfen = true ;
 EgoStopUse ;	  
}

/* ************************************************************* */

object ShoeStoneAni {
 setupAsStdEventObject(ShoeStoneAni,LookAt,456,269,DIR_EAST) ;
 setPosition(470,260) ;
 setAnim(Shoe_image) ;
 enabled = GetField(0) ;
 visible = true ;
 absolute = false ; 
 setClickArea(0,0,24,21) ;
 TurnAnimDelay = 0 ;
 StopAnimDelay = 0 ;
 clickable = true ;
 name = "beschwerter Schuh" ;
}

event Rope -> ShoeStoneAni {
Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
  
  suspend ;
  "Mit dem Seil mach das keinen Sinn..."
  "...ich m]sste den Schuh mit einer Schlaufe fangen..."
  "...und ich bin viel zu ungeschickt daf]r."
  "Es muss einen einfacheren Weg geben."
 clearAction ;	
} 

event Rope -> ShoeStoneAni {
Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
  
  suspend ;
  "Mit dem Seil mach das keinen Sinn..."
  "...ich m]sste den Stein mit einer Schlaufe fangen..."
  "...und ich bin viel zu ungeschickt daf]r."
  "Es muss einen einfacheren Weg geben."
 clearAction ;	
} 

event AbsperrStange -> ShoeStoneAni {
 Ego:
  //walk(300,267) ;
  walk(313,278) ;
  face(DIR_EAST) ;
  
  suspend ;
  "Gute Idee."
  "Ich versuche mir den Schuh mit der Stange zu angeln."
  "Auf diese Art vermeide ich nochmal die vorige Platte betreten zu m]ssen."

  EgoStartUse ;
  Absperrimage.enabled = true ;
  PlatteDrei.setField(0, false) ;
  ShoeStoneAni.enabled = false ;
  ShoeStoneAni.SetField(0,false) ;
  delay 4 ;  
  takeItem(Ego, ShoeStone) ;
  Absperrimage.enabled = false ;
  EgoStopUse ;
  PlatteGedrueckt = false ;
  "Geschafft!"
 clearAction ;
} 

event Take -> ShoeStoneAni {
 Ego:
  WalkToStdEventObject(ShoeStoneAni) ;
  
  suspend ;
  EgoStartUse ;
  PlatteDrei.setField(0, false) ;
  ShoeStoneAni.enabled = false ;
  ShoeStoneAni.SetField(0,false) ;
  takeItem(Ego, ShoeStone) ;
  EgoStopUse ;
  PlatteGedrueckt = false ; 
 clearAction ;
}

event LookAt -> ShoeStoneAni {
 Ego:
  WalkToStdEventObject(ShoeStoneAni) ;
  "Ich habe den beschwerten Schuh auf die Bodenplatte geworfen und sie somit gedr]ckt."
} 


/* ************************************************************* */

object ShoeAni {
 setupAsStdEventObject(ShoeAni,LookAt,456,269,DIR_EAST) ;
 setPosition(470,260) ;
 setAnim(Shoe_image) ;
 enabled = GetField(0) ;
 visible = true ;
 absolute = false ;
 setClickArea(0,0,24,21) ;
 TurnAnimDelay = 0 ;
 StopAnimDelay = 0 ;
 clickable = true ;
 name = "Schuh" ;
}

event Rope -> ShoeAni {
Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
  
  suspend ;
  "Mit dem Seil mach das wenig Sinn..."
  "...ich m]sste den Schuh mit einer Schlaufe fangen..."
  "...und ich bin viel zu ungeschickt daf]r."
  "Es muss einen einfacheren Weg geben."
 clearAction ;	
} 

event Rope -> SteinAni {
Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
  
  suspend ;
  "Mit dem Seil mach das wenig Sinn..."
  "...ich m]sste den Stein mit einer Schlaufe fangen..."
  "...und ich bin viel zu ungeschickt daf]r."
  "Es muss einen einfacheren Weg geben."
 clearAction ;	
} 

event AbsperrStange -> ShoeAni {
 Ego:
  //walk(300,267) ;
  walk(313,278) ;
  face(DIR_EAST) ;
  
  suspend ;
  "Gute Idee."
  "Ich versuche mir den Schuh mit der Stange zu angeln."
  "Auf diese Art vermeide ich nochmal die vorige Platte betreten zu m]ssen."

  EgoStartUse ;
  Absperrimage.enabled = true ;
  ShoeAni.enabled = false ;
  ShoeAni.SetField(0,false) ;
  delay 4 ;
  takeItem(Ego, Shoe) ;
  Absperrimage.enabled = false ;
  EgoStopUse ;
  //PlatteGedrueckt = false ;
  "Geschafft!"
 clearAction ;
} 

event Take -> ShoeAni {
 Ego:
  WalkToStdEventObject(ShoeAni) ;
  
  suspend ;
  EgoStartUse ;
  PlatteDrei.setField(0, false) ;
  ShoeAni.enabled = false ;
  ShoeAni.SetField(0,false) ;
  takeItem(Ego, Shoe) ;
  EgoStopUse ;
  PlatteGedrueckt = false ;
 clearAction ;
}

event LookAt -> ShoeAni {
 Ego:
  WalkToStdEventObject(ShoeAni) ;
  "Ich habe den Schuh auf die Bodenplatte geworfen."
} 

/* ************************************************************* */

object SteinAni {
 setupAsStdEventObject(SteinAni,LookAt,456,269,DIR_EAST) ;
 setPosition(467,270) ;
 setAnim(Stein_image) ;
 enabled = GetField(0) ;
 visible = true ;
 absolute = false ;
 setClickArea(-5,-5,5,5) ;
 TurnAnimDelay = 0 ;
 StopAnimDelay = 0 ;
 clickable = true ;
 name = "Stein" ;
}

event Take -> SteinAni {
 Ego:
  WalkToStdEventObject(SteinAni) ;
  
  suspend ;
  EgoStartUse ;
  PlatteDrei.setField(0, false) ;
  SteinAni.enabled = false ;
  SteinAni.SetField(0,false) ;
  takeItem(Ego, Stone) ;
  EgoStopUse ;
  PlatteGedrueckt = false ; 
 clearAction ;
}

event AbsperrStange -> SteinAni {
 Ego:
  walk(313,278) ;
  face(DIR_EAST) ;
  
  suspend ;
  "Ich versuche mir den Stein mit der Stange herzuziehen,..."
  "...ohne dabei die vorige Platte herunterzudr]cken."
  delay(10) ;
  
  EgoStartUse ;
  Absperrimage.enabled = true ;
  PlatteDrei.visible = false ;
  PlatteDrei.setField(0, false) ;
  PlatteEins.visible = true ;
  SteinAni.setPosition(368,271) ;
  delay(5) ;
  Absperrimage.enabled = false ;
  EgoStopUse ;
  Ego.say("Verdammt!") ;
    
  EgoUse;
  PlatteEins.visible = false ;
  lastPlatte = 1 ;
  
  SteinAni.enabled = false ;
  SteinAni.SetField(0,false) ;
  SteinAni.setPosition(467,270) ;
  takeItem(Ego, Stone) ;
  PlatteGedrueckt = false ;
  "Vielleicht sollte ich es mit einem Gegenstand versuchen..."
  "...der sich leichter wieder angeln l#sst."
  "Der Stein ist daf]r einfach zu klein."  
  "Oder ich bin einfach zu ungeschickt."
 clearAction ;
} 

event LookAt -> SteinAni {
 Ego:
  WalkToStdEventObject(SteinAni) ; 
  "Ich habe den Stein auf die Bodenplatte geworfen und sie somit gedr]ckt."
} 

/* ************************************************************* */

object PlatteDrei { 
 setupAsStdEventObject(PlatteDrei,LookAt,462,272,DIR_EAST) ;
 setPosition(429,229) ;
 setAnim(graphics::Platte3_image) ;
 name = "Bodenplatte" ;
 priority = 5 ;
 visible = PlattenAktiviert ;
 enabled = true ; 
 //setClickPath(Platte3_path) ;
 setClickArea(26,11,100,60) ;
 clickable = true ;
 path = Platte3_path ;
}

event animate PlatteDrei {
 if (!PlattenAktiviert) return ;
 PlatteDrei:
  visible = ((insidePath(Ego.positionX, Ego.positionY)) or (getField(0))) ;
  if (visible) 
   if ((lastPlatte == 2) or (lastPlatte == 3)) { 
    lastPlatte = 3 ;
   } 
} 

event LookAt -> PlatteDrei {
 Ego:
  WalkToStdEventObject(PlatteDrei) ;
  "Auf der Bodenplatte befindet sich das Symbol eines Kreises mit mehreren Wellenlinien darin."
  "Das kommt mir irgendwie bekannt vor."
  "Ich glaube, ich habe dieses Symbol schon mal im Tagebuch des Professors gesehen."
  if (PlattenAktiviert) ClickHint ;
} 

event Push -> PlatteDrei {
 Ego:
  WalkToStdEventObject(PlatteDrei) ;
  if (PlattenAktiviert) {
   "Ich muss die Platte nur betreten und sie wird heruntergedr]ckt."
  } else {
   EgoUse ;
   "Solider Steinboden."
  } 
} 
event Use -> PlatteDrei { TriggerObjectOnObjectEvent(Push,PlatteDrei) ; }

event Pull -> PlatteDrei {
 Ego:
  WalkToStdEventObject(PlatteDrei) ;
  "Es macht keinen Sinn an der Platte zu ziehen..."
  "...vorallem nicht solange ich daraufstehe."
}

event invobj -> PlatteDrei {
 Ego:
  if (PlattenAktiviert) {
   walk(300,267) ;
   face(DIR_EAST) ;
   static int first = true ;
   if (first) {
    "Wenn es mir gelingt etwas aus der Ferne auf die Platte zu werfen..."
    "...kann ich vielleicht vermeiden die Platte davor betreten zu m]ssen."
    "Das m[chte ich allerdings nicht auf den Steinboden werfen."
    first = false ;
   } else {
    "Das m[chte ich nicht auf den Steinboden werfen."
   }
   clearAction ;
  } else {
   WalkToStdEventObject(PlatteDrei) ;
   "Ich m[chte meine Besitzt]mer nicht auf dem Boden verstreuen."
  } 
}

event AbsperrStange -> PlatteDrei {
 Ego:
  if (!PlattenAktiviert) {
   WalkToStdEventObject(PlatteDrei) ;
   "Ich m[chte meine Besitzt]mer nicht auf dem Boden verstreuen."
   return ;
  } 

  static int first = true ;
  
  walk(313,278) ;
  face(DIR_EAST) ;
	  
  suspend ;
  if (first) {
   "Vielleicht kann ich mit der Stange aus der Ferne auf die Platte dr]cken..."
   "...und so vermeiden die Platte davor betreten zu m]ssen."
   first = false ;
   delay(5) ;
    
   "Los gehts."
   EgoStartUse ;
   Absperrimage.enabled = true ;
   delay(5) ;
   Absperrimage.enabled = false ;
   EgoStopUse ;
   delay(5) ;
   EgoStartUse ;
   Absperrimage.enabled = true ;
   "Verdammt!"
   Absperrimage.enabled = false ;
   EgoStopUse ;
    
   "Die Platte bewegt sich nicht..."
   "Wahrscheinlich kann ich von der Seite und ]ber diese Entfernung..."
   "...nicht genug Druck auf die Platte aufbringen."
   "Es muss noch eine andere M[glichkeit geben."
  } else {
   "Das habe ich bereits versucht..."
   "...der Druck reicht nicht aus um die Platte herunterzudr]cken."   
  } 
 clearAction ;   
}

event Stone -> PlatteDrei {
 if (!PlattenAktiviert) { 
  Ego.WalkToStdEventObject(PlatteDrei) ;
  Ego.say("Ich m[chte meine Besitzt]mer nicht auf dem Boden verstreuen."); 
  return ; 
 }
 
 if (did(Give)) { Ego.say("Das macht keinen Sinn.") ; clearAction ; return ; }
 //if (ShoeAni.enabled) { Ego.say("Ich habe bereits den Schuh auf die Platte geworfen.") ; clearAction ; return ; }
 
 switch upcounter(2) {
  case 0:  Ego.say("Wenn es mir gelingt den Stein auf die Platte zu werfen...") ;
	   Ego.say("...muss ich nicht zwangsl#ufig die vorige Platte betreten.") ;
	   Ego.say("Hoffentlich treffe ich.") ;
           throwStone ;
           Ego:
            "Volltreffer!"
            "Ich sollte damit im Zirkus auftreten."
            "Und da w#re dann dieser kleine Affe..."  
            "Lassen wir das."
  case 1:  Ego.say("Und nochmal...") ;
           throwStone ;
  default: throwStone ;
 }
 clearAction ;
}

event Shoe -> PlatteDrei {
 if (!PlattenAktiviert) { 
  Ego.WalkToStdEventObject(PlatteDrei) ;
  Ego.say("Ich m[chte meine Besitzt]mer nicht auf dem Boden verstreuen."); 
  return ; 
 }
 
 if (did(Give)) { Ego.say("Das macht keinen Sinn.") ; clearAction ; return ; }
 if (SteinAni.enabled) { 
  Ego.say("Ich habe bereits den Stein auf die Platte geworfen...") ;
  Ego.say("...und sie damit heruntergedr]ckt.") ;
  Ego.say("Warum sollte ich den Schuh also auch noch werfen?") ;  
  clearAction ; 
  return ; 
 } 

 switch upcounter(2) {
   case 0:  Ego.say("Wenn es mir gelingt den Schuh auf die Platte zu werfen...") ;
	    Ego.say("...muss ich nicht zwangsl#ufig die vorige Platte betreten.") ;
	    Ego.say("Mal sehen ob ich treffe.") ;
	    throwShoe ;
            Ego:
             "Volltreffer!"
	     "Aber die Platte ist nicht heruntergedr]ckt..."
	     "...der Schuh allein scheint nicht schwer genug zu sein."  
   case 1:  Ego.say("Und noch ein Versuch...") ;
	    throwShoe ;
	    Ego.say("Wieder kein Erfolg...") ;
	    Ego.say("...vielleicht sollte ich den Schuh irgendwie beschweren.") ;
   default: throwShoe ;
  }
 clearAction ;
}


event ShoeStone -> PlatteDrei {
 if (!PlattenAktiviert) { 
  Ego.WalkToStdEventObject(PlatteDrei) ;
  Ego.say("Ich m[chte meine Besitzt]mer nicht auf dem Boden verstreuen."); 
  return ; 
 }
 
 if (did(Give)) { Ego.say("Das macht keinen Sinn.") ; clearAction ; return ; }

 switch upcounter(2) {
   case 0:  Ego.say("Nun wo der Stein beschwert ist, k[nnte es klappen.") ;
	    Ego.say("Nimm dies Isaac Newton!") ;
	    throwShoeStone ;
            Ego:
             "Es hat funktioniert!"
             "Die Platte ist durch den beschwerten Schuh heruntergedr]ckt worden."	     
   case 1:  Ego.say("Und noch einmal...") ;
	    throwShoeStone ;
   default: throwShoeStone ;
  }
 clearAction ;
}

/* ************************************************************* */

object PlatteEins { 
 setupAsStdEventObject(PlatteEins,LookAt,353,293,DIR_EAST) ;
 setPosition(293,258) ;
 setAnim(Platte1_image) ;
 name = "Bodenplatte" ;
 priority = 5 ;
 visible = PlattenAktiviert and (!PlatteGedrueckt)  ;
 enabled = true ;
 //setClickPath(Platte1_path) ; 
 setClickArea(19,16,218,62) ;
 clickable = true ;
 path = Platte1_path ;
}

event animate PlatteEins {
 if ((!PlattenAktiviert) or PlatteGedrueckt) return ;	
 PlatteEins:
  visible = insidePath(Ego.positionX, Ego.positionY) ;
  if (visible) lastPlatte = 1 ;
}

event LookAt -> PlatteEins {
 Ego:
  WalkToStdEventObject(PlatteEins) ;
  "Auf der Bodenplatte befindet sich das Symbol einer Feder oder eines Schilfblatts."
  "Das kommt mir irgendwie bekannt vor."
  "Ich glaube, ich habe dieses Symbol schon mal im Tagebuch des Professors gesehen."
  if (PlattenAktiviert) ClickHint ;
} 


event Push -> PlatteEins {
 Ego:
  WalkToStdEventObject(PlatteEins) ;
  if (PlattenAktiviert) {
   "Ich muss die Platte nur betreten und sie wird heruntergedr]ckt."
  } else {
   EgoUse ;
   "Solider Steinboden."
  } 
} 

event Use -> PlatteEins { TriggerObjectOnObjectEvent(Push,PlatteEins) ; }

event Pull -> PlatteEins {
 Ego:
  WalkToStdEventObject(PlatteEins) ;
  "Es macht keinen Sinn an der Platte zu ziehen..."
  "...vorallem nicht solange ich daraufstehe."
}

event invobj -> PlatteEins {
 Ego:
  WalkToStdEventObject(PlatteEins) ;
  "Ich m[chte meine Besitzt]mer nicht sinnlos auf dem Boden verstreuen."
} 

/* ************************************************************* */

object PlatteFuenf { 
 setupAsStdEventObject(PlatteFuenf,LookAt,230,310,DIR_EAST) ;
 setPosition(181,279) ;
 setAnim(Platte5_image) ;
 name = "Bodenplatte" ;
 priority = 5 ;
 visible = PlattenAktiviert and (!PlatteGedrueckt) ;
 enabled = true ;
 //setClickPath(Platte5_path) ;
 setClickArea(17,25,184,48) ;
 clickable = true ;
 path = Platte5_path ;
}

event animate PlatteFuenf {
 if ((!PlattenAktiviert) or PlatteGedrueckt) return ;
 PlatteFuenf:
  visible = insidePath(Ego.positionX, Ego.positionY) ;
  if (visible) 
   if (lastPlatte == 4) { if (!Geheim.enabled) { Geheim.enabled = true ; start openGeheim ; } }
    else lastPlatte = 0 ;
} 

event LookAt -> PlatteFuenf {
 Ego:
  WalkToStdEventObject(PlatteFuenf) ;
  "Auf der Bodenplatte befindet sich das Symbol einer Wellenlinie."
  "Das kommt mir irgendwie bekannt vor."
  "Ich glaube, ich habe dieses Symbol schon mal im Tagebuch des Professors gesehen."
  if (PlattenAktiviert) ClickHint ;
} 


event Push -> PlatteFuenf {
 Ego:
  WalkToStdEventObject(PlatteFuenf) ;
  if (PlattenAktiviert) {
   "Ich muss die Platte nur betreten und sie wird heruntergedr]ckt."
  } else {
   EgoUse ;
   "Solider Steinboden."
  } 
} 
event Use -> PlatteFuenf { TriggerObjectOnObjectEvent(Push,PlatteFuenf) ; }

event Pull -> PlatteFuenf {
 Ego:
  WalkToStdEventObject(PlatteFuenf) ;
  "Es macht keinen Sinn an der Platte zu ziehen..."
  "...vorallem nicht solange ich daraufstehe."
}

event invobj -> PlatteFuenf {
 Ego:
  WalkToStdEventObject(PlatteFuenf) ;
  "Ich m[chte meine Besitzt]mer nicht sinnlos auf dem Boden verstreuen."
} 

/* ************************************************************* */

script openGeheim {
 Geheim.enabled = true ;
 Geheim.setField(0,1) ;
 Geheim.name = "Objekt" ;
 Geheim.clickable = true ;
 Ego.Stop ;
 suspend ;
 soundBoxStart(Music::SecretMirror_wav) ;
 start { Geheim: sayslow("* klick *",5) ; }
 
 
 Ego.turn(DIR_WEST) ;
 Ego.say("Raffiniert!") ;
 Ego.say("Eine der Kacheln an der Wand hat sich ge[ffnet...");
 Ego.say("...und einen dahinter verborgenen Hohlraum freigelegt.");
 Ego.turn(DIR_SOUTH) ;
 Ego.say("Offenbar habe ich die Bodenplatten in der korrekten Reihenfolge gedr]ckt.");
 clearAction ;  
}

object Geheim { 
 setupAsStdEventObject(Geheim,LookAt,93,292,DIR_NORTH) ;	
 setAnim(Geheim_sprite) ;
 setPosition(85,234) ;
 enabled = (getField(0) > 0) and (!solvedAtonPuzzle) ;
 setClickArea(0,0,24,27) ;
 visible = true ;
 autoAnimate = false ;
 frame = getField(0)-1 ; ;
 priority = 34 ;
 clickable = (getField(0) == 1) ;
 absolute = false ;
 if (getField(0) == 1) name = "Objekt" ;
  else name = "Hohlraum" ;
 captionwidth = 100 ;
 captionX = 15 ;
 captionY = -10 ;
 captionColor = COLOR_WHITE ;
 captionBase = BASE_ABOVE ;
}

event LookAt -> Geheim {
 Ego:
  WalkToStdEventObject(Geheim) ;
  "Dieser Hohlraum hat sich ge[ffnet, als ich auf die f]nfte Bodenplatte trat."
  "Darin befindet sich ein kleiner Steinquader und ein Objekt, das wie ein Schl]ssel aussieht!"
}

event Take -> Geheim {
 Ego:
  WalkToStdEventObject(Geheim) ;
  
 suspend ;
  EgoStartUse ;
  "In dem Hohlraum befindet sich ein kleiner Steinquader..."
  "... mit einem Halbkreis darauf..."
  "...und ein unf[rmiger alter Schl]ssel..."
  "...ich frage mich was er wohl [ffnet."
  Geheim.clickable = false ;
  Geheim.Frame++ ;
  Geheim.setField(0,2) ; 
  Geheim.name = "Hohlraum" ;
  takeItem(Ego, ScheibeBrotlaib) ;
  takeItem(Ego, EchKeyDirty) ;
  EgoStopUse ;
 clearAction ;
}


