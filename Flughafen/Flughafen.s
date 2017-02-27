// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

const MECHANIKER_GROUP = 23235 ;
var CoinSpotted = false ;
var TookCoin = false ;
var TalkedToGuy = false ;
var KnowBulb = 0 ;
var KnowFake = false ;
var TookBulb = false ;
var Saidname = false ;
var GaveHint = false ;
var saidhint = false ;
var WantMember = false ;
var PlayerhasOscarNeedsPhotos = false ;
var alreadyAsked2 = false ;

event enter {	
  EnableEgoTalk ;   
  takeItem(Ego,Wallet) ;  
  takeItem(Ego,Envelope) ;
  takeItem(Ego,Letter) ;  
  forceShowInventory ; 	
	
  if (JumpToIntro == 2) {
   John:
    caption = null ;
    visible = false ;
    enabled = false ;
   Jack:
    caption = null ;
    visible = false ;
    enabled = false ;
   Ego:
    caption = null ;
  }

  InstallSystemInputHandler(&SystemInput_Handler) ;
	
  forceShowInventory ;
  backgroundImage = Flughafen_image ;
  backgroundZBuffer = Flughafen_zbuffer ;
  path = Flughafen_path ;
  
  InstallScreenPostdrawingHandler(&FlughafenPostdraw) ;  

  Ego:
   PositionX = 120 ;
   PositionY = 270 ;
   visible = true ;
   setPosition(30,244);
   walk(100,253);  

  clearAction ;   
  
  start AnimatePersonal ;
  start AnimateZuechter ;
  start AnimateChef ;   
  start AnimateMechaniker ;
}

/* ************************************************************* */

script FlughafenPostdraw {  
  static int status ;
  if (Mechaniker.animMode == ANIM_TALK and LightOff == 0 and random(23) == 5) or (LightOff == 0 and(status > 0 and status <= 3)) {
    if (! status) status = 1 ;
    if (drawingColor != COLOR_WHITE) drawingColor = COLOR_WHITE ;
    drawSprite(329-ScrollX,32,Lichtaus_sprite,0) ;
    drawSprite(531-ScrollX,40,Lichtaus_sprite,1) ;	  
    drawSprite(796-ScrollX,28,Lichtaus_sprite,2) ;
    var al = 69 ;
    if (status == 1) drawGradientRectangle(0,0,640,360,RGBA(0,0,0,al/2),RGBA(0,0,0,al/2)) ;    
    if (status == 2) drawGradientRectangle(0,0,640,360,RGBA(0,0,0,al),RGBA(0,0,0,al)) ;
    if (status == 3) drawGradientRectangle(0,0,640,360,RGBA(0,0,0,al/2),RGBA(0,0,0,al/2)) ;
    if (status == 3) status = false ;
     else status++ ;
  }	

 if (LightOff == 0) return ;
  drawingPriority = 250 ;
  drawGradientRectangle(0,0,640,360,RGBA(0,0,0,255),RGBA(0,0,0,250)) ;
  drawingPriority = 256 ; 
  drawingScale = 1000 ;
  drawingColor = RGBA(255,255,255,255) ;
  drawSprite(472-ScrollX,124,Personalauge_sprite,0) ;
  drawImage(99-scrollX,153, LampeDunkel_image) ;
  drawSprite(868-ScrollX,135,Zuechterauge_sprite,0) ;  
  drawSprite(269-scrollX,188,Chefauge_sprite,0) ;    
  var myY = Ego.positionY - floatMul(floatDiv(Ego.GetPathScale(Ego.PositionX, Ego.PositionY),1000), GetSpriteFrameHeight(Graphics::JulBlackDn_sprite,0)) + GetSpriteFrameHeight(Graphics::JulBlackDn_sprite,0) ;
  var myX = Ego.positionX - floatMul(floatDiv(Ego.GetPathScale(Ego.PositionX, Ego.PositionY),1000), GetSpriteFrameWidth(Graphics::JulBlackDn_sprite,0)) + GetSpriteFrameWidth(Graphics::JulBlackDn_sprite,0) ;	  
  switch (Ego.Direction) {
    case 10,9,8 : drawScaledSprite(myX-ScrollX,myY,Graphics::JulBlackLt_sprite,0,Ego.GetPathScale(Ego.PositionX, Ego.PositionY)) ;	    
    case 2,3,4 : drawScaledSprite(myX-ScrollX,myY,Graphics::JulBlackRt_sprite,0,Ego.GetPathScale(Ego.PositionX, Ego.PositionY)) ;	    
    default : drawScaledSprite(myX-ScrollX,myY,Graphics::JulBlackDn_sprite,0,Ego.GetPathScale(Ego.PositionX, Ego.PositionY)) ;
   }
  
}

script TooDark {
 var ao = activeObject ;
 if (LightOff != 0) {
   Ego:
    "Es ist zu dunkel." 
   clearAction ;
   activeObject = ao ;
   return true ;
 }
 activeObject = ao ;
 return false ;
}

/* ************************************************************* */

event paint PassbildGross { 
 drawingPriority = 255 ;
 drawingColor = COLOR_WHITE ;
 drawImage(0,0,PassbildGross.getAnim(ANIM_STOP,0)) ;
}

object PassbildGross {
 absolute = false ;
 setPosition(0,0) ;
 clickable = false ;
 setAnim(null) ;
 enabled = false ;
 visible = true ; 
 priority = 1 ; 
}

/* ************************************************************* */

object Oscar { 
 setupAsStdEventObject(Oscar,Take,572,288,DIR_NORTH) ;							
 clickable = true ;
 visible = true ;
 enabled = true ;
 absolute = false ;
 setPosition(551,176) ;
 setAnim(oscar_image) ;
 setClickArea(0,0,37,36) ;
 priority = 200 / 8 ;
 name = "kleiner Kaktus" ;	
}

event WalkTo -> Oscar { 
 Ego:
  walkToStdEventObject(Oscar) ;
}

event Pull -> Oscar {
 triggerObjectOnObjectEvent(Push, Oscar) ;
}

event TalkTo -> Oscar {
 Ego:
  walkToStdEventObject(Oscar) ;
 suspend ;
  say("Hallo, kleiner Kaktus!") ;
 delay 10 ;
  say("Er antwortet nicht.") ;
 clearAction ;
}

event Push -> Oscar {
 Ego:
  walkToStdEventObject(Oscar) ;
  say("Lieber nicht.") ;
  say("Er k[nnte herunterfallen.") ;
}

event LookAt -> Oscar {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Oscar) ;
 suspend ;
  say("Ein kleiner Kaktus steht hier auf dem Schreibtisch.") ;
  say("Er sieht fast wie ein Igel aus.") ;
 clearAction ;
}

event Take -> Oscar {
 Ego:
  walkToStdEventObjectNoResume(Oscar) ;	
 if (LightOff != 0) {
   EgoStartUse ;	 
   Oscar.enabled = false ;   
   takeItem(Ego, Cactus) ;
   EgoStopUse ;
   Ego.say("Hab ihn.") ;   
 } else {
   Ego:
    "Haben Sie was dagegen, wenn ich dieses Gew#chs von Ihrem Arbeitsplatz entferne?"
   Personal:
    "Gew#chs?"
   delay(5) ;
    "Ach, Sie meinen dieses Unkraut hier?"
   delay(10) ;
    "Nein, nehmen Sie ruhig."
   EgoStartUse ;
   Oscar.enabled = false ;   
   takeItem(Ego, Cactus) ;
   EgoStopUse ;
 }
 clearAction ;
}

/* ************************************************************* */

object Guy {
 setupAsStdEventObject(Guy,TalkTo,386,335,DIR_WEST) ;								
 name = "Gesch#ftsmann" ;
 setPosition(255,178) ;
 setClickArea(0,0,80, 175) ; 
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 CaptionY = -30 ;
 CaptionX = GetSpriteFrameWidth(Chef_sprite,0) / 2 ;
 CaptionColor = COLOR_YELLOW ;
 Priority = 200 ; 
 autoAnimate = false ;

 setAnim(Chef_sprite) ;
 animMode = ANIM_STOP ;
}

event LookAt -> guy {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Guy) ; 
  say("Seltsamer Kerl... Er scheint auf etwas zu warten.") ;
}

event TalkTo -> guy { 
 if (TooDark) return ;
 Ego:
  walkToStdEventObjectNoResume(Guy) ;
 if (! TalkedToGuy) {
    "Hallo!"
   Guy:
    "Gut, dass Du da bist!"    
    "Ich habe hier diesen eiligen Job, der muss unbedingt noch heute..."
   Ego:
    "Entschuldigung, aber ich glaube, hier liegt eine Verwechslung vor."
   Guy:
    "Ah, verstehe. Nichts f]r ungut." 
   talkedToGuy = true ;
 } else {
  Ego:
   "Nein, das lasse ich lieber bleiben."
   "Der ist mir nicht ganz geheuer."
 }
 clearAction ;
}

event default -> guy {	
 if Did(Use) or Did(Push) or Did(Pull) or Did(Close) or Did(Open) or Did(Take) or (Did(Give) and SelectedObject == Give) {
   triggerDefaultEvents ;
   return ;
 }
 if (! TalkedToGuy) {
   TriggerObjectOnObjectEvent(TalkTo,Guy) ;
   return ;
 }
 if (TooDark) return ;
 if Did(Give) {
  Ego:
   walkToStdEventObjectNoResume(Guy) ;
  if (sourceObject == Wallet) {
   say("Ganz bestimmt nicht!") ;
   say("Da ist meine Kreditkarte drin.") ;
   clearAction ;
   return ; 
  }
   EgoUse ;
  switch random(4) {
    case 0 : "Nehmen Sie das."
    case 1 : "Hier."
    case 2 : "Das ist f]r Sie." 
    case 3 : "Bittesch[n!"
  }   
  delay(10) ;   
  guy:
  switch upcounter(6) { 
    case 0:  "Was will ich damit?"
	     "K[nntest Du mich bitte in Ruhe arbeiten lassen?"
    case 1:  "Ich will das nicht." 
    case 2:  "Bitte h[r auf, mich zu bel#stigen." 
	     "Ich brauche nichts von dir."
    case 3:  "Ich brauche das nicht."
    case 4:  "Ich brauche das wirklich nicht."	    	    
    case 5:  "Du gehst mir langsam auf die Nerven..."
    default: "Lass mich endlich in Ruhe oder ich rufe den Sicherheitsdienst!"
  }   
  
 } else triggerDefaultEvents ;
 clearAction ;
}

event WalkTo -> guy {
  Ego:
   walkToStdEventObject(Guy) ;
}

script AnimateChef {
 activeObject = Guy;
 killOnExit = true ;
 loop {
  if (LightOff == 0) {
  if animMode == ANIM_STOP {
   if (frame == 2) frame = 0 ;
   if random(15) == 0 {
    frame++ ;
    if frame > 1 { frame = 0 ; }   
   } 
   delay random(10)+5 ;
  } else if (animMode == ANIM_TALK) {
   if (frame == 1) frame = 0 ;
    else if (frame == 0) frame = 2 ;
    else if (frame == 2) frame = 0 ;
   if frame > 2 { frame = 2 ; } 
   delay (random(3))+1 ;
  }
  delay ;
  } else delay ;
 }
}

/* ************************************************************* */

object Werbeschild {
 setupAsStdEventObject(Werbeschild,LookAt,190,260,DIR_WEST) ;									
 setClickArea(0,32,108,77) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Werbung" ;
}

event Push -> Werbeschild {
 triggerObjectOnObjectEvent(Take, Werbeschild) ;
}

event Pull -> Werbeschild {
 triggerObjectOnObjectEvent(Take, Werbeschild) ;
}

event Take -> Werbeschild {
 Ego:
  walkToStdEventObject(Werbeschild) ;
  "Ich komme nicht ran."
}

event LookAt -> Werbeschild {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObjectNoResume(Werbeschild) ;
 "Ein Werbeplakat mit der Aufschrift 'SAMTEC PHARMACEUTICALS'.";
 clearAction ;
}

/* ************************************************************* */

object Muenze {
 setupAsStdEventObject(Muenze,Take,346,224,DIR_NORTH) ;										
 name = "M]nze" ; 
 setClickArea(353,150,357,156) ;
 clickable = true ;
 enabled = false ;
 visible = false ;
 absolute = false ;
}

event Take -> Muenze {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObjectNoResume(Muenze) ;
  delay 3 ;  
  "Mit blo}en H#nden komme ich nicht ran."
 clearAction ;
}

event Push -> Muenze {
 TriggerObjectOnObjectEvent(Take, Muenze) ;
}

event Pull -> Muenze {
 TriggerObjectOnObjectEvent(Take, Muenze) ;
}

event LookAt -> Muenze {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObjectNoResume(Muenze) ;
  "Sie scheint festzustecken."  
 clearAction ;
}

event Pen -> Muenze {
 TriggerObjectOnObjectEvent(Pen, Automat) ;
}

event WalkTo -> Muenze {
 Ego:
  walkToStdEventObject(Muenze) ;
}

/* ************************************************************* */

object Automat {
 setupAsStdEventObject(Automat,LookAt,320,220,DIR_NORTH) ;											
 setClickArea(291,118,367,207) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Getr#nkeautomat" ;
}

event Push -> Automat {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObjectNoResume(Automat) ;
 delay 2 ;
  EgoUse ;
 delay 1 ;
  "Er ist zu schwer f]r mich."
  if (CoinSpotted and not TookCoin) "Au}erdem komme ich so auch nicht an die M]nze."
 clearAction ;	  
}

event Pull -> Automat {
 TriggerObjectOnObjectEvent(Push, Automat) ;
}

event Use -> Automat {
 if (TooDark) return ;
 Ego:
  walkToStdEventObject(Automat) ;
 suspend ;
  if (! HasItem(Ego, Coin)) 
   if (CoinSpotted) {
     "Ich habe leider kein Kleingeld bei mir."
   } else {
     "Ich habe leider kein Kleingeld bei mir."
     "Aber... Moment mal..."
     "Da h#ngt eine M]nze in dem Einwurfsschlitz."
     "Vielleicht komme ich da irgendwie ran."
    CoinSpotted = true ;    
    Muenze.enabled = true ;    
   }
  else say("Ich habe gerade keinen Durst.") ;
 clearAction ;
}

event LookAt -> Automat {
  if (TooDark) return ;	
   Ego: 
    walkToStdEventObject(Automat) ;
   suspend ;
   delay(1) ;
  if (TookCoin == false) {
   if (CoinSpotted == false) {
     "Einer der legend#ren Chuckwiser-Getr#nkeautomaten." 
     "Leider habe ich nicht genug Kleingeld bei mir." 
     "Moment mal, da h#ngt eine M]nze in dem Einwurfsschlitz."
     "Vielleicht komme ich da irgendwie ran."
    CoinSpotted = true ;    
    Muenze.enabled = true ;    
   } else 
     "In dem Einwurfsschlitz des Automaten h#ngt eine M]nze."
  } else say("Ein Chuckwiser-Getr#nkeautomat.") ;
  clearAction ;
}

event WalkTo -> Automat { 
 Ego: 
  walkToStdEventObject(Automat) ;
}

event Open -> Automat {  
 if (TooDark) return ;	
 Ego: 
  walkToStdEventObject(Automat) ;
 suspend ;
 delay(1) ;  
  "Ohne passendes Werkzeug und unter dem aufmerksamen Blick..." ;  
  "...des Flughafenpersonals wird das nichts." ;  
 clearAction ;  
}

event Coin -> Automat {
 Ego:
  walkToStdEventObject(Automat) ;
  say("Ich habe keinen Durst.") ;
}

event Pen -> Automat {
 if (TooDark) return ;	
 Ego: 	
  walkToStdEventObject(Automat) ;
 if (TookCoin == false) {
  suspend ;
  if (! CoinSpotted) {
   "Warum sollte ich..."
   "Moment mal!"
   "Da steckt ja eine M]nze im Einwurfsschlitz!"
   CoinSpotted = true ;
   Muenze.enabled = true ;
  }
  "Ich versuche, die M]nze mit dem Kugelschreiber durchzudr]cken..." ;
  dropItem(Ego, Pen) ;
  EgoStartUse ;
  delay ;
  soundBoxPlay(Music::Muenze2_wav) ; 
  delay ;
  takeItem(Ego,Coin) ;
  delay(5) ;
  EgoStopUse ;
  turn(DIR_SOUTH) ;
  "Es hat geklappt!"  
  takeItem(Ego, Pen) ;
  Muenze.enabled = false ;
  TookCoin = true ;
  Personal: 
   delay(5) ;
   "Sie da!"
   "Was machen Sie da?"
   "Ist das etwa mein Kugelschreiber?"
   "Geben Sie den sofort wieder zur]ck!" ;
  Ego:
   walk(450,285) ;
   turn(DIR_NORTH) ;
   EgoStartUse ;
   dropItem(Ego, Pen) ;
  PenOnTable:
   enabled = true ;
   EgoStopUse ;
  Ego:
   "Bitte sehr, kommt nicht wieder vor." ;
  Personal: 
   "Hmpf!" ;
 } else {
  "Das w]rde nichts bewirken."
 }
 clearAction ; 
}


 
/* ************************************************************* */
 
object Kaktus {
 setupAsStdEventObject(Kaktus,LookAt,109,267,DIR_SOUTH) ;												
 setClickArea(65,210,121,347);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kaktus" ;
}

event LookAt -> Kaktus {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Kaktus) ;
 suspend ;
  "Ein ziemlich gro}er Kaktus." ;
 if (random(3)==0) say("Es soll Kakteen geben deren Verzehr psychoaktive Nebenwirkungen hat.") ;
 clearAction ;
}

event Take -> Kaktus {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Kaktus) ;
 suspend ;
 "Der ist zu gro} und stachelig."
 clearAction ;
} 

event Push -> Kaktus {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Kaktus) ;
 suspend ;
  "Ich bin kein Masochist."
 clearAction ;
}

event Pull -> Kaktus {
 TriggerObjectOnObjectEvent(Push, Kaktus) ;
}

event TalkTo -> Kaktus {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Kaktus) ;
 suspend ;
 delay 2 ;
  "Hallo Kaktus!"
 delay 10 ;
 clearAction ;
}

/* ************************************************************* */

object Toilettentuer {
 setupAsStdEventObject(Toilettentuer,LookAt,245,205,DIR_NORTH) ;													
 setClickArea(216,112 ,278,192);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r zu den Toiletten" ;
}

event LookAt -> Toilettentuer {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Toilettentuer) ;
  "Durch die T]r geht es zu den sanit#ren Anlagen des Flughafens." ;
  "Sie scheint mir etwas klein geraten..."
}

event WalkTo -> Toilettentuer {
 Ego: 
  walkToStdEventObject(Toilettentuer) ;
}

event Use -> Toilettentuer {
 triggerObjectOnObjectEvent(Open, Toilettentuer) ;
}

event Open -> Toilettentuer {
 Ego: 
  walkToStdEventObject(Toilettentuer) ; 
 suspend ;
  say("Dort gehe ich nicht rein, solange es nicht n[tig ist.") ;
 clearAction ;
}

event Close -> Toilettentuer {
 Ego: 
  walkToStdEventObject(Toilettentuer) ; 
  say("Die T]r ist schon geschlossen.") ;

}

/* ************************************************************* */

object Pflanze {
 setupAsStdEventObject(Pflanze,LookAt,227,220,DIR_WEST) ;	
 setClickArea(153,146,194,218);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pflanze" ;
}

event LookAt -> Pflanze {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Pflanze) ;
 suspend ;
  "Sie verleiht dem Raum ein angenehmes Flair." ;
 clearAction ;
} 

event Take -> Pflanze {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Pflanze) ;
 suspend ;
  "Sie ist so ziemlich das letzte, was mir momentan weiterhilft."
 clearAction ;
}

event Pull -> Pflanze {
 if (TooDark) return ;
 Ego:
  walkToStdEventObject(Pflanze) ; 
 suspend ;
 EgoUse ; 
  "Sie ist zu schwer."
 clearAction ;
}

event Push -> Pflanze {
 TriggerObjectOnObjectEvent(Pull, Pflanze) ;
}

/* ************************************************************* */

object Draussen {
 setClickArea(0,112,66,284);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "nach Drau}en" ;
}

event WalkTo -> Draussen {
 Ego: 
  turn(DIR_SOUTH) ;
  "Wozu sollte ich jetzt umkehren?"
  "Auf nach @gypten!" ;
 clearAction ; 
} 

event LookAt -> Draussen {
 if (TooDark) return ;	
 Ego: 
  clearAction ; 
  walk(130,260) ;
  "Von dort komme ich her." ; 
} 

/* ************************************************************* */

object Monitor {
 setupAsStdEventObject(Monitor,LookAt,420,287,DIR_NORTH) ;		
 setClickArea(399,156,452,209) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Monitor" ;
}

event LookAt -> Monitor {
 if (TooDark) return ;	
 Ego: 
  walkToStdEventObject(Monitor) ;
 suspend ;
  "An diesem Monitor arbeitet die junge Frau hier." ;
 clearAction ;
}

event Use -> Monitor {
 Ego:
  walkToStdEventObject(Monitor) ;
 suspend ;
 if (LightOff != 0) {  
  "Von hier aus kann ich kann nichts erkennen."
 } else {
  "Nicht, wenn das Fr#ulein zusieht."
 }
 clearAction ;
}

event Take -> Monitor {
 if (TooDark) return ;	
 Ego: 
  walkToStdEventObject(Monitor) ;
 suspend ;
 "Was w]rde mir ein Monitor weiterhelfen?" ;
 clearAction ;
}

event Push -> Monitor {
 if (TooDark) return ;	
 Ego: 
  walkToStdEventObject(Monitor) ;
 suspend ;
 "Lieber nicht. Er k[nnte herunterfallen." ;
 clearAction ;
}

event Pull -> Monitor {
 triggerObjectOnObjectEvent(Push, Monitor) ;
}


/* ************************************************************* */

object carpetO { 
 setupAsStdEventObject(Carpeto,Take,675,250,DIR_NORTH) ;			
 name = "Riss" ;
 setPosition(628,212 ) ;
 setClickArea(40,36,58,44) ;
  
 enabled = true ;
 visible = true ;
 absolute = false ;
 
 autoAnimate = false ;
 setAnim(scrap_sprite) ;
 frame = 0 ;
} 

event Pull -> CarpetO {
 TriggerObjectOnObjectEvent(Take, CarpetO) ;
}

event Take -> CarpetO {
 Ego:
 if (CarpetO.Frame == 0) {  
   if (LightOff != 0) {
      walk(677,270) ;
      turn(DIR_NORTH) ;	  
     takeItem(Ego, CarpetScrap) ;
     carpetO.frame = 1 ;
     carpetO.name = "Loch im Teppichboden" ;  	  
   } else {   
      walk(675,250) ;
     if (Ego.direction == DIR_EAST) {
        turn(DIR_EAST) ;
       say("Ich tu einfach so als ob ich mir die Schuhe binde...") ;
       delay 4 ;
       EgoUse ;
       takeItem(Ego, CarpetScrap) ;
       carpetO.frame = 1 ;
       carpetO.name = "Loch im Teppichboden" ;
     } else {
        walk(677,270) ;
        turn(DIR_NORTH) ;
       delay(5) ;
       Personal: mode = 3 ; 
       delay(30) ;
       Ego: turn(DIR_WEST) ;
       delay(20) ;
       Ego: turn(DIR_SOUTH) ;
       delay(2) ;
       switch upcounter(3) {
         case 0:   "Ich sollte wohl besser kein Flughafeneigentum besch#digen."
                   Personal: Mode = Random(3) ;
                   Ego: "Auf jedenfall nicht direkt vor ihren Augen." 
         case 1:   "Es ist ungeschickt, den Teppichfetzen direkt vor ihren Augen herauszurei}en."
	           Personal: Mode = Random(3) ;
         case 2:   "Vielleicht kann ich den Teppichfetzen irgendwie verdecken..."
	           "...so dass sie ihn nicht sieht."
	           Personal: Mode = Random(3) ;
         default:  "Ich sollte mich zwischen sie und das Loch im Teppich stellen."
	           "Dann kann sie nicht sehen was ich mache."
	           Personal: Mode = Random(3) ;
       } 
     }
   } 
 } else {
   Ego: 
    walk(650,240) ;
     turn(DIR_EAST) ;
     Personal: Mode = 3 ; 
     delay(25) ;
     Ego: turn(DIR_WEST) ;
     delay(15) ;
     Ego: turn(DIR_SOUTH) ;  
     Ego: "Ich rei}e besser kein weiteres St]ck heraus." ;
     Personal: Mode = 0 ;
 } 
 clearAction ;
} 

event LookAt -> carpetO {
 if (TooDark) return ;	
 Ego:
 walk(670,260) ;
 turn(DIR_NORTH) ;
 if (carpetO.frame == 0) {
  carpetO.name = "Teppichfetzen" ;
  Ego: "Der Teppichboden ist an dieser Stelle eingerissen." ;
 } else {
  Ego: "Hier war das St]ck Teppichboden, das ich herausgerissen habe." ;
 } 
 clearAction ;
} 

/* ************************************************************* */

object Lamp {
 setupAsStdEventObject(Lamp,LookAt,125,245,DIR_NORTH) ;				
 name = "Lampe" ;
 setPosition(66,127) ;
 setClickArea(36,28,60,49) ;
 enabled = true ;
 visible = false ;
 absolute = false ; 
 setAnim(lampoff_image) ;
 visible = false ;
} 

event LookAt -> Lamp {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Lamp) ;
 suspend ;
  if (TookBulb) {
   "Die Lampe ist aus."	  
   "Ich habe die Gl]hbirne herausgeschraubt."   
  } else {
    delay ;
    switch random(3) {
     case 0 : "Was f]r eine helle Lampe."
     case 1 : "Eine ziemlich leistungsstarke Lampe."
     case 2 : "Sie ist so stark, dass ich fast davon geblendet werde."
    }
  }
 clearAction ;
}

script GesehndialogEx(x) {
 Personal: Mode=0; delay(1); doAnimate = false ; delay(10) ;
 if (x==1) {  takeItem(Ego,CarpetScrap) ;}
 Ego: turn(DIR_EAST) ; delay(15) ;
 static int DoAgain = false ;
 if DoAgain {
  Personal: "Das hatten wir doch schon mal..." ; doAnimate = true ; mode = 0 ;
 } else {
  Personal: "Das lassen Sie mal lieber bleiben!"; doAnimate = true ; mode = 0 ;
  doAgain = true ;
 } 
 Ego: 
  walk(286,340) ;
 clearAction ;
 finish ;
} 

event CarpetScrap -> Lamp {
 Ego:
  walkToStdEventObject(Lamp) ;
 suspend ;
 
 if (TookBulb) {  
  "Ich habe die Birne bereits herausgeschraubt." ;
  clearAction ;
  return ;
 } 
 
 if (KnowBulb) {
  if (LightOff == 0) {
   dropItem(Ego,CarpetScrap) ;
   GesehndialogEx(1) ;
   takeItem(Ego,CarpetScrap) ;
   Ego: turn(DIR_EAST) ;
  } else { 
   Ego.turn(DIR_WEST) ;
   dropItem(Ego,CarpetScrap) ; 
   delay(10) ; 
   if (lightoff == 0) { GesehndialogEx(1); return ; } 
   "Mit dem Teppichfetzen sp]re ich die Hitze so gut wie gar nicht!" 
   if (lightoff == 0) { GesehndialogEx(1); return ; } 
   delay(10) ; 
   if (lightoff == 0) { GesehndialogEx(1); return ; } 
   "Gleich hab ich sie..." ; 
   if (lightoff == 0) { GesehndialogEx(1); return ; } 
   delay(10) ; 
   if (lightoff == 0) { GesehndialogEx(1); return ; } 
   takeItem(Ego,Bulb) ; 
   Lamp.visible = true ; 
   takeItem(Ego,CarpetScrap) ; 
   turn(DIR_SOUTH) ;    
   "Hier ist sie." ; 	  
  }    
 } else {
  Ego: "Warum sollte ich die Gl]hbirne putzen?" ;
 }
 clearAction ;  
} 

event Take -> Lamp {
 Ego:
  walkToStdEventObject(Lamp) ;
 suspend ;
 if (KnowBulb) and (! saidhint) {
   Ego:    
    "Gute Idee."  
    "Mit der Lampe kann der Mechaniker vielleicht den Automaten reparieren."    
    saidhint = true ;
 }
 if (TookBulb) {
  "Ich habe die Gl]hbirne bereits herausgeschraubt." ;
  clearAction ;
  return ;
 }
 
 if (KnowBulb) {
  if (LightOff == 0) {
   start EgoUse ;
   GesehndialogEx(0) ;
  } else { 
   delay(10) ;
   "AUTSCH!"
   delay(5) ;
   turn(DIR_EAST) ;   
   "Die ist viel zu hei} zum anfassen." ;
  } 
 } else {
   Ego:	 
    "Wie hilft mir eine Gl]hbirne jetzt weiter?" ;
 } 
 clearAction ; 
} 

/* ************************************************************* */

object Kaktus2 {
 setupAsStdEventObject(Kaktus2,LookAt,350,226,DIR_NORTH) ;					
 setClickArea(394,136,424,155) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kaktus" ;
}

event LookAt -> Kaktus2 {
 if (TooDark) return ;	
 Ego:	 
  walkToStdEventObject(Kaktus2) ;
 suspend ;
 switch random(3) {
  case 0: "Was f]r ein s]}er kleiner Kerl." 
  case 1: "Fr]her hab ich immer davon getr#umt, ein Kaktus zu sein." 
  case 2: "Ein Kaktus."
	  "Wie s]}."  
 } 
 clearAction ;
} 

event Take -> Kaktus2 {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Kaktus2) ;
 suspend ;
 "Der ist mir zu stachelig."
 clearAction ;
} 

event Push -> Kaktus2 {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Kaktus2) ;
 suspend ;
  "Ich bin kein Masochist."
 clearAction ;
}

event Pull -> Kaktus2 {
 TriggerObjectOnObjectEvent(Push, Kaktus2) ;
}

event TalkTo -> Kaktus2 {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Kaktus2) ;
 suspend ;
 delay 2 ;
  "Hallo Kaktus!"
 delay 10 ;
 clearAction ;
}

/* ************************************************************* */

object Pflanze2 {
 setupAsStdEventObject(Pflanze2,LookAt,615,300,DIR_NORTH) ;						
 setClickArea(579,135,612,183) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Gew#chs" ;
}

event LookAt -> Pflanze2 {
 if (TooDark) return ;	
 Ego:
  walkToStdEventObject(Pflanze2) ;
 suspend ;
  "Sie verleiht dem Raum ein angenehmes Flair." ;
 clearAction ;
}

/* ************************************************************* */

object Kalender {
 setupAsStdEventObject(Kalender,LookAt,487,289,DIR_NORTH) ;	
 setClickArea(453,178,520,207) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kalender" ;
}

event LookAt -> Kalender {
 if (TooDark) return ;	 
 Ego: 
  walkToStdEventObject(Kalender) ;
 suspend ;
  "Ein Kalender, in dem die Fl]ge f]r heute eingetragen sind." 
 clearAction ;  
} 

event Take -> Kalender {
 Ego:
  walkToStdEventObject(Kalender) ;
 suspend ;
 switch random(2) {
   case 0 : "Der wird hier doch noch ben[tigt." ;
   case 1 : "Das w]rde der jungen Frau hier sicher nicht gefallen." ;
 } 
 clearAction ;
} 

event Pen -> Kalender {
 Ego:
  walkToStdEventObject(Kalender) ;
 suspend ;
  say("Dadurch w]rde ich vermutlich nur Chaos erzeugen.") ;
 clearAction ;
}

/* ************************************************************* */

object Personal {
 setupAsStdEventObject(Personal,TalkTo,500,275,DIR_NORTH) ;	
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ; 
 member mode = 0 ;
 member DoAnimate = true ;
 autoAnimate = false ;
 setPosition(449,106) ;
 setClickArea(0,0,55,85) ;
 captionColor = COLOR_FPERSONAL ;
 captionY = - 30 ;
 captionX = GetSpriteFrameWidth(personal_sprite,0) / 2 ; 
 captionWidth = 450 ;
 name = "Flughafenpersonal" ; 
 setAnim(personal_sprite) ;
 animMode = ANIM_STOP ; 
}

script AnimatePersonal {
 Personal:
 killOnExit = true ;
 int i = 0 ;
 int d = 0 ;
 loop {
  if (not DoAnimate) { delay(1) ; } 
  else  {
  if d < 0 {
  switch animMode {
	  
   case ANIM_STOP :
    switch mode {
     case 0 :
      frame = 0 ;
      i-- ;
      d = 2+Random(5) ;
     case 1 : 
      d = random(5) ;
      if (frame >= 2) or (frame < 1) {frame = 1; i--; d = 4+random(8) ;} else {frame++ ; }
     case 2 :
      d = random(2) ;
      if (frame >= 4) or (frame < 3) {frame = 3; i--; d = 2+random(8) ;} else {frame++ ; }
      if (frame == 4) start soundBoxStart(click_wav) ;
     case 3 :
      if (frame == 9) frame = 10 ;	
      if (frame != 9) and (frame != 10) { frame = 9 ; } 	      
      i = 1 ;      
     case 4 :
      frame = 9 ;
      i-- ;
      d = 1+Random(3) ; ;    
    } 

   case ANIM_TALK :
    if (frame < 5) or (frame > 8) { frame = 5 ; } else { frame++ ; } 
    d = 3 ;     
    if (frame == 6) and (random(3) == 0) { frame = 5 ; d=6+Random(8) ;} 
    if (frame == 8) and (random(3) == 0) { frame = 7 ; d=6+Random(8) ;} 
    if (frame == 8) { frame = 5 ; d=6+Random(8) ; } 
   } 
  } 
  
  d-- ;
  if (i < 0) { 
   if (mode == 1) and (random(3) == 0) { mode = 4; i = 1 + Random(3); } else {
    if (mode == 4) { mode = 1; i = 1 + Random(3); } else {
     mode = random(3) ; i = 1 + Random(4); } 
   }
  } 
  if (mode == 0) frame = 0 ;
  
  delay(1) ;
 } 
 } 
}

event MemberCard -> Personal {
 var didGive = did(give) ;
 Ego:
  walkToStdEventObject(Personal) ;
 suspend ;
 if didGive {
  if (HasItem(Ego,Ticket)) {
   Ego:    
    "Ich habe mein Ticket doch schon."
  } else {
   Ego:
    "Hi."
    "Mein Name ist Peter Wonciek."
    "Ich habe einen Flug nach Kairo reservieren lassen."
    dropItem(Ego, MemberCard) ;
    "Hier ist mein Ausweis."    
    Personal:
    "Ja. Hier...Wonciek, Peter."
    "Alles klar. Hier ist Ihr Ticket."
    EgoStartUse ;
    takeItem(Ego, Membercard) ;
    takeItem(Ego, Ticket);
    EgoStopUse ;
    Ego: "Dankesch[n!";
    Personal: "Global Trans w]nscht Ihnen einen guten Flug, Herr Wonciek.";
  }
 } else say("Ich sollte ihr den Ausweis geben.") ;
 clearAction ;
}

event TalkTo -> Personal {
 Ego:
  walkToStdEventObject(Personal) ;
 suspend ;
  if (HasItem(Ego,Ticket)) {
    Ego:     
     "Ich habe mein Ticket doch schon."
     "Mehr brauche ich nicht von ihr."
     clearAction ;
     return ;
  }
  if (TooDark) return ;
  static var alreadyTalked = false ;
  if (alreadyTalked == false) {
   switch random(2) {
    case 0 : "Hallo!"
    case 1 : "Hi."
   }
   alreadyTalked = true ;
  } else
   switch random(2) {
    case 0 : "Hallo, ich bin's wieder."
    case 1 : "Hi, ich bin's nochmal."
   }
  Personal:   
  if (HasItem(Ego, Coin)) {
   switch random(3) { 
    case 0 : "Sie sind ja immernoch da..." 
    case 1 : "Was wollen Sie denn schon wieder?" 
    case 2 : "Sie schon wieder!"
   }
  } else {
   switch random(3) {
    case 0 : "Wie kann ich Ihnen behilflich sein?" 
    case 1 : "Was kann ich f]r Sie tun?" ;
    case 2 : "Wie kann ich Ihnen weiterhelfen?"
   } 
  } 	  
  if (PersonaldialogEx == 2 and  GaveHint == false) {
   Ego:
   walk(positionX,340) ;   
   turn(DIR_SOUTH) ;
    "Hmmm... Irgendwie muss ich an das Ticket kommen."
   GaveHint = true ; 
  }
  clearAction ;
}

event Use -> Personal {
 Ego: 	
  walkToStdEventObject(Personal) ;
 suspend ;
 if (LightOff != 0) {
   "So etwas hatte JULIAN HOBLER noch nie n[tig."
   clearAction ;
   return ;
 }
 if flipcounter { 
  "Daf]r habe ich jetzt keine Zeit."   
 } else "So einfach geht das nicht."
 clearAction ;
}

event Take -> Personal {
  triggerObjectOnObjectEvent(Use, Personal) ;
} 

event LookAt -> Personal {
 if (TooDark) return ; 	
 Ego:
  walkToStdEventObject(Personal) ;
 suspend ;
  "Das Flughafen-Personal." ;
 if (!HasItem(Ego,Ticket)) say("Bei ihr sollte ich mein Ticket abholen.") ;
 clearAction ;
}

event Push -> Personal {
 Ego:
  walkToStdEventObject(Personal) ;
 suspend ;
 delay(2) ;
  "Das w]rde ihr bestimmt nicht gefallen." 
 clearAction ;  
}

event Pull -> Personal {
 TriggerObjectOnObjectEvent(Push, Personal) ;
}

event Pen -> Personal {
 Ego:
  walkToStdEventObject(Personal) ;
 suspend ;
  "Warum sollte ich ihn ihr zur]ckgeben?"
 clearAction ;
}

/* ************************************************************* */
 
object Logo {
 setupAsStdEventObject(Logo,LookAt,500,275,DIR_NORTH) ;		
 setClickArea(385,61,591,135);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 Priority = 0;
 name = "'Global Trans'-Logo" ;
}

event LookAt -> Logo {
 if (TooDark) return ; 	
 Ego: 
  walkToStdEventObject(Logo) ;
 suspend ;
  "Global Trans Airlines - Ankommen statt Umkommen." ;
 clearAction ;
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,Open,797,174,DIR_NORTH) ;		
 setClickArea(772,87 ,835,166);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event Use -> Tuer {
 triggerObjectOnObjectEvent(Open, Tuer) ;
}

event LookAt -> Tuer {
 Ego: 
  walkToStdEventObject(Tuer) ;
 suspend ;
  "Hier geht es wohl in einen Raum, in dem nur Personal Zutritt hat." ;
 clearAction ;
}

event Open -> Tuer {
 Ego: 
  walkToStdEventObject(Tuer) ;
 suspend ;
  "Hier hat nur das Personal Zutritt." ;
 clearAction ;
} 

/* ************************************************************* */

object Ausgang {
 setClickArea(933,121 ,999,297);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Ausgang" ;
}

event Ticket -> Ausgang {
 triggerObjectOnObjectEvent(WalkTo, Ausgang) ;
}

event WalkTo -> Ausgang {  
 clearAction ;  
 Ego:  
  if HasItem(Ego,Ticket) {  
   interruptCaptions ;
   walk(994,253) ;
   dropItem(Ego, Ticket) ;
   InstallSystemInputHandler(&IntroPartThree_Handler) ;	
   InstallScreenPostdrawingHandler(null) ;  
   doEnter(Map) ;   
  } else {  
   walk(920,260) ;
   turn(DIR_EAST) ;
   switch random(3) {  
     case 0: "Zuerst brauche ich ein Ticket."   
     case 1: "Ohne ein g]ltiges Ticket kann ich nicht fliegen." 
     case 2: "Dazu ben[tige ich ein g]ltiges Ticket."  
   }  
 }    
}

/* ************************************************************* */

object Kloschild {
 setupAsStdEventObject(Kloschild,LookAt,245,205,DIR_NORTH) ;	
 setClickArea(235,84 ,259,108);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event LookAt -> Kloschild {
 if (TooDark) return ; 	
 Ego: 
  walkToStdEventObject(Kloschild) ;
 suspend ;
  "Das Schild weist darauf hin, dass sich hinter dieser T]r die Toiletten befinden." ;
 clearAction ;
} 

event Take -> Kloschild { 
 clearAction ;
 Ego:
  walkToStdEventObject(Kloschild) ;
 suspend ;
  "Solch einer obskuren Sammelleidenschaft bin ich noch nicht verfallen."
 clearAction ;
}

/* ************************************************************* */

object Personalschild {
 setupAsStdEventObject(Personalschild,LookAt,797,174,DIR_NORTH) ;			
 setClickArea(764,64 ,839,81);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event LookAt -> Personalschild {
 if (TooDark) return ; 	
 Ego: 
  walkToStdEventObject(Personalschild) ;
 suspend ;
  "Der Raum ist nur f]r Angestellte." ;
 clearAction ;
}

event Take -> Personalschild {
 Ego:
  walkToStdEventObject(Personalschild) ;
 suspend ; 
  "Ich brauche das Schild nicht."
 clearAction ;
}

/* ************************************************************* */

object Schild {
 setupAsStdEventObject(Schild,LookAt,626,297,DIR_NORTH) ;	
 setClickArea(600,172 ,652,216);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event LookAt -> Schild {
 if (TooDark) return ; 	
 Ego: 
  walkToStdEventObject(Schild) ;
 suspend ;
  "Das Schild weist h[flich darauf hin, Abstand zu halten." ;
 clearAction ;
} 

event Take -> Schild {
 triggerObjectOnObjectEvent(Push, Schild) ;
}

event Pull -> Schild {
 triggerObjectOnObjectEvent(Push, Schild) ;
}

event Push -> Schild {
 if (TooDark) return ; 	
 Ego: 
  walkToStdEventObject(Schild) ;
 suspend ;
 EgoUse ;
  "Ich kann es nicht bewegen." ;
 clearAction ;
	
}

/* ************************************************************* */

object Mechaniker {
 setupAsStdEventObject(Mechaniker,TalkTo,770,220,DIR_WEST) ;		
 setPosition(635,140) ;
 autoAnimate = false ;
 SetStopAnim(mechaniker_sprite) ; 
 SetTalkAnim(mechanikertalk_sprite) ;
 captionY = -20 ;
 captionX = GetSpriteFrameWidth(mechaniker_sprite,0) / 2 ;
 captionWidth = 300 ;
 captionColor = COLOR_TECHNICIAN ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 name = "Mechaniker" ;
 setClickArea(25,0,100,100) ; 
} 

script AnimateMechaniker {
 activeObject = Mechaniker ;
 eventGroup = MECHANIKER_GROUP ;
 killOnExit = true ;
 loop {
  if (LightOff == 0) {
  if animMode == ANIM_STOP {
    if(frame==0) and (random(12)==0) { frame=2; delay(random(15));} else
     if (random(5) == 0) {frame++;} else
      if (random(55) == 23) { frame = 1 ; delay(random(2)) ; frame = 2 ; delay(random(2)) ; frame = 1 ; delay(random(20)) ; frame = 2 ;  }
    if (frame == 3) frame = random(2) ;
    delay 2 ;
  } else if (animMode == ANIM_TALK) {
    if (random(2) == 0) frame = 0 ;
  }
  }
  delay 1 ;
 }
}

event LookAt -> Mechaniker {
 if (TooDark) return ; 	
 Ego:
  walkToStdEventObject(Mechaniker) ;
 suspend ;
  "Er scheint den Passbildautomaten zu reparieren."
 clearAction ;
}

event Push -> Mechaniker {
  if (LightOff != 0) {
   Ego:
   "Nein, es ist bereits dunkel."
   clearAction ;
  } else {
   Ego:
    walk(700,235) ;
    turn(DIR_NORTH) ; 
    EgoStartUse ;    
   delay(10) ; 
    EgoStopUse ;   
    Mechaniker: "Ahrg...Was soll das?" ;
   Ego:
    turn(DIR_SOUTH) ;
    LightTurnsOff ;
  }
}

script MechanikerGoAway {
 killEvents(MECHANIKER_GROUP) ;
 Mechaniker:
 setPosition(672,104) ;
 autoAnimate = false ;
 setAnim(MechanikerStandUp_sprite) ;
 frame = 0 ;
 delay 3 ;
 var saveprior = priority ;
 priority = 255 ;
 frame = 1 ;
 delay 10 ;
 priority = saveprior ;
 walkingSpeed = 6 ;
 WalkAnimdelay = 4 ;
 setPosition(718,242) ; 
 setAnim(MechanikerWalk_sprite) ;  
 autoAnimate = true ; 
 walk(994,253) ; 
 visible = false ;
 enabled = false ; 
}

event Bulb -> Mechaniker {
 if (TooDark) return ; 	
 if did(give) {
  Ego:
   walkToStdEventObject(Mechaniker) ;
  suspend ;
   EgoStartUse ;
  Ego: "K[nnten Sie die zuf#llig gebrauchen?" ;
  Mechaniker: "Ist das etwa eine Hyper-Ampoule?" ;
  Ego: "Aber sicher." ;
  Mechaniker: "Vielen Dank." ;
              "Genau das was mir gefehlt hat."
	      "Ich baue sie schnell ein und mach' dann Mittag."
  dropItem(Ego, Bulb) ;
  EgoStopUse ;
  Mechaniker: "Bis dann!"
  MechanikerGoAway ;
  Ego:
   path = flughafen2_path ;
 } else Ego.say("In diesem Moment eben schoss mir das Verb GEBEN durch den Kopf.");
  clearAction ;
}

event TalkTo -> Mechaniker {  
 if (TooDark) return ; 		
 Ego:
  walkToStdEventObject(Mechaniker) ;
 suspend ;
 AutomatdialogEx_1 ; 
 clearAction ; 
} 

event Cactus -> Mechaniker {
  if (LightOff != 0) {
   Ego:
   "Nein, es ist bereits dunkel."
   clearAction ;
  } else {
   Ego:
    walk(700,235) ;
    turn(DIR_NORTH) ;  
    EgoStartUse ;
   delay(10) ;
    EgoStopUse ;
   Mechaniker:
    "AUTSCH!!"
   Ego:
    turn(DIR_SOUTH) ;
   Mechaniker:
    "WAS ZUM... ?!?" ;
   LightTurnsOff ;
  }
}
  
script LightTurnsOff {
 LightOff = 1 ; 
 soundBoxStart(Music::Kurzschluss_wav) ;
 Mechaniker.CaptionClick = false ;
 Mechaniker.say("Verdammt!") ;
 Mechaniker.say("Nun ist mir der Kontakt wieder abgerutscht.") ; 
 Personal.CaptionClick = false ;
 Personal.Mode = 3 ;
 delay(10) ;
 Personal.DoAnimate = false ;
 Personal.say("Nicht schon wieder!") ;
 clearAction ;
 start {   
   static int mydelay = 0 ; 
   if (mydelay < 10) mydelay++ ;
   delay (mydelay) ;
   Personal.say("Reparieren Sie das sofort wieder!") ;
   delay (mydelay*2) ;
   Mechaniker.say("Bin ja dabei!") ;
   delay (mydelay) ;
   Personal.say("Machen Sie mal schneller!") ;
   delay (mydelay) ;
   Mechaniker.say("Hab's ja gleich...") ;
   delay (mydelay) ;
   Mechaniker.say("Ist doch nichts passiert.") ;
   delay (mydelay) ;
   Personal.say("Das hier ist ein Flughafen.") ;
   delay (mydelay) ;
   Personal.say("Die Flugg#ste brauchen Licht!") ;
   delay (mydelay*2) ;
   Mechaniker.say("So, jetzt habe ich es.") ;
   delay (mydelay) ;
   LightOff = 0 ; 
   Mechaniker.say("Tut mir Leid.") ;
   Mechaniker.CaptionClick = true ;  
   Personal.CaptionClick = true ;
   Personal.DoAnimate = true ; 
   Personal.Mode = 0 ;
   finish ;
 }
} 

/* ************************************************************* */

object Passbildautomat {
 class = StdEventObject ;
 StdEvent= Use ;
 setClickArea(610,110,765,210);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Passbildautomat" ;
}

event LookAt -> Passbildautomat {
 if (TooDark) return ;	
 Ego:	 
 if (Mechaniker.enabled) {  
  "Der Passbildautomat ist wohl defekt, denn daran scheint jemand zu arbeiten." 
 } else {
  "Ein frisch reparierter, voll funktionst]chtiger Passbildautomat." 
 } 
 clearAction ;
}

event Use -> Passbildautomat {
 if (TooDark) return ;	
 if (Mechaniker.enabled) {
  Ego: "Jetzt nicht, daran wird gearbeitet." 
  clearAction ;
 } else { 
  	 
  if (not PlayerHasOscarNeedsPhotos) {
   Ego.say("Ich brauche gerade keine Passbilder von mir.") ;
   clearAction ;
   return ;
  }
	 
  if (HasItem(Ego,Coin)) {
   Ego:    
   forceHideInventory ;   
   walk(706,218) ;
   visible = false ;
   delay 15 ;
   soundBoxPlay(Music::Muenze_wav) ; 
   dropItem(Ego,Coin) ;
   delay 20 ;
   
   soundBoxStart(Music::Photo_wav) ; 
   delay 1 ;
   PassbildGross.setAnim(Passbild1_image) ;
   PassbildGross.enabled = true ;
   delay(65) ;
   
   soundBoxStart(Music::Photo_wav) ; 
   delay 1 ;
   PassbildGross.setAnim(Passbild2_image) ;
   PassbildGross.enabled = true ;
   delay(65) ;

   soundBoxStart(Music::Photo_wav) ; 
   delay 1 ;
   PassbildGross.setAnim(Passbild3_image) ;
   PassbildGross.enabled = true ;
   delay(75) ;

   PassbildGross.setAnim(null) ;
   PassbildGross.enabled = false ;
   takeItem(Ego,Photo) ;    
   face(DIR_SOUTH) ;   
   visible = true ;   
   forceShowInventory ;
  } else {
   Ego: "Ich habe kein Kleingeld bei mir." 
  } 
 } 
 clearAction ;
}

event Coin -> Passbildautomat {
 TriggerObjectOnObjectEvent(Use, Passbildautomat) ;
} 

event Push -> Passbildautomat {
 if (TooDark) return ;	
 Ego:
  walk(769,187) ;
  turn(DIR_WEST) ; 
 Mechaniker:
 if enabled {
  "Bitte lassen Sie das, sonst passiert hier noch ein Ungl]ck."
 } else {
  Ego:
   EgoUse ;
   "Er bewegt sich nicht."
 }
 clearAction ;
}

event Pull -> Passbildautomat {
 TriggerObjectOnObjectEvent(Push, Passbildautomat) ;
}

event Open -> Passbildautomat {
 if (TooDark) return ;	 
 if Mechaniker.enabled {
  Mechaniker:	 
  "Das lassen Sie sch[n bleiben. Ich brauche hier meine Ruhe.";
 } else {
  Ego:
   face(DIR_SOUTH) ;
   "Vielleicht sollte ich ihn lieber benutzen?" ;
 }
 clearAction ;
}

/* ************************************************************* */

object Zuechter {
 setupAsStdEventObject(Zuechter,TalkTo,810,240,DIR_EAST) ;	
 setPosition(838,122) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 Priority = 4 ;
 setClickArea(0,0,70,115) ; 
 name = "Kleintierz]chter"; 
 autoAnimate = false ;
 CaptionColor = COLOR_ORANGE ;
 setStopAnim(ZuechterStand_sprite) ;
 setTalkAnim(ZuechterTalk_sprite) ;
 animMode = ANIM_STOP ;
} 

event TalkTo -> Zuechter {
 if (TooDark) return ;
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
 if (HasItem(Ego,Membercard)) {
  Ego:
   "Ich habe den Mitgliedsausweis mit Peters Namen schon."
  clearAction ;
  return ;
 }
 ZuechterdialogEx_1 ;
 clearAction ; 
} 

event Cactus -> Zuechter {
 if (TooDark) return ; 
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
 if (! KnowFake) {
  Ego:   
   "Nein. Das grenzt an sinnloser K[rperverletzung."
  clearAction ;
  return ;
 }
 if (HasItem(Ego,MemberCard)) {
  Ego:
  turn(DIR_SOUTH) ;
  "Ich bin schon Mitglied!" 
  clearAction ;  
  return ;
 }
 ZuechterdialogEx3(false, false) ;
 clearAction ; 
} 

event Photo -> Zuechter {
 var didGive = did(Give) ;
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
 if (TooDark) return ; 	
 if (didGive) {
  if (WantMember) {
  Ego: 
  "Hallo!"
  "Ich habe eben ein Passbild von mir gemacht..."
  "..und m[chte Ihrem Verein nun beitreten."
  ZuechterdialogEx3(false, true) ;
  clearAction ;
  return ;
  } else {
  Ego:   
   "Was will er mit meinen Passbildern?"
  }
 } else {
  Ego:   
   "Vielleicht sollte ich ihm ein Passbild GEBEN."
 }
 clearAction ;
}

event LookAt -> Zuechter {
 if (TooDark) return ; 	
 Ego:
  walkToStdEventObject(Zuechter) ;
 suspend ;
  "Ein witzig aussehender, kleiner Kerl." 
 clearAction ;  
}

script AnimateZuechter {
 activeObject = Zuechter ;
 killOnExit = true ;
 int i = 0 ;
 loop {
  if (LightOff == 0) {
  if animMode == ANIM_STOP {
   if (i < 0) {
   switch frame {
    case 0 :
     if (Random(10) == 1) {
      frame = 2 ;
      i = 15 + Random(20);
     } else {
      frame = 1 ;
      i = 1 + Random(2) ;     
     } 
    case 1 :
     frame = 0 ;
     i = 8 + Random(20) ;  
    default :
     frame = 0 ;
     i = 20 + Random(30) ;     
    } 
   } 
   i = i - 1 ;    
   delay(1) ;
  } else {
   frame++ ;
   if frame > 1 { frame = 0 ; } 
   delay(2) ;
  }
  } else delay ;
 }
} 

/* ************************************************************* */

object PenOnTable {
 setupAsStdEventObject(PenOnTable,Take,545,290,DIR_NORTH) ;		
 setPosition(527,179) ;
 setClickArea(0,0,15,15) ;
 setAnim(pen_image) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 name = "Kugelschreiber" ;
} 

event LookAt -> PenOnTable {
 if (TooDark) return ; 	
 Ego:
  walkToStdEventObject(PenOnTable) ;
 suspend ;
  "Auf dem Tisch liegt ein Kugelschreiber." ;
 clearAction ;
} 

event Take -> PenOnTable {
 Ego: 
  walkToStdEventObject(PenOnTable) ;
 suspend ;
 if TookCoin {
   "Den brauche ich nicht mehr." 
   clearAction ;
 } else if (LightOff != 0) {    
   PenOnTable.enabled = false ;
   takeItem(Ego, Pen) ;
   "Hab ihn." ;
   clearAction ;
 } else {
  Personal :
   if (mode == 0) {
    EgoStartUse ;
    takeItem(Ego, Pen) ;
    PenOnTable.enabled = false ;
    EgoStopUse ;
    clearAction ;
   } else {
    Personal: mode = 3 ;
    EgoStartUse ;
    takeItem(Ego, Pen) ;    
    PenOnTable.enabled = false ;
    EgoStopUse ;
    delay(23) ;
    Personal: ; DoAnimate = false ; delay(5);
    Ego:
    switch (random(4)) {
     case 0 : "Oh..."
     case 1 : "Oha..."
     case 2 : "Huch!"
     case 3 : "Ups!"
    }
    delay(10) ;
    EgoStartUse ;
    dropItem(Ego, Pen) ;
    PenOnTable.enabled = true ;
    EgoStopUse ;
    Ego: 
    switch (random(3)) {
     case 0 : "Entschuldigung, kommt nicht wieder vor." 
     case 1 : "Wird nicht wieder vorkommen."
     case 2 : "Entschuldigung, das wird nicht wieder vorkommen."
     }
    Personal: DoAnimate = true ; Mode = 0 ;
    Ego:
    if (CoinSpotted) {
     walk(positionX,340) ;
     turn(DIR_SOUTH) ;
    switch upcounter(3) { 
      case 0:  "Aber trotzdem gute Idee, denn mit dem Kuli k[nnte ich an die M]nze im Automaten kommen."  
      case 1:  "Vielleicht sollte ich nicht nach dem Kuli greifen w#hrend sie hinsieht." 
      case 2:  "Sie beobachtet doch ab und zu den Eingang."
	       "Das w#re eine passende Gelegenheit." 
      default: "Ich sollte das n#chste mal lieber abwarten, bis sie sich zum Eingang dreht."
     } 
    }
  }    
  clearAction ;
 } 
} 

/* ************************************************************* */
 
script AutomatdialogEx_1 {
 static int alreadyAsked2 = false ;
 static int askedforleavingreason = false ;
 Ego : "Hi." ;
 Mechaniker: "Moment, ich kann gerade nicht..." ;
 delay(8) ;
 Mechaniker: "Ja ?" ;
 
 static int ad1_s1 = 0 ; 
 static int ad1_s2 = 0 ;
 int c ;
 Loop {
  Ego:
  AddChoiceEchoEx(1,"Was machen Sie da?",false) unless (ad1_s1 != 0) ;
  if (askedforleavingreason)
   {AddChoiceEchoEx(5,"Warum sagten sie gleich k[nnen Sie hier nicht weg?",false) unless (ad1_s1 == 0);} else
   {AddChoiceEchoEx(5,"Warum k[nnen Sie den Automaten nicht verlassen?",false) unless (ad1_s1 == 0);}	   
  AddChoiceEchoEx(2,"W#re es m[glich mich kurz ein Passbild von mir machen zu lassen?",false) unless ((ad1_s2 != 0) or (alreadyasked2 == true)) ;
  AddChoiceEchoEx(2,"W#re es vielleicht nicht doch m[glich, kurz ein Passbild von mir machen zu lassen?",false) unless ((ad1_s2 != 0) or (alreadyasked2 == false)) ;
  
  AddChoiceEchoEx(3,"Ich ben[tige wirklich dringend ein Passbild von mir!",false) unless (ad1_s2 == 0) ;
  if (ad1_s1==0) {
   AddChoiceEchoEx(4,"Ich komme wieder.",false) ; } else {
   AddChoiceEchoEx(6,"Tsch]ss.",false) ; } 
  
  c = dialogEx () ;
  
  switch c { 
   case 5 : 
    if (!askedforleavingreason) {
     Ego: "Warum k[nnen Sie den Automaten nicht verlassen?" ;
     askedforleavingreason = true ;
    } else Ego.say("Warum sagten sie gleich k[nnen Sie hier nicht weg?") ;
    
    Mechaniker: "Das h#ngt mit dieser verflixten franz[sischen Bauweise zusammen." ;
                "Mein Assistent hat die alte Birne mitgenommen, um eine passende neue zu finden" ;
                "und jetzt muss ich die Kontakte festhalten, damit sie nicht abrutschen." ;
                "Sonst w]rde das Ger#t wom[glich einen Kurzschluss ausl[sen." ;
                "Selbst wenn ich mit Ihnen rede, kann ich die Kontake nicht richtig festhalten..."
                "...wie Sie sicher schon bemerkt haben."
   case 1 :
    Ego: "Was machen Sie da?" ;
    Mechaniker: "Dieser Passbildautomat funktioniert nicht. Ich repariere ihn." ;
    Ego: "Was ist denn kaputt?" ;
    Mechaniker: "Irgendwas scheint mit dem Blitzlicht nicht zu stimmen."
                "Ich habe das Gef]hl, dass die Birne defekt ist. Ich werde sie wohl austauschen m]ssen." ;
    Ego: "Und wie lange brauchen Sie noch?"
    Mechaniker: "Nun ja, die Ersatzbirne h#tte eigentlich schon vor 10 Minuten eintreffen sollen..."
                "Aber ohne die Birne kann ich nichts machen."
		"Ich kann den Automaten nicht einmal verlassen." 
    Lamp.StdEvent= Take ;
    KnowBulb = 1 ;
    ad1_s1 = 1 ;
  case 2 :
   if alreadyAsked2 {
    Ego: "W#re es vielleicht nicht doch m[glich mich kurz ein Passbild von mir machen zu lassen?" ;
   } else { 
    Ego: "W#re es m[glich mich kurz ein Passbild von mir machen zu lassen?" ;
    alreadyAsked2 = true ;
   } 
   if (ad1_s1 == 0) 
   { 
    Mechaniker: "Nein das geht leider nicht." ; 
   } else {
    Mechaniker: "Wie ich schon sagte,"
                "das Blitzlicht funktioniert nicht. Ich muss die Birne austauschen."
                "Und leider ist die Ersatzbirne noch nicht da." ;
    KnowBulb = 1 ;   
    Lamp.StdEvent= Take ;
    ad1_s2 = 1 ;
    }
  case 3 :
   Ego: "Ich ben[tige wirklich dringend ein Passbild von mir!" ;
   Mechaniker: "Tut mir Leid, da kann ich jetzt auch nichts machen."
               "Es sei denn Sie h#tten rein zuf#llig eine Hyper-Ampoule X230..."
               "...aber ich glaube nicht." ;
                
   if (HasItem(Ego,Bulb)) {
    Ego: "Zuf#lligerweise befindet sich wirklich eine in meinem Besitz. Hier." ;
    Mechaniker: "Was? Das h#tte ich nicht erwartet." ;
    Ego: "Nehmen Sie sie." ;
    Mechaniker: "Vielen Dank! Ich tausche die Birne aus."
    dropItem(Ego, Bulb) ;    
    Mechaniker: "Jetzt kann ich endlich Mittag machen."
    "Bis dann."
    MechanikerGoAway ;
    Ego:
     path = flughafen2_path ;
    
   }
   return ;  
  case 4 : Ego: "Ich komme wieder." 
	   Mechaniker:
	   "Bitte lassen Sie mich jetzt weiterarbeiten."
	   "Ich muss mich konzentrieren, sonst mache ich noch einen Fehler." 
	   "Und das k[nnte katastrofale Folgen haben..."
	   return ; 
  case 6 : Ego: "Tsch]ss." 
	   Mechaniker:
	   "Bitte lassen Sie mich jetzt weiterarbeiten."
	   "Ich muss mich konzentrieren, sonst mache ich noch einen Fehler." 
	   "Und das k[nnte katastrophale Folgen haben..."
	   return ; 
  } 
 }   

} 

script PersonaldialogEx {
static int reservabhol = true ;
int c ;
 loop {
  Ego :

  if reservabhol {
   AddChoiceEchoEx(1, "Ich habe einen Flug nach Kairo reservieren lassen.", false) ;
  } else {
   AddChoiceEchoEx(1, "Ich m[chte bitte mein Flugticket abholen.", false) ;
  } 
  AddChoiceEchoEx(2, "Danke, ich komme alleine klar.", false) ;
  
  c = dialogEx () ;

  switch c {
  case 1:
      if reservabhol {
       Ego : "Ich habe einen Flug nach Kairo reservieren lassen." ;
       reservabhol = false ;
      } else {
       Ego : "Ich m[chte bitte mein Flugticket abholen." ;
      } 
      if SaidName {
	Personal: "Sie waren doch gerade schon einmal hier, oder?";
	          "Wie lautet Ihr Name doch gleich, ich habe so ein schlechtes Ged#chtnis in letzer Zeit."
      } else {
	Personal: "In Ordnung, dann brauche ich Ihren Namen."; 
	Saidname = true ;
      }	
      loop {
       Ego :
       AddChoiceEchoEx(1, "Julian Hobler.", false) ;
       AddChoiceEchoEx(2, "Peter Wonciek.", false) ;
       AddChoiceEchoEx(3, "Michael Jackson.", false) ;
       AddChoiceEchoEx(4, "Cliff Huxtable.", false) ;    
       c = dialogEx () ;
       
       switch c {
       case 1:
            Ego: "Julian Hobler." 
            Personal: "Es tut mir Leid, Herr Hobler. Es wurde kein Flug auf diesen Namen reserviert."
            Ego: "Alles klar...ich verstehe schon. Danke trotzdem."
            return 2 ;
       case 2:
	    Ego: "Peter Wonciek."   
            KnowFake = true ;	    
            Personal: "Ja Hier...Wonciek, Peter."
              	      "K[nnen Sie sich ausweisen, Herr Wonciek?"
            int askidentity = true ;
	    loop {
            Ego :
            AddChoiceEchoEx(1, "@hm...reicht es nicht, wenn ich Ihnen sage, dass ich Peter Wonciek bin?", false) ;
            AddChoiceEchoEx(2, "Ja.", false) unless (!askidentity) ;
	    AddChoiceEchoEx(2, "Gen]gt auch mein offizieller Kleintierz]chterausweis?", false) unless (!HasItem(Ego,Membercard)) ;
            AddChoiceEchoEx(3, "Tut mir Leid. Ich habe meinen Ausweis vergessen.", false) ;  
            askidentity = false ;

           c = dialogEx () ;

           switch c {
            
            case 1:
		 Ego: "@hm...reicht es nicht, wenn ich Ihnen sage, dass ich Peter Wonciek bin?" ;   
                 Personal:  "Nein.";
            case 2:
	         if (AskIdentity) {
		  Ego: "Ja." ;   
	         } 
		 if (HasItem(Ego, Membercard)) {		  
		  Ego: "Gen]gt auch mein offizieller Kleintierz]chterausweis?" ;		 	          
		 }
                 Personal: "Lassen Sie mich mal sehen...";
                 if HasItem(Ego,membercard) {
		 EgoStartUse ;
                 dropItem(Ego, membercard) ;
		 Ego: "Bittesch[n. ";
                 Personal: "Alles klar, Herr Wonciek. Hier ist Ihr Ticket.";
                 takeItem(Ego, membercard) ;
		 EgoStopUse ;
		 EgoStartUse ;
		 takeItem(Ego,Ticket);
		 EgoStopUse ;
                 Ego: "Dankesch[n!";
                 Personal: "Global Trans w]nscht Ihnen einen Guten Flug, Herr Wonciek.";
                 return true ;
                 } else {
		 EgoStartUse ;
                 Ego: "Hier. Ich habe nur meinen Personalausweis dabei.";
                 delay(10) ;
		 Personal: "Das ist in Ordnung."
                           "Moment mal..."
			   "Sie sind gar nicht Peter Wonciek!"
		 EgoStopUse ;
                 Ego: "Da haben Sie verdammt Recht!"
		 return 2 ;
                 }
                 
            case 3:
		 Ego: "Tut mir Leid. Ich habe meinen Ausweis vergessen."   
                 Personal: "Dann tut es mir auch Leid. So kann ich Ihnen das Ticket leider nicht ausstellen.";
                 return 2 ;
               }
              }
            return true ;
       case 3:
	    Ego: "Michael Jackson." ;   
            Personal: "Sie wollen mich wohl an der Nase herumf]hren?";
            "D]rfte ich jetzt Ihren wirklichen Namen erfahren?";
            Ego: "Tito Jackson.";
            Personal: "Na also, geht doch.";
            "Tut mir Leid, ich habe hier keine Reservierung auf diesen Namen, Herr Jackson.";
            Ego:
            "Verstehe. Danke trotzdem.";
            return 2 ;
       case 4:
	    Ego: "Cliff Huxtable." ;   
            Personal: "In Ordnung.";
            "Moment, hier steht dass Ihr Flug bereits vor zwei Tagen abgeflogen ist, Herr Huxtable.";
            Ego:
            "Oh...Entschuldigen Sie vielmals, mein Fehler.";
            return 2 ;
      }
    }            
            
  case 2:
      Ego: "Danke, ich komme alleine klar." ;
      Personal: "Wie Sie meinen.";
      return true ;
  }
 }
}

script ZuechterdialogEx3(x, x2) {
 static var ShowedOscar = false ;
 
 if (showedOscar and x == false and x2 == false) {
  Ego: "Ich bin's nochmal."
   "Ich m[chte Ihrem exklusiven Verein beitreten."
 } else {
	 
 if not ((PlayerHasOscarNeedsPhotos and HasItem(Ego, Photo)) and WantMember == true) {	
  dropItem(Ego, Cactus) ;
  if (WantMember == false) {
   Ego:
   "Hallo!"
   "Sehen Sie mal..."
   "...das ist Oscar, mein Igel!"  
  } else {
   Ego: "Das ist Oscar, mein Igel." ;
  }
  EgoStartUse ;
  showedOscar = true ;
  Zuechter: "Ein Igel??!" ; delay(10) ;
            "Wie wunderbar!" ;
  EgoStopUse ;
  Ego: "Ja. Ich liebe Igel." ;
  Zuechter: "Ich auch."
  if (WantMember == false) {
    "Zuf#lligerweise bin ich Vorstand des Kleintierz]chtervereins 'Ein Herz f]r Kleintiere e.V.'"
    "Ich bin mir sicher, es l#ge sowohl in Ihrem, als auch in Oscars Interesse..."
    "...wenn Sie meinem Verein beitreten w]rden."
    "Sie erhalten unter anderm ein j#hrliches Vereinsmagazin..."
    "...oder den offiziellen 'Ein-Herz-f]r-Kleintiere-Ausweis'."
    "M[chten Sie beitreten?"
  } else {
    "Und Sie wollen nun meinem Verein beitreten..."
    "...und alle Vorz]ge Ihrer Mitgliedschaft, wie z.B. das j#hrliche Vereinsmagazin...";
    "...und den offiziellen 'Ein-Herz-F]r-Kleintiere-Ausweis' genie}en?" ;
  }
  Ego: "Ja." ;
  WantMember = true ;
  AlreadyAsked2 = true ;
  takeItem(Ego, Cactus) ;
 
  Zuechter: "Dann brauche ich nur noch Ihren Namen und ein Lichtbild..."
            "...und ich stelle Ihnen sofort Ihren Ausweis aus." 
  var temp = true ;
 
 } else { 
  Zuechter:
   "Wie wunderbar!"
   "Dann brauche ich nur noch Ihren Namen..."
   "...und ich stelle Ihnen sofort Ihren Ausweis aus."
 }
 }
 
 if (showedOscar and x == false and temp == false and x2 == false) {
 Zuechter: "Dann brauche ich nur noch Ihren Namen und ein Lichtbild..."
           "...und ich stelle Ihnen sofort Ihren Ausweis aus." 	 
 }
 
 if (!HasItem(Ego,Photo)) {
  Ego: "Peter Wonciek. Ich habe leider kein Bild von mir." ;
  Zuechter: "Warum machen Sie dann nicht einfach eins da dr]ben am Automaten?" ;
  PlayerHasOscarNeedsPhotos = true ;
  Ego: "Gute Idee. Bin gleich wieder zur]ck." ;
  return ;
 } else {
  Ego: "Peter Wonciek. Hier ist ein Bild." ;  
  EgoStartUse ;
  dropItem(Ego, Photo) ;
  EgoStopUse ;
  Zuechter: "Wunderbar."
            "Einen Moment bitte..." ;
  delay(8) ;
  takeItem(Ego,MemberCard) ;  
  Zuechter: "So, hier haben Sie Ihren Kleintierz]chter-Ausweis."
  EgoUse ;
  Ego: "Danke!" ;
       "Ich geh dann mal." ;
  Zuechter: "Wie Sie meinen..." ;
            "Tsch]ss Oscar!" ;
  return ;               
 } 
} 

script ZuechterdialogEx_2 { 
 int c = 0 ;
 static var AskedForAdvantage = false ;
 var zd1_mm = 0 ;
 loop {
  Ego : 
  AddChoiceEchoEx(1, "Wieviele Mitglieder sind denn schon in Ihrem Verein?", false) unless (zd1_mm != 0) ;
  if (KnowFake and AskedForAdvantage) AddChoiceEchoEx(2, "Kann man Ihrem Verein beitreten?", false) unless (AlreadyAsked2 == true) ;
  if (KnowFake and AskedForAdvantage) AddChoiceEchoEx(2, "Ich m[chte Ihrem Verein beitreten.", false) unless (AlreadyAsked2 == false) ;
  if (! AskedForAdvantage) AddChoiceEchoEx(2, "Was f]r Vorteile habe ich durch die Mitgliedschaft in Ihrem Verein?", false) ;
  AddChoiceEchoEx(3, "Ich geh dann mal...", false) ;
         
  c = dialogEx () ;
 
  switch c {
  case 1:
   Ego: "Wieviele Mitglieder sind denn schon in Ihren Verein?" ;
   Zuechter: "Sie sind also einer von denen, die ihre Mitmenschen nach..."
             "...der Anzahl der Mitglieder in ihrem Verein beurteilen?" ;
   Ego: "Nein...ich meinte nur..." ;
   Zuechter: "Ist schon klar...ich verstehe Herr 'Wieviele-Mitglieder'";
   Ego: "Aber..." ;
   Zuechter: "Nichts aber! Was wollen Sie denn jetzt noch?" ;
   zd1_mm = 1 ;
  case 2:
   if (AskedForAdvantage == false) {
    AskedForAdvantage = true ;
    Ego: "Was f]r Vorteile habe ich durch die Mitgliedschaft in Ihrem Verein?"
    Zuechter: "Da w#ren zum Beispiel das exklusive j#hrliche Vereinsmagazin oder..."
	      "...der offizielle Ein-Herz-F]r-Kleintiere-Ausweis, der Ihnen zudem Verg]nstigungen..."
	      "...in Kinos, die mit dem 'Ein Herz f]r Kleintiere' - Pr]fsiegel ausgestattet sind, bietet."	      
    if (KnowFake) {
     Ego: "Ein Ausweis, sagten Sie?"
     Zuechter: "Ja. Den Ein-Herz-F]r-Kleintiere-Ausweis."
    }
   } else {
   if alreadyAsked2 {    
    Ego: "Ich m[chte Ihrem Verein beitreten." ;
   } else {
    Ego: "Kann man Ihrem Verein beitreten?" ;
    Zuechter:  "Auf jeden Fall." ;
               "Sind Sie Kleintierliebhaber?" ;
    Ego: "Ja sicher doch." ;
    AlreadyAsked2 = true ;
   } 
   wantmember = true ;
   Zuechter: "Kann ich Ihren kleinen Liebling auch mal sehen?" ;
   if (!HasItem(Ego,Cactus)) {
    Ego: "Denken Sie, ich schleppe ein Tier ]berall mit mir herum?" ;
    Zuechter: "Ein echter Kleintierliebhaber hat seinen besten Freund immer dabei!" ;
    Ego: "Kann ich trotzdem beitreten?" ;
    Zuechter: "Tut mir Leid." ;
    "Sie m]ssen schon die richtige Einstellung..."
    "...f]r einen exquisiten Verein wie den unseren haben." ;
    "Wir k[nnen doch die Vorz]ge des Vereins wie z.B. das j#hrliche Vereinsmagazin..."
    "...und den offiziellen Ein-Herz-F]r-Kleintiere-Ausweis nicht jedem anbieten." ;
    Ego: "Da haben Sie wohl Recht." ;
    return ;
   } else {
    ZuechterdialogEx3(true, false) ;
   }   
   return ;
   }
  case 3:
    Ego: "Ich geh dann mal..." 
    Zuechter: "Auf Wiedersehn." 
    return ;        
  } 
 } 
} 

script ZuechterdialogEx_1 {
 static int zd_knows = 0 ;
 int zd_askfly = 0 ;
 int zd1_rk = 0 ;
 int c = 0 ;
 
 if (zd_knows == 1) {
  Ego: "Ich bin's nochmal." ;
  Zuechter: "Was wollen Sie denn noch?"
            "Sehen Sie nicht, dass ich zu tun habe?"  
  ZuechterdialogEx_2 ;
  return ;
 }

 loop {
  Ego :
   AddChoiceEchoEx(1, "Warten Sie auch auf einen Flug?", false) unless (zd_askfly != 0) ;
   AddChoiceEchoEx(2, "Was machen Sie denn da?", false) ;
   AddChoiceEchoEx(3, "Auf Wiedersehen.", false) ;
   
   c = dialogEx () ;
   
   switch c {   
    case 1:
        Ego: "Warten Sie auch auf einen Flug?" 
        Zuechter: "Nein."
        delay(5) ;
        Zuechter: "W]rden Sie mich jetzt bitte weiterarbeiten lassen?";
        zd_askfly = 1 ;
    case 2:
	Ego: "Was machen Sie denn da?" 
        Zuechter: "Pssstttttt.... Nicht so laut!"
        face(DIR_WEST) ;
        delay(4) ;
        face(DIR_EAST) ;
        delay(4) ;
        Zuechter: "Ich rekrutiere."
        
        loop {
         Ego :
         AddChoiceEchoEx(1, "Wie bitte?", false) unless (zd1_rk!=0) ;
         AddChoiceEchoEx(2, "Wen oder was wollen Sie denn hier rekrutieren?",false) ;
         AddChoiceEchoEx(3, "Ich geh dann mal...", false) ;
         c = dialogEx () ;
	 
         switch c {
          case 1 :
	   Ego: "Wie bitte?" ;
           Zuechter: "Ich rekrutiere, sagte ich das nicht bereits?" 
           zd1_rk = 1 ;                  
          case 2 :
	   Ego: "Wen oder was wollen Sie denn hier rekrutieren?" 
           Zuechter: "Zuk]nftige Mitglieder f]r meinen Verein."
           Ego: "Was ist das f]r ein Verein?" 
           Zuechter: "Ein Herz f]r Kleintiere e. V." 
           zd_knows = 1 ;   
           ZuechterdialogEx_2 ;
           return ;
          case 3 : 
	    Ego: "Ich geh dann mal..." 
            Zuechter: "Auf Wiedersehn." 
            return true ;           
          } 
        } 
        
    case 3:
	Ego: "Auf Wiedersehen."
        Zuechter: "Hmpf!" 
        return true ;
  }
 }
}
  
