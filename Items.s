// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
 
 
script triggerInvDefaultEvents(src, dst) {
  
	
  if (src==Carpetscrap and (passedVerb == use)) {
    "\"F]r einen kurzen Augenblick ]berlegte sich der Held...\""
    "\"...mit dem Teppichfetzen seine ganze Umgebung penibelst zu s#ubern.\""
    "\"Schnell verwarf er die Idee wieder.\"" 	  
    return ;
  }
 
  if (src==Hammer and (passedVerb == use)) {
    say("Sinnlose Gewaltanwendung bringt mich nicht immer weiter.") ;
    return ; 
  }
  
/*  if (src== and(passedVerb == use)) {
    say("") ;
    return ;
  } */
  
  if (( (src==Pen) or (src==optionPen) or (src==Bleistift) ) and(passedVerb == use)) {
    say("Das will ich momentan nicht vollkritzeln.") ;
    return ;
  }
  
  if (((src==Coin)or(src==Coins)) and(passedVerb == use)) {
    say("Das ist nicht f]r den Gebrauch mit einer M]nze vorgesehen.") ;
    return ;
  }
  
  if (src==Photo and(passedVerb == use)) {
    say("Irgendwie gef#llt mir die Idee, hier ]berall im Flughafen mein Gesicht zu verbreiten, aber ich glaube ich kann das Passbild geschickter einsetzen.") ;
    return ;
  }
    
  if (src==Bulb and(passedVerb == use)) {
    say("{berraschenderweise kann man damit keine Hyper-Ampoule X230 kombinieren.") ;
    return ;
  }
  
  if (src==Wallet and(passedVerb == use)) {
    say("Damit kann ich meinen Geldbeutel nicht verwenden.") ;
    return ;
  }
  
  if (src==Ticket and(passedVerb == use)) {
    say("Ein Flugticket braucht man zum Fliegen. Nicht daf]r.") ;
    return ;
  }
  
  if (src==Membercard and(passedVerb == use)) {
    say("Die Verwendung eines offiziellen Kleintierz]chterausweises ist hier vermutlich nicht vorgesehen.") ;
    return ;
  }
  
  if (src==OptionContract and(passedVerb == use)) {
    say("Diesen Vertrag kann ich sicherlich woanders einsetzen, aber nicht hier.") ;
    return ;
  }
  
  if (src==Cigarettes) {
    say("Ich sollte die Zigaretten besser Gonzales geben.") ;
    return ;
  } 
  
  if (src==Picklock and(passedVerb == use)) {
    say("Dietriche verwendet man gew[hnlich mit Schl[ssern.") ;
    return ;
  }   
  
  if (src==PinUpKalender and(passedVerb == use)) {
    say("Damit kann ich den Kalender nicht verwenden.") ;
    return ;
  }     
  
  if (src==Shoelace and(passedVerb == use)) {
    say("Ich m[chte den Schn]rsenkel nicht daran knoten.") ;
    say("Vielleicht kann ich ihn f]r etwas anderes einsetzen.") ;
    return ;
  }  

  if (src==Cactus and(passedVerb == use)) {
    say("Na Oscar, kannst Du dich endlich mal n]tzlich machen?") ;
    delay 5 ;
    say("Hier wohl nicht.") ;
    return ;
  }     
  
  if (((src==Hotelkey) or (src==Masterkey)) and(passedVerb == use)) {
    say("Dieser Schl]ssel kann T]ren im Hotel [ffnen. Nicht das hier.") ;
    return ;
  }       
  
  if (src==Petrolcan and(passedVerb == use)) {
    say("Das ist keine gute Idee. Benzin ist leicht entz]ndlich.") ;
    return ;
  }       
  
  if (src==Shoe and(passedVerb == use)) {
    say("Dieser kreative Verwendungszweck f]r einen alten Schuh hilft mir momentan nicht weiter.") ;
    return ;
  }       
  
  if (src==Screw and(passedVerb == use)) {
    say("Das muss nicht festgeschraubt werden.") ;
    return ;
  }       
  
  if (src==Matches and(passedVerb == use)) {
    say("Ich sollte mir ein besseres Ziel f]r meine pyromanischen Aktivit#ten suchen.") ;
    return ;
  }       
  
  if (src==Screwdriver and(passedVerb == use)) {
    say("Daran muss nicht herumgeschraubt werden.") ;
    return ;
  }       
  
  if (src==A4 and(passedVerb == use)) {
    say("Die Verwendung von A4-Batterien sollte ich auf kleine, daf]r vorgesehene elektrische Ger#te beschr#nken.") ;
    return ;
  }       
  
  if (src==Rope and(passedVerb == use)) {
    say("Es hilft mir nicht weiter, wenn ich daran das Seil binde.") ;
    return ;
  }     

  if (isScheibe(src) and(passedVerb == use)) {
    say("Damit kann ich die Scheibe nicht kombinieren.") ;
    return ;
  }     
  
  if (src==Rankengewaechs and(passedVerb == use)) {
    say("Ich habe die Vorahnung, dass ich dieses Gew#chs woanders sinnbringender einsetzen kann.") ;
    return ;
  }       
  
  if (src==Absperrstange and(passedVerb == use)) {
    say("Hier muss jetzt nichts abgesperrt werden.") ;
    return ;
  }       
  
  if (src==Wires and(passedVerb == use)) {
    say("Hier kann ich die K#belchen nicht anschlie}en.") ;
    return ;
  }       
  
  if (src==Keycard and(passedVerb == use)) {
    say("Damit kann ich die Karte nicht verwenden.") ;
    return ;
  }       
  
  if (src==Probe) {
    say("Ich sollte die Probe besser dem Professor zeigen.") ;
    return ;
  }      

  if (src==Reagenzglas and(passedVerb == use)) {
    say("Das Reagenzglas ist doch kein Multifunktionswerkzeug.") ;
    return ;
  }     
  
  if (src==Dokumente) {
    if (!wonciekDocuments) say("Ich sollte sie besser dem Professor zeigen.") ;
     else say("Ich behalte die Dokumente vorerst als Beweismittel.") ;
    return ;
  }       
  
  if (src==Fax and(passedVerb == use)) {
    say("Das Fax kann an einen Computer angeschlossen werden, nicht aber daran.") ;
    return ;
  }    

  if (((src==Faxpapier) or (src==Thermopapier)) and(passedVerb == use)) {
    say("Hier wird das Papier seinen Zweck eher nicht erf]llen.") ;
    return ;
  }   

  if (src==Zitrone and(passedVerb == use)) {
    say("Die exakte Funktion der Zitrone erschlie}t sich mir dabei nicht ganz.") ;
    say("Ich versuche lieber etwas anderes.") ;
    return ;
  }   

  if (src==Lab2key and(passedVerb == use)) {
    say("Einen Schl]ssel dieser Gr[}e nutzt man ]blicherweise um T]ren aufzuschlie}en.") ;
    return ;
  }     
  
  if (src==Ausdruck and(passedVerb == give)) {
    say("Ich sollte diesen Ausdruck als Beweismittel vorerst behalten.") ;
    return ;
  }       
  
  if (src==Battery) {
    say("Hier wird mir die Autobatterie nicht n]tzlich sein.") ;
    return ;
  }     

  if (src==Kreide and(passedVerb == use)) {
    say("Das muss nicht mit Kreide bemalt werden.") ;
    return ;
  }     
  
  if (src==Monkey and(passedVerb == use)) {
    say("Seltsamerweise kann ich hier das R[ntgenbild eines dreik[pfigen Affens nicht gebrauchen.") ;
    return ;
  }     
  
  if (src==Monkey and(passedVerb == give)) {
    say("Ich m[chte das R[ntgenbild nicht weggeben.") ;
    say("Es w]rde sich an der Wand in meinem zuk]nftigen Zimmer ganz gut machen.") ;
    return ;
  }  
  
  if (src==Kreide and(passedVerb == use)) {
    say("Das muss nicht mit Kreide bemalt werden.") ;
    return ;
  }     
  
  if (src==freqDevice and(passedVerb == use)) {
    if (!readSciDiary) say("Ich wei} doch nichtmal, f]r was dieses Ger#t zu gebrauchen ist.") ;
     else say("Der Frequenzmultiplext]r[ffner hilft mir hier nicht weiter.") ;
    return ;
  }  
  
  if (src==Kondensmilch and (passedVerb == use) and (! isClassDerivate(dst, invDrinks))) {
    say("Dar]ber m[chte ich die Milch nicht gie}en.") ;
    return ;
  }  
  
  if (src==Kondensmilch and (passedVerb == use) and (isClassDerivate(dst, invDrinks))) {
    say("Nein, das w]rde mal total widerlich schmecken.") ;
    return ;
  }  
  
  
  if (src==Kondensmilch and (passedVerb == use) and (dst==DrinkKaffee)) {
    say("Ich trinke ihn lieber schwarz.") ;
    return ;
  }

  if (src==Seife and(passedVerb == use)) {
    say("Das will ich jetzt nicht einseifen.") ;
    return ;
  }
  
  if (((src==Stock) or(src==Stockklammer)) and(passedVerb == use)) {
    say("Hier muss keine Lektion erteilt werden.") ;
    return ;
  }  
  
  if (src==Haarklammer and(passedVerb == use)) {
    say("Daf]r m[chte ich die Haarklammer nicht zweckentfremden.") ;
    return ;
  }    

  
  if (passedVerb == give) {
   switch random(4) {
     case 0: "Ich m[chte das nicht weggeben."
     case 1: "Nein, das k[nnte mir noch n]tzlich sein."
     case 2: "Lieber nicht, ich k[nnte es noch ben[tigen."
     case 3: "Besser nicht, ich k[nnte es noch gebrauchen."
   }
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
 
object InvObj { priority = 254 ; } 
 
event Use -> InvObj  { PassItem(activeObject) ; }
event Give -> InvObj { PassItem(activeObject) ; }
script setupAsInvObj { class = InvObj ; }
 
event Take -> InvObj {
 Ego:
 clearAction ;
 switch random(5) {
  case 0 : "Das habe ich bereits." 
  case 1 : "Ich beklaue mich doch nicht selbst." 
  case 2 : "Das geh[rt mir schon." 
  case 3 : "Das besitze ich bereits." 
  case 4 : "Das habe ich doch schon."  
 } 
}

/* ************************************************************* */
//
//                            Akt 1
//
/* ************************************************************* */

object Pen {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Biro_image) ;
 name = "Kugelschreiber" ;
}

event LookAt -> Pen {
 clearAction ;
 Ego: 
  "Ein grauer Kugelschreiber."
  "Ich habe ihn vom Flughafenpersonal entwendet."
}


/* ************************************************************* */

object Coin {
 SetupAsInvObj ;
 enabled = false ;
 name = "M]nze" ; 
 setAnim(Graphics::Coin_image) ;
}

event LookAt -> Coin {
 clearAction ;
 Ego:
  if (currentAct==1) say("Diese M]nze hat in dem Getr#nke-Automaten gesteckt.") ;
   else say("Diese M]nze hat in dem Kondom-Automaten gesteckt.") ;
}

/* ************************************************************* */


object Photo {
 SetupAsInvObj ;
 enabled = false ;
 name = "Passbilder" ; 
 setAnim(Graphics::Photos_image) ;
}

event LookAt -> Photo {
 clearAction ;
 Ego:
  "Bilder von mir."
  "Mann, sehe ich GUT aus!"
}

/* ************************************************************* */

object Bulb {
 SetupAsInvObj ;
 enabled = false ;
 name = "Gl]hbirne" ; 
 setAnim(Graphics::Bulb_image) ;
}

event LookAt -> Bulb {
 clearAction ;
 Ego:
  "Eine leistungsstarke Gl]hbirne."
}

/* ************************************************************* */

object CarpetScrap {
 SetupAsInvObj ;
 enabled = false ;
 name = "Teppichfetzen" ; 
 setAnim(Graphics::Scrap_image) ;
}
 
event LookAt -> CarpetScrap {
 clearAction ;
 Ego:
  "Den habe ich aus einem Teppich gerissen."
  "Er ist aus einem ziemlich dicken Stoff."
}
 
/* ************************************************************* */
 
object Wallet {
 SetupAsInvObj ;
 enabled = false ;
 name = "Geldbeutel" ; 
 setAnim(Graphics::Wallet_image) ;
}
 
event LookAt -> Wallet {
 clearAction ;
 Ego:
  "Mein Geldbeutel."
  "G#hnende Leere, aber eine vollwertige Kreditkarte."
}

event Open -> Wallet {
 clearAction ;
 Ego:
  "Wozu? Au}er meiner Kreditkarte ist da nichts drin."
  "Und die ist darin gut aufgehoben."
}

 
/* ************************************************************* */
 
object Ticket {
 SetupAsInvObj ;
 enabled = false ;
 name = "Flugticket" ; 
 setAnim(Graphics::Ticket_image) ;
}
 
event LookAt -> Ticket {
 clearAction ;
 Ego:
  "Mein Flugticket von M]nchen nach Kairo."
  "Ausgestellt auf den Namen 'Peter Wonciek'."
}
 
/* ************************************************************* */
 
object Membercard {
 SetupAsInvObj ;
 enabled = false ;
 name = "Kleintierz]chterausweis" ; 
 setAnim(Graphics::Passport_image) ;
}
 
event LookAt -> Membercard {
 clearAction ;
 Ego:
  "Mein offizieller Kleintierz]chterausweis."
  "Ausgestellt ist er auf 'Peter Wonciek'."
  "Au}erdem ist hier noch eine Notfall-Nummer angegeben."
}

/* ************************************************************* */
//
//                            Akt 2
//
/* ************************************************************* */

object OptionContract {
 SetupAsInvObj ;
 enabled = false ;
 name = "Optionsvertrag" ; 
 setAnim(Graphics::Treaty_image) ;
}

event LookAt -> OptionContract {
 clearAction ;
 Ego:
  "Das ist ein Options-Vertrag auf #gyptische Kulturg]ter."
  "'Die Geldanlage der Zukunft'."
}

/* ************************************************************* */

object OptionPen {
 SetupAsInvObj ;
 enabled = false ;
 name = "Kuli" ; 
 setAnim(Graphics::Biro2_image) ;
}

event LookAt -> OptionPen {
 clearAction ;
 Ego:
  "Ein Kuli, mit dem ich den Options-Vertrag unterschreiben soll."
}

event OptionPen -> OptionContract {
 if (did(give)) {
  Ego:
   "Das macht keinen Sinn..."
 } else {
  Ego:
   "Also so bescheuert bin ich nicht."
 }
 clearAction ;
}

/* ************************************************************* */

object Cigarettes {
 SetupAsInvObj ;
 enabled = false ;
 name = "Zigaretten" ; 
 setAnim(Graphics::Cigarettes_image) ;
}

event LookAt -> Cigarettes {
 clearAction ;
 Ego:
  "Eine volle Packung Zigaretten."
}

/* ************************************************************* */

object Coins {
 SetupAsInvObj ;
 enabled = false ;
 name = "Kleingeld" ; 
 setAnim(Graphics::Coins_image) ;
}

event LookAt -> Coins {
 clearAction ;
 Ego:
  "Geld: der beste K[der um nach Menschen zu fischen."
}

/* ************************************************************* */

object Picklock {
 SetupAsInvObj ;
 enabled = false ;
 name = "Dietrich" ; 
 setAnim(Graphics::Picklock_image) ;
}

event LookAt -> Picklock {
 clearAction ;
 Ego:
  "Ein Dietrich von dem Kerl am Flughafen."
 if (random(2) == 1) say "Er sieht sehr billig verarbeitet aus." ;  
}

/* ************************************************************* */
/*
object Telbook {
 setupAsInvObj ;
 enabled = false ;
 name = "Telefonbuch" ;
 setAnim(Graphics::Notebook_image) ;
}

event LookAt -> Telbook {
 
 Ego:
  "Das private Adressbuch von Trump."
  switch upcounter(2) {
   case 0: "Mal sehen..."
	   delay 10 ;
	   "'Schatz':"
	   saySlow(TelToStr(TelNums[6],MaxTelLen),10) ;
	   delay 5 ;
	   "Das wird wohl seine Frau sein."
   default: "Die Privatnummer seiner Frau lautet:"
	    saySlow(TelToStr(TelNums[6],MaxTelLen),10) ;
  }
  
  clearAction ;
}

*/
/* ************************************************************* */

object PinUpKalender {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::pinup_image) ;
 name = "Pinup-Kalender" ;
} 

event LookAt -> PinUpKalender {
 Ego:
 Face(DIR_NORTH) ;
 EgoStartUse ;
 delay(5) ;
 "Hallo ihr zwei S]}en."
 delay(5) ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Shoelace {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Shoelace_image) ;
 name = "Schn]rsenkel" ;
} 

event LookAt -> Shoelace {
 Ego:
  "Diesen Schn]rsenkel fand ich in dem M]lleimer vor dem #gyptischen Flughafen."
 clearAction ;
}

event Shim -> Shoelace {
 if (did(give)) {
  clearAction ;
  Ego:
   "Das macht keinen Sinn."
 } else {
  MakeShimLace ;
 }
}

event Shoelace -> Shoe {
 Ego:
  say("Ich habe schon zwei intakte Schuhe.") ;
 clearAction ;
}

event Shoe -> Shoelace {
 triggerObjectOnObjectEvent(Shoelace, Shoe) ;
}

/* ************************************************************* */

object Shim {               // two cases: field(0) = 0 -> Shim, field(0) = 1 -> Shim with Shoelace
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Shim_image) ;
 name = "Unterlegscheibe" ;
} 

event LookAt -> Shim {
 Ego:
 if (Shim.getField(0)) {
  "Ein Schn]rsenkel, den ich an eine Unterlegscheibe gebunden habe."
 } else {
  "Eine nach dem DIN 125 Standard genormte Unterlegscheibe aus verzinktem Stahl."
  "Sie hat etwa die Gr[}e und das Gewicht einer M]nze."      // Puja
 }
 clearAction ;
}

event Shoelace -> Shim { 
 if (did(give)) {
  clearAction ;
  Ego:
   "Das macht keinen Sinn."
 } else {
  MakeShimLace ;
 }
}

/* ************************************************************* */

script MakeShimLace {
 Ego:
  "Ich binde den Schn]rsenkel an die Unterlegscheibe."
 dropItem(Ego, Shoelace) ;
 Shim:
  setField(0, 1) ;
  setAnim(Graphics::Shimlace_image) ;
  name = "Schn]rsenkel an Unterlegscheibe" ;
 clearAction ;	
}

/* ************************************************************* */
/*
object Mirror {
 SetupAsInvObj ; 
 enabled = false ;
 setAnim(Graphics::Mirror_image) ;
 name = "Spiegel" ;	
}

event LookAt -> Mirror {
 clearAction ;
 Ego:
  "Ein kleiner Spiegel mit goldenem Rahmen."
  "Ich sehe blendend aus."
}
*/
/* ************************************************************* */
 
event Probe -> Cactus {
 Ego:
 
 if (cactusMutated) {
   say("Na Oscar, m[chtest Du noch mehr?") ;
  delay 10 ;
   say("Lieber nicht.") ;
   say("Er sieht nicht gl]cklich aus.") ;
  clearAction ;
  return  ;
 }
 
  say("Oscar alter Junge!") ;
  say("Bist Du durstig?") ;
 delay 2 ;
  turn(DIR_NORTH) ;
 delay 5 ;
 EgoStartUse ;
  dropItem(Ego, Probe) ;
  dropItem(Ego, Probe) ;
  takeItem(Ego, Reagenzglas) ;
 delay 15 ;
 mutateCactus ;
 delay 10 ;
 Ego:
  say("Erstaunlich.") ;
  say("Seine Stacheln sind gewachsen.") ;
  say("Ich sollte unbedingt nochmal eine Probe von diesem Abwasser nehmen, und sie Peter zeigen.") ;
 clearAction ;
}
 
script cactusMutated {
 return Cactus.getField(0) ;
}

script mutateCactus {
 Cactus:
  setAnim(Graphics::CactusMutated_image) ;
  name = "mutierter Oscar" ;
  setField(0, 1) ;
}

script cactusDestroyed {
 return Cactus.getField(5) ;
}

script destroyCactus {
 Cactus:
  setAnim(Graphics::CactusDestroyed_image) ;
  setField(5,1) ;
 var test = "Haufen " ;
 stringAppend(test, Cactus.name) ;
 stringAppend(test, "-Asche") ;
  name = test ;
}

script cactusDrowned {
 return Cactus.getField(6) ;
}

script drownCactus {
 var test = "ertr#nkter " ;
 stringAppend (test, Cactus.name) ;
 Cactus.name = test ;
 Cactus.setField(6, true) ;
}

script cactusBurned {
 return Cactus.getField(4) ;
}

script burnCactus {
 Cactus:
  setAnim(Graphics::CactusBurned_image) ;
 var test = "verbrannter " ;
 stringAppend (test, Cactus.name) ;
  name = test ;
  setField(4,1) ;
}
 
object Cactus {
 SetupAsInvObj ;
 enabled = false ;
 name = "Oscar" ; 
 setAnim(Graphics::Cactus_image) ;
}
 
event LookAt -> Cactus {
 Ego:
 
 if (cactusDestroyed) {
   say("Oscar sieht nicht gerade gesund aus.") ;
   clearAction ;
   return ;
 }
 
 if (cactusBurned) {
   say("Nachdem ich ihn auf die hei}e Herdplatte gestellt habe, macht er einen weniger gl]cklichen Eindruck.") ;
   clearAction ;
   return ;	 
 }
 
 if (cactusMutated) {
   say("Nachdem ich ihn gegossen habe, sind seine Stacheln um ein Vielfaches angewachsen.") ;
   clearAction ;
   return ;
 }
  switch random(3) {
   case 0 : "Er sieht wie ein Igel aus." 
   case 1 : "Sein Aussehen erinnert mich irgendwie an einen Igel."
   case 2 : "Er sieht einem Igel sehr #hnlich." 
  }
 clearAction ;
}

event TalkTo -> Cactus {
 Ego:
 OscarTableTalk = 0 ;
 switch CurrentScene {
  case Ausgrabungsstelle: 
   switch upcounter(3) {
    case 0 : "So Oscar, jetzt gehen wir der Sache auf den Grund."
             "Du hast doch nicht etwa Angst vor engen, dunklen, geschlossenen R#umen?"
             "AUTSCH!" 
	     delay(10) ;
             "Du vielleicht nicht, aber ich!"
    case 1 : "Denk immer daran Oscar, wenn es hart auf hart kommt, ist es keine Schande, davonzulaufen."
             "AUTSCH!" 
	     delay(10) ;
	     "Das w}rde ich auch sagen, wenn ich ein Stachelkleid wie du bes#}e."
    default: "AUTSCH!"
	     "Genug geplaudert, Oscar will endlich Taten sehen."
   }	
   
  default:
   switch upcounter(3) {
    case 0 : "Hey, Oscar."
	     "AUTSCH!"
	     delay(10) ;
	     "Er hat mich gestochen!"
    case 1 : "Ich w]nschte, ich w#re auch ein einfacher Kaktus wie Du, Oscar..."
	     "Das Leben w#re so viel einfacher."
	     "AUTSCH!"
	     "Aber ich meinte doch nur..."
	     "AUTSCH!"
	     "Okay, okay, es tut mir leid."
    default: "AUTSCH!"
	     "Genug geplaudert, Oscar will endlich Taten sehen."		  
   }
 } 
 clearAction ;
}
 
/* ************************************************************* */
 
object CactusPot {
 SetupAsInvObj ;
 enabled = false ;
 name = "Blumentopf" ; 
 setAnim(Graphics::CactusSchale_image) ;
}
 
event LookAt -> CactusPot {
 Ego:
  face(DIR_NORTH) ;
  "Ein Blumentopf aus Keramik."
  "Darin befand sich einmal mein Kaktus Oscar." 
 clearAction ;
}
 
/* ************************************************************* */ 
 
object Letter {
 SetupAsInvObj ;
 enabled = false ;
 name = "Brief" ; 
 setAnim(Graphics::Letter_image) ;
}
 
// DER ABSINTH BRIEF
 
script Brief_Handler(key) {
  switch key {
    case <DRAW>: drawingPriority = PRIORITY_HIGHEST ; 
                 drawingColor = RGBA(255,255,255,255) ; 
                 drawImage(0,0,Graphics::Letterbig_image) ;
    case <LBUTTON>, <ESC>, <SPACE>:  ShowInventory ; 
                 clearAction ; return 1 ; 
  }
}
 
event LookAt -> Letter {
	
 if ((lightoff != 0) or (DarknessEffect.enabled)) { 
  Ego.say("Es ist viel zu dunkel um zu lesen.") ; 
  clearAction ; 
  return 0 ; 
 }
 
 if (chaseStage == 2) {
  clearAction ;
  Ego.say("Jetzt nicht!") ;
  return ;
 }
 
 HideInventory ;
 InterruptCaptions ;
 Menu(&Brief_Handler) ;
}
 
/* ************************************************************* */
 
object Envelope {
 SetupAsInvObj ;
 SetupAsContainer(Envelope) ;
 enabled = false ;
 name = "Briefumschlag" ; 
 setAnim(Graphics::Envelope_image) ;
}
 
event Letter -> Envelope {
 MoveItem(Ego,Envelope,Letter) ;
 clearAction ;
}

event LookAt -> Envelope {
 Ego: "Der Briefumschlag von Professor Wonciek." ;
 if random(3) == 0 {
  "Er riecht irgendwie nach Absinth."
 }
 if HasItem(Envelope,Letter) {
  "Der Brief von Peter ist darin."
 } else {
  "Er ist leer." ;
 } 
 if (Egypt and KnowsHotel == false) {
   "Die Absenderadresse lautet:"
   delay 5 ;
   "L'Hotel"
   delay 5 ;
   "Port Said Street 75"
   KnowsHotel = true ;
   if (currentScene == Vorflughafen) {
     delay 4 ;	   
      turn(DIR_SOUTH) ;
      "Sehr sch[n."
     delay 4 ;
      "Ich nehme am besten gleich das Taxi dort dr]ben."
     delay 4 ;	   
   }
 } else if (Egypt and knowsHotel) {
   "Hintendrauf steht die Absenderadresse:"
   delay 2 ;
   "L'Hotel"
   delay 2 ;   
   "Port Said Street 75."   
 }
 clearAction ;
}
 
event Open -> Envelope {
 if HasItem(Envelope,Letter) {
  MoveItem(Envelope,Ego,Letter) ;
 } else {
  Ego: "Er ist leer." 
 }
 clearAction ;
}
 
/* ************************************************************* */
 
object Hotelkey {
 SetupAsInvObj ;
 enabled = false ;
 name = "Schl]ssel" ; 
 setAnim(Graphics::Hotelkey_image) ;
}
 
event LookAt -> Hotelkey {
 clearAction ;
 Ego:
  "Das ist der Schl]ssel f]r mein Hotelzimmer."
}
 
/* ************************************************************* */
 
object Landkarte {
 setupAsInvObj ;
 enabled = false ;
 name = "Landkarte" ;
 setAnim(Graphics::Map_image) ;
}
 
event Use -> Landkarte {
 triggerObjectOnObjectEvent(LookAt, Landkarte) ;
}
 
event LookAt -> Landkarte {
 Ego:
 KnowsExcavation = true ;
 "Das ist die Landkarte aus Peters Zimmer."
 delay 10 ;
 "Es sind zwei Dinge eingezeichnet."
 delay 10 ;
 "Einmal ein mit 'Truckverleih' betitelter Ort..."
 delay 15 ;
 "Und ein weiteres, rotes Kreuz markiert die ''Ausgrabungsstelle''."
 clearAction ;
}
 
/* ************************************************************* */
 
object MasterKey {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::MasterKey_image) ;
 name = "Generalschl]ssel" ;
}
 
event LookAt -> MasterKey {
 clearAction ;
 Ego: "Das ist der Generalschl]ssel des l'Hotels den ich entwendet habe."
 static int first = true ;
 if (first) {
  "Er wird sicher schon vermisst."
  turn(DIR_SOUTH) ;
  "Ein Grund mehr hier lebendig herauszukommen."
  first = false ;
 }
}
 
/* ************************************************************* */
 
object Newspaper {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Newspaper_image) ;
 name = "Zeitung" ;
} 
 
event Use -> Newspaper {
 triggerObjectOnObjectEvent(LookAt, Newspaper) ;
}	
 
event LookAt -> Newspaper {
 Ego: "Eine deutsche Tageszeitung."
 if (currentAct == 4) {
   if (knowsMutated) {
     "Der interessanteste Aufmacher ist:"
     "'Mutierte Fische im Nil - SamTec lehnt jegliche Verantwortung ab'"
   } else {
     knowsMutated = true ;
     jukeBox_addIn(Music::BG_Short1_mp3,10) ;
     "Hmm, dieser Artikel ist interessant:"
     "'Mutierte Fische im Nil - SamTec lehnt jegliche Verantwortung ab'"
     "Darin wird gemutma}t, dass von einem der SamTec-Labors ausgeschiedene chemische Verunreinigungen..."
     "...f]r Mutationen der Lebewesen im Nil verantwortlich sind."
     "SamTecs Pressesprecher meint hierzu: 'V[lliger Unsinn, das ist reine Spekulation.'"
     delay 10 ;
     "Vielleicht sollte ich der Sache nachgehen."
   }
 } else {
  "Eine der kleineren Schlagzeilen lautet:"
  switch random(7) {
   case 0 : "Konfliktfeld Gentechnik - dreik[pfiger Affe aus Forschungslabor ausgebrochen." 
   case 1 : "Wirbelst]rme in den USA und Kanada - Auswirkungen der globalen Erw#rmung?" 
   case 2 : "Arbeitsplatzsituation f]r Hochschulabsolventen immer schlechter." 
   case 3 : "Massenhysterie auf Popkonzert - zwei Jugendliche schwer verletzt ins Krankenhaus eingeliefert." 
   case 4,6 : "Drogen und Gesellschaft - Grafikadventures als psychedelische Kunst." 
   case 5:  "Grabmal des Sonnenk[nig Echnatons entdeckt."
  } 
 }  
 
 clearAction ;
}
 
/* ************************************************************* */
 
object Petrolcan {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Petrolcan_image) ;
 name = "Benzinkanister" ;
 SetField(0,false) ;
} 
 
event LookAt -> Petrolcan {
 Ego:
  "Der Ersatzkanister aus dem Truck."
  if (!Petrolcan.GetField(0)) "Es ist nur noch ein kleiner Rest Benzin darin."
  if (Petrolcan.GetField(0)) "Er ist leer."
 clearAction ;
}
 
/* ************************************************************* */
 
object Shoe {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Shoe_image) ;
 name = "alter Schuh" ;
} 
 
event LookAt -> Shoe {
 Ego:
  "Diesen alten Schuh habe ich aus dem M]lleimer vor dem #gyptischen Flughafen."
 if (Shoe.getField(0)) Ego.say("Er tropft und ist voller Wasser.") ;
 clearAction ;
}
 
/* ************************************************************* */
 
object ShimLace {               // two cases: field(0) = 0 -> Shim, field(0) = 1 -> Shim with Shoelace
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Shimlace_image) ;
 name = "Schn]rsenkel an Unterlegscheibe" ;
} 
 
event LookAt -> ShimLace {
 Ego: "Ein Schn]rsenkel, den ich an eine Unterlegscheibe gebunden habe"
 clearAction ;
}
 
/* ************************************************************* */
 
object Screw {             
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Screw_image) ;
 name = "Schraube" ;
} 
 
event LookAt -> Screw {
 clearAction ;
 Ego:
  "Eine Sechskantschraube aus Edelstahl mit metrischem Gewinde."
}

event Screwdriver -> Screw {
 clearAction ;
 Ego:
  "Das ist eine Sechskantschraube. Daf]r ben[tige ich schon einen Schraubenschl[ssel."
}
 
/* ************************************************************* */
 
object Matches {
 SetupAsInvObj ;
 enabled = false ;
 name = "Streichh[lzer" ; 
 setAnim(Graphics::Matches_image) ;
}
 
event LookAt -> Matches {
 clearAction ;
 Ego:
  "Das ist eine Packung #gyptischer Streich[lzer aus dem Hotel."
}
 
/* ************************************************************* */
 
object DiaryInv {             
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::DiaryInv_image) ;
 name = "Notizbuch" ;
 member Page = 0 ;
 
 // Sprungstellen der Tabs einstellen
 DiaryTabX[0] = 245 ; DiaryTabY1[0]=28; DiaryTabY2[0]=28; 
 DiaryTabY3[0]=28; DiaryTabIndex[0] = 1 ;
 DiaryTabX[1] = 200 ; DiaryTabY1[1]=32; DiaryTabY2[1]=32; 
 DiaryTabY3[1]=32; DiaryTabIndex[1] = 3 ;
 DiaryTabX[2] = 155 ; DiaryTabY1[2]=30; DiaryTabY2[2]=30; 
 DiaryTabY3[2]=32; DiaryTabIndex[2] = 5 ;
 DiaryTabX[3] = 124 ; DiaryTabY1[3]=31; DiaryTabY2[3]=31; 
 DiaryTabY3[3]=30; DiaryTabIndex[3] = 9 ; 
} 
 
event use -> DiaryInv {
 triggerObjectOnObjectEvent(LookAt, DiaryInv) ;
}	
 
event LookAt -> DiaryInv { 
 if (((torchLight) and (currentScene==Grabeingang)) or
    ((currentScene==Grabsonnenraum) and (SolvedAtonPuzzle)) or
    (currentScene==Grabkristallraum) or
    (FlashLightEffect.enabled)) or
    (currentScene == Ausgrabungsstelle) or
    (currentScene == Grabschiebe)
 {
  HideInventory ; 
  InterruptCaptions ;
  Menu(&DiaryHandler) ;
 } else {
  Ego.say("Hier ist es nicht hell genug zum lesen.") ;
  clearAction ;
 } 
}
 
script DiaryHandler(key) {
  switch key {
    case <DRAW>: drawingPriority = PRIORITY_HIGHEST ; drawingColor = RGBA(255,255,255,255) ; drawDiary ;
    case <LBUTTON>: ClickDiary(MouseX,MouseY) ; if (mouseY > 400) { ShowInventory ;  clearAction ; return 1 ; } 
    case <LEFT>: GotoDiaryPage(DiaryInv.Page-1) ;
    case <RIGHT>, <SPACE>: GotoDiaryPage(DiaryInv.Page+1) ;
    case <ESC>:  ShowInventory ;  clearAction ; return 1 ; 
  }
}
 
/* ************************************************************* */
 
object Rod {             
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Rod_image) ;
 name = "Stab" ;
} 
 
event LookAt -> Rod {
 clearAction ;
 Ego:
  "Ein stabiler Stab den ich von der Statue im Kristallraum entwendet habe."
}
 
/* ************************************************************* */
 
 
object Stone {             
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Stone_image) ;
 name = "Stein" ;
} 
 
event LookAt -> Stone {
 clearAction ;
 Ego:
  "Ein schwarzer, steiniger Stein."
  "F]r seine Gr[}e wiegt er eine ganze Menge."
}

event Stone -> Shoe {
 Ego:
 if (!SchuhGeworfen) { 
  "Der Stein passt zwar in den Schuh..."
  "...aber warum sollte ich ihn dort hinein stecken."
 } else {
  EgoStartUse ;
  "Ich beschwere den Schuh indem ich den Stein hineinlege..."
  dropItem(Ego,Shoe) ;
  dropItem(Ego,Stone) ;
  "...er passt und scheint relativ fest zu sitzen."
  takeItem(Ego,ShoeStone) ;  
 } 
 clearAction ;
}
event Shoe -> Stone { TriggerObjectOnObjectEvent(Stone,Shoe) ; }

script makeSpark {
 Ego:
  turn(DIR_NORTH) ;
 EgoStartUse ;
 soundBoxPlay(Music::Flintstone_wav) ;   
 EgoStopUse ;
 switch upcounter(3) {
  case 0:   "Ich habe einen Funken erzeugt!"
            turn(DIR_SOUTH) ;
            "Mein Studium der Physik zahlt sich endlich aus..."
  case 1:   "Schon wieder ein Funke."
  default : "Und noch ein Funke..."
            "...der sinnlos verpufft."	
  }
}

event Stone -> Screwdriver {
 makeSpark ;
 clearAction ;
}

event Screwdriver -> Stone {
 makeSpark ;
 clearAction ;
}
 
/* ************************************************************* */

object ShoeStone {             
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Shoe_image) ;
 name = "beschwerter Schuh" ;
} 
 
event LookAt -> ShoeStone {
 clearAction ;
 Ego:
  "Diesen alten Schuh habe ich aus dem M]lleimer vor dem #gyptischen Flughafen."
  "Ich habe einen faustgro}en Stein hineingesteckt um ihn zu beschweren."
}

event Pull -> ShoeStone {
 Ego:
  EgoUse ;
  dropItem(Ego,ShoeStone) ;
  "Ich habe den Stein aus dem Schuh herausgenommen."
  takeItem(Ego,Shoe) ;
  takeItem(Ego,Stone) ;
 clearAction ; 
} 

event Take -> ShoeStone { triggerObjectOnObjectEvent(Pull, ShoeStone) ; }

event Open -> ShoeStone { triggerObjectOnObjectEvent(Pull, ShoeStone) ; }

event Push -> ShoeStone {
 Ego: "Der Stein sitzt bereits ziemlich fest."
 clearAction ;
} 
 
/* ************************************************************* */
 
object Screwdriver {             
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Screwdriver_image) ;
 name = "Schraubenzieher" ;
} 
 
event LookAt -> Screwdriver {
 clearAction ;
 Ego:
  "Ein Schraubenzieher aus Metall..."
  "...und Kunststoff."
}
 
/* ************************************************************* */

// A4 batteries

object A4 {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::A4_image) ;
 name = "A4-Batterien" ;
}

event LookAt -> A4 {
 Ego:
  say("Herk[mmliche A4-Batterien.") ;
 clearAction ;
}

/* ************************************************************* */
 
object Flashlight {             // setField(1,true): took A4 batteries
 SetupAsInvObj ;                // setField(0,true): flashlight on
 enabled = false ;
 setAnim(Graphics::Flashlight_image) ;
 name = "Taschenlampe" ;
} 
 
event Open -> Flashlight {
 Ego:
 if ((currentAct < 4) || ((currentScene != Securitygef) and (currentScene != Securitygang) and (currentScene != Securitylab2) and (currentScene != Securitylab1))) {
   say("Das hilft mir momentan nicht weiter.") ;
   clearAction ;
   return ;
 }
 if (Flashlight.getField(0)) {
   say("Dazu sollte ich sie besser ausmachen.") ;
   clearAction ;
   return ;
 } 
 if (Flashlight.getField(1)) {
   say("Sie ist leer.") ;
   clearAction ;
   return ;
 }
  turn(DIR_NORTH) ;
 EgoStartUse ;
 soundBoxPlay(Music::Rausnehmen_wav) ;
 takeItem(Ego, A4) ;
 Flashlight.setField(1, true) ;
 EgoStopUse ;
  turn(DIR_SOUTH) ;
 clearAction ;
}
 
event A4 -> Flashlight {
 Ego:
  turn(DIR_NORTH) ;
 EgoStartUse ;
 soundBoxStart(Music::Einlegen_wav) ;
 dropItem(Ego, A4) ;
 Flashlight.setField(1, false) ;
 EgoStopUse ;
 clearAction ;
}
 
event LookAt -> Flashlight {
 clearAction ;
 Ego:
  "Eine Taschenlampe."
 
}

script FlashlightOn {
 if ((torchLight) and (currentScene==Grabeingang)) {
  Ego.say("Die Fackel spendet gen]gend Licht.") ;
  return ;
 } else if ( ((solvedAtonPuzzle) and (currentScene==Grabsonnenraum)) or (currentScene==Grabkristallraum)) {
  Ego.say("Hier ist es hell genug.") ;
  return ;
 } else if (Flashlight.getField(1)) {
  Ego.say("Kein Saft.") ;
  return ;
 }
 Flashlight.setField(0, true) ;
 FlashLightEffect.enabled = true ;
 DarknessEffect.enabled = false ;
}
 
script FlashlightOff {
 if ((torchLight) and (currentScene==Grabeingang)) {
  Ego.say("Die fackel spendet gen]gend Licht.") ;
  return ;
 }	
 Flashlight.setField(0, false) ;
 FlashLightEffect.enabled = false ;
 DarknessEffect.enabled = true ;
}
 
event Use -> Flashlight {
 if ((currentScene == Grabeingang) or (currentScene == Grabsonnenraum) or (currentScene == Securitygef2)) {
  Flashlight:
  if (getField(0)) {
   if (currentScene==Securitygef2) { Ego.say("Lieber nicht, sonst sehe ich nichts mehr.") ; clearAction ; return ;  }
   FlashlightOff ;
  } else { 
   if (nightVision.enabled) { triggerObjectOnObjectEvent (Use, Nachtsicht) ; Ego.say("Das Nachtsichtger#t schalte ich aus.") ; }
   FlashlightOn ;
  }
 } else {
  Ego.say("Jetzt nicht.") ;
  if (hasItem(Ego, Nachtsicht)) Ego.say("Ich habe ein Nachtsichtger#t.") ;
 }
 clearAction ;
}
 
/* ************************************************************* */

object Echkey {
 SetupAsInvObj ; 
 enabled = false ;
 setAnim(Graphics::Echkey_image) ;
 name = "spiegelnder Schl]ssel" ;	
}

object EchKeyDirty {
 SetupAsInvObj ; 
 enabled = false ;
 setAnim(Graphics::EchkeyDirty_image) ;
 name = "verschmutzter Schl]ssel" ;	
}

event PetrolCan -> EchKeyDirty {
 Ego:
  if (Petrolcan.GetField(0)) {
   "Der Benzinkanister ist bereits leer."
  } else {
   "Der Schl]ssel ist total verschmutzt..."
   "...ich gebe ein wenig Benzin auf den Teppichfetzen..."
   "...und versuche damit die Verunreinigungen zu entfernen."
   dropItem(Ego,EchKeyDirty) ;
   EgoUse ;
   EgoUse ;
   takeItem(Ego,EchKey) ;
   "Nun blitzt und blinkt der Schl]ssel wieder..."
   "...fast wie ein Spiegel."  
 } 
 clearAction ; 
} 

event CarpetScrap -> EchKeyDirty {
 Ego:
  "Der Schl]ssel ist total verschmutzt..."
  "...ich poliere ihn mit dem Teppichfetzen ein wenig."
  dropItem(Ego,EchKeyDirty) ;
  EgoUse ;
  EgoUse ;
  takeItem(Ego,EchKey) ;
  "Nun blitzt und blinkt der Schl]ssel wieder..."
  "...fast wie ein Spiegel."  
 clearAction ;
} 
 
event LookAt -> Echkey {
 clearAction ;
 Ego:
  "Ein spiegelnder gro}er Schl]ssel..."
  "...oder ein schl]sselnder Taschenspiegel."
  "Ich bin mir da nicht ganz sicher."
}
event LookAt -> EchKeyDirty {
 clearAction ;
 Ego:
  "Ein ziemlich gro}er Schl]ssel."
  "Er ist ziemlich dreckig."
}
 
/* ************************************************************* */
 
object Rope {
 SetupAsInvObj ; 
 enabled = false ;
 setAnim(Graphics::Rope_image) ;
 name = "Seil" ;
}
 
event Stone -> Rope {
 triggerObjectOnObjectEvent(Rope, Stone) ;
}

event Rope -> Stone {
 clearAction ;
 Ego:
  "Der Stein ist viel zu klein und flutschig zum festbinden."
}

event LookAt -> Rope {
 clearAction ;
 Ego:
  "Ein Seil, das das Bergungsteam in einer Kiste vergessen hat."
  "Es ist gute f]nf Meter lang."
}
 
event Rope -> Absperrstange {
 Ego:
  "Die Absperrstange ist zu gro} und zu schwer, als dass mir das irgendwie weiterhelfen k[nnte."
 clearAction ;
}

event Absperrstange -> Rope {
 triggerObjectOnObjectEvent(Rope, Absperrstange) ;
}
 
event Rope -> Rod {
 Ego:
   Stop ;
   turn(DIR_NORTH) ;
   EgoStartUse ;
   dropItem(Ego,Rope) ;
   delay(5) ;
   dropItem(Ego,Rod) ;
   delay(10) ;
   EgoStopUse ;
   takeItem(Ego,RodRope) ;
   turn(DIR_SOUTH) ;
   clearAction ;
   "Ich habe das Seil an den Stab geknotet." 
  if AtonTrapDoorOpen {
   "Das k[nnte in der Tat hilfreich sein."
  } else {   
   "Jetzt sollte ich nur noch wissen..."
   "Was ich damit anstellen soll."
  }
} 
 
event Rod -> Rope { 
  TriggerObjectOnObjectEvent(Rope,Rod) ; 
}
 
/* ************************************************************* */
 
object RodRope {
 SetupAsInvObj ; 
 enabled = false ;
 setAnim(Graphics::RodRope_image) ;
 name = "Stab mit Seil" ;
}
 
event LookAt -> RodRope {
 clearAction ;
 Ego:
  "Ich habe das Seil an den Stab gebunden."
}
 
event Pull -> RodRope {
 Ego:
   Stop ;
   turn(DIR_NORTH) ;
   EgoStartUse ;
   delay(5);
   dropItem(Ego,RodRope) ;
   takeItem(Ego,Rod) ;
   takeItem(Ego,Rope) ;
   EgoStopUse ;
   turn(DIR_SOUTH) ;
   clearAction ;
   "Der Knoten sa} ziemlich fest."
   "Aber kein Problem f]r JULIAN HOBLER!"
}
 
event Open -> RodRope { 
  TriggerObjectOnObjectEvent(Pull,RodRope) ; 
}
 
/* ************************************************************* */

script IsScheibe(obj) {
 return ((obj == ScheibeBrotlaib) or (obj == ScheibeHocker) or
        (obj == ScheibeLeer)  or (obj == ScheibeLeer2) or
	(obj == ScheibeSchilfoben) or (obj == ScheibeSchilfmitte) or
	(obj == ScheibeSchilfunten) or (obj == ScheibeSonnenscheibe) or
	(obj == ScheibeWasser)) ;
} 

/* ************************************************************* */
 
object ScheibeBrotlaib {
 SetupAsInvObj ; 
 enabled = false ;
 setAnim(Graphics::Scheibebrotlaib_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeBrotlaib {
 clearAction ;
 Ego:
  "Ein flacher Steinquader."
  static int firstBrot = true ;
  if (firstBrot) {
   "Das Relief stellt einen Brotlaib dar."
   "Oder die untergehende Sonne."
   "Oder einen Halbkreis..."
   firstBrot = false ;
 } else {
   switch random(3) {
    case 0 : "Die Abbildung darauf zeigt einen Brotlaib." 
    case 1 : "Das Relief erinnert an die untergehende Sonne."
    case 2 : "Mit einem Halbkreis." 
  }
 }
}
 
/* ************************************************************* */
 
object ScheibeHocker {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeHocker_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeHocker {
 clearAction ;
 Ego:
  "Ein flacher Steinquader."
  static int firstHocker = true ;
  if (firstHocker) {
   "Das Relief stellt einen Bilderrahmen dar."
   "Oder einen Hocker."
   "Oder ein Rechteck..."
   firstHocker = false ;
 } else {
   switch random(3) {
    case 0 : "Auf dem Quader ist ein Bilderrahmen abgebildet." 
    case 1 : "Das Relief erinnert an einen Hocker."
    case 2 : "Mit einem Rechteck." 
  }
 }
}
 
/* ************************************************************* */
 
// eigentlich gibt's vier leere Scheiben aber man kann maximal zwei Scheiben im Inventar haben
 
object ScheibeLeer {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeLeer_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeLeer {
 clearAction ;
 Ego:
  "Ein flacher Steinquader."
}
 
object ScheibeLeer2 {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeLeer_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeLeer2 {
 clearAction ;
 Ego:
  "Ein flacher Steinquader."
}
 
/* ************************************************************* */
 
object ScheibeSchilfoben {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeSchilfoben_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeSchilfoben {
 clearAction ;
 Ego:
  "Ein flacher Steinquader"
  "Das Relief sieht wie der Teil eines gr[}eren Objekts aus."
}
 
object ScheibeSchilfmitte {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeSchilfmitte_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeSchilfmitte {
 clearAction ;
 Ego:
  "Ein flacher Steinquader"
  "Das Relief sieht wie der Teil eines gr[}eren Objekts aus."
}
 
object ScheibeSchilfunten {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeSchilfunten_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeSchilfunten {
 clearAction ;
 Ego:
  "Ein flacher Steinquader"
  "Das Relief sieht wie der Teil eines gr[}eren Objekts aus."
}
 
/* ************************************************************* */
 
object ScheibeSonnenScheibe {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeSonnenscheibe_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeSonnenScheibe {
 clearAction ;
 Ego:
  "Ein flacher Steinquader."
  static int firstSonne = true ;
  if (firstSonne) {
   "Das Relief stellt ein Rad dar."
   "Oder die Sonne."
   "Oder zwei konzentrische Kreise..."
   firstSonne = false ;
 } else {
   switch random(3) {
    case 0 : "Das Relief stellt die Sonne dar." 
    case 1 : "Auf ihm ist ein Rad abgebildet."
    case 2 : "Mit zwei konzentrischen Kreisen." 
  }
 }
}
 
/* ************************************************************* */
 
object ScheibeWasser {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::ScheibeWasser_image) ;
 name = "Steinquader" ;
}
 
event LookAt -> ScheibeWasser {
 clearAction ;
 Ego:
  "Ein flacher Steinquader."
  static int firstWasser = true ;
  if (firstWasser) {
   "Das Relief stellt eine Wasserwelle dar."
   "Oder eine Art Gebirgszug."
   "Oder eine gezackte Linie..."
   firstWasser = false ;
 } else {
   switch random(3) {
    case 0 : "Das Relief stellt ganz eindeutig eine Wasserwelle dar." 
    case 1 : "Auf ihm ist eine Art Gebirgszug abgebildet."
    case 2 : "Mit einer gezackten Linie." 
  }
 }
}
 
/* ************************************************************* */
 
object RankenGewaechs {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Gewaechs_image) ;
 name = "rankiges Gew#chs" ;
} 
 
event LookAt -> RankenGewaechs {
 clearAction ;
 Ego:
  "Ein kleines, rankiges Gew#chs."
  "Au}er mir wahrscheinlich eines der einzigen Lebewesen hier unten."
  "Ich frage mich wie es hier unten ]berlebt hat."
}

/* ************************************************************* */

object AbsperrStange {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::AbsperrStange_image) ;
 name = "Absperrstange" ;	
} 

event LookAt -> Absperrstange {
 clearAction ;
 Ego:
  "Eine Absperrstange aus dem Raum mit der Anubisstatue."
}

/* ************************************************************* */

script dropAct3Items {
 if (hasItem(Ego, Absperrstange)) dropItem(Ego, Absperrstange) ;
 if (hasItem(Ego, Rankengewaechs)) dropItem(Ego, Rankengewaechs) ;
 if (hasItem(Ego, Stone)) dropItem(Ego, Stone) ;
 if (hasItem(Ego, Shoestone)) dropItem(Ego, Shoestone) ;
 if (hasItem(Ego, Screw)) dropItem(Ego, Screw) ;
 if (hasItem(Ego, Petrolcan)) dropItem(Ego, Petrolcan) ;
 if (hasItem(Ego, Masterkey)) dropItem(Ego, Masterkey) ;
 if (hasItem(Ego, Cactuspot)) dropItem(Ego, Cactuspot) ;	 
 if (hasItem(Ego, Scheibeleer)) dropItem(Ego, Scheibeleer) ;
 if (hasItem(Ego, Scheibeleer2)) dropItem(Ego, Scheibeleer2) ;
 if (hasItem(Ego, Scheibehocker)) dropItem(Ego, Scheibehocker) ;
 if (hasItem(Ego, DiaryInv)) dropItem(Ego, DiaryInv) ;	 
	 
 if (!hasItem(Ego, Shoe)) takeItem(Ego, Shoe) ;	 
}

/* ************************************************************* */
//
//                            Akt 4
//
/* ************************************************************* */

object Wires {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Wires_image) ;
 name = "Kabel" ;	
} 

event LookAt -> Wires {
 clearAction ;
 Ego:
  "Viele, kleine, rote K#belchen."
}

/* ************************************************************* */

object Keycard {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Keycard_image) ;
 name = "Keycard" ;	
} 

event LookAt -> Keycard {
 clearAction ;
 Ego:
  "Das ist eine SamTec-Security-Keycard eines gewissen 'Agent Johnson'."
  if ((random(5)) > 3) say("Was f]r ein Trottel.") ;
}

/* ************************************************************* */

object Probe {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Probe_image) ;
 name = "Probe" ;	
} 

event LookAt -> Probe {
 clearAction ;
 Ego:
  "Eine Abwasserprobe die ich von einem der Abflussrohre des SamTec-Labors genommen habe."
}

/* ************************************************************* */

object Reagenzglas {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Reagenzglas_image) ;
 name = "Reagenzglas" ;	
} 

event LookAt -> Reagenzglas {
 clearAction ;
 Ego:
  "Ein unbenutztes Reagenzglas."
}


/* ************************************************************* */

script disguisedEgo {
 return Kittel.getField(0) ;
}

script disguiseEgo {
 Kittel.setField(0, 1) ;
}

object Kittel {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Coat_image) ;
 name = "Kittel" ;	
} 

event LookAt -> Kittel {
 Ego: 
  "Ein #lterer, gebrauchter und etwas verschmutzter Laborkittel."
  "Die Taschen sind leer."
 clearAction ;
}

// event Use -> kittel: see Samtecempfang\Samtecempfang.s

/* ************************************************************* */

object Anleitung {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::HowTo_image) ;
 name = "Kn#uel" ;	
} 

script unfoldedAnleitung {
 return Anleitung.getField(0) ;
}

script readAnleitung {
 return Anleitung.getField(1) ;
}

script Anleitung_Handler(key) {
  switch key {
    case <DRAW>: 
	drawingPriority = PRIORITY_HIGHEST ; 
	drawingColor = RGBA(255,255,255,255) ; 
	drawImage(0,0,Graphics::Howtobig_image) ;
    case <LBUTTON>, <ESC>, <SPACE>:  
	ShowInventory ; 
        clearAction ; 
	return 1 ; 
  }
}
 
event LookAt -> Anleitung {
 if (!unfoldedAnleitung) {
  Ego:
   say("Ich falte das auseinander...") ;
   suspend ;
   EgoStartUse ;
   soundBoxPlay(Music::Unfold_wav) ;
   Anleitung.name = "Anleitung" ;
   Anleitung.setAnim(Graphics::HowToUnfolded_image) ;
   Anleitung.setField(0, true) ;
   EgoStopUse ;
   delay 4 ;
   say("Sieht mir nach einer Anleitung zum Knacken von Garagentoren mit Drehstromantrieb aus.") ;
   delay 2 ;
   say("Das schau ich mir genauer an.") ;
   triggerObjectOnObjectEvent(Use, Anleitung) ;   
 } else {
	 
   if (chaseStage == 2) {
    clearAction ;
    Ego.say("Jetzt nicht!") ;
    return ;
   }	 	 
	 
   Ego:
    say("Eine Anleitung zum Knacken von Garagentoren mit Drehstromantrieb.") ;
   delay 2 ;
   triggerObjectOnObjectEvent(Use, Anleitung) ;
 }
 clearAction ;
}

event Use -> Anleitung {
 if (!unfoldedAnleitung) {
   triggerObjectOnObjectEvent(LookAt, Anleitung) ;
 } else {
	 
    if (nightVision.enabled or darknessEffect.enabled) {  
      Ego.say("Jetzt nicht.") ; 
      clearAction ;
      return ;
    }
	 
   HideInventory ;
   InterruptCaptions ;
   Anleitung.setField(1,true) ;
   Menu(&Anleitung_Handler) ;
 }
}

/* ************************************************************* */

script wonciekSolvedLS {
 return Notiz.getField(0) ;
}

script wonciekSolveLS {
 Notiz.setField(0, true) ;
}

object Notiz {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Zettel_image) ;
 name = "Notiz" ;	
} 

event LookAt -> Notiz {
 suspend ;
 Ego:
  "Ein lila Notizzettel. Darauf steht:"
 delay 4 ;
  "'Johnson, falls Sie die vier Zahlen der Kombination f]r den Tresor wieder vergessen haben:'"
 delay 1 ;
  "'Die ersten beiden Zahlen sind am Safe wie gehabt abzulesen.'"
 delay 2 ;
  "'Beginnen Sie mit der kleineren Ziffer.'"
 delay 2 ;
  "'Die anderen beiden Zahlen sind Primzahlen, wobei die letzte um zwei gr[}er ist, als die vorletzte.'"
 delay 2 ;
 if (! wonciekSolvedLS) {
   "'Mit freundlichen Gr]}en, Brander'"
   delay 2 ;
   "'VERGESSEN SIE NICHT, DASS SICH DARIN STRENG VERTRAULICHE DOKUMENTE BEFINDEN!'"
   "'ENTT@USCHEN SIE MICH NICHT WIEDER!'"
 } else {
   "Peter meinte, dass Primzahlen ganze Zahlen, und nur durch sich selbst und eins glatt teilbar sind."
 }
 clearAction ;
}

/* ************************************************************* */

object Klappspaten {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Klappspaten_image) ;
 name = "bedrucktes Blatt Papier" ;
}

event LookAt -> Klappspaten {
 if (chaseStage == 2) {
  clearAction ;
  Ego.say("Jetzt nicht!") ;
  return ;
 }
 Ego:
  say("Das fand ich in dem stillgelegten SamTec-Labor.") ;
  say("Die {berschrift lautet: 'Operation Klappspaten'.") ;
 delay 5 ;
 if (nightVision.enabled or darknessEffect.enabled) {    
   clearAction ;
   return ;
 }
 forceHideInventory ;
 interruptCaptions ;
 Menu(&Klappspaten_Handler) ; 
}

script Klappspaten_Handler(key) {
  switch key {
    case <DRAW>: drawingPriority = PRIORITY_HIGHEST ; 
                 drawingColor = RGBA(255,255,255,255) ; 
                 drawImage(0,0,Graphics::Klappspatenbig_image) ;
    case <LBUTTON>, <ESC>, <SPACE>:  forceShowInventory ; 
                 clearAction ; return 1 ; 
  }
}

/* ************************************************************* */

object Dokumente {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Documents_image) ;
 name = "streng vertrauliche Dokumente" ;	
} 

event LookAt -> Dokumente {
 suspend ;
 Ego: 
  "Das sind von einem unabh#ngigen Institut vorgenommene Gentoxizit#tstests..."
  "...der Abw#sser des stillgelegten SamTec-Labor von vor etwa zwei Monaten."
 delay 3 ;
  "Und nach internationalen Kriterien sind die Abw#sser eindeutig mutagen!"
 clearAction ;
}

/* ************************************************************* */

object Nasenbrille {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Noseglasses_image) ;
 name = "Nasenbrille" ;	
} 

event LookAt -> Nasenbrille {
 Ego:
  say("Die habe ich von dem seltsamen Rezeptionisten.") ;
  say("Und noch keine Ahnung wieviel sie mich kosten wird...") ;
 clearAction ;
}

event Use -> Nasenbrille {
 Ego:
  say("Ich muss mich jetzt nicht verkleiden.") ;
 clearAction ;
}

/* ************************************************************* */

object Raetselbuch {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::book_image) ;
 name = "'R#tsel und Knobeleien'-Buch" ;	
} 

script pickRiddle {
 loop {
  Ego:
   addChoiceEchoEx(RIDDLE_MOTHER, "Mutter, Tochter und Vater", false) ;
   addChoiceEchoEx(RIDDLE_PIGEON, "Fliegende Taubenschar", false) ;
   addChoiceEchoEx(RIDDLE_NUMBER, "Zahlenr#tsel nach Johann Hemeling", false) ;
   addChoiceEchoEx(RIDDLE_CHESS, "Springer auf dem Schachbrett", false) ;
   addChoiceEchoEx(RIDDLE_ROPELADDER, "Strickleiter am Tanker", false) ;
   addChoiceEchoEx(RIDDLE_PARADOX, "Die Fee im Traum", false) ;
   addChoiceEchoEx(RIDDLE_INTEGER, "Nat]rliche Zahl gesucht", false) ;
   addChoiceEchoEx(RIDDLE_SHANDY, "Das Radler", false) ;
   addChoiceEchoEx(RIDDLE_NONE, "keines", false) ;
   return dialogEx ;  
 }		
}
event use -> Raetselbuch {
 triggerObjectOnObjectEvent(LookAt, Raetselbuch) ;
}

event LookAt -> Raetselbuch {
 suspend ;
 Ego:
 
 if (chaseStage == 2) {
  clearAction ;
  Ego.say("Jetzt nicht!") ;
  return ;
 }
 
 if (darknessEffect.enabled) {  
   Ego.say("Es ist zu dunkel zum Lesen.") ; 
   clearAction ;
   return ;
 }
 
  "Das Buch tr#gt den Titel 'R#tsel und Knobeleien'."
  "Welches R#tsel soll ich mir genauer ansehen?"
  printRiddle(pickRiddle) ;
 clearAction ;
}

script printRiddle(myRiddle) {
	
 switch myRiddle {
   case RIDDLE_MOTHER:
	"Olivia ist genau 25 Jahre j]nger als ihre Mutter."
	"In 7 Jahren wird die Mutter 5 mal so alt sein wie Olivia."
	"Wo befindet sich Olivias Vater?"
	
   case RIDDLE_PIGEON:
	"Eine fliegende Taubenschar kam zu einem hohen Baume" 
	"ein Teil von ihnen setzte sich auf den Baum, ein anderer darunter."
	"Da sprachen die auf dem Baume zu denen die darunter lagerten:" 
	"'Wenn eine von euch herauffliegt, so seid ihr ein Drittel von uns allen"
	"und wenn eine von uns hinabfliegt, so werden wir euch an Zahl gleich sein.'"
	
   case RIDDLE_NUMBER:
	"Rechner, gebet eine Zahl,"
	"Wenn man sie ein achtteil Mal"
	"Zu einhundertf]nfzig legt,"
	"dass es f]nfzig mehr betr#gt,"
	"Als wenn man sie ohne Wahl"
	"Richtig setzt dreiviertel mal."
	"Nun zeigt an mit schneller Frist:"
	"Was f]r eine Zahl es ist!"
	
   case RIDDLE_CHESS:
	"Bei einem Schachbrett (A-H, 1-8) fehlen Feld A1 und H8..."
	"also die Endfelder einer Diagonalen. Ein Springer soll jetzt auf alle..." 
	"Felder des unvollst#ndigen Schachbrettes genau einmal springen."
	"Auf welchem Feld startet der Springer und wo muss er landen? "
	
   case RIDDLE_ROPELADDER:
	"Vor der K]ste liegt ein Tanker vor Anker."
	"Das Meer ist sehr ruhig und eine von der Bordwand h#ngende..."
	"Strickleiter ber]hrt mit ihrer untersten Sprosse gerade die Meeresoberfl#che."
	"Da setzt die Flut ein, mit der das Wasser st]ndlich um 20 cm ansteigt."
	"Wie lange dauert es, bis die dritte Sprosse der Strickleiter..."
	"vom Wasser erreicht ist, wenn der Sprossenabstand 25 cm betr#gt?"
	
   case RIDDLE_PARADOX:
	"Eine Fee erscheint dem Philosophen Ben Nils Mordio im Traum, und fragt ihn..."
	"ob der ihr glauben w]rde, wenn sie behauptete, dass das..."
	"was sie als n#chstes sagen w]rde, die Wahrheit sei, was sie aber..."
	"eben gesagt habe, eine L]ge. Was antwortet der Philosoph?"
	
   case RIDDLE_INTEGER:
	"Gesucht ist eine vierstellige nat]rliche Zahl mit folgenden Eigenschaften:"
	"1. Ihre Quersumme ergibt 26."
	"2. Das Querprodukt ist gerade."
	"3. Aus den Ziffern dieser Zahl lassen sich 12 verschiedene Zahlen bilden."
	"4. Streicht man die erste Ziffer weg, so ergibt sich eine Primzahl."
	"Welche ist es?"
	
   case RIDDLE_SHANDY:
	"Ein Mann bestellt in einer Gastst#tte ein Bier trinkt es zur H#lfte aus..."
	"und denkt dann: 'Ein Radler w#re doch besser gewesen!'"
	"So sch]ttet er sein Glas nun mit wei}er Limonade wieder voll."
	"Er trinkt erneut, diesmal mit weniger Durst und leert das Glas nur zu einem Drittel."
	"Aber die Geschmacksrichtung scheint noch immer nicht perfekt."
	"Er gie}t erneut Limo nach, probiert, in dem er ein Sechstel des Glases leert..."
	"ist noch immer nicht zufrieden, kippt das fehlende Sechstel erneut mit Limo nach."
	"Die Geschmacksnerven vibrieren beim Genuss dieses Gemisches."
	"Er trinkt das Glas auf Ex."
	"Hat er mehr Bier oder mehr Limo getrunken?"
	
   default: return ;
 }
}

script printRiddleSolution(myRiddle) {
 switch (myRiddle) {
  case RIDDLE_MOTHER:     "Neun Monate vor der Geburt der Tochter wird sich der Vater vermutlich in der Mutter befinden."
  case RIDDLE_PIGEON:     "Sieben Tauben waren auf dem Dach, und f]nf darunter."
  case RIDDLE_NUMBER:     "Die gesuchte Zahl ist 160."
  case RIDDLE_CHESS:      "Der Springer kann nicht auf alle Felder des unvollst#ndigen Schachspiels springen, egal wo er anf#ngt."
  case RIDDLE_ROPELADDER: "Mit dem Meeresspiegel steigt auch das Boot, also erreicht das Wasser die dritte Sprosse nie."
  case RIDDLE_INTEGER:    "Die L[sung lautet 4877."
  case RIDDLE_SHANDY:     "Er hat die gleiche Mengen an Bier und Limo getrunken."
 }	
}	

script countSolvedRiddles {
 var res = 0 ;
 if (solvedRiddles.bit[RIDDLE_MOTHER]) res++ ;
 if (solvedRiddles.bit[RIDDLE_PIGEON]) res++ ;
 if (solvedRiddles.bit[RIDDLE_NUMBER]) res++ ;	 
 if (solvedRiddles.bit[RIDDLE_CHESS]) res++ ;	 
 if (solvedRiddles.bit[RIDDLE_ROPELADDER]) res++ ;	 
 if (solvedRiddles.bit[RIDDLE_INTEGER]) res++ ;	 
 if (solvedRiddles.bit[RIDDLE_SHANDY]) res++ ;	 
 return res ;
}

/* ************************************************************* */

object Fax {
 SetupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Fax_image) ;
 name = "Faxger#t" ;	
} 

event LookAt -> Fax {
 Ego:
  clearAction ; 
  "Ein #lteres Faxger#t."
  "Es ist mit einem Computeranschluss versehen." ;
}

event Open -> Fax {
 Ego:
  "Ohne Werkzeug klappt das nicht."
  clearAction ;
}

event Screwdriver -> Fax {
 Ego:
  say("Ich denke nicht, dass mir das weiterhilft.") ;
  say("Au}erdem m]chte ich nicht riskieren, dass es kaputt geht.") ;
 clearAction ;	
}

event Thermopapier -> Fax {
 triggerObjectOnObjectEvent(Faxpapier, Fax) ;
}

event Faxpapier -> Fax {
 Ego:
  say("Ich sollte das Fax erst anschlie}en.") ;
 clearAction ;
}

/* ************************************************************* */

object Faxpapier {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Faxpapier_image) ;
 name = "Papier" ;
}

event LookAt -> Faxpapier {
 Ego:
  clearAction ;
  "Ein Stapel Din-A4-Papier."
}

event Faxpapier -> Zitrone {
 Ego:
  if (did(give)) say("Die Zitrone will das Papier nicht.") ;
   else say("Die Zitrone mit Papier zu umwickeln scheint mir keine so hilfreiche Idee.") ;
 clearAction ;
}

/* ************************************************************* */

object Zitrone {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Zitrone_image) ;
 name = "Zitrone" ;
}

event LookAt -> Zitrone {
 Ego:
  clearAction ;
  say("Eine ]bergro}e Zitrone.") ;
}

event Zitrone -> Faxpapier {
 if (did(give)) {
  Ego:
   "Das macht keinen Sinn..."
 } else {
  Ego:
   "Als Kinder haben wir uns mit sowas immer Geheimnachrichten geschrieben."
  delay 4 ;
   "Mal schauen, ob das immer noch klappt..."
   turn(DIR_NORTH) ;
   egoStartUse ;
  delay 5 ;
   dropItem(Ego, Faxpapier) ;
   dropItem(Ego, Zitrone) ;
   takeItem(Ego, Thermopapier) ;
   EgoStopUse ;
   turn(DIR_SOUTH) ;
 }
 clearAction ;
}

event Push -> Zitrone {
 Ego:
  clearAction ;
  say("Ich m[chte keine Sauerei in meinem Inventar veranstalten.") ;
}

/* ************************************************************* */

object Thermopapier {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Thermopapier_image) ;
 name = "Thermopapier" ;
}

event LookAt -> Thermopapier {
 Ego:
  clearAction ;
  "Ich habe etwas Zitronensaft auf das Papier gegeben."
}

/* ************************************************************* */

object Lab2Key {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Lab2Key_image) ;
 name = "Schl]ssel" ;
}

event LookAt -> Lab2Key {
 Ego:
 clearAction ;
  "Ein kleiner Schl]ssel, den der Wissenschaftler verlor."
}

/* ************************************************************* */

object Hammer {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Hammer_image) ;
 name = "Hammer" ;
}

event LookAt -> Hammer {
 Ego:
 clearAction ; 
  say("Ein robuster Hammer.") ;
  say("Im Leben kommt es darauf an, Hammer oder Ambo} zu sein - aber niemals das Material dazwischen.") ;
}

event Hammer -> Hammer {
 Ego:
  delay 10 ;
  "Also nach einigem {berlegen bin ich zu dem Entschluss gekommen, nicht weiter dar]ber nachzudenken." 
 clearAction ;
}

event Hammer -> invObj {
 Ego: 
  say("Ich habe das nicht bis jetzt mit mir herumgeschleppt, um es jetzt kaputt zu h#mmern.") ;	
 clearAction ;  
}


/* ************************************************************* */

object Ausdruck {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Ausdruck_image) ;
 name = "Ausdruck" ;
}

event use -> Ausdruck {
 triggerObjectOnObjectEvent(LookAt, Ausdruck) ;
}

event LookAt -> Ausdruck {
 Ego:
  say("Das ist der Ausdruck aus dem Samtec Zentralrechner.") ;
  say("Er schildert den Ablauf einer geheimen Operation, die die profitbringende Verpestung des Nilwassers zum Ziel hat.") ;
 delay 5 ;
 if (nightVision.enabled or darknessEffect.enabled) {    
   clearAction ;
   return ;
 }
 forceHideInventory ;
 interruptCaptions ;
 Menu(&Ausdruck_Handler) ; 
}

script Ausdruck_Handler(key) {
  switch key {
    case <DRAW>: drawingPriority = PRIORITY_HIGHEST ; 
                 drawingColor = RGBA(255,255,255,255) ; 
                 drawImage(0,0,Graphics::Ausdruckbig_image) ;
    case <LBUTTON>, <ESC>, <SPACE>:  forceShowInventory ; 
                 clearAction ; return 1 ; 
  }
}

/* ************************************************************* */

object Nachtsicht {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Nachtsicht_image) ;
 name = "Nachtsichtger#t" ;
}

event LookAt -> Nachtsicht {
 Ego:
  say("Ein kleines, handliches Nachtsichtger#t.") ;
  if (Nachtsicht.getField(1)) say("Es sind keine Batterien drin.") ;
 clearAction ;
}

event Open -> Nachtsicht {
 Ego:
 if (Nachtsicht.getField(1)) {
   say("Ich habe die Batterien schon rausgenommen.") ;
   clearAction ;
   return ;
 }
 if (currentScene!=Securitygef) {
   say("Da sind Batterien drin.") ;
   say("Sie rauszunehmen hilft mir aber jetzt auch nicht weiter.") ;
   clearAction ;
   return ;
 }
 if (nightVision.enabled) {
   say("Ich schalte es besser zuvor aus.") ;
   triggerObjectOnObjectEvent(Use, Nachtsicht) ;
 } 
 turn(DIR_NORTH) ;
 EgoStartUse ;
 soundBoxPlay(Music::Rausnehmen_wav) ;
 Nachtsicht.setField(1, true) ;
 takeItem(Ego, A4) ;
 EgoStopUse ;
 turn(DIR_SOUTH) ;
 clearAction ;
}

event A4 -> Nachtsicht {
 if (Nachtsicht.getField(1)) {
  Ego:
   turn(DIR_NORTH) ;
   EgoStartUse ;
   soundBoxStart(Music::Einlegen_wav) ;
   dropItem(Ego, A4) ;
   Nachtsicht.setField(1,false) ;
   EgoStopUse ;
   turn(DIR_SOUTH) ;
 } else Ego.say("Da sind schon Batterien drin.") ;
 clearAction ;
}

event Use -> Nachtsicht {
 if ((currentScene == Securitygef) || (currentScene == Securitygef2) || (currentScene == Securitygang) || (currentScene == Securitylab1) || (currentScene == Securitylab2)) {
   if (nightVision.enabled) { 
     nightVisionOff ; 
     if (currentScene == Securitygef2) DarknessEffect.enabled = true ;
   } else { 
     if (!darknessEffect.enabled) { Ego.say("Es ist hell genug.") ; clearAction ; return ; }
     if (currentScene == Securitygef2) { Ego.say("Die Taschenlampe erweist mir gute Dienste.") ; clearAction ; return ; }
     if (Nachtsicht.getField(1)) {Ego.say("Die Batterien fehlen.") ; clearAction ; return ; }
     if (Flashlight.getField(0)) { 
       triggerObjectOnObjectEvent(Use, Flashlight) ;
       Ego.say("Die Taschenlampe schalte ich aus.") ;
     }
     nightVisionOn ;     
   }
 } else Ego.say("Ich brauche es nicht.") ;
 clearAction ;
}

event Screwdriver -> Nachtsicht {
 Ego:
  clearAction ;
  say("Ich schraube es besser nicht auf. Es scheint mir funktionst]chtig.") ;
}

/* ************************************************************* */

object Battery {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Battery_image) ;
 name = "Autobatterie" ;
}

event LookAt -> Battery {
 Ego:
 clearAction ;
  say("Die Autobatterie aus meinem Truck.") ;
  say("Der H#ndler sagte, ich soll sie zur]ck bringen.") ;
}

/* ************************************************************* */

object sciDiary { // setField(0,true): player read the diary
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::SciDiary_image) ;
 name = "Aufzeichnungen" ;
}

script readSciDiary { return sciDiary.getField(0) ; } 

event Use -> sciDiary {
 triggerObjectOnObjectEvent(LookAt, sciDiary) ;
}

event LookAt -> sciDiary {
 Ego:
 
  if ((currentScene!=Securitygef) and (currentScene!= Securitygef2)) {
    say("Keine Zeit.") ;
    clearAction ;
    return ;
  }
 
  if (readSciDiary) {
   say("Das sind die Aufzeichnungen eines SamTec-Wissenschaftlers der hier eingesperrt wurde, weil er zuviel fragen gestellt hat.") ;
   say("Au}erdem beschreibt der Wissenschaftler, dass er ein Ger#t gebaut hat, mit dem sich diese T]r [ffnen l#sst.") ;
   say("Ich sollte sp#ter Peter diese Aufzeichnungen zeigen.") ;
   clearAction ;
   return ;
  }
  
 hideInventory ;
 delay 20 ;
 say("Das sind Aufzeichnungen eines Wissenschaftlers, der hier gearbeitet hat.") ;
 delay 30 ;
 say("Das ist ja unfassbar!") ;
 say("Er schreibt, dass er hier eingesperrt worden ist!") ;
 say("Dem Datum des ersten Eintrags nach zu urteilen muss das etwa vor einem Monat gewesen sein.") ;
 delay 15 ;
 say("Das ist interessant:") ;
 delay 4 ;
 
 say("'Bei meinem w[chentlichen Datenbackup fiel mir ein Verzeichnis ins Auge, dass der Chef wohl versehentlich im Netzwerk freigegeben hatte.'") ;
 say("'Er enthielt diverse Briefe, die sowohl einige Rationalisierungsma}nahmen in unseren Produktionswerkst#tten ank]ndigten sowie...") ;
 say("...Kooperationsanfragen an ein Unternehmen namens \"Voltan Firearms\".'") ;
 say("'Schnell fand ich heraus, dass \"Voltan Firearms\", wie der Name schon andeutet, tats#chlich Schusswaffen und Panzer herstellt.'") ;
 say("'Ich war zun#chst geschockt, dann ver#rgert, dass Brander weder mich als Betriebsrat...") ;
 say("'...noch den Wirtschaftsausschuss von seinen Pl#nen informiert hat.'") ;
 say("'Sein Verhalten ist seit unserer Entdeckung f]r mich absolut undurchschaubar geworden.'") ;
 say("'Ich machte einen Termin mit ihm aus, und stellte ihn zur Rede.'") ;
 say("'Er zeigte sich ]berrascht und meinte, dass er die Rationalisierungsma}nahmen noch mit mir besprechen wollte...") ;
 say("...und er mit gegen]ber keine Mitteilungspflicht bez]glich wirtschaftlichen Angelegenheiten bes#}e.'") ;
 say("'Auf mein Dr#ngen hin, zumindest den Wirtschaftssausschuss von seinen Pl#nen zu unterrichten und offenzulegen...") ;
 say("...inwiefern eine Kooperation mit einem auf die Produktion von Schusswaffen spezialisiertes Unternehmen fruchtbar f]r unsere Zwecke sein k[nnte...") ;
 say("...lie} mich Brander von diesen zwei Affen mit Sonnenbrillen aus seinem B]ro werfen.'") ;
 say("'Am n#chsten Morgen lag ein Brief auf meinem Schreibtisch, indem stand, dass ich meine Nase aus Dingen raushalten sollte, die mich nichts angingen...") ;
 say("...sofern ich meinen Arbeitsplatz nicht verlieren m[chte.'") ;
 say("'Sofort schrieb ich Leroy eine Mail mit der Absicht mich sobald wie m[glich mit ihm zu treffen.'") ;
 say("'Er antwortete, dass er gerade Zeit hat und ich zu ihm hoch kommen soll.'") ;
 say("'Als ich an seine B]rot]r klopfte sagte mir Johanna im Vorbeigehen noch, dass Leroy krankgeschrieben sei.'") ;
 say("'Ich [ffnete die T]r, und das letzte, woran ich mich erinnern kann ist dass ich noch einen dieser Jackson- oder Johnson-Br]der am Schreibtisch sitzen sah.'") ;
 
 delay 20 ;
 say("Das sollte ich unbedingt Peter zeigen...") ;
 delay 23 ;
 say("Das hier weiter hinten ist auch noch aufschlussreich:") ;
 delay 10 ;
 
 say("'Nachdem ich etwa ein Tag hier eingesperrt war, kam einer der Schl#ger herein, um mich mit Nahrung zu versorgen.'") ;
 say("'Mir fiel auf, dass die \"Game Over\"-Lampe w#hrend die T]r offen ist, nicht mehr blinkte.'") ;
 say("'Nachdem der Schl#ger die T]r von drau}en wieder schloss, blinkte die Lampe mit einer anderen Frequenz, als vor dem Besuch.'") ;
 say("'Meine Theorie, dass irgendjemand einen Fehler bei der Konstruktion dieser Gef#ngnist]r gemacht haben muss, best#tigte sich relativ bald.'") ;
 say("'Die Vermutung lag nahe, dass die Lampe mit dem T]r[ffnungsmechanismus auf der anderen Seite verkabelt war.'") ;
 say("'Nach einigen Experimenten und Versuchen diesen Mechanismus zu knacken, gelang es mir mithilfe der Elektronik...") ;
 say("...aus den Kisten unterschiedliche Frequenztr#ger zusammenzuschalten, um ein einfaches Frequenzmultiplexverfahren zu realisieren.'") ;
 say("'Zur Stromversorgung dienen herk[mmliche A4-Batterien, die ich aus einem alten aber funktionst]chtigen Nachtsichtger#t nahm.'") ;
 say("'Die Frequenztr#ger werden automatisch mit dem Signal moduliert, das die T]r [ffnet...") ;
 say("...und auf die Leitungen der Lampe gekoppelt, die zu dem Bedienfeld auf der anderen Seite f]hren.'") ;
 say("'Man muss lediglich darauf achten, die passende Anfangs-Frequenz zu finden, was sich ]ber drei Schalter meines elektrischen T]r[ffners - ") ;
 say("...ich taufte ihn FMPT| (Frequenzmultiplext]r[ffner) bewerkstelligen l#sst.'") ;
 say("'Diese Anfangsfrequenz wird jedesmal, wenn die T]r geschlossen wird, zuf#llig, zwischen sieben m[glichen Frequenzen, eingestellt.'") ;
 
 delay 10 ;
 say("Das muss dieses Ger#t sein, das ich mit den Aufzeichnungen fand.") ;
 delay 20 ;
 say("Ansonsten steht hier nichts mehr Wichtiges.") ;
 
 freqDevice.name = "Frequenzmultiplext]r[ffner" ;
 sciDiary.setField(0,true) ;
 showInventory ;
  
 clearAction ;
}

/* ************************************************************* */

object Kreide {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Kreide_image) ;
 name = "St]ck Kreide" ;
}

event LookAt -> Kreide {
 Ego:
  clearAction ;
  "Es ist ein kleines St]ck Tafelkreide aus Kalk."
}

/* ************************************************************* */

object Monkey {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::XRay_image) ;
 name = "R[ntgenbild eines dreik[pfigen Affens" ;
}

event LookAt -> Monkey {
 if (chaseStage == 2) {
  clearAction ;
  Ego.say("Jetzt nicht!") ;
  return ;
 }	
 static var firstComment = false ;
 suspend ;
 Ego:     
  "Und ich hab dreik[pfige Affen immer f]r ein Hirngespinst gehalten!"
 if (!firstComment) {
   say("Affen sind Tiere, die auf B#umen leben, besonders gern auf Stammb#umen.") ;
   firstComment = true ;
 }
 delay 5 ;  
 if (nightVision.enabled or darknessEffect.enabled) {  
   clearAction ;
   return ;
 }
 forceHideInventory ;
 interruptCaptions ;
 Menu(&Xray_Handler) ;  
}

script Xray_Handler(key) {
  switch key {
    case <DRAW>: drawingPriority = PRIORITY_HIGHEST ; 
                 drawingColor = RGBA(255,255,255,255) ; 
                 drawImage(0,0,Graphics::XrayBig_image) ;
    case <LBUTTON>, <ESC>, <SPACE>:  forceShowInventory ; clearAction ; return 1 ; 
  }
}


/* ************************************************************* */

script freqDeviceWorking {
 return freqDevice.getField(0) ;
}

object freqDevice {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::FMP_image) ;
 name = "seltsames Ger#t" ;
}

event Open -> freqDevice {
 Ego:
  if (freqDeviceWorking) {
    say("Ich nehme die Batterien raus.") ;
    turn(DIR_NORTH) ;
    EgoStartUse ;
    soundBoxPlay(Music::Rausnehmen_wav) ;
    takeItem(Ego, A4) ;
    freqDevice.setField(0, false) ;
    EgoStopUse ;
    clearAction ;
    return ;
  }
  say("Das geht nicht.") ;
 clearAction ;
}

event A4 -> freqDevice {
 Ego:
  say("Ich lege die Batterien ein.") ;
 turn(DIR_NORTH) ;
 EgoStartUse ;
 start { soundBoxPlay(Music::Einlegen_wav) ; soundBoxStart(Music::FreqStart_wav) ; }
  dropItem(Ego, A4) ;
  freqDevice.setField(0, true) ;
 EgoStopUse ;
 clearAction ;
}

event LookAt -> freqDevice {
 Ego:
 if (readSciDiary) say("Das ist ein Frequenzmultiplext]r[ffner.") ;
  else say("Hmmm. Ich habe keine Ahnung, was das darstellen soll.") ;
 if (freqDeviceWorking) say("Es sind Batterien eingelegt.") ;
 clearAction ;
}

event Screwdriver -> freqDevice {
 Ego:
  clearAction ;
  say("Ich schraube das Ger#t besser nicht auf.") ;
  say("Nacher mache ich noch etwas kaputt.") ;
}

/* ************************************************************* */
//
//                            Akt 5
//
/* ************************************************************* */

object Kondensmilch {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Kondensmilch_image) ;
 name = "Kondensmilch" ;
}

event LookAt -> Kondensmilch {
 Ego:
  "Eine portionierte Packung Kondensmilch, die ich von der Bedienung zum Kaffee erhalten habe."
 clearAction ;
}

/* ************************************************************* */

object IDCard {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Sicherheitskarte_image) ;
 name = "Identifikationskarte" ;
}

event LookAt -> IDCard {
 Ego:
  "Die Identifikationskarte eines gewissen Herrn Lange."
 clearAction ;
}

/* ************************************************************* */

object Haarklammer {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Haarklammer_image) ;
 name = "Haarklammer" ;	
}

event LookAt -> Haarklammer {
 Ego:
  "Eine kleine schwarze Haarklammer."
 clearAction ;
}

event Stock -> Haarklammer {
 triggerObjectOnObjectEvent(Haarklammer, Stock) ;
}

event Haarklammer -> Stock {
 Ego.say("Ich stecke die Haarklammer in den Spalt am Ende des Stocks.") ;
 Ego.turn(DIR_NORTH) ;
 EgoStartUse ;
 takeItem(Ego, Stockklammer) ;
 dropItem(Ego, Stock) ;
 dropItem(Ego, Haarklammer) ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Stock {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Stock_image) ;
 name = "Bambusstock" ;	
}

event LookAt -> Stock {
 Ego:
  "Ein stabiler Bambusstock." 
 clearAction ;
}

/* ************************************************************* */

object StockKlammer {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Stockklammer_image) ;
 name = "Bambusstock mit Haarklammer" ;	
}

event LookAt -> StockKlammer {
 Ego:
  "Eine weitere Konstruktion des Chef-Mechanikers JULIAN HOBLER!"
  "Eine Haarklammer ist in das gespaltene Ende eines Bambusstocks gesteckt."
 clearAction ;
}

/* ************************************************************* */

object invDrinks {
 setupAsInvObj ;
}

object DrinkOrange {
 class = invDrinks ;
 enabled = false ;
 setAnim(Graphics::Orangensaft_image) ;
 name = "Orangensaft" ;
}

event LookAt -> DrinkOrange {
 Ego:
  "Ein Glas Orangensaft."
 clearAction ;
}

object DrinkApfel {
 class = invDrinks ;
 enabled = false ;
 setAnim(Graphics::Apfelsaft_image) ;
 name = "Apfelsaft" ;
}

event LookAt -> DrinkApfel {
 Ego:
  "Ein Glas Apfelsaft."
 clearAction ;
}

object DrinkGrog {
 class = invDrinks ;
 enabled = false ;
 setAnim(Graphics::Grog_image) ;
 name = "Grog" ;
}

event LookAt -> DrinkGrog {
 Ego:
  "Ein Glas Grog."
  "Es ist offensichtlich kein echter Grog."
 clearAction ;
}

object DrinkKaffee {
 class = invDrinks ;
 enabled = false ;
 setAnim(Graphics::Kaffee_image) ;
 name = "Kaffee" ;
}

event LookAt -> DrinkKaffee {
 Ego:
  "Eine Tasse Kaffee."
 clearAction ;
}

object DrinkBier {
 class = invDrinks ;
 enabled = false ;
 setAnim(Graphics::Bier_image) ;
 name = "Bier" ;
}

event LookAt -> DrinkBier {
 Ego:
  "Ein Glas Bier."
 clearAction ;
}

/* ************************************************************* */

script drySoap(dry) {
 Seife.setField(0, dry) ;
 if (dry) Seife.name = "getrocknetes St]ck Seife" ;
   else Seife.name = "nasses St]ck Seife" ;
}

script driedSoap {
 return Seife.getField(0) ;
}

object Seife {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Seife_image) ;
 name = "nasses St]ck Seife" ;	
}

event LookAt -> Seife {
 Ego:
  say("Ein St]ck Seife.") ;
 if (driedSoap) say("Ich habe es mit dem F[n getrocknet.") ;
  else say("Es ist ziemlich nass.") ;
 delay 3 ;
  say("Mir scheint, als ob ein fremder Fingerabdruck darauf zu sehen ist.") ;
 clearAction ;
}

/* ************************************************************* */

object Bleistift {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Pencil_image) ;
 name = "Bleistift" ;
}

event LookAt -> Bleistift {
 Ego:
  "Ein Bleistift mit gr]ner Umrandung."
  "Ich mag gr]n."
 clearAction ;
}

/* ************************************************************* */

object SFormular {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::Formular_image) ;
 name = "Formular" ;
}

event LookAt -> SFormular {
 Ego:
  "Auf diesem Formular sind Felder f]r Name und Adresse, an die man Informations-Post vom SamTec-Konzern schicken lassen kann."
 clearAction ;
}

event Bleistift -> SFormular {
 Ego:
  say("Das Formular werde ICH ganz gewiss nicht ausf]llen.") ;
 clearAction ;
}

event Bleistift -> SFormularV {
 triggerObjectOnObjectEvent(Bleistift, SFormular) ;
}

event SFormularS -> Seife {
 triggerObjectOnObjectEvent(Seife, SFormularS) ;
}

event Seife -> SFormularS {
 Ego:
  say("Ich habe schon einen Abdruck gemacht.") ;
 clearAction ;
}

event SFormularV -> Seife {
 triggerObjectOnObjectEvent(Seife, SFormularV) ;
}

event Seife -> SFormularV {
 Ego:
  say("Ich nehme besser ein frisches Formular, das hier ist zu nass und voller verschmierter Seife.") ;
 clearAction ;
}

event SFormularF -> Seife {
 triggerObjectOnObjectEvent(Seife, SFormularF) ;
}

event Seife -> SFormularF {
 Ego:
  say("Ich habe bereits einen sichtbaren Fingerabdruck auf dem Formular.") ;
 clearAction ;
}

event SFormular -> Seife {
 triggerObjectOnObjectEvent(Seife, SFormular) ;
}

event Seife -> SFormular {
 Ego:
  turn(DIR_SOUTH) ;
  say("Ich versuche einen Abdruck der Seife auf die R]ckseite des Formulars zu machen...") ;
  
 delay 4 ;
  turn(DIR_NORTH) ;
  EgoStartUse ;
 if (driedSoap) {
  dropItem(Ego, SFormular) ;
  takeItem(Ego, SFormularS) ;
  delay 3 ;  
  say("Der Fingerabdruck ist nun als Seifenr]ckstand auf dem Formularblatt.") ;
 } else {
  dropItem(Ego, SFormular) ;
  takeItem(Ego, SFormularV) ;
  say("Hmmm...") ;
  delay 4 ;
  say("Der Abdruck ist so verschmiert dass man nichts mehr erkennen kann.") ;
  say("Die Seife ist zu nass.") ;
 }
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object SFormularS {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::FormularS_image) ;
 name = "Formular mit Seifenabdruck" ;
}

event LookAt -> SFormularS {
 Ego:
  "Auf die Rückseite des Formulars habe ich mit Seife einen Fingerabdruck von Herrn Lange gepresst."
 clearAction ;
}

event SFormularS -> Bleistift {
 triggerObjectOnObjectEvent(Bleistift, SFormularS) ;
}

event Bleistift -> SFormularS {
 Ego:
 
  turn(DIR_SOUTH) ;
  delay 2 ;
  say("Ich verwende die Spitze des Schraubenziehers um aus der Bleistiftmine etwas Graphitpulver herzustellen...") ;
  delay 4 ;
  turn(DIR_NORTH) ;
  EgoStartUse ;
  soundBoxPlay(Music::Pencilfinger_wav) ;
  EgoStopUse ;
  delay 2 ;
  say("Das Pulver streue ich auf den Seifenr]ckstand.") ;
  egoStartUse ;
  dropItem(Ego, SFormularS) ;  
  takeItem(Ego, SFormularF) ;
  egoStopUse ;
  say("Es bleibt an den Stellen das Abdrucks haften!") ;
  delay 3 ;
  turn(DIR_SOUTH) ;
  delay 2 ;
  say("JULIAN HOBLER ist der Chef-Forensiker!") ;
  
 clearAction ;
}

/* ************************************************************* */

object SFormularV {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::FormularV_image) ;
 name = "Formular mit verwischtem Seifenabdruck" ;
}

event LookAt -> SFormularV {
 Ego:
  "Ich habe versucht mit der nassen Seife einen Fingerabdruck von Herrn Lange auf die R]kseite des Formulars zu pressen."
  "Jedoch ist das Blatt jetzt total nass und verschmiert, so dass man nichts mehr erkennen kann, was einem Fingerabdruck #hneln k[nnte."
 clearAction ;
}

/* ************************************************************* */

object SFormularF {
 setupAsInvObj ;
 enabled = false ;
 setAnim(Graphics::FormularF_image) ;
 name = "Formular mit sichtbarem Fingerabdruck" ;
}

event Bleistift -> SFormularF {
 Ego: 
  say("Ich habe den Fingerabdruck schon sichtbar genug gemacht.") ;
 clearAction ;
}

event LookAt -> SFormularF {
 Ego:
  "Auf der R]ckseite des Formulars habe ich einen Fingerabdruck von Herrn Lange abgebildet."
 clearAction ;
}




