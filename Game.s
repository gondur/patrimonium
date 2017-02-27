// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
//           version 1.04
// ----------------------------------
// Game.s - Initialize game settings
//    and declare default events 
// ----------------------------------


// GAME VARS

var intro_phase        = 1 ;  // to determine which intro phase we are on
var JumpToIntro        = 0 ;  // for skipping the introduction with escape

var ShowDebugInfo      = false ;
var currentAct         = 0 ;  
var LightOff           = 0 ;
var Egypt              = 0 ;
var KnowsInfoNr        = 0 ;
var PhonedHotel        = 0 ; 
var LastPhonedHotel    = 0 ;
var KnowsHotel         = 0 ;  // hotel
var AskAboutToilets    = 0 ;
var GuestEvicted       = 0 ;  // 2 = currently evicting; 1 = evicted
var NeedPicklock       = 0 ;  // Zum Einbrechen bei Bateman
var NeedPickLock2      = 0 ;  // Zum Einbrechen bei Wonciek
var SeenWonciek        = 0 ;
var WonciekAtHotel     = 0 ;
var UsedTelMoney       = 0 ;
var TalkedToWonciek    = 0 ;
var HasRoom            = 0 ;  // Julian leased hotel room
var canAskForTrucks    = 0 ;  // Julian can ask for other truck rental companies
var HasTruck           = 0 ;
var HasSTAuthorization = 0 ;  
var knowsExcavation    = 0 ;  // Julian knows where to find the archeological excavation
var discerpLabel       = 0 ;  // Julian discerped the SamTec label
var knowsSamTec        = 0 ;  // Julian just knows of the connection SamTec <-> Wonciek
var knowsHeadQuarters  = 0 ;  // Julian knows how to get to the SamTec head quarters
var excavationClosed   = 0 ;
var goingBusiness      = 0 ;  // Julian knows he could pay the truck salesman by selling him an option
var knowsOptions       = 0 ;  // Julian got the option-buying-contract from schlemiel
var knowsBrander       = 0 ;  // Julian knows SamTec's head's name
var EscapedEchnaton    = 0 ;
var lastPlatte         = 0 ;
var torchLight         = 0 ;  // Fackel brennt
var solvedAtonPuzzle   = 0 ;  // Richtige Kartuschen-Kombination eingestellt
var AtonTrapDoorOpen   = 0 ;  // Deckenöffnung im Kristallraum offen
var KartuscheChanged   = 0 ;  // Anordnung der Kartuschen verändert
var PlattenAktiviert   = 0 ;  // Bodenplatten in Grabeingang/Grabsonnenraum drückbar
var PlatteGedrueckt    = 0 ;  // Stein/Schuh auf platte
var KenntPlatten       = 0 ;
var SchuhGeworfen      = 0 ;
var OscarTableTalk     = 0 ;
var knowsPharma        = 0 ;
var knowsDOTT          = 0 ;  // DOTT headquarters
var knowsMutated       = 0 ;
var wagenMoved         = 0 ;
var hackedComputer     = 0 ;
var knowsSuriza        = 0 ;  // Julian tried to solve the Suriza Puzzle
var doOpenPanel        = 0 ;
var surizaPuzzle       = 0 ;  // determines which Suriza-Puzzle to use (initialised in random.s)
var surizaSolved       = 0 ;
var sawAgentsHint      = 0 ;
var keycardPos         = 0 ;
var wondersSecurity    = 0 ;
var stopWater          = 0 ;
var openedSafe         = 0 ;
var needsBattery       = 0 ;
var wonciekSample      = 0 ;  // Julian presented the sample to Wonciek
var wonciekDocuments   = 0 ;  // Julian presented the secret documents to Wonciek
var gotSecurityKey     = 0 ;
var sawDrStrangelove   = 0 ;  // Julian saw Dr. Strangelove
var julianCaught       = 0 ;  // Lady at SamTecs headqaurters caught julian while breaking in dressed up as Dr. Strangelove
var ladyDistracted     = 0 ;  // Lady at SamTecs headquarters is distracted
var gotLadysNum        = 0 ;  // Julian asked for the SamTecs ladys number
var isDressed          = 0 ;
var knowsAskRiddle     = 0 ;  // Julian knows that Bunsen Honeydew likes Riddles
var knowsMainframe     = 0 ;  // Julian knows that Bunsen is occupied with the mainframe computer
var lastRiddle         = RIDDLE_NONE ;
var solvedRiddles      = 0 ;
var BunsenStage        = 0 ;  // 0: Bunsen sitzt, 1: Bunsen sitzt, ihm wurde aber ein Rätsel gestellt, 2: Bunsen wurde im Lab 2 gesehen, 3: Bunsen wurde wieder im Lab 1 gesehen
var installedPrinter   = 0 ;  // Drucker am Zentralrechner installiert
var printCutscene      = 0 ;
var needsCitron        = 0 ;
var knowsCitron        = 0 ;
var panelFrequency     = 0 ;
var deviceMode         = 0 ;
var chaseStage         = 0 ;  // 0: keine Jagd, 1: erstesmal in lab2 wegen Zwischensequenz dann automatisch 2: Jagd, 3: nachdem Julian den Ausdruck genommen und eingesperrt wurde
var secLab2Locked      = 0 ;  // Julian locked the door to security lab 2 
var shortCircuit       = 0 ;
var trinkerAtToilet    = 0 ;
var knowsIDCard        = 0 ;
var needsFingerPrint   = 0 ;
var endChoice          = 0 ;
var cheated            = 0 ;

var lastScene          = 0 ;  // scene prior to previousScene
var nextScene          = 0 ;  // the next scene player wants to enter in future (did anybody implement the oracle routines yet?)

var HotelCount         = 0 ;
var OutsideChefCount   = 0 ; 
var ExcavationCount    = 0 ;
var SamTecOutsideCount = 0 ; 

var TelStage           = 0 ;  // handle phone calls

event main {
  setWindowCaption("Patrimonium") ;
  defaultMouseSprite    = Cursor_sprite ;
  defaultMouseFrame     = 0 ;
  transitionEffect      = EFFECT_FADE ;
  transitionTime        = 24 ;  
  cycleTime             = 1000 / 30 ;  
  DialogTextColor       = COLOR_WHITE ;
  DialogChoiceTextColor = COLOR_YELLOW ;
  printingTextColor     = COLOR_BLACK ;
  drawingTextColor      = COLOR_BLACK ;  
  DialogFont            = Fonts::AgastSmall_font ;  
  defaultFont           = Fonts::Akt1_font ;  
  soundMasterVolume     = VOLUME_FULL ;    
  playerObject          = Ego ;

  initInput ;
  initMenus ;
  initRandom ;
  
  setupDialogEx ;
  enableScrolling ;  
  setupJukeBox ;  
  setupDiaQuest ; 
  
  printingFont = Fonts::AgastSmall_font;
  printingTextColor = COLOR_WHITE;
  printingStyle = STYLE_TRANS ;  
  printingColor = COLOR_BLACK;
  
  setupAsContainer(Ego) ;
  INV_SETCONTAINER(Ego) ;
  
  delay(1) ;
  
  currentAct = 0 ; 

  doEnter(GameMenu) ;
 }

script doEnter(Room) {
 TransitionEffect = EFFECT_BLEND ;
 transitionTime = 24 ;
 lastScene = currentScene ;
 
 
 if (Room == Flughafen) {
  jukeBox_Stop ;
  jukeBox_Shuffle(true) ;	 
  jukeBox_Enqueue(Music::BG_JustAsSoon_mp3) ;
  jukeBox_Start ;
 } else   
 if (Room == IntroCPLogo) {
  jukeBox_Stop ;
  jukeBox_Shuffle(false) ;
 } else   
 if (Room == Map) {
  jukeBox_Stop ;
 } else   
 if (Room == Vorflughafen and currentScene != Telefon) {
  jukeBox_Stop ;
  jukeBox_Shuffle(true) ;
  jukeBox_Enqueue(Music::BG_Vorflughafen_ogg) ;
  jukeBox_Start ;
 } else   
 if (Room == SamTecEmpfang and currentScene != Aufzug) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Samtec_mp3) ; 
  jukeBox_Start ;
 } else   
 if (Room == Truck) {
  jukeBox_Stop ;
 } else 
 
 if (Room == Credits) {
  jukeBox_Addin(Music::BG_Ende_mp3,10) ;
  jukeBox_Shuffle(false) ;
 } else
 if (Room == GameMenu and currentScene != Credits) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Menu_ogg) ;  
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;
 } else
 if ((Room == Ausgrabungsstelle) and (lastscene != GrabEingang)){
  jukeBox_Stop ;
  if (currentAct==4) jukeBox_Enqueue(Music::BG_Fuell6_mp3) ;
   else jukeBox_Enqueue(Music::BG_Fuell1_mp3) ;     
  jukeBox_Start ;
  jukeBox.shuffle = false ;
 } else
 if ((Room == GrabEingang) or (Room == GrabSonnenraum)) {
  if ((lastscene != GrabSchiebe)  and (lastscene != GrabEingang) and (lastScene != GrabSonnenraum)) jukeBox_Stop ;
  if ((lastscene == Ausgrabungsstelle) and (EscapedEchnaton==0)) jukeBox_Stop ;
  if (Rankengewaechs.getField(0)) Rankengewaechs.setField(0, false) ;
   else {
     jukeBox_Enqueue(Music::BG_Grab1_ogg) ;  
     jukeBox_Enqueue(Music::BG_Grab2_ogg) ;
     jukeBox_Start ;
   }
  if ((solvedAtonPuzzle) and (lastscene == GrabSchiebe)) TransitionEffect = EFFECT_NONE ;
 } else
 if (Room == GrabKristallraum) {
  jukeBox_Stop ;
  jukeBox_Shuffle(true) ;
  jukeBox_Enqueue(Music::BG_Grab3_mp3) ;   
  jukeBox_Start ;
 } else
 if (Room == GrabSchiebe) {
  TransitionEffect = EFFECT_NONE ;
 } else
 if (Room == ChefBuero) {
  if (currentAct != 4) {	 	 
    jukeBox_Stop ;
    jukeBox_Shuffle(false) ;
    jukeBox_Enqueue(Music::BG_Brander_mp3) ;
    jukeBox_Start ;
  }
 } else
 if (Room == HotelZimmerL) {
  if (currentAct != 4) {	 
    jukeBox_Stop ;
    if (!wonciekAtHotel) {
      jukeBox_Enqueue(Music::BG_Theme_mp3) ;
      jukeBox_Enqueue(Music::BG_Fuell4_mp3) ;
      jukeBox_Start ;
    }
  } else if (!currentScene == Ausgrabungsstelle) jukeBox_Stop ;
 } else
 if ((Room == Dottgarage) and (currentScene == Dott)) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Amountofevil_mp3) ;
  jukeBox_Start ;	 
 } else
 if ((Room == Dott) and (currentScene != Suriza) and (currentScene != Dottrohre) and (currentScene != Dottgarage)) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Dott_mp3) ;
  jukeBox_Start ;
 } else
 if ((Room == Securitygang) and (currentScene == Samtecempfang)) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Interloper_mp3) ;
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;
 }
 if (Room == Dottbuero) {
  if (!sawAgentsHint) jukeBox_Stop ;  
 } else
 if (Room == FinaleDavor) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Barnett_mp3) ;
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;	 
 } else
 if (Room == FinaleToilette) {
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Bad_mp3) ;
  jukeBox_Start ;
 } else
 if (Room == Taxikarte) {
  jukeBox_Stop ;
  jukeBox_Shuffle(true) ;
  jukeBox_Enqueue(Music::BG_Fuell7_mp3) ;
  jukeBox_Start ;
  jukeBox_Shuffle(false) ;
 }
 
 enter Room ;

} 

// DEFAULT EVENTS

script LeftButtonClick { 
 if (suspended) return ;
 var obj = ObjectUnderMouse ; 
 if (!LightIsOn) and (obj) {
  if ((isclassderivate(obj,stdEventObject)) and (SelectedObject != WalkTo)) { SelectVerb(Touch); TriggerObjectOnObjectEvent(Touch,Obj) ; return ; } 
 }
 TriggerMouseClickEvent() ;
} 

script RightButtonClick { 
 if (suspended) return ;
 var obj = ObjectUnderMouse ;
 if (!Obj) return ;
 if ((isclassderivate(obj,stdEventObject)) and (!LightIsOn)) { SelectVerb(Touch); TriggerObjectOnObjectEvent(Touch,Obj); return ; }
 TriggerStandardObjectEvent(ObjectUnderMouse) ;    
} 

event click {
  if (Ego.visible and suspended == false) resume ; 
  if (CurrentScene != GameMenu and CurrentScene != Credits) {
   clearAction ;
   if ((INTERFACE_VISIBLE != -1) and (ClickY > 360)) return ;
   if (CV == WalkTo) { if (Ego.enabled) Ego.walk(ClickX, ClickY) ; }   
  } else resume ; 
}

var passedVerb = -1 ;

event default -> default {  if (isclassderivate(cv, verbbuttonclass)){ passedVerb = cv ; } else passedVerb = -1 ; triggerDefaultEvents ; } 

script TriggerStandardObjectEvent(obj) {
  if ((obj == -1) or (suspended)) return ;
  if (IsClassDerivate(obj, stdEventObject)) {
    clearAction ;
    if (obj.StdEvent >= 0) {
     SelectVerb(obj.StdEvent) ;
     TriggerObjectOnObjectEvent(obj.StdEvent, obj) ; 
    } else TriggerObjectOnObjectEvent(LookAt, obj) ;     
  } else if (! IsClassDerivate(obj, NonInteractiveClass)) {
    clearAction ;
    SelectVerb(LookAt) ;
    TriggerObjectOnObjectEvent(LookAt, obj) ;
  }
}

script triggerDefaultEvents { 
 var a = SelectedObject ;
 var to = TargetObject ;
 activeObject = Ego ;

 if (Ego.enabled) {
  if (isClassDerivate(TargetObject,stdEventObject)) {
   WalkToStdEventObject(TargetObject) ;
   if (a == WalkTo) return ;
  } else clearAction ;
 } else clearAction ;
 
 if (a == WalkTo) {
  if (isClassDerivate(TargetObject,InvObj)) return ;
  if (Ego.enabled) { walk(ClickX,ClickY) ; return ; } 
 }
 
 if (a == Touch) {
  switch random(4) {
   case 0 : "Ich kann nichts genaues ertasten." ;
   case 1 : "Da ist etwas aber ich kann nicht ertasten was es ist." ;
   case 2 : "Ich kann das Ertastete nicht einordnen." ;
   case 3 : "Mein Tastsinn teilt mir mit:"
	    "Dort ist etwas."
  } 
  return ;
 }
   
 if (!LightIsOn) {
  switch random(4) {
   case 0 : "Daf]r ist es zu dunkel." ;
   case 1 : "Ich kann ]berhaupt nichts sehen." ;
   case 2 : "Daf]r ben[tige ich mehr Licht." ;
   case 3 : "Ohne Licht geht das nicht." ;
  } 
  return ;
 } 

 if (a == Pull || a == Push) {
  switch random(4) {
   case 0 : "Das will ich jetzt nicht bewegen." ;
   case 1 : "Das muss ich nicht bewegen." ;
   case 2 : "Das brauche ich nicht zu bewegen." ;
   case 3 : "Ich muss das nicht bewegen." ;
  } 
  return ;
 }  
 
 if (a == LookAt) {
  switch random(4) {                 
   case 0 : "Ich kann nichts Besonderes daran erkennen." ;
   case 1 : "Nichts Besonderes." ;
   case 2 : "Ich kann nichts Wichtiges erkennen." ;
   case 3 : "Nichts Wichtiges." ;
  } 
  return ;
 } 

 if (a == Take) {
  switch random(4) {
   case 0 : "Das will ich nicht." ;
   case 1 : "Das ben[tige ich nicht." ;
   case 2 : "Das brauche ich nicht." ;
   case 3 : "Damit kann ich jetzt nichts anfangen." ;
  } 
  return ;
 } 
 
 if (a == Give) {
  switch random(4) {
   case 0 : "Das kann ich nicht hergeben, es geh[rt mir nicht." ;
   case 1 : "Das befindet sich nicht in meinem Besitz." ;
   case 2 : "Ich sollte das erstmal an mich nehmen, bevor ich es weggebe." ;
   case 3 : "Ich kann das nicht weggeben, solange ich es nicht besitze." ;
  } 
  return ;
 }  
 
 if (isClassDerivate(a, invObj)) { // workaround since object -> default events does not seem to be catched
   triggerInvDefaultEvents(a, to) ;
   return ;
 }

 switch random(11) {
  case 0 : "Das funktioniert so nicht." ;
  case 1 : "Das kann ich nicht machen." ;
  case 2 : "Das geht so leider nicht." ;
  case 3 : "Das klappt nicht." ;
  case 4 : "Ich glaube das funktioniert so nicht." ;
  case 5 : "Das macht keinen Sinn." ;
  case 6 : "Das w]rde nichts bringen." ;
  case 7 : "Das w]rde nichts bewirken." ;
  case 8 : "Ich denke nicht, dass mir das weiterhilft." ;
  case 9 : "Nein, das bringt mich nicht weiter." ;
  case 10 : "Wie soll das funktionieren?" ;
 }	
 
}