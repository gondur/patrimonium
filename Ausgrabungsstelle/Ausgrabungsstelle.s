// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------


const AGENTTALK_GROUP = 45835 ;

event enter {
 
 enableEgoTalk ;
 
 if ((TalkedToWonciek) and (EscapedEchnaton==0)) {
  backgroundImage = Ausgrabungsstelle2_image ;
  backgroundZBuffer = Ausgrabungsstelle2_zbuffer ;    
 } else { 
  backgroundImage = Ausgrabungsstelle_image ;
  backgroundZBuffer = 0 ;  
 }
 
 ExcavationCount++ ;
 
 FlashlightEffect.enabled = false ;
 DarknessEffect.enabled = false ;
 forceHideInventory ;    
 Ego.enabled = false ;
 path = 0 ;
 
 if (CurrentAct == 2) {
  Ego:
  pathAutoScale = false ;
  enabled = true ;
  visible = true ;
  path = 0 ;  
  PositionX = 750 ;
  PositionY = 287 ;
  Scale = 700 ;
  walk(610,287);  
  path = Ausgrabungsstelle_path ;
  pathAutoScale = true ;
  delay transitionTime ;
  static var ff1 = true ;
  if (ff1) { Ego.say("Hier muss es sein.") ; ff1 = false ; }
  Ego.enabled = true ;
  forceShowInventory ;
  clearAction ; 
 }

 if ((PreviousScene != GrabEingang) and (CurrentAct == 3)) {
  Ego:
  pathAutoScale = false ;
  enabled = true ;
  visible = true ;
  path = 0 ;  
  PositionX = 750 ;
  PositionY = 287 ;
  Scale = 700 ;
  walk(610,287);  
  path = Ausgrabungsstelle_Akt3_path ;
  pathAutoScale = true ;
  forceShowInventory ;
  Ego.enabled = true ;
  clearAction ;
 }
 
 if ((PreviousScene == GrabEingang) and (CurrentAct == 3)) {
  Ego:
  path = Ausgrabungsstelle_Akt3unten_path ;
  if (!HasItem(Ego,FlashLight)) ShowCutScene ;
  if (HasItem(Ego,FlashLight)) { forceShowInventory; ShowAgents ; start AgentTalk ; clearAction ; }	  
 } 
 
 if (currentAct == 4) {
  backgroundZBuffer = Ausgrabungsstelle_zbuffer ;  
  
  dropAct3Items ;
  
  Ego:
  pathAutoScale = true ;
  enabled = true ;
  visible = true ;
  face(DIR_EAST) ;
  path = Ausgrabungsstelle_Akt4_path ;  
  PositionX = 246 ;
  PositionY = 201 ;
  delay 12 ;
  say("Uff.") ;
  delay(10) ;
  turn(DIR_SOUTH) ;
  delay 3 ;
  turn(DIR_WEST) ;
  delay 3 ;
  turn(DIR_NORTH) ;
  delay 3 ;
  turn(DIR_EAST) ;
  delay 3 ;
  turn(DIR_SOUTH) ;
  delay 3 ;
  say("Scheint niemand mehr hier zu sein.") ;
  delay 3 ;
  turn(DIR_EAST) ;
  delay 3 ;
  say("Zum Gl]ck steht mein Truck noch da.") ;
  delay 2 ;
  say("Hoffen wir mal dass das keine Falle ist...") ;
  delay 3 ;
  say("Ich muss Peter erz#hlen, was hier passiert ist.") ;
  delay 5 ;
  walk(610,287) ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 700 ;
  walk(750,287) ;
  pathAutoScale = true ;
  doEnter(HotelzimmerL) ;  
 }
 
}

/* ************************************************************* */

script showAgents {
  Ego: 
   visible = false ;
   enabled = false ;
   setPosition(340,420) ;
   path = 0 ;
   
  Schild.enabled = false ;
  Steinhaufen.enabled = false ; 
  ZumTruck.enabled = false ;
  Holz1.name = "Holzabdeckung" ;
  Holz1.enabled = true ;
  Holz2.name = "Grab" ;
  Holz2.enabled = true ;
  Kiste.enabled = false ;
  Aufkleber.enabled = false ;
  AufkleberUnten.enabled = true ;
  Fass.enabled = false ;
  Eingang.enabled = false ;
  
  John:
   enabled = true ;
   visible = true ;
   setPosition(127,277) ;
   face(DIR_EAST) ;
   path = 0 ;
   pathAutoScale = false ;
   scale = 600 ;
  Jack: 
   enabled = true ;
   visible = true ;   
   setPosition(337,263) ;
   path = 0 ;
   pathAutoScale = false ;
   scale = 600 ;
   face(DIR_WEST) ;	
}

script showCutScene {
  Eingang.setField(0,true) ;
  showAgents ;
   
  Ego:
   Rankengewaechs.setField(0, true) ;
   setPosition(340,420) ;
   delay 40 ;
   "HALT!"
  soundBoxPlay(Music::doorknock_wav) ;
   "Ich bin noch hier unten!"   
  Jack: 
   "HEHEHEHEHEHEHEHE..."   
  John:
   "HAHAHAHAHAHAHAHAHAHA"
   delay 3 ;
   "Ihr Scharfsinn ist bewundernswert."
   delay 2 ;
   "Sie Hofnarr!"
  Jack: 
   "HEHEHEHEHEHEHEHE"   
   "Hofnarr..."
  Ego:
   "|ffnen Sie sofort wieder die Abdeckung!"
   delay 4 ;
   "Oder ich komme raus!"
  delay 33 ;
  John:
   turn(DIR_SOUTH) ;
  delay 20 ;
   turn(DIR_EAST) ;
  delay 10 ;
   "DAS will ich sehen."
   "HAHAHAHAHAHAHAHAHAHA"
   
  AD1 ;
  
  forceShowInventory ;
  clearAction ;
  
  start AgentTalk ;
}


script AgentTalk {
 eventGroup = AGENTTALK_GROUP ;
 killOnExit = true ;
 loop {
  delay(5*23) ;
  delay(random(10)*23) ;
  var a = RandomTalk ; 
  if (! a)  RandomTalk ; 
 }
}

script RandomTalk {
 static var lasttalk = -1 ;
 static int tc = 0 ;
 switch random(10) {
  case 0 :
   if (lasttalk == 0) { RandomTalk ; return 1 ; }
   lasttalk = 0 ;
   Jack:
    "Wie lange m]ssen wir hier noch warten?"  
   John:
    "Noch ein bi}chen." 
    "Wir m]ssen sicher sein, dass er nicht entwischen kann."
  case 1:
   if (lasttalk == 1) { RandomTalk ; return 1 ; }
   lasttalk = 1 ;	  
   John: 
    "Wusstest du, dass ein Wissenschaftler im Grab gestorben ist?"
   Jack:
    "Nein."
   John:
    "Hobler wird nun endlich sein gr]nes Wunder erleben."
  case 2:
   if (lasttalk == 2) { RandomTalk ; return 1 ; }
   lasttalk = 2 ;	  
   Jack:
    "Meinst du der Chef freut sich?"
   John:
    "Aber sicher."
    "Da wartet garantiert eine fette {berraschung auf uns."
  case 3:
   if (lasttalk == 3) { RandomTalk ; return 1 ; }
   lasttalk = 3 ;	      
   John:
    "Ist der Ruf erst ruiniert, lebt sich's v[llig ungeniert. "
  case 4:
   if (lasttalk == 4) { RandomTalk ; return 1 ; } 
   lasttalk = 4 ;            
   John: 
    "Denkst du das gleiche wie ich?"
   Jack:
    "Ja, ich glaube schon..."
    delay(15) ;
   John:
    "HEHEHEHEHEHE..." 
   Jack:
    "HAHAHAHAHAHAHAHAHAHA!"
  case 5:
   if (lasttalk == 5) { RandomTalk ; return 1 ; } 
   lasttalk = 5 ;            
   Jack: 
    "Meinst du es regnet heute noch?"
    delay(10) ;
   John:
    "Hoffentlich nicht."  

  case 6:
   static int s6 = false ;
   if ((lasttalk == 6) or (tc < 5) or (s6)) { RandomTalk ; return 1 ; } 
   s6 = true ;
   lasttalk = 6 ;            
   John: 
    "Bald ist es soweit."
    delay(10) ;
   John:
    "Hast du schon gepackt?" 
   Jack:
    "Nein."
    "Aber ich habe mir einen Spaten besorgt." 
   John:
    "Einen Klappspaten?"
   Jack: "Ja."
   John:
    "Ich mir auch."
   John:
    "HEHEHEHEHEHE..." 
   Jack:
    "HAHAHAHAHAHAHAHAHAHA!"
  case 7: 
   static int s7 = false ;
   if ((lasttalk == 7) or (tc < 5) or (s7)) { RandomTalk ; return 1 ; } 
   s7 = true ;
   lasttalk = 7 ;            
   Jack: 
    "Das Paket ist gestern eingetroffen." 
   John:
    "Ausgezeichnet."
    delay(15) ;
   Jack:
    "Darf ich die Briefmarke behalten?"
    "Die wird bald eine Menge wert sein."
   John:
    "Nein, darfst du nicht."   
  case 8: 
   static int s8 = false ;
   if ((lasttalk == 8) or (tc < 5) or (s8)) { RandomTalk ; return 1 ; } 
   s8 = true ;
   lasttalk = 8 ;            
   Jack: 
    "Hat sich unser Kontaktmann schon gemeldet?"
   John:
    "Nein."
  case 9:
   static int s9 = false ;
   if ((lasttalk == 9) or (tc < 5) or (s9)) { RandomTalk ; return 1 ; } 
   s9 = true ;
   lasttalk = 9 ;            
   Jack: 
    "Meinst du, jemand wird versuchen, uns aufzuhalten?"
   John:
    "Unsinn."
  }
 tc++ ;
 return 1 ;
}

/* ************************************************************* */

object Eingang {
 setClickArea(0,275,110,333) ;
 absolute = false ;
 clickable = true ;
 enabled = (TalkedToWonciek) and (EscapedEchnaton == 0) ;
 visible = false ;
 name = "Eingang" ;
}

event WalkTo -> Eingang {
 clearAction ;
 Ego:
  walk(124,350) ;
 suspend ;
  pathAutoScale = false ;
  path = 0 ;
  walk (100, 390) ;
  walk (24, 420) ;
 forceHideInventory ;  
 InterruptCaptions ;
 doEnter(Grabeingang) ;
}

/* ************************************************************* */

object Fass {
 setClickArea(125,191,158,229);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fass" ;
}

event WalkTo -> Fass {
 clearAction ;
 Ego:
  walk(154,251) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Fass {
 Ego:
  walk(154,251) ;
  turn(DIR_NORTH) ;
 EgoUse ;
  "Ein leeres Fass."
 clearAction ;	
}

/* ************************************************************* */

object AufkleberUnten { 
 if (Aufkleber.getField(0) == 2) setAnim(Aufkleber2_image) ; else setAnim(Aufkleber_image) ;
 setPosition(390,215) ;
 absolute = false ;
 clickable = false ;
 enabled = (Aufkleber.getField(0) != 0) ;
 visible = (Aufkleber.getField(0) != 0) ;
}

object Aufkleber { 
 setClickArea(393,214,439,242) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Aufkleber" ;
}

event WalkTo -> Aufkleber {
 TriggerObjectOnObjectEvent(WalkTo, Kiste) ;
}

event LookAt -> Aufkleber {
 Ego:
  walk(414,267) ;
  turn(DIR_NORTH) ;
  
 switch (Aufkleber.getField(0)) {
  case 0: 

    "Hier ist etwas ]berklebt worden. Ein Schriftzug oder sowas."
    "Beim Abl[sen des Aufklebers sollte ich vorsichtig sein, um nichts zu besch#digen."  
  case 1:
    "Auf dem Aufkleber steht:"
    delay 4 ;
    "PROPERTY OF SAMTEC"
    delay 4 ;
    "Al Gaish Street 46"
    if (! KnowsHeadQuarters) { 
     delay 4 ;	
     "SamTec? Vielleicht wissen die, wo Wonciek steckt."
     delay 4 ;
     "Ich sollte ihnen mal einen Besuch abstatten."    
     KnowsHeadQuarters = true ;
    }
  case 2:
    "Da ich den Aufkleber ungeschickt abgerissen habe..."
    "...kann ich nur 'SAMTEC' lesen."
    if (! KnowsSamTec) {
     "Vielleicht wissen die, wo Wonciek steckt."
     "Ich sollte die Adresse von SamTec herausfinden."
     if (! KnowsInfoNr) say("Und dazu die Nummer der Auskunft, wenn es sowas hier gibt.") ;
      else say("Und dabei kann mir sicher die Auskunft weiterhelfen.") ;
     KnowsSamTec = true ;
    }
 }
 clearAction ;
}

event Pull -> Aufkleber {
 triggerObjectOnObjectEvent(Take, Aufkleber) ;
}
event Take -> Aufkleber {
 Ego:
  walk(414,267) ;
  turn(DIR_NORTH) ;
  if (! Aufkleber.getField(0)) {
    "Auch wenn ich dadurch den Schriftzug auf dem unteren Aufkleber unlesbar machen k[nnte..."
    "...einen Versuch ist es wert."
    delay 2 ;
    EgoStartUse ;
    delay 3 ;
    start soundBoxPlay(Music::Abreissen_wav) ;
    Aufkleber.setField(0,2) ;
    AufkleberUnten.setAnim(Aufkleber2_image) ;
    AufkleberUnten.visible = true ;
    AufkleberUnten.enabled = true ;
    EgoStopUse ;      
    delay 4 ;
    "Schade. Aber wenigstens kann man noch etwas davon lesen."
  } else {
    say "Lieber nicht." ;
  }
 clearAction ;
}

event PetrolCan -> Aufkleber {
  Ego:	
 if (did(Give)) {
   "Ich w]sste nicht, wie mir das weiterhelfen k[nnte."
   clearAction ;
 } else {
  if (Aufkleber.getField(0) == 0) {
    walk(414,267) ;
    turn(DIR_NORTH) ;
    "Das k[nnte funktionieren..."
    delay 4 ;
    EgoStartUse ;
    start soundBoxPlay(Music::Abreissen_wav) ;
    Aufkleber.setField(0,true) ;
    AufkleberUnten.visible = true ;
    AufkleberUnten.enabled = true ;
    EgoStopUse ;    
  } else if (Aufkleber.getField(0) == 2) {
    walk(414,267) ;
    turn(DIR_NORTH) ;
    "Dazu ist es jetzt leider zu sp#t."
  } else {
    walk(414,267) ;
    turn(DIR_NORTH) ;
    "Ich habe den anderen Aufkleber bereits entfernt."	      
  }
  delay 4 ;
  clearAction ;
 }
}
/* ************************************************************* */

object Kiste {
 setClickArea(376,186,452,250) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kiste" ;
}

event WalkTo -> Kiste {
 clearAction ;
 Ego:
  walk(414,267) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Kiste {
 Ego:
  walk(414,267) ;
  turn(DIR_NORTH) ;
  "Eine Kiste mit einem Aufkleber auf einer Seite."
  "Der Deckel der Kiste ist zugenagelt."	
 clearAction ;
}

event Open -> Kiste {
 Ego:
  walk(414,267) ;
  turn(DIR_NORTH) ;
  "Der Deckel der Kiste ist zugenagelt."	  
 clearAction ;	
}

event Pull -> Kiste {
 triggerObjectOnObjectEvent(Push, Kiste) ;
}

event Push -> Kiste {
 Ego:
  walk(414,267) ;
  turn(DIR_NORTH) ;
  "Die Kiste durch die Gegend zu schieben hilft mir auch nicht weiter."	  
 clearAction ;		
}

/* ************************************************************* */

object Holz1 {
 setClickArea(114,249,380,339);
 absolute = false ;
 clickable = true ;
 enabled = (! TalkedToWonciek) and (EscapedEchnaton == 0) ;
 visible = false ;
 name = "Holzabdeckung" ;
}

event WalkTo -> Holz1 {
 clearAction ;
 if (EscapedEchnaton != 2) {;
 Ego:
  walk(392,308) ;
  turn(DIR_WEST) ;
 } 
}

event LookAt -> Holz1 {
 Ego:
 if (EscapedEchnaton != 2) { walk(392,308) ; turn(DIR_WEST) ; }
 "Die Holzabdeckung soll wahrscheinlich Besucher davon abhalten..."	
 "...die Ausgrabungsstelle zu betreten."
  if (EscapedEchnaton == 2) Ego.say("Oder in meinem Fall sie wieder zu verlassen...") ;
 clearAction ;
}

event Open -> Holz1 {
 Ego:
 if (EscapedEchnaton != 2) { 
  walk(392,308) ; 
  turn(DIR_WEST) ;
  "Unm[glich."
  "Selbst wenn ich Werkzeug h#tte, w]rde das eine Zeit lang dauern."
 } else {
  soundBoxPlay(Music::DoorKnock_wav) ;
  delay(10) ;
  "Ich sehe keine M[glichkeit die Holzabdeckung von hier unten zu [ffnen."
 }	 
 clearAction ;
}

event cactus -> Holz1 {
 Ego:
 "Ich bef]rchte, nicht einmal Oscar schafft es, diese Abdeckung zu [ffnen."
 clearAction ;
} 

event Screw -> Holz1 {
 Ego:
 "Ich denke es bringt mich nicht weiter das Holz auch noch festzuschrauben..."
 clearAction ;
} 

event HotelKey -> Holz1 {
 Ego:
 "Leider befindet sich kein Schlo} an der Holzabdeckung..."
 clearAction ;
} 

event MasterKey -> Holz1 {
 Ego:
 "Nicht einmal der Generalschl]ssel vermag diese Holzabdeckung zu [ffnen.."
 clearAction ;
} 

event Shoe -> Holz1 {
 Ego:
  static int first = true ;
  if (John.enabled) and (first) {
   first = false ;
   "Hallo da oben!"
   "Ich habe einen Schuh gefunden..."
   "...wenn sie mich rauslassen, k[nnen Sie ihn haben."
   John: "Netter Versuch Herr Hobler."
  } else {
   "Das bringt mich nicht weiter."
  } 
 clearAction ;
} 

event PetrolCan -> Holz1 {
 Ego:
  "Nicht alle Probleme kann man durch ein vors#tzlich gelegtes Feuer l[sen..."
 clearAction ;
} 

event TalkTo -> Holz1 {
 Ego:
  "Es macht keinen Sinn mit Holz zu diskutieren,..."
  "...es ist von Natur aus sehr sehr unnachgiebig."
 clearAction ;
} 

event Push -> Holz1 {
 Ego:
  "Sie wird nicht nachgeben."  
 clearAction ;
}

event Screwdriver -> Holz1 {
 Ego:
  "Erstens ist die Holzabdeckung vernagelt und nicht verschraubt..."
  "...und zweitens bin ich hier unten und die Nagelk[pfe dort oben."
 clearAction ;
} 

event EchKey -> Holz1 {
 Ego:
  "Auch dieser wertvolle Schl]ssel bringt mich hier nicht weiter."
 clearAction ;
}

event Rod -> Holz1 {
 Ego:
  "Selbst mit der Stange als Hebel gelingt es mir nicht..."
  "...die festgenagelte Holzabdeckung anzuheben."
 clearAction ; 
} 

event AbsperrStange -> Holz1 { TriggerObjectOnObjectEvent(Rod,Holz1); }

event Stone -> Holz1 {
 Ego:
  "Der Stein ist viel zu klein um eine Wirkung zu erzielen."
 clearAction ; 
} 

/* ************************************************************* */

object Holz2 {
 setClickArea(1,269,115,339);
 absolute = false ;
 clickable = true ;
 enabled = (! TalkedToWonciek) and (EscapedEchnaton == 0) ;
 visible = false ;
 name = "Holzabdeckung" ;
}

event WalkTo -> Holz2 {
 if (EscapedEchnaton == 2) {
  delay 30 ;
  Jack.enabled = false ;
  John.enabled = false ;
  InterruptCaptions ;
  doEnter(Grabeingang) ;
  return ;
 } 
 clearAction ;
 Ego:
  walk(392,308) ;
  turn(DIR_WEST) ;
}

event LookAt -> Holz2 {
 if (EscapedEchnaton == 2) { Ego.say("Hier geht es zur]ck ins Grab."); } else triggerObjectOnObjectEvent(LookAt, Holz1) ;
 clearAction ;
}

event Open -> Holz2 {
 if (EscapedEchnaton != 2) triggerObjectOnObjectEvent(Open, Holz1) ;
}


/* ************************************************************* */

object ZumTruck {
 setClickArea(577,202,640,368);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Zur]ck zum Truck" ;
}

event WalkTo -> ZumTruck {
 clearAction ;
 Ego.walk(610,287) ;
  
 if (CurrentAct == 3) {
  Ego.turn(DIR_WEST) ;
  delay 5 ;
  Ego.say("Ich sollte mich erstmal im Grab umsehen.") ;
  return ;
 }  
  
 suspend ;
 Ego:
  path = 0 ;
  pathAutoScale = false ;
  scale = 700 ;
  walk(750,287) ;
  pathAutoScale = true ;
 doEnter(Leer) ;  
}

/* ************************************************************* */

object Steinhaufen {
 setClickArea(158,166,339,227);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Steinhaufen" ;
}

event WalkTo -> Steinhaufen {
 clearAction ;
 Ego:
  walk(270,240) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Steinhaufen {
 Ego:
  walk(270,240) ;
  turn(DIR_NORTH) ;
  "Hier wurden Sand und Steine angeh#uft."
  "Vermutlich wurde an der Stelle, an der sich..."
  "...jetzt die Holzabdeckung befindet, gegraben."
 clearAction ;	
}

/* ************************************************************* */

object Schild {
 setClickArea(42,154,111,192);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

event WalkTo -> Schild {
 clearAction ;
 Ego:
  walk(80,258) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Schild {
 Ego:
  walk(80,258) ;
  turn(DIR_NORTH) ;
  "Ein Schild mit einem Totenkopf und den W[rtern 'Nicht betreten'."
  "Das Wort 'Nicht' ist unterstrichen."
 clearAction ;	
}

event Take -> Schild {
 Ego:
  walk(80,258) ;
  turn(DIR_NORTH) ;
  "Ich will das Schild nicht mit mir herumtragen."
 clearAction ;
}

/* ************************************************************* */

script AD1 {
 var AD = 0 ;
		
 loop {
  Ego:
   addChoiceEchoEx(1, "Wer sind Sie?", false) if (!AD.bit[0]) ;
   addChoiceEchoEx(2, "Haben Sie mich mit Absicht hier unten eingesperrt?", false) if (!AD.bit[1]) ;
   addChoiceEchoEx(3, "|ffnen Sie die Abdeckung! Sofort!", false) if (!AD.bit[2]) ;
   addChoiceEchoEx(4, "F]r wen arbeiten Sie eigentlich?", false) if (!AD.bit[3]) ;
   addChoiceEchoEx(5, "Sie werden noch von mir h[ren.",false) if ((AD.bit[0]) and (AD.bit[1]) and (AD.bit[2]) and (AD.bit[3])) ;
   
  var c = dialogEx () ;

  
  switch c {
   case 1: 
    AD.bit[0] = true ;
    Ego: "Wer sind Sie?"
    John: "John Jackson."    
    Jack: "Und Jack Johnson."
    John: "Stets zu Ihren Diensten."
    Ego: "Haben Sie nicht mein Haus in die Luft gesprengt?"
    delay 2 ;
    John: "Yep."
    delay 10 ;
    Ego: "Warum machen Sie sowas?"
    John: "Berufsgeheimnis."    
   case 2:
    AD.bit[1] = true ;
    Ego: "Haben Sie mich etwa mit Absicht hier unten eingesperrt?"
    John: "Darauf k[nnen Sie wetten."
   case 3:
    AD.bit[2] = true ;	   
    Ego: "|ffnen Sie die Abdeckung! Sofort!"
    John: "Nein!"
    AD2 ;
   case 4:
    AD.bit[3] = true ;	   
    Ego: "F]r wen arbeiten Sie?"
    John: "Wir sind nicht hier, um Ihnen Fragen zu beantworten."
	  "Wir wollen Sie aus dem Weg schaffen."
	  "Und jetzt benehmen Sie sich bitte wie ein anst#ndiges Opfer."
   case 5:
    Ego: "Sie werden noch von mir h[ren."    
    John: "Das wage ich zu bezweifeln."
    Jack: "HEHEHEHEHE..."
    delay 10 ;
    Ego: "Hier komme ich wohl nicht weiter."
    return ;
  }
  
 }
	
}

script AD2 {
	
 loop {
  Ego:
   addChoiceEchoEx(1, "Doch!", false) ;
   addChoiceEchoEx(2, "Doch! Oder Ihnen wird es noch verdammt Leid tun!", false) ;
   addChoiceEchoEx(3, "Also gut...", false) ;
   
  var c = dialogEx() ;
  
  switch c {
   case 1:
    Ego: "Doch!"
    John: "Nein!"
   case 2:
    Ego: "Doch! Oder Ihnen wird es noch verdammt Leid tun!"
    John: "Wollen Sie uns etwa drohen?"    
    John: "Das sollten Sie sich momentan wirklich verkneifen."    
   case 3:
    Ego: "Also gut..."
    
    return ;
  }
  
 }
}


