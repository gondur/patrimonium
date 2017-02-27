// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
		
 backgroundImage = truck_image ;
 backgroundZBuffer = truck_zbuffer ;
 forceShowInventory ;
 pathAutoScale = true ;
  
 Ego:
 
 if (previousScene == Leer) {
   positionX = 370 ;
   positionY = 256 ;
   face(DIR_SOUTH) ;
   visible = true ;
   path = truck_path  ;
   delay transitionTime ;
 } else {
   scrollX = 700-320 ;
   path = 0 ;
   pathAutoScale = false ;
   positionX = 700 ;
   positionY = 500 ;
   visible = true ;
   scale = 900 ;
   face(DIR_NORTH) ;
   delay transitionTime ;
   walk(610,330);   
   path = truck_path  ;
   pathAutoScale = true ;
 }
 
 StanHutAb ;
 start animateStan ;
 
 clearAction ;  
 start {
  
  jukeBox_Stop ;
  jukeBox_Enqueue(Music::BG_Desertcity_mp3) ;
  delay 23 ;	   
  jukeBox_shuffle(true) ;
  jukeBox_Start ;
 }
 
}

/* ************************************************************* */

object BlueTruck {
 class = StdEventObject ;
 StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Blauer Lastwagen" ;
 setClickArea(0,70,320,320) ;
} 

event animate BlueTruck {
 var z = GetZBufferPriority(truck_zbuffer, MouseX+ScrollX, MouseY+ScrollY) ;
 Sun.clickable = (Z != 0) ;
 Bones.clickable = (Z != 0) ; 
 Skull.clickable = Bones.clickable ;
 GreenTruck.clickable = (Z != 0) ;
 Mountains.clickable = (Z == 2) and (ObjectUnderMouse != SalesMan) ; 
 BlueTruck.clickable = (Z > 30)  ;
 Hut.clickable = (Z < 37) and (Z > 2) ;
 Sign.clickable = (Z > 37) ;
}

event Take -> BlueTruck {
 triggerObjectOnObjectEvent(Open, BlueTruck) ;
}

event Use -> BlueTruck {
 Ego: 
 if (currentAct==4) {
  say("Ich muss nicht mehr zur]ck zur Ausgrabungsstelle.") ;
  clearAction ;
  return ;
 }
 if (hasTruck) {
  "Ich nehme den Gr]nen."
  walk(370,256) ;
  turn(DIR_EAST) ;
  EgoStartUse ;    
  doEnter(Leer) ;
 } else {
  turn(DIR_SOUTH) ;
  "Da h#tte der Besitzer sicherlich etwas dagegen."
  clearAction ;
 }
}

event Open -> Bluetruck {
 Ego:
  walk(340,280) ;
  turn(DIR_WEST) ;  
 if (!hasTruck) say("Der geh[rt mir doch nicht mal!") ;
  else say("Ich habe den Gr]nen gemietet.") ;
 clearAction ;
}

event WalkTo -> BlueTruck {
 clearAction ;
 Ego: 
  walk(340,280) ;
  turn(DIR_WEST) ; 
}

event LookAt -> BlueTruck {
 Ego: 
  walk(340,280) ;
  turn(DIR_WEST) ;
  "Ein blauer Truck."
 if (!hastruck) "Genau sowas br#uchte ich jetzt."
 clearAction ;
} 

event Battery -> BlueTruck {
 clearAction ;
 Ego:
  walk(340,280) ;
  turn(DIR_WEST) ;
  say("Dieser Truck hat schon eine Batterie.") ;
}

/* ************************************************************* */

object Motorhaube {
 setupAsStdEventObject(Motorhaube,Open,487,277,DIR_NORTH) ;		
 setClickArea(422,174,526,191) ;
 absolute = false ;
 clickable = true ;
 enabled = (currentAct==4) and (needsBattery) ;
 visible = false ;
 name = "Motorhaube" ;
}

event LookAt -> Motorhaube {
 Ego:
  walkToStdEventObject(Motorhaube) ;
  say("Die Motorhaube meines Trucks.") ;	
}

event Use -> Motorhaube {
 triggerObjectOnObjectEvent(Open, Motorhaube) ;
}

static var tookBat = false ;

event Open -> Motorhaube {
 Ego:
  walkToStdEventObject(Motorhaube) ;
 if (hasItem(Ego, Battery) or (tookBat)) {
  say("Ich brauche hier nichts mehr.") ;
  clearAction ;
  return ;
 }
 suspend ;
 delay 3 ;
 EgoStartUse ;
 soundBoxPlay(Music::Motorauf_wav) ;
 MotorhaubeGra.enabled = true ;
 delay 3 ;
 EgoStopUse ;
 delay 5 ;  
 delay 15 ;
  say("Die Autobatterie k[nnte mir weiterhelfen.") ;
 delay 5 ;
  turn(DIR_EAST) ;
 delay 3 ;
  say("H#tten Sie was dagegen, wenn ich mir kurz die Autobatterie ausborge?") ;
 delay 5 ;
 salesman.say("Nein, bedienen Sie sich!") ;
 salesman.say("Die Zufriedenheit unserer Kunden wird bei uns gro} geschrieben.") ;
 salesman.say("Vergessen Sie aber nicht, sie wieder zur]ckzubringen.") ;
 salesman.say("Sie haben den Truck nur geliehen!" ) ;
 salesman.say("Bei uns wird auch die Zufriedenheit unserer n#chsten Kunden gro}geschrieben." ) ;
 delay 5 ;
  turn(DIR_NORTH) ;
 EgoStartUse ;
 takeItem(Ego, Battery) ;
 tookBat = true ;
 EgoStopUse ;
 delay 7 ;
 EgoStartUse ;
 soundBoxStart(Music::Motorzu_wav) ;
 MotorhaubeGra.enabled = false ;
 EgoStopUse ;
 delay 2;
 clearAction ;
}

object MotorhaubeGra {
 setPosition(414,146) ;
 setAnim(Truckoffen_image) ;
 absolute = false ;
 clickable = false ; 
 visible = true ;
 enabled = false ;
 priority = 29 ;
}

/* ************************************************************* */

object GreenTruck {
 class = StdEventObject ;
 if (hasTruck) StdEvent = Use ;
  else StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Gr]ner Lastwagen" ;
 setClickArea(345,96,550,265) ;
} 

event WalkTo -> GreenTruck {
 clearAction ;
 Ego: 
  walk(370,256) ; 
  turn(DIR_EAST) ;	
}

event Battery -> GreenTruck {
 clearAction ;
 Ego:
  walk(370,256) ;
  turn(DIR_WEST) ;
  say("Ich habe die Batterie doch nicht erst hier ausgebaut um sie jetzt wieder einzubauen.") ;
}

event Open -> GreenTruck {
 triggerObjectOnObjectEvent(Use, GreenTruck) ;
}

event Use -> GreenTruck {
 Ego: 
 if (currentAct==4) {
  say("Ich muss nicht mehr zur]ck zur Ausgrabungsstelle.") ;
  clearAction ;
  return ;
 } 
 if (hasTruck) {
  walk(370,256) ;
  turn(DIR_EAST) ;
  EgoStartUse ;  
  doEnter(Leer) ;
 } else {
  turn(DIR_SOUTH) ;
  "Da h#tte der Besitzer sicherlich etwas dagegen."
  clearAction ;
 }
}

event LookAt -> GreenTruck {
 Ego: 
  walk(370,256) ;
  turn(DIR_EAST) ; 
  "Ein gr]ner Truck."
 if (! hastruck) say("Genau sowas br#uchte ich jetzt.") ;
  else say("Mein gr]ner Truck.") ;
 clearAction ;
} 

/* ************************************************************* */

object Mountains {
 class = StdEventObject ;
 StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Bergkette" ;
 setClickArea(218,0,944,190) ;	
}

event LookAt -> Mountains {
 Ego: turn(DIR_NORTH) ;
      "In der Ferne kann ich eine langgestreckte Bergkette erkennen."
 clearAction ;
} 

/* ************************************************************* */

object Sun {
 class = StdEventObject ;
 StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Sonne" ;
 setClickArea(743,0,800,21) ;	
}

event LookAt -> Sun {
 Ego: 
 turn (DIR_NORTH) ;
 "Die Hitze hier ist unertr#glich."
 clearAction ;
}

event TalkTo -> Sun {
 Ego: 
  turn (DIR_NORTH) ;
 suspend ;
  "HALLO DA OBEN!"
 delay 6 ;
 clearAction ;
}

/* ************************************************************* */

object Hut {
 class = StdEventObject ;
 StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Laden" ;
 setClickArea(623,69,822,287) ;
} 

event WalkTo -> Hut {
 clearAction ;
 Ego:
  walk(626,253) ;
  turn(DIR_EAST) ;
}

event LookAt -> Hut {
 Ego: 
  walk(626,253) ;
  turn(DIR_EAST) ; 
  "Sieht aus wie eine heruntergekommene W]rstchenbude."
 if (!knowspurpose) "Der Mann ist vielleicht eine Art H#ndler."
 clearAction ;
} 

/* ************************************************************* */

object Salesman {
 class = StdEventObject ;
 StdEvent = TalkTo ;
 setAnim(Stan_sprite) ;
 autoAnimate = false ;
 frame = 11 ;
 setClickArea(0,0,92,181) ;
 setPosition(545,84) ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 CaptionColor = COLOR_STAN ;
 captionY = 0 ;
 captionX = 46 ;
 captionWidth = 500 ;	 
 name = "Verk#ufer" ;	
}

script StanHutAb {
 Salesman:
 frame = 11 ;
 delay 3 ;
 frame = 6 ;
 delay 2 ;
 frame++ ;
 delay 2 ;
 frame++ ;
 delay 2 ;
 frame++ ;
 delay 2 ;
 frame++ ;
 delay 2 ;
 frame = 0 ;
}

script AnimateStan {
 activeObject = Salesman ;
 killOnExit = true ;
 loop {
  if animMode == ANIM_STOP {
   if (frame > 2) frame = 0 ;
   if (random(15) == 0) {
    if (frame == 0) frame = 1 ;
     else frame = 0 ;
    if (animMode == ANIM_STOP) delay 5 ;
   } 
   if (animMode == ANIM_STOP) delay random(10)+5 ;
   if (random(4) == 0 and frame == 1) {
    frame++ ;
    delay 2 ;
    frame-- ;
   }
   if (animMode == ANIM_STOP) delay random(10)+5 ;
  } else if (animMode == ANIM_TALK) {
    frame = random(3)+3 ;   
   delay 1 ;
  }
  delay ;
 }
}

event WalkTo -> Salesman {
 clearAction ;
 Ego: 
  walk(572,262) ;
  turn(DIR_NORTH) ;
}

static int knowspurpose = false ;

static int bankruptcy = false ;

event Klappspaten -> Salesman {
 Ego: walk(572,262) ;
      turn(DIR_NORTH) ;
 Ego.say("Hallo nochmal.") ;	
 Ego.say("Was halten Sie von 'Operation Klappspaten'?") ;
 EgoStartUse ;
 dropItem(Ego, Klappspaten) ;
 delay 19 ;
 takeItem(Ego, Klappspaten) ;
 EgoStopUse ;
 Salesman.say("Genial!") ;
 Salesman.say("Wann soll es denn losgehen?") ;
 delay 2 ;
 Ego.say("Wenn die Zeit reif ist.") ;
 clearAction ;
}

event TalkTo -> Salesman {
 
 Ego: walk(572,262) ;
      turn(DIR_NORTH) ;
 Ego: "Hallo!"
 Salesman: "Salam Effendi."
           "Womit kann ich dienen?"
 if (currentAct==2) DiaAct2 ;
  else DiaAct4 ;
	  
 clearAction ;
} 

script DiaAct4 {
 static var infoNoseglasses = false ;
 static var askedAgents = false ;
 static var askedHappening = false ;
 static var askedSuriza = false ;
 static var askedBattery = false ;
 loop {
  addChoiceEchoEx(1, "Hat sich etwas getan w#hrend ich weg war?", true) if (!askedHappening) ;
  addChoiceEchoEx(2, "Haben Sie zwei Schr#nke in Anz]gen gesehen?", true) if (!askedAgents) ;
  addChoiceEchoEx(3, "Haben Sie eine Autobatterie?", true) if ((needsBattery) and (!hasItem(Ego, Battery)) and ((!askedBattery) or (!tookBat))) ;
  addChoiceEchoEx(4, "Haben Sie eine Nasenbrille?", true) if ((sawDrStrangelove) and (!hasItem(Ego, Nasenbrille))) ;
  addChoiceEchoEx(5, "Wissen Sie, wie man ein Stahl-Garagentor mit Drehstromantrieb knackt?", true) if ((!hasItem(Ego, Anleitung)) and (knowsSuriza) and (! surizasolved) and (! askedSuriza)) ;
  addChoiceEchoEx(6, "Ich gehe dann mal wieder.", true) ;
  
  var c = dialogEx ;
  
  switch c {
   case 1: Salesman: "Drei Strohballen wurden vorbeigeweht und zwei Geier sind vorbeigeflogen."
	             askedHappening = true ;
   case 2: Salesman: "Nein."
	             "Potenzielle Kunden?"
	   Ego: "Ich denke nicht."
	   askedAgents = true ;
   case 3: Salesman: "Ja, ich habe sogar mehrere."
	             "Warum nehmen Sie nicht die aus Ihrem Truck?"
	   Ego: "Gute Idee. Danke."
	   Salesman: "Vergessen Sie aber nicht, sie wieder zur]ckzubringen."
	             "Sie haben den Truck nur geliehen!"
	   askedBattery = true ;
   case 4: Salesman: "Nein."
	   if (infoNoseglasses==false) {
	     infoNoseglasses = true ;
	     Salesman: "Aber mein Bruder hatte einst ein Nasenbrillen-Gesch#ft."
	     Ego: "Hatte?"
	     Salesman: "Ja, mittlerweile verkauft er Kleinsche Flaschen."
           } else {
	     Salesman: "Immer noch nicht."
	               "Kann ich Sie vielleicht stattdessen f]r einen nagelneuen Keilriemen begeistern?"
	     Ego: "Vielleicht komme ich darauf zur]ck."
	   }
   case 5: Salesman: "Ich bin unschuldig! Ich habe mit der Sache nichts zu tun!"
	   Ego: "Mit welcher Sache?"
	   Salesman: "Sind Sie ein Schn]ffler?"
	   Ego: "Nein."
	   Salesman: "Also bitte, f]r wen halten Sie mich?"
	             "F]r einen Kriminellen?"
		     "Ich kann Ihnen da leider nicht weiterhelfen..."
	   askedSuriza = true ;
   case 6: Salesman: "Fein."
	   return ;
  }
 }
}

script DiaAct2 {	
 static int knowsskeleton = false ;	
 loop {
 AddChoiceEchoEx(1, "Was machen Sie hier?", false) unless (knowspurpose) ;
 AddChoiceEchoEx(2, "Ich m[chte einen Truck mieten.", false) unless (!knowspurpose) or (bankruptcy);
 AddChoiceEchoEx(3, "Nochmal wegen dem Preis f]r einen Truck...", false) unless (!bankruptcy) or (hastruck) ;
 AddChoiceEchoEx(4, "Warum steht auf dem Schild Kamelli?", false) unless (knowssign != 1) ;
 if ((KnowsInfoNr == false) and (KnowsSamTec == true) and (KnowsHeadQuarters == false)) 
  AddChoiceEchoEx(7, "Kennen Sie die Nummer der Auskunft?", false) ;
 else AddChoiceEchoEx(5, "Vor Ihnen liegt ein menschliches Skelett!", false) unless (knowsskeleton) ;
 AddChoiceEchoEx(6, "Ich gehe dann mal wieder.", false) ; 
 
 var c = dialogEx ;
 
 switch c {
  case 5 : Ego: "Vor Ihnen liegt ein menschliches Skelett!"
	   Salesman: "Ja."
	   Ego: "Warum denn das?"
	   Salesman: "Es soll Kunden anlocken."
	   Ego: "Warum sollte ein Skelett anziehend auf Kunden wirken?"
	   Salesman: "Es vermittelt deutlich, was die W]ste von Fussg#ngern h#lt."
	   Ego: "Oh."
	   knowsskeleton = true ;
  case 4 : Ego: "Warum steht auf dem Schild Kamelli?" ;
	   Salesman: "Das ist der Name meiner Firma."
	             "Kamelli."
	   Ego: "Kamelli h[rt sich f]r mich nach Kameltreiber an."
	   Salesman: "Ja."
	             "Das behaupten viele der ahnungslosen Touristen."
	   Ego: "Dann kl#ren Sie mich doch auf."
	   Salesman: "Nein."
	   knowssign = 2 ;
  case 1 : Ego: "Was machen Sie hier?"
	   Salesman: "Ich betreibe ein renommiertes Transportunternehmen."
	   Ego: int ld = Direction ;
	        turn(DIR_WEST) ;
	        delay(10) ;
	        turn(ld) ;
	       "Sie sprechen von den zwei Trucks hier?"
	   Salesman: "Exakt."
	   knowspurpose = true ;
  case 2 : Ego: "Ich m[chte einen Truck mieten." ;
	   Salesman: "Da sind Sie bei mir richtig."
	             "Die Firma Kamelli unterh#lt Lastfahrzeuge f]r alle Einsatzgebiete."
		     "F]r was ben[tigen Sie denn das Fahrzeug?"
	   Ego: "F]r eine Fahrt in die W]ste."
	   Salesman: "W]ste soll es sein?"
	             "Kein Problem."
		     "Nat]rlich fallen in diesem Fall extra Kosten an."
		     "Reservekanister, Spritzsch#den am Lack, Materialbeanspruchung, Ausfallrisiko..."
	   Ego:      "Ausfallrisiko?"
	   Salesman: "Vorschrift."
		     "Fahrten in die W]ste stellen ein erhebliches Risko dar."
	   Ego: "Wieviel wird mich das etwa kosten?"
	   Salesman: "20000 Pfund und das Baby geh[rt Ihnen."
	   Ego: "20000 Pfund ??"
	        "Soviel Geld besitze ich nicht!"
	   Salesman: "Ja, das dachte ich mir."
	             "Trotzdem nett mit Ihnen zu sprechen."
		     "Empfehlen Sie uns weiter."
	   
	   bankruptcy = true ;
	   canAskForTrucks = true ;
	   if (SalesMandialogEx2(false)) { clearAction ; return 0 ; }
   case 3: Ego: "Nochmal wegen dem Preis f]r einen Truck..." ;
	   Salesman: "Was ist damit?"
	   if (SalesMandialogEx2(false)) { clearAction ; return 0 ; }
   case 6: Ego: "Ich gehe dann mal wieder."
	   Salesman: "Bis sp#ter."
	   clearAction ;
	   return 0 ;  
   case 7: Ego: "Kennen Sie die Nummer der Auskunft?"
	   Salesman: "Nein, ich habe nichtmal ein Telefon."
  } 
 } 	
}

var GaveContract = false ;

event OptionContract -> Salesman {
 if (!bankruptcy) {
  Ego:  "Ich sehe keinen Grund, das aus der Hand zu geben."
 } else {
  gaveContract = true ;
  Ego: 
   walk(572,262) ;
   turn(DIR_NORTH) ;
   "Hallo!"
  Salesman: 
   "Salam Effendi."
   "Womit kann ich dienen?"
  Ego: "Ich m[chte nochmal ]ber den Preis verhandeln."
  Salesman: "Was k[nnen Sie mir denn anbieten?" 
  KnowsOptions = true ;
  SalesMandialogEx2(true) ;
  if (goingBusiness == 0) and (triedToFool) {
   Ego: walk(500,350) ;
   turn(DIR_SOUTH) ;
   "Der Kerl ist nicht leicht zu ]berzeugen."
   "Vielleicht sollte ich jemanden fragen, der sich damit auskennt." ;
   goingBusiness = 1 ;
  } 
 }
 clearAction ;
}


script diaFight {
  jukeBox_addIn(Music::BG_Fuell9_mp3,10) ;                     
  jukeBox_Shuffle(true) ;

  int won = (DiaQuest_Combat(Salesman,1) < MAXTREFFER) ;
  var res = 0 ;  
  

  if won {
    
    switch random(5) {
      case 0:  jukeBox_Addin(Music::BG_Dlose1_mp3,10) ; 
      case 1:  jukeBox_Addin(Music::BG_Dlose2_mp3,10) ; 
      case 2:  jukeBox_Addin(Music::BG_Dlose3_mp3,10) ; 
      case 3:  jukeBox_Addin(Music::BG_Dlose4_mp3,10) ; 
      default: jukeBox_Addin(Music::BG_Dlose5_mp3,10) ; 
    }
    delay 3 ;
    start {
	    delay while (GetMusicPosition(jukeBox.CurRes) < GetDuration(jukeBox.CurRes)) ;
	    jukeBox_Stop ;
            jukeBox_Enqueue(Music::BG_Desertcity_mp3) ;
            jukeBox_Shuffle(true) ;
	    jukeBox_Start ;
    }
    
    
    Salesman: "Scheren Sie sich doch zum Teufel mit ihren Optionen." ; 
    res = 0 ;
  } else {
    jukeBox_addIn(Music::BG_Dwin_mp3,10) ;                     	  
    delay 3 ;
    start {
	delay while (GetMusicPosition(jukeBox.CurRes) < GetDuration(jukeBox.CurRes)) ;
	jukeBox_Stop ;
        jukeBox_Enqueue(Music::BG_Desertcity_mp3) ;
        jukeBox_Shuffle(true) ;
	jukeBox_Start ;
    }
    
    Salesman: 
     "Das ist ja fabelhaft!"
     "Junger Mann, Sie haben ihren Truck."
     "Nehmen Sie den Gr]nen, der Blaue verreckt Ihnen nach 20 Kilometern."
     "Hier ist noch ein Reservekanister f]r die W]ste."
     "Sie werden ihn brauchen."
    takeItem(Ego, petrolcan) ;
     "Wiederbef]llung bei R]ckgabe auf Kosten der Mieters versteht sich."
     "Nun, wo muss ich unterschreiben?"
    Ego: 
     "Gleich hier."
     "Ich habe extra einen individuellen Vertrag f]r Sie vorbereitet..." ;
    dropItem(Ego, OptionContract) ;
    dropItem(Ego, OptionPen) ;
    hasTruck = true ;
    Salesman: 
     "Wunderbar."
     "Gute Fahrt!"
    Ego: 
     "Danke." ;
    res = 1 ;
  } 	
  
  return res ;
}

int triedtofool = false ; 

script SalesMandialogEx2(takefirst) {
loop {
	    if (!takefirst) {
	     if (gavecontract) and (knowsoptions) {
	      AddChoiceEchoEx(0, "Ich biete Ihnen eine Gratisoption gegen einen Truck.", false) unless (triedtofool) ;
	      AddChoiceEchoEx(1, "{berlegen Sie sich das Angebot mit der Option nochmal!", false) unless (!triedtofool) ;
             }
	     AddChoiceEchoEx(2, "Geht es denn nicht etwas billiger?", false) ;
             AddChoiceEchoEx(3, "Gibt es nicht etwas anderes, das Sie gerne h#tten?", false) ;
	     AddChoiceEchoEx(4, "Ich kann auch woanders kaufen!", false) ;
	     AddChoiceEchoEx(5, "Dann vergessen Sie es mit Ihrem Truck!", false) ;
	    
	     var d = dialogEx ;
            } else {
	     if (triedtofool) { d = 1; } else { d = 0; }
	     takefirst = false ;
	    } 

	    
	    switch d {
	     case 0: Ego: "Ich biete Ihnen eine Gratisoption gegen einen Truck." 
		     Salesman: "Was ist denn bitte eine Option?"
		     Ego: "Die Geldanlage der Zukunft!"
		          "Sie investieren ihr Geld in die #gyptischen Kultursch#tze."
			  "Das ist gut f]r Sie und gut f]r das Land."
		     Salesman: "Sie haben meine Frage nicht beantwortet."
		     Ego: "Nun ja."
		          "Eine Option ist eine Art Besitzurkunde."
			  "Sie erkaufen sich ein kulturelles Artefakt wie die Nase der Sphinx..."
			  "... und nach einer kurzen Bearbeitungsphase wird das Artefakt an Sie geliefert."
			  "Bis vor die Haust]r."
		     Salesman: "Ich besitze kein Haus."
		     Ego: "Das macht nichts."
		     Salesman: "Also dazu h#tte ich doch noch ein paar Fragen."
		     triedtofool = true ;
		     
		     if (diaFight) return 1 ;
		     	   
	     case 1 : Ego: "{berlegen Sie sich das mit der Option nochmal." ;
		      static var foolAgain = false ;
		      if (!foolAgain) {
		        Salesman: "Option?"
		                  "Achso, ja."
			  	  "Die Geldanlage."
                                  "Ihre Argumente sind nicht ]berzeugend."
		        Ego: "Vielleicht habe ich mich das letzte mal etwas unklar ausgedr]ckt."
		             "Lassen Sie es sich bitte nochmal durch den Kopf gehen."
		        Salesman: "Nun gut, aber..."
			foolAgain = true ;
		      } else Salesman.say("Also gut...") ;

                     if (diaFight) return 1 ;
		     
	     case 2: Ego: "Geht es denn nicht etwas billiger?"
		     Salesman: "Nat]rlich k[nnen wir um das eine oder andere Pfund verhandeln."
		               "Wieviel w]rden Sie mir denn bieten?"
		     Ego: "So umgerechnet 20 Pfund?"
		     Salesman: "Hahahaha!"
		               "Sie sind ein Scherzbold, das merk ich schon."
                               "In diesem Fall muss ich leider noch eine Personenschadenversicherung auf den Preis aufschlagen."
		     Ego: "WAS?"
		     Salesman: "Nur ein Scherz meinerseits."
		     Ego: "K[nnen Sie mir nicht wenigstens etwas entgegen kommen?"
		     Salesman: "Gut, sagen wir 21000 Pfund!"
		     Ego: "Sie wollten mir doch entgegenkommen"
		     Salesman: "Nein."
             case 3: Ego: "Gibt es nicht etwas anderes, das Sie gerne h#tten?"
		     Salesman: "Eine staatliche Sofortrente?"
		     Ego: "Nein, etwas das ich Ihnen besorgen k[nnte im Gegenzug f]r einen Truck?"
		     Salesman: "Achso."
		               "Nein."
			       "Ich denke nicht, dass ich etwas will, das Sie mir beschaffen k[nnten."
	     case 4: Ego: "Ich kann auch woanders kaufen!"
		     Salesman: "Ach ja?"
			       "Wo denn?"
		     Ego: "Bei der Konkurrenz nat]rlich."
		     Salesman: "Oh."
		     delay(10) ;
		     Ego: "Wollen Sie nichts tun, um mich zu stoppen?"
		     Salesman: "Es gibt keine Konkurrenz."		     
	     case 5: Ego: "Dann vergessen Sie es mit Ihrem Truck!"
		     Salesman: "Schade."
		     return 0 ;
		     
	    }	
    }
} 

/* ************************************************************* */

object Sign {
 class = StdEventObject ;
 StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Schild" ;
 setClickArea(762,220,870,337) ;
} 

event WalkTo -> Sign {
 clearAction ;
 Ego:
  walk(790,345) ;
  turn(DIR_NORTH) ;
}

static int knowssign = 0 ;

event LookAt -> Sign {
 Ego: 
 walk(790,345) ;
 turn(DIR_NORTH) ;
      "Ein aufstellbares Werbeschild aus Plastik."
      "Es zeigt ein tanzendes Kamel, das wohl Kamelli heisst."
 turn(DIR_SOUTH) ;
 delay 5 ;
 if (knowspurpose) { 
  Ego: "Was f]r ein komischer Name." ; 
 } else { 
  if (knowssign == 2) { 
   Ego: "Der Mann leitet vielleicht einen Wanderzirkus."
        "Das w]rde auch die Trucks erkl#ren."
  } else { Ego: "Der Mann muss wohl so eine Art W]stendompteur sein." ; }
 }
 if (knowssign <= 0) knowssign = 1 ;
 clearAction ;
} 

/* ************************************************************* */

object Skull {
 class = StdEventObject ;
 StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Knochen" ;

 setClickArea(507,303,550,336) ;
} 

event WalkTo -> Skull {
 clearAction ;
 Ego:
  walk(650,340) ;
  turn(DIR_WEST) ;	
}

event LookAt -> Skull {
 static int FirstLook = true ;
 Ego: 
 walk(650,340) ;
 Face(DIR_WEST) ;
 if FirstLook {
  say("Wow!");
  say("Ein Sch#del und einige Rippen, die aus dem Sand ragen.");
  say("Und ich dachte sowas gibt's nur im Film.");
  Skull.name = "Sch#del" ; 
  Bones.name = "Rippen" ;
  FirstLook = false ;
 } else {
  Ego: "Sieht ziemlich abgemagert und tot aus."
 } 
  	 
 clearAction ;
} 

/* ************************************************************* */

object Bones {
 class = StdEventObject ;
 StdEvent = LookAt ;
 enabled = true ;
 visible = true ;
 clickable = true ;
 absolute = false ;
 name = "Knochen" ;

 setClickArea(548,236,585,347) ;
} 

event WalkTo -> Bones {
 triggerObjectOnObjectEvent(WalkTo, Skull) ;
}

event LookAt -> Bones {
 TriggerObjectOnObjectEvent(LookAt, Skull) ;
}

/* ************************************************************* */

object zurueck {
 setClickArea(610,323,944,360) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Taxi" ;
}

event Use -> zurueck {
 triggerObjectOnObjectEvent(walkTo, zurueck) ;
}

event Take -> zurueck {
 triggerObjectOnObjectEvent(walkTo, zurueck) ;
}

event WalkTo -> zurueck {
 clearAction ;
 Ego:
  walk(610,330) ;
  suspend ;
  path = 0 ;  
  pathAutoScale = false ;
  scale = 900 ;
  walk(700,550) ;
  pathAutoScale = true ;
 doEnter(Taxikarte) ;
}

