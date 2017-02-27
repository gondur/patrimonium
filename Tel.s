// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
//       Tel.s - Tel speeches
// ----------------------------------



int TelNum = -1 ;
int LastTelNum = -1 ;
int CurTelLen = 0 ;

const MaxTelLen = 6 ;
var   TelNums[9] ; 

script TelToStr(num,len) {
 var TempStr = "lwenfcfvisadihf";
 stringclear(TempStr) ;
 for (int pos=0; pos < len; pos++) {
  int digit = (num % 10) ;
  num = num / 10 ;
  StringAppendChar(TempStr,48 + digit) ;
 }
 return TempStr ; 
} 

script Quersumme(num) {
 var qs = 0 ;
 while (num > 0) { qs += num % 10; num = num / 10; } 
 return qs ; 
} 

/*/* ************************************************************* */
// Concorde El Salam Hotel
/* ************************************************************* */

script TelHotel1(Actor) {
	TelStage = 0 ;
	static var bt2 = false ;
        if (bt2 == false)	{
	  Actor: "Concorde El Salam Hotel, Salam!"
	  Ego: "Hallo. Sprechen Sie Deutsch?"
	  Actor: "Ja - ein bi}chen."
	} else {
	  Actor: "Concorde El Salam Hotel, Salam!"
	  Ego: "Hallo."
	}
	loop {
        Ego:
         AddChoiceEchoEx(1, "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?", false) unless KnowsHotel ;
	 AddChoiceEchoEx(2, "Vergessen Sie's.",false) ;
   
        var c = dialogEx () ;
	static var bt1 = false ;
   
         switch c {
	  case 1: 
            if (bt1 == false) {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
              Actor: "Einen Moment bitte..."
	      delay(40) ;
	             "Nein, es tut mir Leid."
	      Ego: "Schade, auf Wiederh[ren."
	      bt1 = true ;
            } else {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
	      Actor: "Komisch, Sie sind nicht der erste der danach fragt."
	             "Wir haben keinen Gast namens Wonciek."
	      Ego: "Schade, auf Wiederh[ren."	      
	    }
	   return ;
	  case 2:
	   Ego: "Vergessen Sie's."
	   Actor: "Gerne!"
	   return ;
         }
        }
}

/* ************************************************************* */
// Movenpick Hotel
/* ************************************************************* */
 
script TelHotel2(Actor) {
	TelStage = 0 ;
	Actor:
	 "Movenpick Hotel, Herr Mazhar am Apparat."
	loop {
        Ego:
         AddChoiceEchoEx(1, "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?", false) unless KnowsHotel ;
	 AddChoiceEchoEx(2, "Vergessen Sie's.",false) ;
   
        var c = dialogEx () ;
	static var b = false ;
   
         switch c {
	  case 1: 
            if (b == false) {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
              Actor: "Nat]rlich. Einen Moment bitte..."
	      delay(40) ;
	      "Nein, haben wir nicht."
	      Ego:
	      "Schade, auf Wiederh[ren."
	      b = true ;
            } else {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
	      Actor: "Wissen Sie, dass eben schon jemand danach gefragt hat?"
	      "Wir haben keinen Gast namens Wonciek."
	      Ego:
	      "Schade, auf Wiederh[ren."
	    }
	   return ;
	  case 2:
	   Ego: "Vergessen Sie's."
	   Actor: "Wie Sie w]nschen."
	   return ;
         }
        }	
}

/* ************************************************************* */
// Grand Hyatt
/* ************************************************************* */

script TelHotel3(Actor) {
	TelStage = 0 ;
	Actor:
	 "Grand Hyatt, Sie sprechen mit Monsieur Lacombe."
	loop {
        Ego:
         AddChoiceEchoEx(1, "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?", false) unless KnowsHotel ;
	 AddChoiceEchoEx(2, "Vergessen Sie's.",false) ;
   
        var c = dialogEx () ;
	static var b = false ;
   
         switch c {
	  case 1: 
            if (b == false) {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
              Actor: "Selbstverst#ndlich!"
              delay 4 ;
	      "Wenn Sie einen Moment warten w]rden, bitte..."
	      delay(40) ;
	      "Nein, wir haben keinen Gast namens Wonciek."
	      Ego:
	      "Schade, auf Wiederh[ren."
	      b = true ;
            } else {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
	      Actor: "Haben Sie nicht eben schonmal angerufen?"
	             "Wir haben keinen Wonciek zu Gast."
	      Ego: "Oh, tut mir Leid."
	           "Auf Wiederh[ren."
	    }
	   return ;
	  case 2:
	   Ego: "Vergessen Sie's."
	   Actor: "Wie Sie wollen."
	   return ;
         }
        }		
}

/* ************************************************************* */
// L'Hotel
/* ************************************************************* */

script TelHotel4(Actor) {
	TelStage = 0 ;
	Actor: "Guten Tag, Sie sprechen mit dem 'King' des L'Hotel!"
	       "Wie kann ich Ihnen helfen?"
	loop {
        Ego:
         AddChoiceEchoEx(1, "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?", false) unless KnowsHotel ;
	 AddChoiceEchoEx(2, "Vergessen Sie's.",false) ;
   
        var c = dialogEx () ;
   
         switch c {
	  case 1: 
              KnowsHotel = true ;
              lastPhonedHotel = true ;	      
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
              Actor: "Da muss ich eben nachsehen..."              
	      delay(10) ;
	      "Ja, ein gewisser Peter Wonciek befindet sich unter meinen G#sten."
	      Ego: "Das trifft sich gut."
	           "Ich werde wohl gleich vorbeischauen."
	      Actor: "Das L'Hotel liegt in der Port Said Street 75."
	             "Bis dann."
	      PhonedHotel = true ;
	      delay 7 ;
	   return ;
	  case 2:
	   Ego: "Vergessen Sie's."
	   Actor: "Okay."
	   return ;
         }
        }			
}

/* ************************************************************* */
// Marriott Cairo Hotel and Omar Khayyam Casino
/* ************************************************************* */

script TelHotel5(Actor) {
	TelStage = 0 ;
	Actor: "Marriott Cairo Hotel and Omar Khayyam Casino..."
	       "...wie kann ich Ihnen helfen?"
	loop {
        Ego:
         AddChoiceEchoEx(1, "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?", false) unless KnowsHotel ;
	 AddChoiceEchoEx(2, "Vergessen Sie's.",false) ;
   
        var c = dialogEx () ;
	static var b = false ; 
   
         switch c {
	  case 1: 
            if (b == false) {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
              Actor: "Ja, warten Sie eben einen Augenblick..."              
	      delay(40) ;
	      "Nein, ich muss Sie leider entt#uschen."
	      Ego:
	      "Schade, auf Wiederh[ren."
	      b = true ;
            } else {
	      Ego: "K[nnen Sie mir sagen, ob Sie einen Gast namens Wonciek haben?"
	      Actor: "Rufen Sie schon wieder an?"
	             "Nein, haben wir nicht."
	      Ego: "Verdammt."
	           "Auf Wiederh[ren."
	    }
	   return ;
	  case 2:
	   Ego: "Vergessen Sie's."
	   Actor: "Wenn Sie das sagen..."
	   return ;
         }
        }			
}

/* ************************************************************* */
// Besetzt...
/* ************************************************************* */

script TelHotel6(Actor) {
 telStage = 0 ;
 soundBoxPlay(Music::besetzt_wav) ;
}

/* ************************************************************* */
// Auskunft
/* ************************************************************* */

script TelInfo(actor) {
  static var InfoCount = 0 ;
  static var InfoJoke  = 0 ;
  static var ad = 0 ;
  static var askoption = false ;
  static var askedForTruck = false ;
  TelStage = 0 ;
  var c ;
  Actor:
  if (InfoCount == 0) {
    "»«·≈÷«›… ≈·Ï ⁄‰Ê«‰Ï «·»—Ìœ «·√·ﬂ —Ê‰Ï?"
   Ego: "Wie bitte?"
   Actor: "Ah, Sie sprechen Deutsch."
          "Wie kann ich helfen?"
  } else {
   "Guten Tag, wie kann ich Ihnen helfen?"
  }
  
  InfoCount++ ;
   
  loop {
   Ego:
   if (!knowsHotel) {
     if (InfoJoke == 0) addChoiceEchoEx(1, "Wissen Sie, in welchem Hotel ein gewisser Peter Wonciek wohnt?", false) ;
      else addChoiceEchoEx(1, "Geben Sie mir s#mtliche Nummern der Hotels in der N#he des Flughafens.", false) ;
   }
   addChoiceEchoEx(2, "Wissen Sie, wo ich Feuer herbekommen k[nnte?", false) if (NeedPickLock and (ad == 0)) ;
   addChoiceEchoEx(3, "Ich habe Fragen zu einer Option.", false) if ((goingbusiness == 1) and (! askoption)) ;
   addChoiceEchoEx(4, "Ich ben[tige die Adresse einer Organisation namens SamTec.", false) if (KnowsSamTec and (! KnowsHeadQuarters)) ;	   
   addChoiceEchoEx(5, "Ich ben[tige die Adresse des SamTec-Labors in der N#he des Nils.", false) if ((currentAct == 4) and (! knowsDOTT)) ;
   addChoiceEchoEx(6, "Ich ben[tige die Telefonnummer einer Organisation namens SamTec.", false) if ((currentAct == 4) and (juliancaught) and (! gotLadysNum)) ;
   addChoiceEchoEx(7, "Gibt es noch weitere Autovermietungsunternehmen au}er Kamelli?", false) if (canAskForTrucks and (!askedForTruck)) ;
   addChoiceEchoEx(8, "Gar nicht. Auf wiederh[ren.", false) ;
   

   c = dialogEx () ;
   
   switch c {
    case 1:
     if (InfoJoke == 0) {
       Ego: "Wissen Sie, in welchem Hotel ein gewisser Peter Wonciek wohnt?"
       delay 10 ;
       Actor: "Nat]rlich."
       delay 10 ;
	      "Wir sind die Auskunft."
       delay 10 ;
	      "Wir wissen alles."        
	InfoJoke = true ;
       delay 5 ;
       Ego: "Also wissen Sie es nicht?"
       Actor: "Was denken Sie wer ich bin?"
       delay 5 ;
       Ego: "Byrne, sind Sie's?"
       delay 10 ;
       Actor: "Nein."
	      "Wie kann ich Ihnen sonst noch weiterhelfen?"
     } else {
       Ego: "Geben Sie mir s#mtliche Nummern der Hotels in der N#he des Flughafens."
       Actor: "Immer diese Deutschen..."
       delay (70) ;
	"Concorde El Salam Hotel, Nummer:"
       saySlow(TelToStr(TelNums[0],MaxTelLen), 9) ;
       delay(60) ;
        "Movenpick Hotel,"
       saySlow(TelToStr(TelNums[1],MaxTelLen), 9) ;
       delay(60) ;
	"Grand Hyatt,"
       saySlow(TelToStr(TelNums[2],MaxTelLen), 9) ;
       delay(60) ;
	"L'Hotel,"
       saySlow(TelToStr(TelNums[3],MaxTelLen), 9) ;
       delay(60) ;
	"Marriott Cairo Hotel and Omar Khayyam Casino,"
       saySlow(TelToStr(TelNums[4],MaxTelLen), 9) ;
       delay(60) ;
	"Das w#ren alle."
       Ego:
	"Vielen Dank!"
       return ;
     }
    case 2:
     Ego: "Wissen Sie, wo ich Feuer herbekommen k[nnte?"
     ad = 1 ;
     delay 23 ;
     Actor: "Chef! Da ist schon wieder so ein Verr]ckter in der Leitung!"
     delay 45 ;
     "WAS soll ich tun?"
     delay 40 ;
     "Na gut..."
     delay 50 ;
     Ego: "Hallo, ist noch jemand da?"
     delay 30 ;
     Ego: "Seltsam, scheint wohl weggegangen zu sein..."
     delay 5 ;
     return ;
    case 3: 
     Ego: "Ich habe Fragen zu einer Option."
     Actor: "Meiner Option?"
            "Ach SIE sind es?"
	    "Aber ich dachte es w#re schon alles gekl#rt."
     Ego: "Also ich..."
     Actor: "Ich habe das Geld schon vor Monaten ]berwiesen, so wie Sie gesagt haben..."
            "...aber bisher habe ich weder Optionsschein noch Lieferung erhalten!"
     Ego: "Das tut mir ja Leid, aber..."
     Actor: "Was aber?"
            "Beeilen Sie sich gef#lligst etwas!"
     Ego: "Ich glaube, hier liegt ein Missverst#ndnis vor."
     Actor: "Das glaube ich nicht."
            "Das Geld ist raus, der Vertrag unterschrieben!"
            "H[ren Sie?"
     Ego: "Aber..."
     Actor: "Kein aber."
            "Setzen Sie sich endlich in Bewegung!"
     Ego: "Nat]rlich."
          "Ich rufe Sie sp#ter nochmal zur]ck."	
     askoption = true ;
     return ;
    case 4:
     Ego: "Ich ben[tige die Adresse einer Organisation namens SamTec."
     delay 2 ;
     Actor: "Einen Moment bitte..."
     delay 33 ;
            "SamTec besitzt ein Geb#ude in der Al Gaish Street 46 hier in Kairo."
     KnowsHeadquarters = true ;	    
     Ego: "Vielen Dank!"
          "Denen sollte ich am besten mal einen Besuch abstatten."
	  "M[glicherweise finde ich Peter dort."
     Actor: "Vergessen Sie nicht den H[rer aufzulegen."
     Ego: "Richtig."
	  "Auf wiederh[ren."
     return ;
    case 5:
     Ego: "Ich ben[tige die Adresse des SamTec-Labors in der N#he des Nils."
     delay 4 ;
     Actor: "Leider kann ich Ihnen nicht weiterhelfen."
            "Wir haben hier keine Adresse eines SamTec-Labor."
	    "Nur die Adresse des Sitzes der Firma, hilft Ihnen das weiter?"
     delay 1 ;
     Ego: "Nein. Wiederh[ren."
     Actor: "Salam."
     return ;
    case 6:
     Ego:
      "Ich ben[tige die Telefonnummer einer Organisation namens SamTec."
     delay 2 ;
     Actor:
      "Einen kleinen Moment bitte..."
     delay 12 ;
      "SamTec, in der Al Gaish Street 46, Kairo?"
     delay 2 ;
     Ego:
      "Genau."
     delay 3 ;
     Actor:
      "Die Nummer lautet..."
     saySlow(TelToStr(TelNums[6],MaxTelLen), 9) ;
     delay 2 ;
     Ego:
      "Vielen Dank!"
     delay 1 ;
     Actor:
      "Gern geschehen." 
     gotLadysNum = true ;
     return ;
    case 7:
     Ego:
      "Gibt es noch weitere Autovermietungsunternehmen au}er Kamelli?"
     delay 2 ;
     Actor:
      "Lassen Sie mich mal nachsehen..."
     delay 23 ;
      "Nein, gibt es nicht."
     Ego:
      "Wie kann das sein?"
     Actor:
      "Das fragen Sie mal lieber jemanden, der die aktuelle Marktlage im Autovermietungsgesch#ft besser einsch#tzen kann."
     Ego:
      "Na gut."
      "Auf wiederh[ren."
     askedForTruck = true ;
     return ;
    case 8:
     Ego:
      "Gar nicht. Auf wiederh[ren."
     Actor:
      "Salam."
     return ;
   }
  } }
  
  
/* ************************************************************* */
// SamTec
/* ************************************************************* */

script TelSamTec(actor) {
 TelStage = 8 ;
 Actor: "SamTec-Zentrale, Sie sprechen mit Frau Hinze."
        "Was kann ich f]r Sie tun?"
 delay 2 ; 
 Ego: "Hat sich erledigt."  
 delay 2 ;
} 