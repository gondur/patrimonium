// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

const MasterDelimiter = 50 ;
const AntwortenGesamt = 14 ;
const FesteAntworten = 4 ;
const MaxTreffer = 3 ;

int Gesagt[MaxTreffer] ;
var Fragen[AntwortenGesamt] ;
var Antworten[AntwortenGesamt] ;
var MeisterFragen[AntwortenGesamt] ;

object DiaQuest_Questions { enabled = false ; }
object DiaQuest_Responses { enabled = false ; }
object DiaQuest_UsedLines { enabled = false ; }

script SetupDiaQuest {
		
 MeisterFragen[0]  =  "Sind Sie sicher, dass der Verkauf von #gyptischem Kulturgut keine Proteste in der Bev[lkerung hervorrufen wird?" ;
 MeisterFragen[1]  =  "Eine Risiko-Kapitalanlage bei der derzeitigen konjunkturellen Lage?" ;
 MeisterFragen[2]  =  "Gew#hrleisten Sie mir auch jegliche, gesetzlich vorgeschriebene Garantieanspr]che?" ;
 MeisterFragen[3]  =  "Wollen Sie mich f]r dumm verkaufen?" ;
 MeisterFragen[4]  =  "Haben Sie eigentlich einen blassen Schimmer von dem, was Sie mir erz#hlen?" ;
 MeisterFragen[5]  =  "Ich kann das Kleingedruckte in Ihrem Vertrag nicht lesen." ;
 MeisterFragen[6]  =  "Also ich muss das ganze erstmal mit meiner Frau besprechen..." ;
 MeisterFragen[7]  =  "Sollte etwas schief gehen, werde ich Sie verklagen!" ;
 MeisterFragen[8]  =  "Und Sie behaupten wirklich, 100% Ihrer Kunden sind mit Ihnen zufrieden? Das f#llt mir schwer zu glauben!" ;
 MeisterFragen[9]  =  "Ich wei} nicht...au}erdem habe ich gerade keinen Stift dabei, um die Vertr#ge zu unterzeichnen..." ;

 
 Fragen[0]  =  "Ist das Artefakt im Falle eines Brandes auch f]r die Feuerwehr gut zu erreichen?" ;
 Fragen[1]  =  "Da kann ich das Geld doch gleich das Klo runtersp]len." ;
 Fragen[2]  =  "Wenn mein Hund meine Vertragspapiere aus Versehen ansabbert, bekomme ich dann neue?" ;
 Fragen[3]  =  "Aber ich kenne mich kein bi}chen mit #gyptischer Geschichte aus. Ich glaube das ist wirklich nichts f]r mich. " ;
 Fragen[4]  =  "Warum sollte ich eigentlich mit IHNEN Gesch#fte machen?" ;
 Fragen[5]  =  "Mir ist gerade noch etwas eingefallen, aber ich habe es vergessen." ;
 Fragen[6]  =  "Schicken Sie mir den Vertrag bitte zu, dass ich ihn mir alleine zuhause durchlesen kann." ;
 Fragen[7]  =  "Was passiert, wenn mein Artefakt auf dem Postweg verloren geht?" ;  
 Fragen[8]  =  "Mir scheint der Preis aber doch etwas ]berteuert!" ;
 Fragen[9]  =  "W]rden Sie auch noch ein attraktives Werbegeschenk hinzuf]gen?" ;
 
 Fragen[10] =  "Ich lasse mir die Sache noch mal durch den Kopf gehen." ;
 Fragen[11] =  "Ich komme sp#ter wieder." ;
 
 Antworten[0]  =  "Nein, aber Sie k[nnten auch Optionen am Assuan-Staudamm erwerben..." ;
 Antworten[1]  =  "Diese Artefakte haben Jahrtausende ]berdauert, und st#ndig an Wert gewonnen." ;
 Antworten[2]  =  "Sicher. Sie k[nnen Ihren Vertrag innerhalb von 24 Stunden gegen einen neuen umtauschen. Ein Leben lang!" ;
 Antworten[3]  =  "Im Gegenteil. Sie werden sehen, durch dieses Artefakt werden sich Ihre kulturellen Kenntnisse zwangsl#ufig vergr[}ern." ;
 Antworten[4]  =  "Ich bitte Sie, ich habe studiert..." ;
 Antworten[5]  =  "Dann kann es ja nicht so wichtig sein." ;
 Antworten[6]  =  "Kommen Sie, manchmal muss man eben kurzfristig selber Entscheidungen treffen, um im Leben Erfolg zu haben." ;
 Antworten[7]  =  "Das stellt kein Problem dar. F]r solche F#lle sind wir versichert." ;
 Antworten[8]  =  "Ich habe Ihnen doch noch gar keine konkreten Zahlen genannt..." ;
 Antworten[9]  =  "Kein Problem! Ich k[nnte Ihnen zum Beispiel einen attraktiven Kugelschreiber anbieten!"  ;
 
 Antworten[10] =  "Nun kaufen Sie schon!" ;
 Antworten[11] =  "Woher soll ich das wissen?" ;
 Antworten[12] =  "Da kann ich Ihnen leider auch nicht helfen." ; 
 Antworten[13] =  "K[nnten Sie die Frage nochmal wiederholen?" ; 

 SetupAsContainer(DiaQuest_Questions) ; // Bekannte Fragen
 SetupAsContainer(DiaQuest_Responses) ; // Bekannte Antworten
 SetupAsContainer(DiaQuest_UsedLines) ; // Temporärer Fragenspeicher
 
 AddToContainer(DiaQuest_Responses,10) ;
 AddToContainer(DiaQuest_Responses,11) ;
 AddToContainer(DiaQuest_Responses,12) ;
 AddToContainer(DiaQuest_Responses,13) ;  
 AddToContainer(DiaQuest_Questions,10) ;
 AddToContainer(DiaQuest_Questions,11) ;
}

var AskedMasterQuestion = 0 ;

script DiaQuest_PickQuestion(Opponent) {
 ResetdialogEx ; 
 var oldstate = suspended ;
 suspend ; 
 
 int Back = false ;
 
 while (!back) {
	 
  for (int i=0; i < getContainerSize(DiaQuest_Questions); i++) {
   int id = getFromContainer(DiaQuest_Questions, i) ;
   if (id >= MasterDelimiter) { if (askedMasterQuestion < 2) AddChoiceEchoEx(id,MeisterFragen[id-MasterDelimiter],true) ; } else { if ((!IsInsideContainer(Diaquest_Responses,id)) or (id >= AntwortenGesamt - FesteAntworten)) AddChoiceEchoEx(id,Fragen[id],true) ; }
  }
  
  activeObject = Ego ;
  
  int Line = dialogEx ;

  if (Line < MasterDelimiter) and (Line >= AntwortenGesamt - FesteAntworten) { back = true ; } // noch eine weitere Frage stellen
  
  if (Line < AntwortenGesamt - FesteAntworten) { // Fragen der Leute am Telefon
   Opponent: say(Antworten[Line]) ;
   RemoveFromContainer(DiaQuest_Questions, Line) ; // Julian soll die Frage nicht noch einmal stellen können 
   AddToContainer(DiaQuest_Responses, Line) ;      // Julian soll nun die Antwort auf die Frage kennen
  }
  
  if (Line >= MasterDelimiter) { // Fragen des Truck-Verkäufers
   RemoveFromContainer(DiaQuest_Questions, Line) ; // Julian soll die Frage nicht noch einmal stellen können  
   AskedMasterQuestion = 1 ;   
   Opponent: 
   switch upcounter(AntwortenGesamt) {
    case 0 : "Was f]r eine alberne Frage..."
	     "...ich denke die Antwort liegt auf der Hand."
	     Ego: "Ja, und zwar?"
	     Opponent: "Nun ja."
	               "Wenn Sie mich so fragen..." 
	               "Aber es gibt sicher viel wichtigere Fragen, die Sie loswerden wollen."
                       "An so einer Lappalie wollen wir uns doch nicht aufhalten."		       
    case 1 : "Ja also..."
	     "...da muss ich mich erst noch mit der entsprechenden Sachbearbeiterin kurzschlie}en."
	     Ego: "Dann tun Sie das doch bitte."
	     Opponent: "Die betreffende Sachbearbeiterin ist leider im Moment verreist."
	     Ego: "Was f]r ein ungl]cklicher Zufall."
	     Opponent: "H[chst bedauerlich, wohl wahr."
    case 2 : "Also da m]sste ich erst weitere Informationen einholen." 
	     "Und leider ist momentan mein Handy defekt."
	     Ego: "Dort dr]ben ist auch ein M]nzsprecher."
	     Opponent: "Bedauerlicherweise war die Nummer auf meinem Handy gespeichert."
	     Ego: "Verstehe."
    default: "Was f]r eine gerissene Frage!"
	     "Sie geh[ren eindeutig nicht zu meiner Zielgruppe."
	     "Wir sollten Gesch#ftspartner werden."
	     Ego:
	     "Kein Interesse. Ich habe Wichtigeres zu tun."
	     "Vorerst."
	     AskedMasterQuestion = 2 ;
	     if (!oldstate) clearAction ;
	     return Line ;
   }
  } 
  
 } // end while
 
 if (!oldstate) clearAction ;  
 return Line ;
} 

script DiaQuest_Combat(Opponent, level) {
 ResetContainer(DiaQuest_UsedLines) ;
 ResetdialogEx ;
 var oldstate = suspended;
 suspend ;
 
 int Next = -1 ;
 int Right = 0 ;
 for (int i=0; i<MaxTreffer; i++) { Gesagt[i] = -1 ; } 
 
 while (Right < MaxTreffer) and (right >= 0) {
  if (next < 0) {
   Next = Random(AntwortenGesamt-FesteAntworten) ;
   while (HasItem(DiaQuest_UsedLines,Next)) { Next = Random(AntwortenGesamt-FesteAntworten) ; }
   AddToContainer(DiaQuest_UsedLines,Next) ;
  }
  
  activeObject = Opponent ;
  if (level == 0) { say(Fragen[Next]) ; if (!hasitem(DiaQuest_Questions,Next)) { AddToContainer(DiaQuest_Questions,Next); }  } else { say(MeisterFragen[Next]) ; if (!hasitem(DiaQuest_Questions,Next+MasterDelimiter)) {  AddToContainer(DiaQuest_Questions,Next+MasterDelimiter) ; } } 
  
  for (i=0; i<GetContainerSize(DiaQuest_Responses); i++) {
   int id = GetFromContainer(DiaQuest_Responses, i) ;
   AddChoiceEchoEx(id,Antworten[id],true);
  }
  
  activeObject = Ego ;
  int Line = dialogEx ;
  
  if (Line < AntwortenGesamt-FesteAntworten) {
   Gesagt[Right] = Line ;
   RemoveFromContainer(DiaQuest_Responses,Line) ;
  }

  if (Line == Next) { 
   Right = Right + 1 ;
   Next = -1 ;
   if (Right < MaxTreffer - 1) {
    activeObject = Opponent ;
    switch random(5) {
     case 0 : say("Das leuchtet mir ein, aber...") ;
     case 1 : say("Nun ja, da haben Sie schon recht, aber...") ;
     case 2 : say("Wenn Sie das sagen, aber...") ;
     case 3 : say("Da haben Sie wahrscheinlich schon Recht, aber...") ;	    
     case 4 : say("Das ist ein gutes Argument, aber...") ;	    
    } 
   } 
  } else { if (Line != 13) { right = -1 ; } }   
 }
 
 for (i=0;i<MaxTreffer;i++) { if (Gesagt[i] >= 0) { AddToContainer(DiaQuest_Responses,Gesagt[i]); } }
 
 if (!oldstate) clearAction ; 
 return Right ;
} 

object CalledNums { SetupAsContainer(CalledNums); enabled = false; } 
object FooledNums { SetupAsContainer(FooledNums); enabled = false; } 
object AskedNums { SetupAsContainer(AskedNums); enabled = false; } 

script DiaQuest_TelCombat(Opponent,TelNr) {
 static int chefphone = false ;
 int called = HasItem(CalledNums, LastTelNum) ;
 int fooled = HasItem(FooledNums, LastTelNum) ;
 int asked = HasItem(AskedNums, LastTelNum) ;
 
 if (!called) AddToContainer(CalledNums, LastTelNum) ;

 if ((!chefphone) and (HasTruck) and (!called)) {
  chefphone = true ;
  TelNums[8] = TelNr ;
  Opponent: "SamTec Enterprises..."
            "...Gesch#ftsf]hrer Brander am Apparat."
  delay(5) ;
  Ego: "Guten Tag Herr Brander!"
  Opponent: "Wer zur H[lle sind Sie?"
  Ego:
  if (KnowsBrander) {
    "[hm..."
    delay 2 ;    
    "Mein Name ist..."
    delay 10 ;
    "...Jochen K]bler."
  } else {
    "Das tut nichts zur Sache."
  }
  delay 4 ;
  "Ich m[chte Sie mit der Kapitalanlage der Zukunft vertraut machen."
  Opponent: "Kapital?"
            "Das gef#llt mir."
            "Fahren Sie fort."
  Ego: "Nun ja..."
  TelStage = 10 ;
  doEnter(chefbuero) ;
  return 0 ;
 } 
 
 static int talktime = 0 ;
 static int AskedForLanguage = false ;
 
 if (HasTruck) {
  Opponent: "Hallo?" ;
  Ego: "Falsch verbunden."
  TelStage = 12 ;
  return 0 ;
 } 
 
 if (fooled) {
  Opponent:
  switch random(3) {
   case 0: "Hallo?"
   case 1: "Ja?"
   case 2: "Wer ist da?"
   case 4: "Salam."
  }  
  Ego: "Julian Hobler hier."
  Opponent: "Guten Tag Herr Hobler."
	    "Gut, dass Sie anrufen."
	    "Sie haben vorhin meine Adresse gar nicht notiert."
  Ego: "Doch, habe ich."
  Opponent: "Nein, haben Sie nicht."
  Ego: "Ich muss auflegen."  
  TelStage = 0 ;
  return 0 ;
 } 
 
 Opponent:
 switch random(4) {
  case 0: "Hallo?"
	  Ego: "Julian Hobler hier."	  
	  if called { Opponent: "Was wollen Sie diesmal?" ; } else { Opponent: "Was gibt es?" ; }
  case 1: "ÈÇáÅ[ÇÝÉ Åáì Ú#æÇ#ì ÇáÈÑíÏ ÇáÃáßÊÑæ#ì?"
	  if (TalkTime == 0) {
	  Ego: "Warum sprechen Sie so komisch?"
	  Opponent: "Das ist Arabisch..."
	  Ego: "Ja, das meinte ich."
          } 
	  if (TalkTime == 1) {
	  Ego: "Lassen Sie die Spielchen."
          }
	  if (TalkTime > 1) {
	   Opponent: "Wer da?"
	   Ego: "Salam."
	   Opponent: "Was wollen Sie?" 
          }
	  TalkTime++ ;
  case 2: "Guten Tag."
	  Ego: "Hallo!"
	  Opponent: "Was wollen Sie?"
  case 3: "Wer ist da?"
	  Ego: "Julian Hobler am Apparat."
	  Opponent:
          if (called) {
	    "Sie schon wieder."
	    "Was wollen Sie nun?"
	  } else {  
	    "Was wollen Sie?" 
          }
 } 
 
 TelStage = 0 ;
 loop {
  Ego:
  if (goingbusiness != 0) {
	  
   if (!asked) {
    switch random(3) {
    case 0: AddChoiceEchoEx(1, "Wollen Sie eine Option kaufen?", true) ;
    case 1: AddChoiceEchoEx(1, "Haben Sie schonmal an den Kauf einer Option gedacht?", true) ;
    case 2: AddChoiceEchoEx(1, "Wussten Sie, dass Optionen die Geldanlage der Zukunft sind?", true) ;
    }
   } else { AddChoiceEchoEx(2, "Lassen Sie sich mein Angebot nochmal durch den Kopf gehen.", true) ; }	   
  }
  
  AddChoiceEchoEx(3, "Warum k[nnen alle @gypter Deutsch sprechen?", false) unless (AskedForLanguage) or (GetItemCount(CalledNums)<3);
  AddChoiceEchoEx(4, "Wissen Sie, wo ich Feuer herbekommen k[nnte?", false) if (NeedPickLock) ;
  AddChoiceEchoEx(5, "Ich lege jetzt auf.", false) ;
 
  var c = dialogEx() ;
  switch c {
   case 1: Opponent: "Nein."
	             "Was sind Optionen?"
	   Ego: "Eine moderne Kapitalanlage."
	        "Mit Optionen sichern Sie Ihre Altersvorsorge..."
		"und f[rdern gleichzeitig die Kulturg]ter Ihres Vaterlandes."
		"Jeder Patriot sollte eine Option besitzen."
	   Opponent: "Also ein Patriot bin ich ganz sicher."
	   Ego: "Freut mich das zu h[ren."
	        "Nun suchen Sie sich einfach ein #gyptisches Kulturgut aus..."
		"...ich schicke Ihnen einen Kaufvertrag zu..." 
                "...sobald der Staat zustimmt folgt die Lieferung."
	   Opponent: "Das h[rt sich ja nicht schlecht an, aber...."
	   AddToContainer(AskedNums, LastTelNum) ;
	   
	   jukeBox_Stop ;
           jukeBox_Enqueue(Music::BG_Fuell3_mp3) ;
           jukeBox_Start ; 
	   
	   var cnt = 0 ;
	   
	   while (cnt < 3) {
	    if (DiaQuest_Combat(Opponent,0) < MAXTREFFER) {
	     Opponent:
	     switch random(3) {
              case 0 : say("Also das will mir nicht so recht einleuchten.") ;
              case 1 : say("Das ist doch nicht Ihr Ernst, oder?") ;
              default: say("Das ]berzeugt mich nicht so recht.") ;   
             } 
	     if (cnt != 2) {
	      switch random(3) {
               case 0 : say("Eigentlich interessiere ich mich ja schon daf]r, aber...") ;
	       case 1 : say("Das Konzept an sich interessiert mich ja schon, aber...") ;
	       default: say("Ich habe eine weitere Frage...") ;
	      }
             }
	     cnt++ ;
	    } else { cnt = 10; }
	   } 
	   
	   if (cnt != 10) { // Julian verkauft die Option nicht
		   
	     switch random(5) {
	       case 0:  jukeBox_Addin(Music::BG_Dlose1_mp3,10) ;
	       case 1:  jukeBox_Addin(Music::BG_Dlose2_mp3,10) ;
	       case 2:  jukeBox_Addin(Music::BG_Dlose3_mp3,10) ;
	       case 3:  jukeBox_Addin(Music::BG_Dlose4_mp3,10) ;
	       default: jukeBox_Addin(Music::BG_Dlose5_mp3,10) ;
	     }		   
		   
	    Opponent: "Tut mir Leid, aber ich denke Ihre Optionen sind nicht das Richtige f]r mich."
	              "Auf wiederh[ren."
	    return ;
	    
           } else { // Julian verkauft die Option
		   
            jukeBox_addIn(Music::BG_Dwin_mp3,10) ;			   
	    AddToContainer(FooledNums, LastTelNum) ;
	    Opponent: "Sie haben mich ]berzeugt."
	              "K[nnen Sie mir bitte einen Kaufvertrag zukommen lassen?"
	    Ego: "Nat]rlich."
	         "War mir eine Freude, mit Ihnen Gesch#fte zu machen."
		 "Auf Wiederh[ren."
	    Opponent: "Aber Sie wissen doch noch gar nicht, wo..."
	    TelStage = 13 ;
            return 0 ;
	   }	
   case 2: Opponent: "Warum sollte ich?"
           Ego: "Weil Optionen die Zukunft sind."
	   Opponent: "Das mag schon sein, aber..." ;
	   
	   jukeBox_Stop ;
           jukeBox_Enqueue(Music::BG_Fuell3_mp3) ;
           jukeBox_Start ; 
	   
	   cnt = 0 ;
	   
	   while (cnt < 3) {
	    if (DiaQuest_Combat(Opponent,0) < MAXTREFFER) {
	     Opponent:
	     switch random(3) {
              case 0 : say("Also das will mir nicht so recht einleuchten.") ;
              case 1 : say("Das ist doch nicht Ihr Ernst, oder?") ;
              case 2 : say("Das ]berzeugt mich nicht so recht.") ;  
             } 
	     if (cnt != 2) {
	      switch random(2) {
               case 0 : say("Eigentlich interessiere ich mich ja schon daf]r, aber") ;
	       case 1 : say("Das Konzept an sich interessiert mich ja schon, aber") ;
	      }
             }
	     cnt++ ;
	    } else { cnt = 10; }
	   } 
	   
	   if (cnt != 10) { // Julian verkauft die Option nicht
		   
	     switch random(5) {
	       case 0:  jukeBox_Addin(Music::BG_Dlose1_mp3,10) ;
	       case 1:  jukeBox_Addin(Music::BG_Dlose2_mp3,10) ;
	       case 2:  jukeBox_Addin(Music::BG_Dlose3_mp3,10) ;
	       case 3:  jukeBox_Addin(Music::BG_Dlose4_mp3,10) ;
	       default: jukeBox_Addin(Music::BG_Dlose5_mp3,10) ;
	     }		   
		   
	    Opponent: "Tut mir Leid, aber ich denke Optionen sind nicht das Richtige f]r mich."
	              "Auf wiederh[ren."
	    return ;
	    
           } else { // Julian verkauft die Option
		   
            jukeBox_addIn(Music::BG_Dwin_mp3,10) ;		   
	    AddToContainer(FooledNums, LastTelNum) ;
	    Opponent: "Sie haben mich ]berzeugt."
	              "K[nnen Sie mir bitte einen Kaufvertrag zukommen lassen?."
	    Ego: "Nat]rlich."
	         "Es war mir eine Freude mit Ihnen Gesch#fte zu machen."
		 "Auf Wiederh[ren."
	    Opponent: "Aber Sie wissen doch noch gar nicht, wo..."
	    TelStage = 13 ;
            return 0 ;
	   }	
   case 3: Ego: "Warum k[nnen alle @gypter Deutsch sprechen?"
	   Opponent: "Das ist allerdings seltsam."
	             "Es k[nnte daran liegen, dass wir einfach ein gebildetes Volk sind..."
                     "...oder dass die meisten Spieleentwickler kein #gyptisch sprechen..."
                     "...oder Sie w#hlen zuf#llig immer die Nummer eines Deutschen."		     
                     "Suchen Sie sich etwas aus." 
	   AskedForLanguage = true ;

   case 4: Ego: "Wissen Sie, wo ich Feuer herbekommen k[nnte?"
	   if (called) {
	    switch random(3) {
	     case 0: "Nein."
		     "H[ren Sie auf mich deswegen zu bel#stigen!"
	     case 1: "Wie oft wollen Sie mich das noch fragen?"
		     "Rufen Sie nicht mehr an!"
	     case 2: "Zum allerletzten Mal: NEIN!"
	    }
	   } else {
	    switch random(3) {
	     case 0: "Da kann ich Ihnen nicht helfen."
	     case 1: "Tut mir Leid, das m]ssen Sie schon selbst herausfinden."
	     case 2: "Sind Sie ein Pyromane?"
	    } 	    
	   } 
   case 5: Ego: "Ich lege jetzt auf."
	   Opponent: "Wie Sie meinen." 
	   return ;
	        
  } 
 } 
 
 return 0 ;	 
} 

