// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var AskElevator = 0 ;
var forbidScientist = 0 ;

event enter {
 forbidScientist = 0 ;
 if (ladyDistracted == 1) ladyDistracted = 2 ; 
	
 if (previousScene != Aufzug) forceShowInventory ;
	
 backgroundImage = Samtecempfang_image;
 backgroundZBuffer = Samtecempfang_zbuffer ;
 start AnimateEmpfangsdame;
 if ((currentAct == 4) and (ladyDistracted != 2)) start ScientistScript ;

 if (ladyDistracted == 2) { start distractLady ; } else Dame.captionClick = true ;

 Ego:
 
 if (previousScene == Aufzug) {
   setPosition(820,261) ; 
   face(DIR_WEST) ;
   path = 0 ;
   pathAutoScale = false ;
   scale = 735 ;
   
  delay transitionTime ;
  delay 10 ;
  soundBoxPlay(Music::Aufzug_wav) ;
  delay 6 ;
  aufzugAuf ;
  Ego:
   walk(716,269) ;
   pathAutoScale = true ;
   path = Samtecempfang_path ;
  aufzugZu ;  
 } else {
   scrollX = 160 ;
   setPosition(620,440) ;
   scale = 900 ;
   pathAutoScale = false ;
   face(DIR_NORTH) ;
   walk(588,357) ;
   path = Samtecempfang_path ;	 	 
   pathAutoScale = true ;
 }
  
 //ShowInventory ;
 
 if (OutsideChefCount == 1  and TalkedToWonciek == false) {
  Dame:
   "Hey, Sie da!"
  Ego:
   walk(344,271) ;
   turn(DIR_NORTH) ;
  Dame:
   "Gerade war Herr Wonciek hier, und meinte, er mache jetzt Feierabend."
  WonciekAtHotel = true ;
   "Sie sollten ihn also in seinem Hotel antreffen k[nnen."
   "Brauchen Sie die Adresse?"
  Ego:
   "Nein Danke."
  Dame:
   "Wie war Ihr Bewerbungsgespr#ch?"
  Ego:
   "Nun ja, es war sehr.. #h.. aufschlussreich."
   "Jetzt muss ich aber weg!"
  Dame: 
   "Auf wiedersehen!"
  Ego: 
   walk(588,357) ;
   path = 0 ;
   scale = 900 ;
   pathAutoScale = false ;
   walk(620,440) ;
   pathAutoScale = true ;
  doEnter(VorSamTec) ;
 }
 
 clearAction ;
 
} 

/* ************************************************************* */

event Use -> Nasenbrille {
 triggerObjectOnObjectEvent(Use, Kittel) ;
}

event Use -> Kittel {
 if (sawDrStrangelove) {
  if (currentScene != SamTecEmpfang) {
    Ego.say("Hier m[chte ich mich nicht verkleiden.") ;
    clearAction ;
    return ;
  }
  
  if (! disguisedEgo) Ego.say("Eventuell schaffe ich es, mich als dieser Dr. Seltsam zu verkleiden, um in den SamTec-Security-Bereich zu gelangen.") ;
  if (ladyDistracted==2) Ego.say("Jetzt, w#hrend sie abgelenkt ist, k[nnte es vielleicht klappen.") ;
  
  if (!hasItem(Ego, Nasenbrille)) { 
    Ego.say("Wenn ich mich recht erinnere, hat er allerdings eine etwas klobigere Nase und eine Brille mit kleineren, runden Gl#sern.") ;
    Ego.say("M[glicherweise finde ich noch was passendes.") ;
    clearAction ;
    return ;
  }
  if (!hasItem(Ego, Keycard)) {
    Ego.say("Ich habe aber keine Keycard f]r diese Konsole.") ;
    clearAction ;
    return ;
  }
  if (!gotSecurityKey) {
    Ego.say("Ich habe zwar eine passende Nasenbrille und eine Keycard, aber keine Kombination.") ;
    clearAction ;
    return ;
  }
  if (currentScene == SamtecEmpfang) triggerObjectOnObjectEvent(Keycard, Panel) ;
   else Ego.say("Aber hier m[chte ich mich noch nicht kost]mieren.") ;  
 } else {
  Ego.say("Ich will mich jetzt nicht verkleiden.") ;
 }
 clearAction ;	
}

/* ************************************************************* */

script distractLady {
  TelefonGra.enabled = true ;
  Dame.captionClick = false ;
  
  delay 23 ;
  
  continueDistractScript ;
  
  loop {
    delay(2*23) ; 
    delay(random(5)*12) ; 	  
    
    if (! distractInterrupted)
    switch random(7) {
      case 0:
        Dame.say("Das ist ja gro}artig!") ;
      case 1:
        Dame.say("Und Sie versprechen mir, dass mir ]berhaupt keine Nachteile dadurch entstehen?") ;
      case 2:
        Dame.say("Einen KOSTENLOSEN Kugelschreiber gleich mit dazu sagen Sie?") ;
	Dame.say("Das ist ja fantastisch!") ;
      case 3:
	Dame.say("Ich werde auch gleich heute abend meinen Mann fragen, ob er an einer weiteren Option interessiert ist!") ;
      case 4:
        Dame.say("Ein St]ck Pyramide w#re vermutlich das Beste.") ;
      case 5:
	Dame.say("Was ist, wenn mein Artefakt brennt?") ;
      case 6:
	Dame.say("Kann ich meine Option auch in Raten bezahlen?") ;
      case 7:
	Dame.say("Mein gesamter Freundeskreis wird neidisch auf mich sein...") ;
	Dame.say("...wenn ich erstmal ein St]ck Pyramide besitze!") ;
    }
    
  }
}

/* ************************************************************* */

object Scientist {
  name = "Dr. Seltsam" ;
  setupAsActor ;
	
  clickable = false ;
  visible = true ;
  enabled = false ;

  pathAutoScale = true ;
  
  CaptionY = -150 ;

  CaptionColor = COLOR_PLAYER ;
  CaptionFont = defaultFont ;

  walkingSpeed = 8 ;
  WalkAnimDelay = 3 ;
  setStopAnim(ScStat_sprite) ;
  setTurnAnim(ScStat_sprite) ;
  setWalkAnim(ScWalkUp_sprite) ;	
  setPlayAnim(ScTalk_sprite) ;	  
}



script scientistScript {
  delay transitionTime ;

  delay (200 + (random(7)+2) * 50) ;

  if (random(2)==0) delay(200+ (random(9)+3)*40) ;

  if (random(2)==0) { return ; } // don't make the scientist enter the security area 
  if (sawDrStrangelove) if (random(2)==0) { return ;  }
	  
  delay while (forbidScientist) ;
	  
  delay 5 ;

  suspend ;
  Ego.stop ;
  interruptCaptions ;
  scientistCutScene ;
  clearAction ;
}

script scientistCutScene {
  forceHideInventory ;
  sawDrStrangelove = true ;
  Scientist:
   setPosition(620,440) ;
   scale = 900 ;
   pathAutoScale = false ;
   face(DIR_NORTH) ;
   enabled = true ;
  Ego:
   walk(456,288) ;
   turn(DIR_EAST) ;
  Scientist:
   path = Samtecempfang_path ;	 	 
   pathAutoScale = true ;
   walk(565,264) ;
  delay 2 ;
  Dame:
   "Ah, Dr. Seltsam!"
   "Sie sind es wieder?"
  delay 4 ;
  Scientist:
   autoAnimate = false ;
   animMode = ANIM_PLAY ;
   frame = 0 ;
  delay 1 ;
   frame = 1 ;
  delay 1 ;
   frame = 2 ;
  delay 2 ;
   frame = 3 ;
  delay 3 ;
   frame = 4 ;
  start say("Jawohl!") ;
  delay 1;
   frame = 5 ;
  delay 1 ;
   frame = 4 ;
  delay 1 ;
   frame = 3 ;
  delay 4 ;
   frame = 2 ;
  delay 1 ;
   frame = 1 ;
  delay 1 ;
   frame = 0 ;
  delay 5 ;
   animMode = ANIM_STOP ;
   autoAnimate = true ;
  delay 1 ;
   walk(552,228) ;
   autoAnimate = false ;
   animMode = ANIM_PLAY ;
   frame = 0 ;
  delay 8 ;  
   frame = 6 ;
  delay 3 ;
   frame = 7 ;
  delay 3 ;
  for (var i=0; i<6; i++) {
     frame = 8 ;
    delay 2 ;
     frame = 8 ;
    soundBoxStart(Music::Konsole_wav) ;
    delay 1 ;
    delay random(2) ;
  }
  delay 3 ;
   frame = 7 ;
  delay 2 ;
   frame = 6 ;
  delay 12 ;
   frame = 7 ;
  delay 3 ;  
   frame = 8 ;
  soundBoxStart(Music::Opensecurity_wav) ;
  delay 2 ;
  Tuer.visible = true ;
  Scientist:   
  delay 21 ;
   frame = 7 ;
  delay 2 ;
   frame = 6 ;
  delay 3 ;
   frame = 0 ;
   animMode = ANIM_STOP ;
   autoAnimate = true ;
  delay 1 ;
   walk(592,196) ;
  delay 3 ;
  soundBoxStart(Music::Closesecurity_wav) ;
  delay 2 ;
   Tuer.visible = false ;
   Scientist.enabled = false ;
  delay 10 ;
  Ego.turn(DIR_SOUTH) ;
  pujaTipp ;
  forceShowInventory ;
}

script pujaTipp {
  
  if (wonciekSample and wonciekDocuments) {
    Ego.say("Der macht es richtig.") ;	
  } else {
    Ego.say("Ich frage mich, was sich hinter dieser T]r befindet.") ;
    wondersSecurity = true ;
  }
  
}

/* ************************************************************* */

object Strahler {
 setPosition(467,115) ;
 setAnim(Strahl_image) ;
 priority = 213 / 8 ;
 visible = false ;
 enabled = true ;
}

/* ************************************************************* */

object KameraAni {
 setPosition(634,10) ;
 setAnim(Kamera_sprite) ;
 stopAnimDelay = 4 ;
 autoAnimate = true ;
 frame = 1 ;
 visible = true ;
 enabled = true ;
 clickable = false ;
}

/* ************************************************************* */

object Schein {  // Lichtkegel von oben
 setPosition(140,0) ;
 priority = 255 ;
 setAnim(Schein_image) ;
 visible = true ;
 enabled = true ;
}

/* ************************************************************* */

object Tuer { 
 setAnim(sectueroffen_image) ;
 setPosition(525,28) ;
 setClickArea(0,0,120,172) ;	 
 clickable = true ;
 absolute = false ;
 visible = false ;
 enabled = true ;
 name = "T]r zum Securitybereich" ;
}


event WalkTo -> Tuer {
 clearAction ;
 Ego: 
  walk(574,227) ;
  turn(DIR_NORTH) ;
}

event Open -> Tuer {
 clearAction ;
 Ego: 
  walk(574,227) ;
  turn(DIR_NORTH) ;
  "Ich denke, ohne passendes Werkzeug oder das Verwenden der Konsole, wird das nicht klappen."
  
}

event LookAt -> Tuer {
 clearAction ;
 Ego: 
  walk(574,227) ;
  turn(DIR_NORTH) ; 
  "Eine Sicherheitst]r."
  "Sie sieht sehr stabil aus."
  "Neben der T]r befindet sich eine Konsole." 
}

event Use -> Tuer {
 clearAction ;
 Ego: 
  walk(574,227) ;
  turn(DIR_NORTH) ;
  "Ich sollte mich besser an der Konsole zu schaffen machen."
}

/* ************************************************************* */

object Pinnwand {
 setClickArea(86,103,185,174) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Pinnwand" ;
}

event WalkTo -> Pinnwand {
 clearAction ;
 Ego: 
  walk(194,245) ;
  turn(DIR_WEST) ;
}

event LookAt -> Pinnwand {
 Ego: 
  walk(194,245) ;
  turn(DIR_WEST) ;
  delay 10 ;
  if (! hasSTAuthorization) {
   if (! Pinnwand.getField(0)) {
    "Das h[rt sich doch mal interessant an:"
    "Eine Stellenanzeige als Diplom Ingenieur (Uni/FH) Elektrotechnik, Maschinenbau, Physik."
    delay 5 ;
    "Ihre T#tigkeit:"
    delay 5 ;
    "Ihre Aufgabe wird die Leitung eines Applikationsprojektes f]r die Erzeugnisklasse..."
    "...Parkpilot im Bereich Fahrerassistenzsysteme sein. Dies beinhaltet im Kern die Koordination..."
    "...der unternehmensinternen Entwicklungsaktivit#ten innerhalb eines jungen, dynamischen Produktbereiches."
    "Sie tragen die Verantwortung f]r die Schnittstellen zum jeweiligen (internationalen) Kunden und..."
    "...f]r das Projektcontrolling (Termine, Kosten und Technik)."
    delay 5 ;
    "Unsere Erwartungen:"
    delay 5 ;
    "Mehrj#hrige Berufserfahrung in der Fahrzeugtechnik"
    "hohe Bereitschaft zur Zusammenarbeit und Teamf#higkeit"
    "sicheres Auftreten, z.B. bei Kundenpr#sentationen"    
    "Belastbarkeit und mentale St#rke"    
    "Englisch, verhandlungssicher in Wort und Schrift"
    "Franz[sisch unerw]nscht (!)"
    Pinnwand.setField(0, 1) ;
    delay 10 ;
    "Das trifft sich gut, ich hasse Franz[sisch!"
   } else {
    "Hier wird ein Diplom-Ingenieur f]r die Bereiche Elektrotechnik, Maschinenbau und Physik gesucht."
   }
  } else {
   "Hehe."
  }
 clearAction ;
}

/* ************************************************************* */

script distractInterrupted {
 return Dame.getField(2) ;
}

script interruptDistractScript {
  Dame.setField(2, true) ;
}

script continueDistractScript {
  Dame.setField(2, false) ;
}

object Dame {
 setAnim(Dame_sprite) ;	
 setPosition(400,76) ; 
 setClickArea(0,0,49,97) ; 
 absolute = false ;
 clickable = true ;
 visible = true ;
 enabled = true ;
 captionwidth = 400 ;
 captionX = GetSpriteFrameWidth(Dame_sprite,0) / 2  ;
 captionY = 10 ;
 captionColor = COLOR_HOTELGAST ;
 class = StdEventObject ; 
 StdEvent = TalkTo ;   
 name = "Dame" ;
 autoAnimate = false ;
}

script AnimateEmpfangsdame {
 activeObject = Dame ;
 killOnExit = true ;
 frame = 0 ;
 int i = 0 ;
 loop {
	 
 if (animMode == ANIM_STOP) {
  if (frame == 0) { 
   frame = 1 ; 
   i = (10+random(30)) ; 
   while (i>0) and (animMode == ANIM_STOP) { i--; delay(1); }
  } else
   if (frame == 1) {	   
    if (random(10) == 2) {
     frame = 0 ;     
     i = (8+random(30)) ;
     while (i>0) and (animMode == ANIM_STOP) { i--; delay(1); }
     frame = 1 ;
     i = (18+random(40)) ;
     while (i>0) and (animMode == ANIM_STOP) { i--; delay(1); }
    } else 
     if (random(5) == 2) {
      frame = 2 ;
      i = (20+random(60)) ;
      while (i>0) and (animMode == ANIM_STOP) { i--; delay(1); }
     } else {
      frame = 3 ;
      i = (20+random(60)) ;
      while (i>0) and (animMode == ANIM_STOP) { i--; delay(1); }
     } 
    }
   if (frame > 1) { 
   frame = Random(2); 
   i = (20+random(90)); 
   while (i>0) and (animMode == ANIM_STOP) { i--; delay(1); }
   } 
 }
 
 if (animMode == ANIM_TALK) {
  if (frame < 4) { frame = 1; delay(4); frame = 0; delay(4); } 
  if (frame % 2 == 0) { frame = 5 + Random(3)*2 ; delay(2+random(5)); } else { frame = 4 + Random(3)*2; delay(2+random(5)); }
 }
  
  delay(1) ;
 } 
}

event WalkTo -> Dame {
 clearAction ;
 Ego:
  walk(344,271) ;
  turn(DIR_NORTH) ;
}

event LookAt -> Dame {
 Ego:
  walk(344,271) ;
  turn(DIR_north) ;
 "Eine #ltere Frau sitzt hinter dem Empfangstisch."
 if (ladyDistracted==2) { 
   say("Sie telefoniert gerade mit meinem Gesch#ftspartner.") ;
   say("Das sollte ich ausnutzen.") ;
 }
 clearAction ;
}

event Klappspaten -> Dame {
 Ego: walk(344,271) ;
      turn(DIR_NORTH) ;
 Ego.say("Kennen Sie die 'Operation Klappspaten'?") ;
 EgoStartUse ;
 dropItem(Ego, Klappspaten) ;
 delay 19 ;
 takeItem(Ego, Klappspaten) ;
 EgoStopUse ;
 Dame.say("Ja. Einige Mitarbeiter haben davon geredet.") ;
 Dame.say("Einen Klappspaten h#tte ich.") ;
 Dame.say("Wissen Sie, wann es los geht?") ;
 delay 2 ;
 Ego.say("Wenn die Zeit reif ist.") ;
 clearAction ;
}

event TalkTo -> Dame {	
 Ego:
  walk(344,271) ;
  turn(DIR_NORTH) ;
 if (ladyDistracted == 2) {
  turn(DIR_SOUTH) ;
  "Nicht jetzt, sie ist besch#ftigt!"
  clearAction ;
  return ;
 }
 
 forbidScientist = true ;
 
 switch random(4) {
  case 0 : "Hallo." ;
  case 1 : "Hi." ;
  case 2 : "Guten Tag." ;
  case 3 : "Gr]} Gott." ;  
 }
 
 Dame:
 
 if (currentAct == 4) DD2pre ;
 
 switch random(2) { 
  case 0: "Was kann ich f]r Sie tun?"
  case 1: "Wie kann ich Ihnen helfen?"
 }
 
 if (currentAct == 4) DD2 ;  
  else DD1 ;
   
 clearAction ;
 
 forbidScientist = false ;
 
}

/* ************************************************************* */

object Panel {
 setClickArea(502,116 ,528,148);
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Konsole" ;
}

event WalkTo -> Panel {
 clearAction ;
 Ego:
  walk(565,264) ;
  face(DIR_NORTH) ;
}

event LookAt -> Panel {
 clearAction ;
 Ego:
  walk(565,264) ;
  face(DIR_NORTH) ;
  "Eine kleine Konsole, mit einem Tastenfeld und einem Schlitz f]r Chipkarten."
  "Damit wird sich wohl die Sicherheitst]r [ffnen lassen."
}

event Pull -> Panel {
 triggerObjectOnObjectEvent(Take, Panel) ;
}

event Use -> Panel {
 Ego:
  walk(565,264) ;
  face(DIR_NORTH) ;
  "Ich muss eine Chipkarte damit verwenden."  
 clearAction ;  
}

event Take -> Panel { 
 Ego:
  walk(565,264) ;
  face(DIR_NORTH) ;
  "Ich werde es nicht schaffen, die Konsole aus der Wand zu rei}en."
  "Genauer gesagt will ich es auch gar nicht versuchen."
 clearAction ;  
}

event Keycard -> Panel {
	
 forbidScientist = true ;
 suspend ;
 forceHideInventory ; 
 
 Ego:
 if (gotSecurityKey) {
   "Ich verwende die Kombination von Peter."
  
  if ((not hasItem(Ego, Kittel)) or (not hasItem(Ego, Nasenbrille))) {
   walk(536,229) ;
   face(DIR_NORTH) ;	  
   EgoUse ;
   Dame:
    "Hey!"
    "Was machen Sie da?"
   Ego:
    turn(DIR_WEST) ;
    "|hhhh..."
   delay 2 ;
    "Gar nichts?"
   Dame:
   delay 2 ;
    "Dann verschwinden Sie besser mal von hier."
   delay 3 ;
    "Sie haben hier nichts verloren!"
   delay 4 ;
   Ego:
    turn(DIR_SOUTH) ;
   delay 4 ;
   if (sawDrStrangelove) {
     "Vielleicht kann ich mich irgendwie als dieser Dr. Seltsam verkleiden."
   } else {
     "Ich sollte mir wohl besser etwas einfallen lassen."
   }
   clearAction ;
   
   forbidScientist = false ;
   
   forceShowInventory ;
   
   return 0 ;
  }
  
   "Und gehe mich mal eben noch umziehen."
  delay 10 ;
   walk(588,357) ; 
   turn(DIR_SOUTH) ;
   visible = false ;
  delay 20 ;
  JulianDress ;
  delay 50 ;
   setPosition(620,440) ;
   scale = 900 ;
   pathAutoScale = false ;
   face(DIR_NORTH) ;
   enabled = true ;
   visible = true ;
   walk(588,357) ;
   path = Samtecempfang_path ;	 	 
   pathAutoScale = true ;  
   walk(565,264) ;
  interruptDistractScript ;  
  Dame.caption = null ; 
  delay 3 ;
  Dame:
   caption = null ;
   "Ah, Dr. Seltsam!"
   "Sie sind es wieder?"
  delay 4 ;
  Ego:
   turn(DIR_WEST) ;
  delay 9 ;
   say("Jawohl!") ;
  delay 5 ;
  
   turn(DIR_NORTH) ;
  delay 20 ;
  
  if (ladyDistracted != 2) {
   Dame:
    "Moment mal!"
   delay 3 ;
    "Sie sind gar nicht Dr. Seltam!"
   delay 4 ;
    "Ich kenne Sie ]berhaupt nicht."
   delay 3 ;
    "Machen Sie, dass Sie verschwinden, Sie haben hier nichts verloren!"
   delay 2 ;
   Ego:
    walk(563,354) ;
    visible = false ;
    JulianUnDress ;
   delay 20 ;
    setPosition(620,440) ;
    scale = 900 ;
    pathAutoScale = false ;
    face(DIR_NORTH) ;
    enabled = true ;
    visible = true ;
    walk(588,357) ;
    path = Samtecempfang_path ;	 	 
    pathAutoScale = true ;  
    walk(565,264) ;
   pujaTipp2 ;
   julianCaught = true ;
   clearAction ;
   
   forbidScientist = false ;
   
   forceShowInventory ;
   
   continueDistractScript ;
   
   return 0 ;
   
  }
   walk(552,228) ;
  start {
   Dame.say("Ich glaube Sie haben mich ]berzeugt.") ;
   delay 2 ;
   Dame.say("Ich kaufe die Option. Ich will den linken Fu} der Sphinx.") ;
  }
  delay 6 ;
  
  EgoStartUse ;
  
  for (var i=0; i<6; i++) {
    delay 2 ;
    soundBoxStart(Music::Konsole_wav) ;
    delay 1 ;
    delay random(2) ;
  }
  EgoStopUse ;
  delay 12 ;
  EgoStartUse ;
  soundBoxStart(Music::Opensecurity_wav) ; 
  delay 2 ;
  Tuer.visible = true ;
  EgoStopUse ;
   walk(592,196) ;
   turn(DIR_NORTH) ;
  delay 3 ;
  soundBoxStart(Music::Closesecurity_wav) ;
  delay 2 ;
   Tuer.visible = false ;
   Ego.enabled = false ;
  delay 123 ;
  Dame.say("Ja, Kreditkarte klingt gut.") ;
  delay 10 ;
  doEnter(Securitygang) ;
  finish ;
  return ;
 } else say("Ich habe keine Kombination!") ;
 
 forbidScientist = false ;
 Dame.setField(1,0) ;
 
 forceShowInventory ;
 
 clearAction ;
 
}

script pujaTipp2 {
 Ego:
  turn(DIR_SOUTH) ;
  if (JulianCaught == false) {
    say("Muss das eben l#cherlich ausgesehen haben.") ;
    say("Hoffentlich beobachtet momentan gerade niemand das Bild der Kamera.") ;
    delay 3 ;
  }
  say("Ich muss die Frau irgendwie ablenken...") ;
}

/* ************************************************************* */

object Kamera {
 setClickArea(628,0,661,27 ) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kamera" ;
}

event WalkTo -> Kamera {
 clearAction ;
 Ego:
  walk(615,240) ;
  face(DIR_NORTH) ;
}

event LookAt -> Kamera {
 clearAction ;
 Ego:
  walk(615,240) ;
  face(DIR_NORTH) ;
  "Eine kleine {berwachungskamera."
  "Gut gesichert, dieses Geb#ude."
}

event Push -> Kamera {
 clearAction ;
 Ego:
  walk(323,262) ;
  face(DIR_NORTH) ;
  "Ich komme nicht ran."
}

event Pull -> Kamera {
 clearAction ;
 Ego:
  walk(323,262) ;
  face(DIR_NORTH) ;
  "Ich komme einfach nicht ran."
}

/* ************************************************************* */

object Stifte {
 setClickArea(334,173,348,194) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Stifte" ;
}

event WalkTo -> Stifte {
 clearAction ;
 Ego:
  walk(323,262) ;
  face(DIR_NORTH) ;
}

event Take -> Stifte {
 Ego:
  "Die brauche ich wirklich nicht."
  "Vorerst." 
 clearAction ;
}

event LookAt -> Stifte {
 clearAction ;
 Ego:
  walk(323,262) ;
  "Ein paar Stifte in einem Becher."
  "Der Becher sieht aus wie ein Zahnputzbecher."
  "Moment mal!"
  "Einer der Stifte ist in Wirklichkeit eine Zahnb]rste." // warum zahnbürste?
}


/* ************************************************************* */

object Pflanze {
 setClickArea(271,143,320,221) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Zimmerpflanze" ;
}

event WalkTo -> Pflanze {
 clearAction ;
 Ego:
  walk(290,236) ;
  face(DIR_NORTH) ;
}

event LookAt -> Pflanze {
 Ego:
  walk(290,236) ;
  face(DIR_NORTH) ;
 "Eine sch[ne Zimmerpflanze."
 clearAction ;
}

event Use -> Pflanze {
 clearAction ;
 Ego:
  walk(290,236) ;
  face(DIR_NORTH) ;
 "Niemals!"
}

event TalkTo -> Pflanze {
 Ego:
  walk(290,236) ;
  face(DIR_NORTH) ;
 "Hallo Pflanze."
 clearAction ;
}


/* ************************************************************* */

object TelefonO {
 setClickArea(469,162,504,190) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Telefon" ;
}

object Telefongra {
 setPosition(452,162) ;
 setAnim(Telefon_sprite) ;
 visible = true ;
 enabled = false ;
 clickable = false ;
 absolute = false ;
}

event Use -> TelefonO {
 
 forbidScientist = true ; 

 Ego:
  walk(487,277) ;
  face(DIR_NORTH) ;
  "D]rfte ich mal schnell telefonieren."
  "Es dauert auch wirklich nicht lange."
 Dame:
  "Es tut mir leid, das kann ich Ihnen leider nicht gestatten."
 Ego:
  "Keine Chance?"
 Dame:
  "Keine Chance."
 clearAction ;
 
 forbidScientist = false ;
 
}

event WalkTo -> TelefonO {
 clearAction ;
 Ego:
  walk(487,277) ;
  face(DIR_NORTH) ;
}

event LookAt -> TelefonO {
	
 clearAction ;
 Ego:
  walk(487,277) ;
  face(DIR_NORTH) ;
 suspend ;  
 forbidScientist = true ;	
 
  "Sieht mir verd#chtig nach einem stinknormalen Telefon aus."
  if (julianCaught) {    
    if (ladyDistracted==2) { 
      say("Gerade telefoniert die Frau mit meinem Gesch#ftspartner.") ;
      say("Das sollte ich ausnutzen.") ;
    } else {
      say("Vielleicht kann ich jemanden dazu bringen, diese Dame da anzurufen...") ;
      say("...so dass sie abgelenkt ist, w#rend ich mich in diesen Sicherheitsbereich schleiche!") ;
    }
  } 
 forbidScientist = false ; 
 clearAction ;
}

event TalkTo -> TelefonO {
	
static var talkedToPhone = 0 ;

 if (TalkedToPhone == 0) {
	 
  forbidScientist = true ;	 
	 
  Ego:
   walk(487,277) ;
   face(DIR_NORTH) ;
   "Hallo? Jemand da?"
  Dame:
   "Sprechen Sie mit mir?"
  Ego:
   "Nein, wie kommen Sie darauf?"
  Dame:
  "Sie haben doch gerade etwas gesagt."
    "Haben Sie etwa mit dem Telefon gesprochen?"
  Ego:
   "@hm... Nein, nat]rlich nicht."
  Dame: 
   "Sie verhalten sich h[chst seltsam..."
  Ego:
   "Manchmal tue ich Dinge, und wei} einfach nicht warum..."
   "Als ob ein b[ser D#mon mein Leben kontrolliert."
  TalkedToPhone = 1 ;
  
  forbidScientist = false ;
  
 } else {
  Ego:
   "Nein!"
   "Ich MUSS mich diesmal beherrschen."
   "Ich kann es schaffen!"   
 }
  clearAction ; 
  
}

/* ************************************************************* */

object Zeitung {
 setClickArea(437,188,477,214) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Zeitungsausschnitt" ;
}

event WalkTo -> Zeitung {
 clearAction ;
 Ego:
  walk(452,276) ;
  face(DIR_NORTH) ;
}

event LookAt -> Zeitung {
	
 forbidScientist = true ;	
	
 Ego:
  walk(452,276) ;
  face(DIR_NORTH) ;
 Ego:
  "Eine deutsche Zeitung."
 if (currentAct == 4) {
   if (knowsMutated) {
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
 
 forbidScientist = false ;
 
}

event Take -> Zeitung {
 Ego:
  walk(452,276) ;
  face(DIR_NORTH) ;
 EgoStartUse ;
 Dame:
 
  "Das lassen sie sch[n hier!"
 EgoStopUse ;
 clearAction ;
}

/* ************************************************************* */

object Aufzugtuer {
 setupAsStdEventObject(Aufzugtuer,Use,716,269,DIR_EAST) ;		
 setPosition(723,72) ;
 setAnim(Aufzug_sprite) ;
 stopAnimDelay = 5 ;
 autoAnimate = false ;
 frame = 0 ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 setClickArea(0,0,77,230) ;
 name = "Aufzug" ;
}


event WalkTo -> Aufzugtuer {
 clearAction ;
 Ego:
  walk(716,269) ;
  turn(DIR_EAST) ;
}

event Open -> Aufzugtuer {
 triggerObjectOnObjectEvent(Use, Aufzugtuer) ;
}

event Use -> Aufzugtuer { 
 Ego:
  walk(716,269) ;
  turn(DIR_EAST) ;
  suspend ;  
 if (! Dame.getField(0)) {
  if (ladyDistracted) { interruptDistractScript ; Dame.caption = null ; delay 4 ; }
  Dame: "Bleiben Sie stehen!"
  Ego: turn(DIR_WEST) ;
  if (currentAct == 2) {
    Dame: "Ich kann Sie den Aufzug leider nicht benutzen lassen."	 
    if (AskElevator == 0) AskElevator = 1 ;
  } else {
    Dame:
     "Sie k[nnen nicht nach oben."
     "Tut mir Leid, aber strenge Anweisungen."
    if (ladyDistracted) { continueDistractScript ; delay 4 ; }     
  }
  clearAction ;	
 } else {
  if (OutsideChefCount == 0) {
   forceHideInventory ;
   delay 3 ;
   Dame: saySlow("Viel Gl]ck!",5) ;
   Ego: 
    turn(DIR_WEST) ;
    delay 4 ;
    "Danke..."
    delay 4 ;
    turn(DIR_EAST) ;
  }	  
   path = 0 ;
   pathAutoScale = false ;
   scale = 735 ;
  aufzugAuf ;
  Ego:
   walk(820,261) ;    
  aufzugZu ;
  // Aufzubenutzung zukünftig wieder verbieten:
  Dame.setField(0, false) ;
  
  delay 23 ;
   Ego.pathAutoScale = true ;
   doEnter(Aufzug) ; 
 }
}

script aufzugAuf {
 start {
   delay 2 ;
   Aufzugtuer:
    frame = 0 ;
    delay 2 ;
    frame = 1 ;
    delay 2 ;
    frame = 2 ;
    delay 2 ;
    frame = 3 ;
    delay 2 ;
    frame = 4 ;
    delay 2 ;
    frame = 5 ;
    delay 2 ;  
    frame = 6 ;
    delay 2 ;  
 }
 soundBoxPlay(Music::Aufzugauf_wav) ;  
}

script aufzugZu {
 start {
   delay 2 ;
   Aufzugtuer:  
    frame = 6 ;
    delay 2 ;  
    frame = 5 ;
    delay 2 ;
    frame = 4 ;
    delay 2 ;
    frame = 3 ;
    delay 2 ;
    frame = 2 ;
    delay 2 ;
    frame = 1 ;
    delay 2 ;
    frame = 0 ;
    delay 2 ;  
 }
 soundBoxPlay(Music::Aufzugzu_wav) ;    
}


/* ************************************************************* */

object Zurueck {
 setClickArea(422,318,729,361) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "nach drau}en" ;
}

event WalkTo -> Zurueck {
 clearAction ;
 Ego:
  walk(563,354) ;
  suspend ;
  doEnter(VorSamTec) ;
}

/* ************************************************************* */

script DD1 {
 static var dd1a = 0 ;	
 static var dd1b = false ;

 loop {
  Ego:
  AddChoiceEchoEx(1, "Kennen Sie einen gewissen Peter Wonciek?", false) if (dd1a==0) ;
  AddChoiceEchoEx(1, "K[nnte ich bitte mit Ihrem Chef sprechen?", false) if (dd1a==1) ;
  AddChoiceEchoEx(1, "Sind Sie ABSOLUT sicher, dass Sie mich nicht zu Ihrem Chef lassen k[nnen?", false) if (dd1a==2 and ! Pinnwand.getField(0)) ;
  AddChoiceEchoEx(1, "Kann ich zu Ihrem Chef, wenn ich mich um die Stelle als Diplom Ingenieur bewerben m[chte?", false) if (dd1a==2 and Pinnwand.getField(0)) ;
  AddChoiceEchoEx(2, "Sie haben nicht sehr viel zu tun, oder?", false) if (dd1b==false) ;
  AddChoiceEchoEx(3, "Warum kann ich den Aufzug nicht benutzen?", false) if (askelevator==1) ;
  AddChoiceEchoEx(4, "Ich gehe dann mal.",false) ;
   
  var c = dialogEx () ;
  
  switch c {
   case 1: 
    if (dd1a == 0) {
     Ego: "Kennen Sie einen gewissen Peter Wonciek?"
     Dame: "Wonciek? Ja, das ist einer unserer neuen Mitarbeiter."    
     Ego: "Sehr gut, ich suche ihn n#mlich schon l#nger."
     dd1a = 1 ;
     DD11 ;
    } else if (dd1a == 1) {
     Ego: "K[nnte ich bitte mit Ihrem Chef sprechen?"
     Dame: "Das geht leider nicht."
           "Mein Chef ist ein vielbesch#ftigter Mann, m]ssen Sie wissen."
	   "Er kann keine unangemeldete G#ste empfangen."
     Ego: "Dann machen Sie bitte einen Termin f]r mich aus, m[glichst bald."
     delay 33 ;
     Dame: "Mittwoch n#chste Woche, 15:00 Uhr, w#re frei. Wie passt Ihnen das?"
     Ego: "Vergessen Sie es, ich will einfach nur wissen, wo Wonciek ist."
          "Und das wei} ja anscheinend nur Ihr Chef."
     Dame: "Tut mir Leid, einfach so kann ich Sie nicht zu ihm lassen."
     dd12 ;
     dd1a = 2 ;
    } else {
     if (Pinnwand.getField(0)) {
      Ego: "Kann ich zu Ihrem Chef, wenn ich mich um die Stelle als Diplom Ingenieur bewerben m[chte?"
      Dame: "Selbstverst#ndlich. Ein ausf]hrliches Bewerbungsgespr#ch wird Ihnen nicht erspart bleiben."
            "Ihre Bewerbungsunterlagen haben Sie bei sich?"
      Ego: "Aber nat]rlich."
      Dame: "Gut. Sie k[nnen den Aufzug nach oben nehmen."
      Dame.setField(0,1) ;
      AskElevator = 2 ;
      return ;
     } else {
      Ego: "Sind Sie ABSOLUT sicher, dass Sie mich nicht zu Ihrem Chef lassen k[nnen?"
      Dame: "Absolut."
     }
    }
   
   case 2:
    Ego: "Sie haben nicht so viel zu tun, oder?"
    Dame: "Naja, es geht."
	  "Ein bisschen Schreibarbeit, ab und an ein Anruf."
	  "Nichts Gro}artiges."
    dd1b = true ;
   case 3:
    Ego: "Warum kann ich den Aufzug nicht benutzen?"
    Dame: "Mein Chef empf#ngt keine unangemeldeten G#ste."
          "Tut mir Leid f]r Sie."
    AskElevator = 2 ;
   case 4:
    Ego: "Ich gehe dann mal."    
    Dame: "Auf wiedersehen."
    return ;
  }
 }
	
}

script DD11 {
	
 static var dd11a = 0 ;		
 static var dd11c = false ;	
	
 loop {
  if (dd11a == 2 and dd11c == true) return ;
  Ego:
  AddChoiceEchoEx(1, "Wissen Sie, wo Wonciek sich gerade aufh#lt?", false) if (dd11a==0) ;
  AddChoiceEchoEx(2, "Gibt es jemanden im Haus, der wissen k[nnte, wo Wonciek steckt?", false) if (dd11a==1) ;	  
  AddChoiceEchoEx(3, "Wann haben Sie Wonciek das letzte mal gesehen?", false) if (dd11c==false) ;
   
   
  var c = dialogEx () ;
  
   
  
  switch c {
   case 1: 
    Ego: "Wissen Sie, wo Wonciek sich gerade aufh#lt?"
    Dame: "Nein, da muss ich Sie leider entt#uschen." 
          "Ich glaube zwar, dass er heute schonmal im Haus war..."
	  "...habe aber keine Ahnung wo er sich jetzt gerade befindet."
    Ego: "Verstehe."
    dd11a = 1 ;
   case 2:
    Ego: "Gibt es jemanden im Haus, der wissen k[nnte, wo Wonciek steckt?"
    Dame: "Aber nat]rlich."
          "Mein Chef, Adrian Brander, beh#lt f]r gew[hnlich den {berblick ]ber seine Mitarbeiter."
    KnowsBrander = true ; 
    dd11a = 2 ;   
   case 3:
    Ego: "Wann haben Sie Wonciek das letzte mal gesehen?"
    Dame: "Ich bin mir nicht ganz sicher, aber ich denke, dass ich ihn heute schon einmal gesehen habe."
          "Wir haben so viele neue Gesichter hier, da f#llt es am Anfang schwer, allen einen Namen zuzuordnen."	      
    dd11c = true ;
  }
 }
	
}

script DD12 {
 loop {  
  Ego:
  AddChoiceEchoEx(1, "Es geht aber um Leben und Tod!", true) ;
  AddChoiceEchoEx(2, "Wenn Sie mich nicht sofort durchlassen, wird etwas Schlimmes passieren.", true) ;
  AddChoiceEchoEx(3, "Bitte, machen Sie eine Ausnahme.", true) ;
   
  var c = dialogEx () ;
   
  switch c {
   case 1, 2:
    Dame: "Das glaube ich kaum."
  
   case 3:
    Dame: "Das kann ich nicht."
  }
  return ;
 }
}

script DD2pre {
 static var told = false ;
 if (!told) {
   told = true ;
   Dame:
    "Sagen Sie, haben Sie die Stelle nun bekommen, f]r die Sie sich bewerben wollten?"
   delay 3 ;
   Ego:
    "@hm..."
    "Nein."
    "Ich war nicht mehr interessiert."
   Dame:
   delay 3 ;
    "Warum dieser Sinneswandel?"
   Ego:
    "Das Gehalt war mir zu niedrig."
   Dame:
   delay 3 ;
    "Ja, das kann ich verstehen."
    "Und glauben Sie mir, wenn Sie hier eine Gehaltserh[hung verlangen, haben Sie keine Chance."
    "Aber das bleibt unter uns."
   Ego:
   delay 4 ;
    "Selbstverst#ndlich."
 }
}


script DD2 {
	
 static var DD2b = false ;
 static var DD2c = 0 ;
 static var askedSecurity = false ;
	
 loop {  
  Ego:
  addChoiceEchoEx(1, "Was k[nnen Sie mir ]ber SamTec erz#hlen?", true) if (DD2c==0) ;
  addChoiceEchoEx(2, "Wissen Sie, ob zwei gro}e starke Typen im Anzug hier arbeiten?", true) if (DD2c==1) ;	  
  addChoiceEchoEx(3, "Wie gut kennen Sie ihren Chef?", true) if (DD2c==2) ;	  	  
  addChoiceEchoEx(4, "Wissen Sie etwas ]ber ein SamTec-Labor, das f]r Mutationen der Fische im Nil verantwortlich sein soll?", true) if (knowsMutated and (not knowsDOTT) and (DD2c>=1)) ; 
  addChoiceEchoEx(5, "Wie lautet die Telefonnummer f]r Ihren Anschluss hier?", false) if ((julianCaught) and (! DD2b)) ;
  addChoiceEchoEx(6, "Was ist hinter dieser T]r da hinten?", true) if (wondersSecurity and (! askedSecurity)) ;
  addChoiceEchoEx(7, "Ich muss dann mal wieder.", true) ;
   
  var c = dialogEx () ;
   
  switch c {
   case 1:
    DD2C = 1 ;	 
    delay 3 ;
    Dame:
     "SamTec ist die Dachgesellschaft mehrerer selbstst#ndiger Tochterunternehmen."
    delay 3 ;
     "Diese sind international in der chemischen und pharmazeutischen Industrie t#tig."
    delay 4 ;
     "Ihre Hauptgesch#ftsfelder sind Chemikalien, Kunststoffe, Veredelungsprodukte..."
     "...Pflanzenschutz und Ern#hrung, |l und Gas, sowie Arzneimittel."
    delay 5 ; 
    Ego:
     "Arzneimittel?"
     delay 4 ;
    Dame:
     "Ja, Sie haben richtig geh[rt."
    delay 2 ;
     "Hier in @gypten ist in Luxor unser Tochterunternehmen 'SamTec Pharmaceuticals' ans#ssig."
     "Es ist ein weltweit f]hrender forschender Pharmahersteller."
    delay 4 ;
     "Das Unternehmen konzentriert sich haupts#chlich auf neue, innovative Pr#parate..."
     "...die zum Gro}teil f]r die Selbstmedikation vorgesehen sind."
    delay 5 ;
    knowsPharma = true ;
    Ego:
     "Interessant..."
    delay 3 ;
    Dame:
     "Wenn Sie noch mehr ]ber die anderen Tochterunternehmen erfahren wollen..."
     "...sind Sie bei mir aber an der falschen Adresse."
    delay 5 ;
     "Ich bin hier schlie}lich nur die Empfangsdame."
    delay 4 ;
    Ego:
     "Vielen Dank." 
     "Ich h#tte aber noch eine andere Frage."    
   case 2:    
    DD2C = 2 ;	   
    Dame:
     "Im Anzug?"
     "Hier arbeiten eine Menge Leute, die im Anzug durch die Gegend laufen."
    delay 2 ;
    Ego:
     "Sie sehen eher nach professionellen Schuldeneintreibern aus."
    Dame:
    delay 3 ;
     "Hmmmmm...."
    delay 7 ;
     "Wenn sie hier arbeiten, sind sie mir jedenfalls noch nicht aufgefallen."
    Ego:
    delay 2 ;
     "Okay."
     "Und die Namen John Jackson und Jack Johnson, sagen die Ihnen was?"
    delay 12 ;
    Dame:    
     "Sind das nicht diese ber]hmten Zirkusartisten?"
    Ego:
    delay 2 ;    
     "Nein, so hei}en die Typen von denen ich sprach."
    Dame:
    delay 4 ;    
     "Hmmm, dann kann ich Ihnen nicht weiterhelfen."
    delay 3 ;
    Ego:
     "Ich habe noch eine weitere Frage."
    DD2C = 2 ;
   case 3:
    Dame:
    delay 3 ;
     "Eigentlich kenne ich ihn kaum."
     "Er arbeitet meistens l#nger als ich, vor allem in letzter Zeit, so dass ich ihn nicht gehen sehe."
     "Wie Sie sich denken k[nnen, ist er ein vielbesch#ftigter Mann."
    Ego:
    delay 4 ;
     "Meinen Sie, ich k[nnte nochmal zu ihm nach oben?"
    delay 5;
    Dame:
     "Nein, das ist ausgeschlossen."
     "Tut mir Leid, aber strenge Anweisungen."
    DD2c = 3 ;
   case 4:
    Dame: 
     "Ja, die Zeitung schrieb dar]ber."
     "Soweit ich wei}, geh[hrt das Labor zu unsererem Tochterunternehmen 'SamTec Pharmaceuticals'."
     "Es ist aber schon seit Monaten stillgelegt."
    Ego:
    delay 3 ;
     "Haben Sie eine Adresse?"
    Dame: 
    delay 2 ;
     "Ja, Moment..."
    delay 12 ;
     "Al Azhar Street."
     "Das Geb#ude liegt aber etwas abseits, in der N#he des Golf-Clubs."     
     knowsDOTT = true ;
    Ego: 
     "Vielen Dank!"    
   case 5:
    Ego:
     "Wie lautet die Telefonnummer f]r Ihren Anschluss hier?"
    Dame:
     "F]r was halten Sie mich, f]r eine einfache Tippse?!"
    DD3 ;
    delay 70 ;
    Ego:
     "Also..."
    delay 20 ;
    Dame:
     "Ihr Schweigen ist eine Unversch#mtheit!"     
    Ego:
     turn(DIR_SOUTH) ;
     "Mehr Feingef]hl, Julian, mehr Feingef]hl!"
    DD2b = true ;
    return ;
   case 6 :
    Dame:
     "Das ist unser Hochsicherheitsbereich."
     "Nur autorisierte Mitarbeiter haben Zutritt."     
    Ego:
     "Wie kommt man dort rein?"
    Dame:
     "Also Sie gar nicht, da muss ich Sie entt#uschen."
    askedSecurity = true ;
   case 7:
    Dame: "Bis bald!"
    return ;
  }
  
 }
	
}

script DD3 {
	
 loop {  
  Ego:
  addChoiceEchoEx(1, "Nein!", false) ;
  addChoiceEchoEx(2, "Ach was, wo denken Sie hin?", false) ;
  addChoiceEchoEx(3, "Das w]rde mir nicht mal im Traum einfallen.", false) ;
  addChoiceEchoEx(4, "Niemals!", false) ;
  dialogEx () ;
  return ;
 }
		
}
