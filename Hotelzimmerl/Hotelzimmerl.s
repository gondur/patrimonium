// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
  
  if (previousScene != Ausgrabungsstelle) forceShowInventory ;
	  
  backgroundImage = hotelzimmerl_image ;
  backgroundZBuffer = hotelzimmerl_zbuffer ;
  
  if (WonciekAtHotel) {
   Peter:
    setPosition(225,247) ;
    face(DIR_EAST) ;    
    pathAutoScale = false ;
    scale = 800 ;    
    clickable = true ;
    enabled = true ;
    visible = true ;
    enablePeterTalk ;
    //setClickArea(0,0,82,76) ; 
    clickable = false ;
  }
  
  Ego:
   path = 0 ;
   Scale = 1000 ;
   positionX = 250 ;
   positionY = 500 ;
   face(DIR_NORTH) ;
   walk(250,350) ;
   while (positionY > 360) { delay(1); }
   path = hotelzimmerl_path ;
    
  // Erstes Gespräch wenn der Professor wieder da ist
  if (! TalkedToWonciek and WonciekAtHotel) {
   forceHideInventory ;
   delay 1 ;
   WonciekTalk(true) ;
  }
  
  // Nachdem Julian aus dem Grab entkommen ist
  if (currentAct == 4 and previousScene == Ausgrabungsstelle) {
   forceHideInventory ;
   delay 1 ;
   WonciekTalk2 ;
   forceShowInventory ;
  }
  
  // Nachdem Julian herausgefunden hat, dass die Agenten für SamTec arbeiten
  if (currentAct == 4 and sawAgentsHint and !toldWonciekAgents) {
   forceHideInventory ;
   delay 1 ;
   tellWonciekAgentsCutscene ;
   forceShowInventory ;
  }
  
  clearAction ;
}

/* ************************************************************* */

object Fernseher {
 setClickArea(104,175,171,240) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Fernseher" ;
}

event WalkTo -> Fernseher {
 clearAction ;
 Ego:
  walk(210,303) ;
  turn(DIR_WEST) ;
}

event LookAt -> Fernseher {
 clearAction ;
 Ego: 
  walk(210,303) ;
  turn(DIR_WEST) ;
  "Jetzt nicht. Ich habe zu tun."
}

event Use -> Fernseher {
 TriggerObjectOnObjectEvent(LookAt, Fernseher) ;
}

event Take -> Fernseher {
 clearAction ;
 Ego: 
  walk(210,303) ;
  turn(DIR_WEST) ;  
  "Wusstest du, dass die h#ufigste Todesursache von Elefantenbabys Fluss]berquerungen sind?"	
}

/* ************************************************************* */

script toldWonciekAgents {
 return Wonciek.getField(0) ;
}

script tellWonciekAgents {
 Wonciek.setField(0, true) ;
}

script tellWonciekAgentsCutscene {
 tellWonciekAgents ;
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 Peter:
  turn(DIR_EAST) ;
 Ego:
  "Du glaubst nicht, was ich eben herausgefunden habe."
  "Die Leute, die f]r die Gasexplosion bei mir zuhause verantwortlich sind, und die mich in Echnatons Grabkammer eingesperrt haben..."
  "...arbeiten tats#chlich f]r SamTec!"
 delay 4 ;
 Peter:
  "Was?"
  "Bist Du dir sicher?"
 delay 2 ;
 Ego:
  "Ja."
 if (wonciekSample) { 
   say("Ich habe mich in dem stillgelegten SamTec-Labor n#her umgesehen, von dem ich auch die Abwasserprobe genommen habe.") ;
   say("Und dort habe ich eindeutige Hinweise gefunden.") ;
 } else say("Ich habe mich in einem stillgelegten SamTec-Labor umgesehen, und habe dort eindeutige Hinweise gefunden.") ;
  "Namensschilder und sogar ein 'Mitarbeiter-des-Monats'-Bild."
 Peter:
 delay 3 ;
  "Unglaublich."
 delay 3 ;
  "Ich kann mir aber trotzdem nicht vorstellen, dass sie im Auftrag SamTecs gehandelt haben."
 delay 5 ;
  "Vielleicht waren sie mit dir im Kindergarten und wurden von dir immer geh#nselt?"
  "Und wollten sich r#chen?"
 delay 1 ;
  "Au}erdem ist das Labor doch schon seit geraumer Zeit stillgelegt."
  "M[glicherweise wurden die zwei schon l#ngst von SamTec gefeuert?"
 delay 4 ;
  "Merkw]rdig ist die Sache jedoch schon, keine Frage."
 delay 2 ;
 Ego:
  "Nein, schlie}lich habe ich die zwei mit deinem Chef sprechen h[ren."
 delay 2 ;
 Peter:
  "Hmmmmm..."
  "Ich kann mich morgen bei der Arbeit vielleicht schlau ]ber die beiden machen."  
  "Zuf#lligerweise kenne ich unseren Personalrat, Leroy."
 delay 3 ;
 Ego:
  "Das halte ich f]r keine gute Idee."
  "Du solltest dich aus der Geschichte raushalten."
 delay 4 ;
 if (!hasItem(Ego, Dokumente)) {
    "Ich denke ich werde versuchen, noch mehr ]ber dein Arbeitgeber herauszufinden."
    "Gerade die Sache mit den mutierten Fischen im Nil haben meine Aufmerksamkeit erweckt."
    "Sobald ich was habe, melde ich mich wieder bei dir."
   delay 2 ;
   Peter:
    "In Ordnung."
    "Aber sei weiterhin vorsichtig dabei!"    
 } else {
   Ego.say("Ich habe dort au}erdem einige Dokumente gefunden, die dich interessieren werden.") ;
   delay 2 ;
   Peter.say("Dann zeig sie mir.") ;   
 }
}

object Wonciek {
 setupAsStdEventObject(Wonciek, TalkTo, 307,267, DIR_WEST) ;
 setClickArea(204,141,258,254) ;
 absolute = false ;
 clickable = true ;
 enabled = (currentAct == 4) ;
 visible = false ;
 name = "Peter Wonciek" ;
}

event LookAt -> Wonciek {
 clearAction ;
 Ego: 
  walk(307,267) ;
  turn(DIR_WEST) ;
  "Das ist mein ehemaliger Professor f]r theoretische Physik, Peter Wonciek."
 if (mutatedPeter) say("Ihm ist ein drittes Ohr auf der Stirn gewachsen.") ;
}

event Take -> Wonciek {
 clearAction ;
 Ego: 
  walk(307,267) ;
  turn(DIR_WEST) ;
  "So verzweifelt bin ich noch nicht..."
}

event TalkTo -> Wonciek {
 Ego: 
  walk(307,267) ;
  turn(DIR_WEST) ;
  WonciekTalk3 ;	
 clearAction ;
}

/* ************************************************************* */
//        Wonciek die Inventargegenstände zeigen                 //
/* ************************************************************* */

event default -> Wonciek {	
 if Did(Use) or Did(Push) or Did(Pull) or Did(Close) or Did(Open) or Did(Take) or (Did(Give) and SelectedObject == Give) {
   triggerDefaultEvents ;
   return ;
 }
 if Did(Give) {
  Ego:
   walk(307,267) ;
   turn(DIR_WEST) ;  
   EgoStartUse ;
   switch random(4) {
    case 0 : "Nimm das."
    case 1 : "Hier."
    case 2 : "Das ist f]r Dich." 
    case 3 : "Bittesch[n!"
   }   
   delay(10) ;
   EgoStopUse ;
   Peter:
   switch random(3) { 
    case 0:  "Hmmm..."
	     "Interessant."
    case 1:  "Was will ich damit?" 
    case 2:  "Das m[chte ich nicht." 
   }   
  
 } else triggerDefaultEvents ;
 clearAction ;
}


event Pen -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Diesen Stift habe ich einer Frau am Flughafen gezockt.") ;
  Peter.say("Du m]sstest doch mittlerweile Unmengen davon haben.") ;
 clearAction ;  
}

event Shim -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Mit dieser Konstruktion kann man die alten M]nztelefone kostenlos benutzen.") ;
  Peter.say("Faszinierend!") ;
 clearAction ;  
}

event Membercard -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Wusstest Du schon, dass ich vollwertiges Mitglied in einem Kleintierz]chterverein bin?") ;
  Peter.say("Nein. Es wundert mich aber auch nicht.") ;
 clearAction ;  
}

event Landkarte -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Ich habe deine Karte genommen, um zur Ausgrabungsstelle zu finden.") ;
  Peter.say("Ah.") ;
  Peter.say("Ich hatte sie bereits gesucht.") ;
  Peter.say("Du kannst sie behalten, ich brauche sie nicht mehr.") ;
 clearAction ;  
}

event Newspaper -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
 if (knowsMutated) {
   Ego.say("In dieser Zeitung steht etwas ]ber mutierte Fische im Nil, und dass SamTec etwas damit zu tun haben k[nnte.") ;
   Peter.say("Ich wei}, ich habe diese Ausgabe bereits gelesen.") ;
   if (! gotSecurityKey) Peter.say("Ich glaube, die Presse sucht aber nur einen Schuldigen.") ;
     else Peter.say("Du solltest dich im Security-Bereich in der SamTec-Zentrale umsehen, und herausfinden, was es damit auf sich hat.") ;
 } else {
   Ego.say("Das ist eine deutsche Tageszeitung eines ehemaligen Gasts hier, die ich unten im Hotel fand.") ;
   Peter.say("Ich habe diese Ausgabe bereits gelesen.") ;
 }
 clearAction ;  
}

event Shoe -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Diesen Schuh fand ich in einer M]lltonne am Flughafen.") ;
  Peter.say("Man kann nie wissen, wann ein alter Schuh noch n]tzlich wird, was?") ;
 clearAction ;  
}

event DiaryInv -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("M[chtest Du dein Notizbuch zur]ck?") ;
  Ego.say("Es hat mir sehr geholfen.") ;
  Peter.say("Nein, Du kannst es behalten.") ;
 clearAction ;  
}

event Screwdriver -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Dieser Schraubenzieher war in einer Kiste im Sonnenraum des Grabes.") ;
  Peter.say("Hast Du gerade eigentlich nichts besseres zu tun?") ;
 clearAction ;  
}

event Flashlight -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Diese Taschenlampe rettete mir unten im Grab das Leben.") ;
  Peter.say("Ein Hoch auf das k]nstliche Licht!") ;
  Peter.say("Hattest Du Schwierigkeiten da unten?") ;
  Ego.say("Kann man so sagen.") ;
 clearAction ;  
}

event Kittel -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Diesen Laborkittel fand ich in dem SamTec-Labor.") ;
  Peter.say("Und, passt er?") ;
  Ego.say("Es ist meine Gr[}e.") ;
 clearAction ;  
}

event Anleitung -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  if (surizaSolved) { 
    Ego.say("Mit dieser Anleitung hier gelang es mir, die Garagentor-Elektrik am SamTec-Labor kurzzuschlie}en.") ;
    Peter.say("Man muss sich nur zu helfen wissen.") ;
  } else {
    Ego.say("Diese Anleitung soll mir helfen, in das SamTec-Labor einzubrechen.") ;
    Ego.say("Kannst Du damit etwas anfangen?") ;
    delay 10 ;
    Peter.say("Hmmmm...") ;
    delay 4 ;
    Peter.say("Nein, ich bin Theoretiker.") ;
    Peter.say("DU bist der Experimentalphysiker.") ;
  }
 clearAction ;  
}

event Nasenbrille -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 EgoStartUse ;
 delay 6 ;
 EgoStopUse ;
  Ego.say("Diese Nasenbrille habe ich von dem Rezeptionisten unten in der Empfangshalle.") ;
  Peter.say("Der war mir schon immer etwas suspekt.") ;
  Peter.say("Neulich habe ich ihn Selbstgespr#che ]ber den 'King' f]hren h[ren.") ;
 clearAction ;  
}

event Notiz -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
  
 if (openedSafe) {
  say("Ich habe die richige Kombination f]r den Tresor bereits.") ;
  clearAction ;
  return ;
 }
  
 if (wonciekSolvedLS) {
  say("Ich m[chte ihn damit nicht nochmal bel#stigen.") ;
  clearAction ;
  return ;
 }
 
 wonciekSolveLS ;
 EgoStartUse ;
  dropItem(Ego, Notiz) ;
 EgoStopUse ;
 delay 2 ;
  say("Kannst Du damit etwas anfangen?") ;
 delay 4 ;
 Peter:
  say("Was ist das?") ;
 Ego:
  say("Ein Hinweis auf eine Tresorkombination.") ;
 Peter:
 delay 2 ;
  say("Hmmm...") ;
 delay 3 ;
  say("Also Primzahlen sind nat]rliche Zahlen, die nur glatt durch eins und sich selbst teilbar sind.") ;
  say("Da steht dass Du die zwei ersten Zahlen irgendwo am Tresor ablesen k[nnen solltest...") ;
  say("Ab dann sollte es kein Problem sein.") ;
 delay 2 ;
 Ego.say("Danke.") ;
 delay ;
 EgoStartUse ;
  takeItem(Ego, Notiz) ;
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

event Dokumente -> Wonciek {
 jukeBox_Stop ;  
 jukeBox_Enqueue(Music::BG_Short7_mp3) ;
 jukeBox_Start ;
 jukeBox_Shuffle(false) ; 
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 if (wonciekDocuments) {
  "Ich habe ihm diese Dokumente bereits gezeigt."
  clearAction ;
  return ;
 }
 if (wonciekSample) forceHideInventory ;
 EgoStartUse ;
 dropItem(Ego, Dokumente) ;
 EgoStopUse ;
 Ego:
  "Diese Dokumente fand ich in dem stillgelegten SamTec-Labor."
  "Das sind die Ergebnisse der Gentoxizit#tstests des Abwassers."
  "Wirf mal auf einen Blick auf diese Werte hier..."
 delay 4 ;
 Peter:
  "Nach internationalen Kriterien sind die Abw#sser eindeutig mutagen!"
  "Das ist ja schrecklich!"
 Ego:
  "Du sagst es."
 EgoStartUse ;
 takeItem(Ego, Dokumente) ;
 EgoStopUse ;
 Peter:
 if (wonciekSample) Peter.say("Ich muss dir hier erneut Recht geben, Julian.") ;
   else Peter.say("Ich muss dir an dieser Stelle Recht geben, Julian.") ;
 if (wonciekSample) {
   say("Zusammen mit der Probe beweist das...") ;
   say("...dass SamTec tats#chlich f]r die mutierten Lebewesen im Nil verantwortlich ist!") ;	 
 }
 wonciekDocuments = true ;
 if (wonciekSample) wonciekConvinced ;
  else {
    Peter.say("Aber das allein kann mich irgendwie noch nicht ganz ]berzeugen.") ;
    Peter.say("Vielleicht sind die Abw#sser gar nicht mehr verschmutzt?") ;
    Peter.say("Was, wenn SamTec nach den Tests entsprechende Vorkehrungen getroffen hat...") ;
    Peter.say("...um die Kriterien nicht zu ]berschreiten?") ;
    Peter.say("Vielleicht findest du noch mehr Beweise, die deine Anschuldigungen unterst]tzen.") ;
  }
 clearAction ;
}

script showedMutatedCactus {
 return Cactus.getField(1) ;
}

script showMutatedCactus {
 Cactus.setField(1, 1) ;
}

event Klappspaten -> Wonciek {
 Ego: walk(307,267) ;
      turn(DIR_WEST) ;
 Ego.say("Was denkst Du ]ber 'Operation Klappspaten'?") ;
 EgoStartUse ;
 dropItem(Ego, Klappspaten) ;
 delay 19 ;
 takeItem(Ego, Klappspaten) ;
 EgoStopUse ;
 Peter.say("Einen Klappspaten habe ich schon...") ;
 Peter.say("Schade um Spanien, aber ich bin dabei.") ;
 Peter.say("Wann geht es los?") ;
 delay 2 ;
 Ego.say("Wenn die Zeit reif ist.") ;
 clearAction ;
}

event Cactus -> Wonciek {
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 delay 4 ;
  say("Das ist Oscar, mein Kaktus.") ;  
 EgoStartUse ;
 Peter:
 delay 5 ;
  say("Wahrlich ein Prachtexemplar.") ;
 if (cactusMutated) say("Und was f]r ausgepr#gte Stacheln!") ;
 Ego:
 EgoStopUse ;
 if (cactusMutated) {
  if (! showedMutatedCactus) {
    showMutatedCactus ;
     say("Ich habe ihn mit dem Abwasser aus dem SamTec-Labor in der N#he des Nils gegossen.") ;
     say("Kurz darauf sind ihm diese Stacheln gewachsen, die waren zuvor noch nicht so gro}.") ;
    delay 10 ;
    if (! wonciekSample) {
      Peter:
       say("Willst Du damit sagen, dein Kaktus ist mutiert?") ;
      delay 2 ;
      Ego:
       say("Ja, das ist er.") ;
      delay 3 ;
      Peter:
       say("Faszinierend. Hast Du eine Probe des Abwassers genommen?") ;
       say("Ich w]rde sie gerne untersuchen.") ;
      Ego:
      if (!hasItem(Ego, Probe)) {
         say("Nein, noch nicht.") ;
        if (hasItem(Ego, Reagenzglas)) {
	   say("Aber ich habe ein Reagenzglas.") ;
	  Peter:
	  delay 2 ;
	   say("Na das eignet sich doch hervorragend daf]r.") ;
	  Ego:
	  delay 3 ;
	   say("Ja, ich werde dir eine Probe beschaffen.") ;
        }
      } else {
         say("Ja, ich habe sie bei mir.") ;
        Peter:
         say("Na dann, zeig mal her.") ;
      }   
    } else {
      Peter.say("Durch diese vielen langen Stacheln ist er hervorragend gegen Feinde gesch]tzt.") ;
      Peter.say("W]rdest Du mir vielleicht nochmal etwas von diesem Abwasser bringen?") ;
      delay 5 ;
      Ego.say("Nein!") ;
    }
  }
  
 }
 clearAction ;
}

event Probe -> Wonciek {
 jukeBox_Stop ;  
 jukeBox_Enqueue(Music::BG_Short7_mp3) ;
 jukeBox_Start ;
 jukeBox_Shuffle(false) ;	
 Ego:
  walk(307,267) ;
  turn(DIR_WEST) ;  	
 if (wonciekDocuments) forceHideInventory ;  
 EgoStartUse ;  
 dropItem(Ego, Probe) ;
 EgoStopUse ;
 Ego:
  "Schau dir mal das genauer an!"
  "Das habe ich vom stillgelegten SamTec-Labor."
  "Die kippen das einfach ins Abwasser."
 start {
  delay 73 ;
  Ego.say("Nein!") ;
  delay 5 ;
  Ego.say("Warte!") ;
 }
 Peter.say("Ich werde mir mal einen Schluck genehmigen.") ;
 delay 12 ;
 peter.turn(DIR_NORTH) ;
 Peter.say("Hmmm...") ;
 delay 12 ;
 start { Peter.playSound(Music::Schluck1_wav) ; }
 Peter.say(" *schluck* ") ;
 delay 3 ;
 
 mutatePeter ;
 
 delay 3 ;
 
 Peter.turn(DIR_EAST) ;
 delay 64 ;  
 Ego:
  "Sag mal Peter..."
 Peter: 
  "Ja?"
 Ego:
  "Ist das ein zus#tzliches OHR auf deiner Stirn?"
 Peter:
  turn(DIR_NORTH) ;
 delay 30 ;
  turn(DIR_EAST) ;
  "Das stimmt!"
  "Das ist ja fantastisch!"
 delay 34 ;
 Ego:
  "Du hast sie doch nicht mehr alle."
 delay 1 ;
 Peter:
  "Sag das nochmal."
 Ego:
  "DU HAST SIE DOCH NICHT MEHR ALLE!"
 delay 4 ;
 Peter: 
  "H[rt sich alles etwas anders an... deutlicher und dreidimensionaler irgendwie..."
 delay 7 ; 
  "Zur]ck zum Thema."
 delay 10 ;
 if (wonciekDocuments) Peter.say("Ich muss dir hier erneut Recht geben, Julian.") ;
   else Peter.say("Ich muss dir an dieser Stelle Recht geben, Julian.") ; 
 "In diesem Reagenzglas ist eine eindeutig mutagene Fl]ssigkeit."
 if (wonciekDocuments) { 
   say("Zusammen mit den Genotoxizit#tstests beweist das...") ;
   say("...dass SamTec tats#chlich f]r die mutierten Lebewesen im Nil verantwortlich ist!") ;
 }
 wonciekSample = true ;
 if (wonciekDocuments) WonciekConvinced ;
  else {
    Peter.say("Das Abwasser dort scheint wirklich f]r die Mutationen im Nil verantwortlich zu sein.") ;
    Peter.say("Aber das allein kann mich irgendwie noch nicht ganz ]berzeugen.") ;
    Peter.say("Da das Labor schon seit Monaten stillgelegt ist, ist noch nicht bewiesen dass SamTec...") ;
    Peter.say("...hierf]r verantwortlich ist. Vielleicht sind ein paar betrunkene Jugendliche dort...") ;
    Peter.say("... eingestiegen und haben ein paar Eimer Tri#thylenmelamin in den Abgu} gekippt?") ;
    Peter.say("Vielleicht findest Du noch mehr Beweise, die deine Anschuldigungen unterst]tzen.") ;
  }

 clearAction ;
}

script WonciekConvinced {
  jukeBox_Stop ;  
  jukeBox_Enqueue(Music::BG_Fuell5_mp3) ;
  jukeBox_Start ;
  Peter:
  delay 3 ;
   "Das ist in der Tat furchtbar."  
  delay 4 ;
   "H#tte ich das gewusst, h#tte ich es mir nochmal ]berlegt, die Stelle bei SamTec anzunehmen."
  delay 5 ;
   "Hmmmmm."
  delay 10 ;
   "Ich traue der Sache irgendwie auch nicht mehr so ganz."
   "Diese mutierten Lebewesen m]ssen doch ein viel zu gro}es Aufsehen erregt haben, als dass..."
   "...sich niemand der Aufkl#rung der Ursachen angenommen h#tte."
  delay 3 ;
   "Schlie}lich ging es doch durch die Presse!"
  delay 5 ;
   "Auch f]r die Menschen hier m]ssen diese Chemikalien doch sch#dlich sein."
   "Zu ]ber 95% ist Kairo auf das Wasser im Nil angewiesen."
  delay 7 ;
   "Und diese Jackson- und Johnson-Gestalten..."
  delay 10 ;
   "Ich habe das Gef]hl, irgendwas stimmt da nicht."
  delay 5 ; 
  Ego:
   "Du hast Recht!"
  delay 3 ;
   "Ich habe noch gar nicht daran gedacht, dass das Abwasser aus dem Labor auch f]r die Menschen sch#dlich ist."
  delay 5 ;
   "Wer wei} was mit ihnen passiert, wenn sie diesen Verunreinigungen einen l#ngeren Zeitraum ]ber ausgesetzt sind."
  delay 15 ;
  if (toldWonciekPharma) {
     "Ich habe dir doch erz#hlt, dass SamTec ein Tochternehmen in der Pharmaindustrie besitzt."
    Peter:
    delay 3 ;
     "Ja, das hast Du."
    delay 4 ;
  } else {
     "Und wei}t Du was?"
    delay 3 ;
     "Ich habe erfahren, dass SamTec ein Tochterunternehmen in der Pharmaindustrie besitzt."  
    delay 4 ;
  }
  delay 10 ;
  Peter:
   "Meinst Du, da besteht ein Zusammenhang?"
  delay 20 ;
  Ego:
   "Ich wei} es nicht."
  delay 23 ;
  Peter:
   "Ich kann mir einfach nicht vorstellen, dass SamTec vors#tzlich die Gesundheit der #gyptischen Bev[lkerung..."
   "...aufs Spiel setzen w]rde, um mehr Profit zu machen."
  delay 4 ;
   "Das sieht dem Unternehmen gar nicht #hnlich."
  Ego:
  delay 10 ;
   "Kannst Du es ausschlie}en?"
  delay 7 ;
  Peter: 
   "Nein."
   "Etwas stinkt hier gewaltig, das ist sicher."
  delay 12 ;
  Ego:
   "Was meinst Du, sollen wir tun?"
  Peter:
  delay 10 ;
   "Hmmmmm..."
  delay 23 ;
   "Ich denke, du solltest dich mal im SamTec-Security-Bereich in der Zentrale umsehen."
   "Ich will mich aus der Sache raushalten."
   "Vielleicht findest Du dort weitere Hinweise im Zentralrechner."
   "Wenn noch Informationen ]ber dieses Labor existieren, dann dort."
  delay 15 ;
   "Das Passwort f]r den Login lautet 'ON'."
  delay 10 ;
  Ego:
   "Danke, ich werde mich dort umsehen."
  Peter:
  delay 6 ;
   "Um reinzukommen brauchst du eine SamTec-Security-Keycard und eine Kombination."
   "Ich kann dir leider nur die Kombination geben."
   "5589715"
  Ego:
   "Danke."
  if (hasItem(Ego, Keycard)) { 
    Ego.say("Eine Security-Keycard habe ich bereits.") ;
    delay 3 ;
    Peter.say("Das wundert mich nicht.") ;
  }
  delay 3 ;
  Peter:
   "Pass auf dich auf!"
  Ego:
  delay 2 ;
   "Werde ich machen."
  Peter:
  delay 3 ;
   "Ich hoffe, dein Verdacht verh#rtet sich nicht."
  gotSecurityKey = true ;
  forceShowInventory ;
}

/* ************************************************************* */

object Rose {
 setClickArea(76,177,103,258) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Rose" ;
}

event WalkTo -> Rose {
 clearAction ;
 Ego:
  walk(210,303) ;
  turn(DIR_WEST) ;	
}

event LookAt -> Rose {
 Ego:
  walk(210,303) ;
  turn(DIR_WEST) ;
  "Eine wei}e Plastikrose in einer Blumenvase."	
  "Warum habe ich sowas nicht auf meinem Zimmer?"
 clearAction ;
}

/* ************************************************************* */

object Nachttisch {
 setClickArea(488,252,526,280) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Nachttisch" ;
}

event WalkTo -> Nachttisch {
 clearAction ;
 Ego:
  walk(457,298) ;
  turn(DIR_EAST) ;
}
 
event Use -> Nachttisch {
 triggerObjectOnObjectEvent(Open, Nachttisch) ;
}
 
event Open -> Nachttisch {
 Ego:
  walk(457,298) ;
  turn(DIR_EAST) ;
  EgoUse ; 
  "Er ist leer."
 clearAction ;
}

event LookAt -> Nachttisch {
 Ego:
  walk(457,298) ;
  turn(DIR_EAST) ;  
  "Ein Nachttisch."
 clearAction ;	
}

/* ************************************************************* */

object decke {
 setClickArea(306,214,453,282) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Bettdecke" ;
}

event WalkTo -> decke {
 clearAction ;
 Ego:
  walk(292,263) ;
  turn(DIR_EAST) ;
}

event Take -> decke {
 Ego:
  walk(292,263) ;
  turn(DIR_EAST) ; 
  "Ich will die Decke nicht."
 clearAction ;
}

event LookAt -> decke {
 clearAction ;
 Ego:
  walk(292,263) ;
  turn(DIR_EAST) ; 
  "Eine Bettdecke."	  
}


/* ************************************************************* */

object Zebra {
 setClickArea(501,174,613,335) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Luigi" ;
}

event WalkTo -> Zebra {
 clearAction ;
 Ego:
  walk(330,350) ;
  turn(DIR_EAST) ;
}

event LookAt -> Zebra {
 Ego:
  walk(330,350) ;
  turn(DIR_EAST) ;
  "Das ist Luigi, das Pl]schzebra des Professors."
 clearAction ;
}	

event Take -> Zebra {
 Ego:
  walk(330,350) ;
  turn(DIR_EAST) ;
  "Nein, es geh[rt dem Professor."
 clearAction ;
}	


/* ************************************************************* */

object RotesBuch {
 setClickArea(138,297,163,322);
 absolute = false ;
 clickable = true ;
 enabled = false ;
 visible = true ;
 name = "Rotes Buch" ;
} 

event WalkTo -> RotesBuch {
 clearAction ;
 Ego:
  walk(218,338) ;
  turn(DIR_WEST) ;
}

event LookAt -> RotesBuch { 
 Ego:
  walk(218,338) ;
  turn(DIR_WEST) ;
  "Das ist das Notizbuch des Professors."
 clearAction ;  
}

event Take -> RotesBuch {
 Ego:
  walk(218,338) ;
  turn(DIR_WEST) ;
  "Das ist das Notizbuch des Professors."
  "Ich m[chte es ihm nicht wegnehmen."
  "Vorerst."
 clearAction ;
} 

/* ************************************************************* */

object Schubl1 {
 setClickArea(110,275,154,331);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schublade" ;
}

event Open -> Schubl1 {
 Ego: 
  walk(218,338) ;
  turn(DIR_WEST) ;
  
 if (currentAct==4) {
  say("Die Schublade ist leer.") ;  
  clearAction ;
  return ;
 }
 if (SchublOffen.enabled) {
  Ego: "Die Schublade ist bereits offen."
 } else {
  EgoStartUse ;
  start soundBoxPlay(Music::Schublade_wav) ;
  SchublOffen.enabled = true ;
  RotesBuch.enabled = true ;
  EgoStopUse ;
 } 
 clearAction ;
} 

event Use -> Schubl1 {
 if (SchublOffen.enabled) triggerObjectOnObjectEvent(Close, Schubl1) ;
  else triggerObjectOnObjectEvent(Open, Schubl1) ;
}

event Close -> Schubl1 {
 Ego: 
  walk(218,338) ;
  turn(DIR_WEST) ;
 if (not SchublOffen.enabled) {
  Ego: "Die Schublade ist bereits geschlossen."
 } else {
  EgoStartUse ;
  start soundBoxPlay(Music::Schublade_wav) ;
  SchublOffen.enabled = false ;
  RotesBuch.enabled = false ;
  EgoStopUse ;
 } 
 clearAction ;
} 

object SchublOffen{
 class = Schubl1 ;
 setAnim(schubladeoffenbuch_sprite) ;
 setPosition(120,272) ;
 priority = 37 ;
 absolute = false ;
 clickable = false ;
 enabled = false ;
 visible = true ;
}

/* ************************************************************* */

object Karte {
 setAnim(Karte_image) ;	
 setPosition(17,272) ;
 setClickArea(0,0,100,40) ;
 visible = true ;
 enabled = !getField(0) ;
 clickable = true ;
 absolute = false ;
 name = "Karte" ;
}

event LookAt -> Karte {
 Ego: 
  walk(218,338) ;
  turn(DIR_WEST) ;
 delay 20 ;
  "Das sieht mal interessant aus."
 delay 4 ;
  "Ich nehme die Karte wohl besser mit."
  EgoStartUse ;
  Karte.visible = false ;
  Karte.enabled = false ;
  Karte.setField(0, true) ;
  takeItem(Ego, Landkarte) ;
  EgoStopUse ;
 clearAction ;
}

event Take -> Karte {
 Ego: 
  walk(218,338) ;
  turn(DIR_WEST) ;
  EgoStartUse ;
  Karte.visible = false ;
  Karte.enabled = false ;
  Karte.setField(0, true) ;
  takeItem(Ego, Landkarte) ;
  EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object zurueck {
 setClickArea(150,350,345,360);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Flur" ;
}

event WalkTo -> zurueck {
 clearAction ;
 start {
  Ego: walk(280,350) ; 
  suspend ;
  if (WonciekAtHotel) {
   Peter:
    enabled = false ;
    visible = false ;
    disablePeterTalk ;
  }
  doEnter(Hotelgang) ;
 }
}

/* ************************************************************* */

object Juliansitzt {
 visible = true ;
 enabled = false ;
 setAnim(Juliansitzt_sprite) ;
 setPosition(267,131) ;
 autoAnimate = false ;
 frame = 1 ;
}

script animateJulianSitzend {	
  killOnExit = true ;
  Juliansitzt:  
  loop {  
   
   if (Ego.animMode == ANIM_STOP) {
    if (frame > 3) frame = 1 ;
    if (random(9) == 0) {
      if (frame == 1) frame = 3 ;
       else frame = 1 ;
      if (Ego.animMode == ANIM_STOP) delay 5 ;
    }
    if (Ego.animMode == ANIM_STOP) delay random(7)+3 ;
    if (random(4) == 0) {
     frame-- ;
     delay random(2) + 1 ;
     frame++ ;
    }
    if (Ego.animMode == ANIM_STOP) delay random(7)+3 ;
   } else if (Ego.animMode == ANIM_TALK) {
    if (frame < 4) {  frame = 4 ; delay 1 ; }
    frame = random(4)+4 ;
    delay 2 + random(3) ;
   }

  delay ;

  }  
} 

/* ************************************************************* */

static var toldWonciekPharma = false ;

script WonciekTalk3 {
 Ego:
  walk(284,267) ;
  path = 0 ;
  scale = 758 ;
  pathAutoScale = false ;
  walk(307,267) ;
  turn(DIR_WEST) ;
 Peter.turn(DIR_EAST) ;
 delay 2 ;
 Ego:
  visible = false ;
  enabled = false ;
 Juliansitzt:
  visible = true ;
  enabled = true ;
 start animateJulianSitzend ;

 static var askedWonciekSecurity = false ;
 static var askedWonciekSamTec = false ;

 loop {
  Ego:
  
  addChoiceEchoEx(1, "Wei}t du etwas ]ber diese mutierten Fische im Nil?", false) if (knowsMutated and (! sawAgentsHint) and (! wonciekSample)) ;
  addChoiceEchoEx(2, "Ich glaube ich habe da etwas gefunden, was dich interessieren k[nnte.", true) if ((hasItem(Ego, Dokumente) and (! wonciekDocuments)) or (hasItem(Ego, Probe)) or ((! wonciekSample) and (cactusMutated))) ;
  addChoiceEchoEx(3, "Wusstest Du, dass ein Tochterunternehmen SamTecs auch in der Pharmaindustrie t#tig ist?", true) if (knowsPharma and (!toldWonciekPharma)) ;
  addChoiceEchoEx(4, "Wei}t Du, was hinter dieser Sicherheitst]r in der SamTec-Zentrale ist?", true) if (wondersSecurity and (!askedWonciekSecurity)) ;
  addChoiceEchoEx(5, "Wie kam es dazu, dass Du f]r SamTec arbeitest?", true) if (! askedWonciekSamTec) ;
  addChoiceEchoEx(6, "Man sieht sich.", false) ;
  var c = dialogEx () ;  	
  
  switch c {
   case 1:
    Ego:
     "Wei}t du etwas ]ber diese mutierten Fische im Nil?"
     delay 3 ;
    Peter: 
     "Ja, ich habe in der Zeitung dar]ber gelesen."
     "SamTec wird die Schuld daf]r in die Schuhe geschoben."
     delay 3 ;
    Ego:
     delay 3 ;
     "M[glicherweise sind die Anschuldigungen berechtigt?"
    Peter: 
     "Ein #lteres SamTec-Labor liegt zwar an einem Fluss, der in den Nil m]ndet, jedoch ist dieses schon seit..."
     "...Monaten stillgelegt."
     delay 5 ;
     "Wir haben so viele Mittel zur Verf]gung, dass k]rzlich neue, moderne Labore eingerichtet worden sind."
     delay 7 ;
     "Demnach hat SamTec meiner Meinung nach damit nichts zu tun."
     delay 5 ;
     "Ich glaube, die Presse sucht einfach einen Schuldigen."
    Ego:
     delay 10 ;
     "Verstehe."
    if (!knowsDott) {
       "Wei}t du, wo sich dieses stillgelegte Labor befindet?"
       delay 3 ;
       "Vielleicht werde ich mal einen Blick darauf werfen."
      Peter:
       delay 3 ;
       "Nein, tut mir Leid. Das war vor meiner Zeit."
       "Vielleicht kann dir ja die freundliche Empfangsdame in der Zentrale weiterhelfen."
       "Ich vergesse ihren Namen immer wieder..."
      Ego:
       delay 3 ;
       "Danke. Ich denke ich versuche es mal dort."
    }
   case 2:
    Peter:
     "Na dann her damit!"
    JulianSitzt.enabled = false ;
    Ego:
     enabled = true ;
     visible = true ;
    delay 5 ;
     turn(DIR_SOUTH) ;
     path = hotelzimmerl_path ;
    return ;	
   case 3:
    Peter:
    delay 4 ;
    if (wonciekSample and wonciekDocuments) say("Bevor Du es mir eben erz#hlt hast, war es mir nicht bekannt.") ;
     else say("Nein, das war mir noch nicht bekannt.") ;
    delay 5 ;
    if (!(wonciekSample and wonciekDocuments)) say("Es freut mich aber, dass sich mein Geldgeber f]r die Gesundheit der Menschen einsetzt.") ;
     else say("Und mittlerweile bin ich am Zweifeln, ob meinem Geldgeber die Gesundheit der Menschen so sehr am Herzen liegt...") ; 
    delay 10 ;
    toldWonciekPharma = true ;
   case 4:
    Peter:
    if (wonciekSample and wonciekDocuments) {
     delay 5 ;
      say("Ja, da geht es in den Security-Bereich von dem ich sprach.") ;
      say("Eigentlich gibt es da nur zwei Labore, die jedoch recht teuer ausgestattet sind.") ;
      say("Auch der Zentralrechner SamTecs ist dort aufgestellt.") ;
      say("Ich arbeite gr[}tenteils in dem Security-Bereich.") ;     
    } else {
     delay 5 ;
      say("Ja, dort ist der Security-Bereich, in dem ich gr[}tenteils arbeite.") ;
      say("Eigentlich gibt es da nur zwei Labore, die jedoch recht teuer ausgestattet sind.") ;
      say("Auch der Zentralrechner SamTecs ist dort aufgestellt.") ;
      say("Man ben[tigt eine Security-Card und eine Zahlenkombination, um hereinzugelangen.") ;
     delay 5 ;
     if (hasItem(Ego, Keycard))  Ego.say("Eine solche Karte habe ich gefunden, kannst Du mir die Zahlenkombination geben?") ;
       else Ego.say("Kannst Du mir deine Karte und Zahlenkombination geben?") ;
     delay 4 ;
     Peter:
      say("Ausgeschlossen.") ;
      say("Wenn die das zur]ckverfolgen, werde ich sofort gefeuert.") ;
    }
    askedWonciekSecurity = true ;
   case 5:
    Peter:
     "Nun, vor etwa zwei Woche bekam per Post eine Einladung nach @gypten zugestellt."
    delay 2 ;
     "Ich sollte mich mit anderen Forschern der Untersuchung eines neuartigen Materials widmen..."
     "...was mein Interesse weckte."
     "Mehr stand in dem Brief nicht, aber als ich dann in Kairo war, wurde mir mehr dar]ber erz#hlt."
    delay 3 ;
     "Dass dieser Kristall in dem k]rzlich gefundenen Grabmal Echnatons entdeckt worden war, und vor allem..."
     "...dass in ihm ein gewaltiges Energiepotenzial steckt."
    delay 3 ;
     "Nachdem wir ihn komplett erforscht haben, sollen Teile von ihm zur Energiegewinnung in..."
     "...Entwicklungsl#ndern eingesetzt werden."
     "Aber auch in der Luft- und Raumfahrtechnik soll seine F#higkeit Anwendung finden."
    delay 5 ;
     "Also unterschrieb ich den Arbeitsvertrag."
    delay 12 ;
    Ego:
     "Was kannst Du mir sonst noch ]ber SamTec erz#hlen?"
    Peter:
    delay 10 ;
     "Die Firma besitzt einige Tochterunternehmen in der chemischen Industrie."
    if (toldWonciekPharma) say("Und wohl auch in der Pharmaindustrie, wie Du in Erfahrung gebracht hast.") ;
     "SamTec fungiert dabei als Muttergesellschaft dieser verbundenen Unternehmen."
     "Hier in Kairo liegt lediglich die SamTec-Zentrale, die jedoch auch mit ziemlich modernen..."
     "...Forschungseinrichtungen ausgestattet ist."
     "Dort arbeite ich mit etwa f]nf weiteren Wissenschaftlern, zwei Physikern, zwei Chemikern..."
     "...und einem Materialwissenschaftler."
    delay 9 ;
     "In einigen der Tochterunternehmen sollen parallel weitere Anwendungsgebiete..."
     "...des Kristalls erforscht werden, habe ich geh[rt."
    delay 5 ;
     "Mehr kann ich dir aber leider auch nicht sagen."
    Ego:
    delay 5;
     "Na gut, vielen Dank."
    askedWonciekSamTec = true ;
   case 6:
    Ego:
     "Man sieht sich."
    Peter:
     "Bis dann."
    JulianSitzt.enabled = false ;
    Ego:
     enabled = true ;
     visible = true ;
    delay 5 ;
     turn(DIR_WEST) ;
     path = hotelzimmerl_path ;
     pathAutoScale = true ;
    return ;	
  }	
 }
}

/* ************************************************************* */

// Nachdem Julian aus Echnatons Grabkammer entkommen ist

script WonciekTalk2 {
 Peter: 
  "Hallo Julian!"
  "Du bist zur]ck?"
 Ego:
  "Ja. Ich habe einiges zu berichten..."
  walk(284,267) ;
  path = 0 ;
  scale = 758 ;
  pathAutoScale = false ;
  walk(307,267) ;
  turn(DIR_WEST) ;
  Peter.turn(DIR_EAST) ;
  delay 2 ;
  visible = false ;
  enabled = false ;
 Juliansitzt:
  visible = true ;
  enabled = true ;
 start animateJulianSitzend ;
 Peter:
 delay 2 ;
  "Hast Du das Grab besichtigt?"
 Ego:
  "Ja, das habe ich."
  "L#nger und ausgiebiger als ich eigentlich vorhatte."
 Peter:
  "Was willst Du damit sagen?"
 Ego:
  "Ich bin wieder diesen zwei Schr#nken begegnet."
  "Die, die bei mir zuhause aufgekreuzt sind, kurz vor der Gasexplosion."
 delay 2 ;
 Peter: 
  "Bist Du dir sicher?"
 delay ;
  "Was ist passiert?"
 delay 2 ;
 Ego:
  "Sie haben mich mit voller Absicht im Grab eingesperrt."
 Peter:
  "Das ist ja entsetzlich!"
 Ego:
  "Halb so wild, ich bin nat]rlich entkommen."
 Peter: 
  "Das sehe ich..."
  "Was f]r ein Gl]ck."
  "Geht es dir gut?"
 delay 3 ;
 Ego:
  "Ja, mir ist nichts passiert."
 delay 2 ;
  "Die zwei haben zugegeben, dass sie mein Haus in die Luft gejagt haben."
  "F]r wen sie arbeiten, wollten sie mir aber nicht verraten."
 delay ;
  "Au}erdem habe ich ihre Namen."
 delay 2 ;
 Peter:
  "Wie hei}en sie?"
 Ego:
  "Jack Johnson und John Jackson."
 Peter:
  "Noch nie geh[rt."
 Ego:
  "Und ich glaube nach wie vor, dass SamTec da irgendwie die Finger im Spiel hat."
  "Das kann doch kein Zufall sein."
 Peter:
  "Ich muss sagen, dass mich das nun auch etwas nachdenklich stimmt."
 delay 10 ;
 Ego:
  "Du sagtest, dass dein Arbeitgeber vorbildlich im Bereich der Kooperation..."
  "...von Wirtschaft und Wissenschaft handelt und dass eure Entdeckung der..."
  "...Schl]ssel in eine bessere Welt ist."
 delay 5 ;
  "Wenn SamTec was mit der Sache im Grab eben zu tun hat, bezweifle ich aber stark..."
  "...dass diese Leute so nobel sind, wie Du den Eindruck hast."
 delay 3 ;
 Peter:
  "Aber es ist doch lange nicht bewiesen, dass die zwei Affen von denen du sprachst..."
  "...im Auftrag von SamTec handeln."
 Ego:
  "Du hast nicht das erlebt, was ich erlebt habe, Peter."
  "Ich kann es dir nicht ver]beln, in der Sache noch etwas unvoreingenommen zu sein."
 delay 4 ;
 Peter:
  "Was willst Du jetzt tun?"
 delay 10 ;
 Ego:
  "Ich werde versuchen, mehr ]ber SamTec in Erfahrung zu bringen."
  "Wenn ich herausfinde, dass dein Arbeitgeber doch keine wei}e Weste tr#gt, melde ich mich wieder hier."
 Peter:
 delay 4 ;
  "Na gut."
  "Wie willst Du das anstellen?"
 delay 3 ;
 Ego:
  "Mir wird schon was einfallen."
 delay 4 ;
 Peter:
  "Sei vorsichtig."
  
 JulianSitzt.enabled = false ;
 Ego:
  enabled = true ;
  visible = true ;
  path = Hotelzimmerl_path ;
  pathAutoScale = true ;
  
  walk(280,350) ;
  delay 5 ;
//  turn(DIR_NORTH) ;

  path = hotelzimmerl_path ;
}

/* ************************************************************* */

script WonciekTalk(long) {

 jukeBox_Stop ;

TalkedToWonciek = true ;
var talkedsamtec = false ;
var WonciekTalkedPhysics = false ;

if long {
	
Peter:
  "Julian!"
  delay 2 ;  
  turn(DIR_EAST) ;
  "Sch[n, dich zu sehen."
   "Setz dich doch!"
  "Dann ist mein Brief wohl heil angekommen."
  
 start {
  //jukeBox_Enqueue(Music::Theme_wav) ;
 // jukeBox_Enqueue(Music::BG_Fuell4_mp3) ;
  //jukeBox_Enqueue(Music::BG_Fuell6_mp3) ;
  jukeBox_Enqueue(Music::BG_ToTheEnds_mp3) ;
  jukeBox_Enqueue(Music::BG_LongNoteTwo_mp3) ;  
  jukeBox_Shuffle(true) ;
  jukeBox_Start ;
 }
  
  
Ego:
  walk(239,269) ;
  turn(DIR_NORTH) ;
  "Das ist er, ja."
Peter:
  "Wie war die Reise?"
Ego:
  "Es geht."
  "Ich muss dir unbedingt etwas erz#hlen!"
Peter:
  "Ich dir auch."
  "Setz dich erstmal, dann werde ich mich bem]hen..."
  "...vorerst mal etwas Licht in die ganze Angelegenheit zu bringen."
Ego:
  walk(284,267) ;
  path = 0 ;
  scale = 758 ;
  pathAutoScale = false ;
  walk(307,267) ;
  turn(DIR_WEST) ; 
  delay 2 ;
  visible = false ;
  enabled = false ;
Juliansitzt:
  visible = true ;
  enabled = true ;
start animateJulianSitzend ;
 Peter:
delay 2 ;
  "Also, ich versuche mich kurz zu fassen." 
delay 2 ;

} else {
 Ego:
  visible = false ;
  enabled = false ;
 Juliansitzt:
  visible = true ;
  enabled = true ;
 Peter.Face(DIR_EAST) ;
 start animateJulianSitzend ;
} 

Peter:
  "Wie ich dir bereits in meinem Brief geschildert habe, wurde..."  
  "...hier in @gypten eine sensationelle Entdeckung gemacht."
  "Es fing eigentlich als rein arch#ologische Ausgrabung an."
  "Einige lokale Forscher behaupteten, das Grabmal des Pharaos Echnaton gefunden zu haben."
delay 2 ;
  "Wei}t du, wer Echnaton war?"
Ego:
  "Ehrlich gesagt, nein."
Peter:
  "Dann geht es dir #hnlich wie es mir ging, als ich hier ankam."
  "Ich habe mich dann in der [rtlichen Bibliothek etwas eingelesen, und dem..."  
  "...@gyptischen Museum einen Besuch abgestattet."
  "*seufz*"
  "Du ahnst nicht, wie faszinierend die #gyptische Geschichte ist..."
  "Nun aber zur]ck zum Thema."
  "Echnaton hie} eigentlich Amenophis IV und war ein Pharao..."  
  "...der 18. Dynastie @gyptens."
  "In @gypten war die Religion damals polytheistisch, das hei}t es gab viele..."  
  "...verschiedene G[tter mit jeweils eigenen Zust#ndigkeitsbereichen."
  "Zudem gab es einen stark ausgepr#gten Priesterkult um die ganzen G[tter..."  
  "...und diese Priester hatten je nachdem, welcher Gottheit sie dienten, mehr oder..."  
  "...noch mehr Macht."
  "Echnaton war dieser ganze Kult und die Vielg[tterei zuwider."
  "Er glaubte nicht an diese verschiedenen G[tter, er glaubte nur an eine..." 
  "...Manifestation des G[ttlichen, die ihm offensichtlich erschien:"
  "Die Macht der Sonne."
  "Das ist auch nicht besonders verwunderlich, schlie}lich war die Sonne es..."  
  "...die machte, dass die Pflanzen wuchsen und die Menschen zu essen hatten."  
 delay 1;
  "In dieser {berzeugung lies er alle Gottheiten abschaffen, und ersetzte..."  
  "...sie durch eine einzige Gottheit, welche die Energie und Kraft der Sonne..."  
  "...verdeutlichte:"
  "ATON"
  "Von diesem Zeitpunkt nannte er sich dann auch Echnaton, was soviel wie..."  
  "...'einziger Priester des Aton' bedeutet."
  "Er verlie} danach auch die ehemalige Hauptstadt @gyptens und gr]ndete..."  
  "...die neue Hauptstadt Achet-Aton, die heute Tell el-Armana hei}t."
 delay 1;
  "Diese neu eingef]hrte Religion, gefiel aber nat]rlich den Priestern der..."  
  "...nun abgeschafften Gottheiten nicht..."
  "...vorallem wegen der Tatsache, dass sie neuerdings auf nicht gerade kleine..."  
  "...Mengen an 'Trinkgeld' verzichten mussten..."
  "...und da Trinkgeld schon im alten @gypten besonders beliebt war, waren..."  
  "...die Priester ziemlich sauer auf Echnaton."
  "So ist es nicht verwunderlich, dass nach Echnatons Tod, der Sonnenkult wieder..."  
  "...abgeschafft wurde, und die Priester alles daran setzten, diese Epoche der..."  
  "...Geschichte zu verstecken."
  "Echnatons Stadt wurde verw]stet, Bildnisse von Aton, der Sonnenscheibe..."  
  "...zerst[rt, und Echnatons Name ]berall getilgt, wo es nur m[glich war..."
  "Allerdings ]berlebten einige Relikte dieser Epoche, weswegen wir heute..."  
  "...diese Geschichte ganz gut rekonstruieren k[nnen."
 delay 2 ;
 Ego:
  "@hm..."
 delay 1 ;
 Peter:
  "Was ist los?" 
  
loop {
 Ego: 
 AddChoiceEchoEx(1, "Wer war nochmal dieser Echnaton?", true)  ;
 AddChoiceEchoEx(2, "Kannst du mir noch ein bi}chen mehr ]ber Aton erz#hlen?", true);
 AddChoiceEchoEx(3, "Was passierte nochmal nach Echnatons Tod?", true)  ;
 AddChoiceEchoEx(4, "Was hast du als Physiker mit der ganzen Sache zu tun?", true) unless (WonciekTalkedPhysics);
 AddChoiceEchoEx(5, "Und was sagtest du, kann dieser Kristall?", true) unless (!WonciekTalkedPhysics);
 AddChoiceEchoEx(6, "Mir ist diese ganze SamTec Sache etwas suspekt.", true) unless (!WonciekTalkedPhysics) or (talkedsamtec) ;
 AddChoiceEchoEx(7, "Ich werde mich an der Ausgrabungsstelle nochmal umsehen.", true) unless (!talkedsamtec);
 
 // Kurzversionen

 var c = dialogEx ;
 
 switch c {
  case 1 : Peter:
		"Echnaton war ein Pharao der 18.ten Dynastie @gyptens."
		"Er brach mit der vorherrschenden #gyptischen Religion..."
		"...und setzte Aton als alleinige Gottheit ein."
  
  case 2 : Peter:
		"Das meiste habe ich dir ja bereits erz#hlt."
		"Aton war die Gottheit, die Echnaton ausschlie}lich anbetete."
		"Aton ist aber keine personifizierte Gottheit..."
		"...sondern stellt die Energie und Kraft der Sonne dar!"
  case 3 : Peter:
		  "Sein Kult wurde ausgel[scht und zerstreut."
		  "Bis heute wei} man nicht genau, wo Echnatons Mumie und Reicht]mer sind."
		  "Das meiste wurde wahrscheinlich zerst[rt."
		  
	
  case 4 :   
 WonciekTalkedPhysics = true ;
 Ego:
 "Und was hat das ganze mit MIR zu tun?"

 Peter:
  "Darauf wollte ich jetzt zu sprechen kommen."
 delay 1 ;
  "Wie gesagt, es wurde ein unterirdisches Felsengrab entdeckt."  
  "Darin befand sich eine Mumie, die die Arch#ologen eindeutig Echnaton zuordneten."  
  "Viel interessanter ist jedoch, was sonst noch in dem Grabmal gefunden wurde!"
 Ego:
  "Ja?"
  "Was denn?"
 start{ 
   jukeBox_Fadeout(10) ;    
   jukeBox_Stop ;
   jukeBox_Enqueue(Music::BG_Fuell2_mp3) ;
   jukeBox_Enqueue(Music::BG_LongNoteOne_mp3) ;  
   jukeBox_Start ;
 }
  
 Peter:
  "Ein Kristall aus einem komplett unbekannten Material..."
  "...mit verbl]ffenden Eigenschaften."
 Ego:
  "Was f]r Eigenschaften?"
 Peter:
  "Er wirkt in etwa so wie eine Solarzelle, nur mit un]bertroffener Effizienz."    
  "Der Kristall scheint das Licht der Sonne regelrecht in sich einzusaugen..."  
  "...und dessen Energie uners#ttlich zu binden."
  "Und ]ber die Jahrtausende hat er sich unwahrscheinlich stark aufgeladen."    
  "Leider ist es uns noch nicht so recht ersichtlich..."
  "...wie man die gespeicherte Energie sinnvoll nutzen kann."
  "Beim Bergen des Kristalls starb sogar einer der Wissenschaftler."  
  "Zu diesem Zeitpunkt wurde ich von SamTec, die die Ausgrabung finanzieren..."  
  "...eingeladen mich hier an den Forschungen zu beteiligen."
  "Inzwischen analysieren ein paar Mitarbeiter und ich einige Splitter des Kristalls."  
  "Den ganzen Kristall habe ich leider noch nicht gesehen."
 delay 1 ;
  "Stell dir vor Julian, was f]r Dinge man mit kleinsten Teilen dieses..."  
  "...Kristalls bewirken k[nnte, wenn man sie richtig anwendet."
  "Die Energieprobleme der Zukunft k[nnten schon jetzt der Vergangenheit..."  
  "angeh[ren."
  "Wir w#ren nicht mehr auf fossile Brennstoffe angewiesen..."
  "...wenn wir den Kristall erstmal vollkommen verstehen w]rden."
  "Er w]rde wahrscheinlich die gesamte Menschheit mit Strom versorgen k[nnen."    
  "Und erst die Fortschrittm[glichskeiten f]r die Entwicklungsl#nder!"
  "Julian, dieser Kristall ist der Schl]ssel in eine neue, bessere Welt!"    
 delay 3 ;
  "Die Arch#ologen glauben, dass dieser Kristall der Ausl[ser f]r Echnatons..."  
  "...Sonnenreligion ist."
  "Der Kristall ist sozusagen Atons Erbe an die Menschheit!"
 Ego:
  "Und du meinst wirklich, dieser Kristall h#tte ein solches Potenzial?"
 Peter:
  "Aber sicher!"
  "Leider dauert es noch eine ganze Weile, bis wir den Kristall so..."  
  "...weit untersucht haben, dass wir seine Energie unter Kontrolle haben."
  "Da sind sicher einige Jahre Forschung noch n[tig."
  "Aber mit den Mitteln von SamTec werden diese sicher optimal genutzt werden."  
  "Dieser Konzern ist wirklich vorbildlich im Bereich der Zusammenarbeit..."  
  "...von Wirtschaft und Wissenschaft."
  "So ein Gl]ck hat man selten."  
 case 5 :   
  Peter: "Naja."
  "Er wirkt in etwa so wie eine Solarzelle, nur mit un]bertroffener Effizienz."    
  "Der Kristall scheint das Licht der Sonne regelrecht in sich einzusaugen..."  
  "...und dessen Energie uners#ttlich zu binden."
  delay 1;
  "Erkennst du das enorme Potenzial dieser Art der Energiegewinnung?"
  "Man k[nnte soviel Gutes tun..."
 case 6:
	 
  Ego:  "Genau deswegen wollte ich noch unbedingt mit dir reden!"
  "Ich komme gerade von der SamTec-Zentrale."
 Peter:
  "Von der SamTec-Zentrale?"
  "Was hast du denn da verloren?"
  "Und was f]r Zweifel meinst du?"
 Ego:
  "Ich hatte dich gesucht."
 Peter:
  "Und woher wusstest du eigentlich, dass ich f]r SamTec arbeite?"
 Ego:
  "Ich habe an der Ausgrabungsstelle einen Hinweis gefunden."
 Peter:
  "Du warst schon dort?"
  "Woher kanntest du denn den Weg?"
 Ego:
  "@hm..."
  "Egal...nicht so wichtig."
 Peter:
  "Naja, gut so. Ansonsten h#tte ich dir meine Karte gegeben."
 delay 2 ;
  turn(DIR_SOUTH) ;
 delay 13 ;
  turn(DIR_EAST) ;
  "Nanu?"
 delay(5) ;
  "Wo ist sie denn?"
  "Ich dachte ich h#tte sie..."
 Ego:
  "Auf jeden Fall traue ich SamTec nicht."
  "Ich bin mir sicher, diese Leute sind nicht so nobel, wie du es dir vorstellst."  
 Peter:
  "Wie kommst du denn auf diese abstruse Idee?"
 Ego:
  "Ich habe da eben eine Unterhaltung belauscht. Anscheinend wollte jemand verhindern, dass wir uns treffen."
  "Das erkl#rt auch den kleinen Unfall, den ich zu Hause hatte."
 Peter:
  "Was f]r ein Unfall?"
 Ego:
  "@hm...naja. In meinem Haus gab es eine Art Explosion."
 Peter:
  "Und warum sollte jemand verhindern, dass wir uns treffen?"
 Ego:
  "Ich habe keine Ahnung."
  "Ich bin mir aber ziemlich sicher, dass es zwei Bodybuilder-Typen auf mich abgesehen haben."
  "Und ich glaube, ihre Stimmen im B]ro deines Chefs geh[rt zu haben."
 Peter:
  "Was willst Du damit andeuten?"
  "Du willst eine Explosion in deinem Haus in Deutschland mit meinem Arbeitgeber in Verbindung bringen?"
  "Ist dir bewusst, wie verr]ckt das klingt?"
 Ego:
  "Ja."
  "Sicher bin ich mir auf jedenfall noch nicht."
  "Ich werde aber Licht hinter die Sache bringen!" 
 delay 4 ;
 Peter:
  "Hmmmmmm."
 delay 2 ;
 start jukeBox_Fadeout(20) ;
  "Ich hoffe das ist nicht wieder einer deiner verr]ckten Ideen ist."
 delay 2 ;
  "Wei}t Du noch, als Du die Polizei gerufen hast, weil Du glaubtest..."
  "...dein Nachbar w]rde die Stadt mit elektromagnetischen Wellen aus..."
  "...einer umgebauten Fernsehbedienung paranoid machen wollen?"
 delay 5 ;
 Ego:
  "Hehehehe."
  "Und ich w]rde es wieder tun..."
 delay 6 ;
  "Vielleicht hast Du Recht."
 delay 3 ;
  "Ich denke ich werde etwas Gras ]ber die Sache wachsen lassen, und solange..."
  "...ein Blick in Echnatons Grab werfen."
 delay 2 ;
  "Vielleicht kann ich das Ganze dann auch etwas klarer sehen."
 delay 2 ;
 Peter:
  "Gute Idee."
  "Ein Besuch im @gyptischen Museum m]chte ich dir auch ans Herz legen."
 delay ;
 Ego:
  "Eher nicht, aber danke."
 talkedSamtec = true ;
  case 7:
 Peter: 
   "Nimm am besten mein Notizbuch mit."
   "Ich habe darin meine Entdeckungen dokumentiert."
   "Es wird dir weiterhelfen."
   delay(5) ;
   "Es m]sste in der Schublade liegen."
   Ego :
   "Danke."

   
   JulianSitzt.enabled = false ;
   Ego.pathAutoScale = false ;
   Ego.Scale = 753 ;
   Ego.enabled = true ;
   Ego.visible = true ;
   Ego.Face(DIR_WEST) ;
   path = Hotelzimmerl_path ;
   Ego.pathAutoScale = true ;
   
   Peter: "Bis sp#ter."
   
   Ego: "Bis dann."
   
   walk(250,350) ;
   path = 0 ;
   Ego.Scale = 1000 ;
   Ego.pathAutoScale = false ;
   Ego.walk(250,600) ;
   
   Peter: "Julian!"
   
   Ego:
    walk(250,350) ;
    path = HotelZimmerl_path ;
    pathAutoScale = true ;
    face(DIR_NORTH) ;
   "Ja?"

   Peter: "Das Notizbuch..."
   DisablePeterTalk ;
   
   Ego: "Oh ja, richtig."
    walk(218,338) ;
    turn(DIR_WEST) ;
   EgoStartUse ;
   soundBoxStart(Music::Schublade_wav) ;
   SchublOffen.enabled = true ;
   RotesBuch.enabled = true ;
   EgoStopUse ;
  
   EgoStartUse ;
   RotesBuch.enabled = false ;
   takeItem(Ego, diaryInv) ;
   delay 2 ;
   EgoStopUse ;
   SchublOffen.setAnim(SchubladeOffen_sprite) ;
  
   EgoStartUse ;
   soundBoxStart(Music::Schublade_wav) ;
   SchublOffen.enabled = false ;
   RotesBuch.enabled = false ;
   EgoStopUse ;
   Ego:
    walk(250,350) ;
   
    path = 0 ;
   Ego.Scale = 1000 ;
   Ego.pathAutoScale = false ;
   Ego.walk(250,600) ;   
   Peter.enabled = false ;
   disablePeterTalk ;
   Ego.enabled = false ;
   
   doEnter(Intrologo) ; // --> Akt 3    
   
   return ;
  } 
 } 
}