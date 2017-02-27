// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

const CHEF_GROUP = 23231 ;

event enter {
 Ego.enabled = false ;
 Ego.visible = false ;
 HideInventory ;
 backgroundImage = Chefbuero_image;
 backgroundZBuffer = 0 ;
 path = 0 ;
  
 if ((TelStage == 10) and ((currentAct == 2) || (currentAct == 4))) {
  delay(24) ; 
  start AnimateChef ;
  TelefonO.captionColor = Ego.captionColor ;
  TelefonO: "...das lassen Sie mal unsere Sorge sein,..."
           "... um die Formalit#ten brauchen Sie sich nicht zu k]mmern" ;
  Chef: "Und ihre Experten sind sich sicher was den Granitpreis in 50 Jahren angeht?"
  TelefonO: "Felsenfest."
  Chef: "Wunderbar."
        "Dann erwarte ich den Kaufvertrag n#chste Woche."
	"Auf Wiederh[ren Herr H]bler."
  delay(3) ;
  TelefonO: "Eine Freude mit ihnen Gesch#fte zu machen." ;
  delay 2 ;
  killEvents(CHEF_GROUP) ;
  auflegen ;
  delay(10) ;
  start AnimateChef ;
  Chef: "Was f]r ein Trottel!"
  delay(3) ;
	"Es h#tte mich ein Verm[gen gekostet, die Sphinx selbst zu stehlen."
  delay(2) ;
  killEvents(CHEF_GROUP) ;
  doEnter(VorFlughafen) ;
  return 0 ;
 } 
 
 if (CurrentAct == 1) {
  delay(24) ; 
  anfang ;
  abheben ;
  start AnimateChef ;
  delay(10) ;
  TelefonO:
   "Chef, ich fasse mich kurz:"
   "Ich habe eine schlechte Neuigkeit."
  Chef: 
   "Schie}en Sie los."
  TelefonO:
   "Nun ja, wie soll ich es erkl#ren..."
   delay 10 ;
   "Johnson und Jackson haben versagt."
  Chef:
   wuetend = true ;
   "WAAAAS???"
   delay 10 ;
   "Wie kann man nur so unf#hig sein?"
   "Es ist doch nicht so schwer..."
   "...mit solch einem Idioten fertig zu werden."
   wuetend = false ;
   "Wo sind die Beiden jetzt?"
  TelefonO:
   "Im Krankenhaus."
  delay 20 ;
  Chef:
   "Und wo ist Hobler jetzt?"
  TelefonO:
   delay 30 ;
   "Er sitzt im Flieger nach Kairo."
  Chef:
   wuetend = true ;
   "ZUM TEUFEL MIT EUCH TAUGENICHTSEN!"
   "Wenn man will, dass etwas richtig gemacht wird..."
   "...muss man sich selber darum k]mmern."
   delay 20 ;
   wuetend = false ;
   "ICH werde die Sache nun selbst ]bernehmen."  
   delay 10 ;
   killEvents(CHEF_GROUP) ;
   auflegen ;
   delay 60 ;  
   doEnter(Intrologo) ;
   return ;
 } 
 
 if (CurrentAct == 3) {
  Txt.enabled = true ;
  delay(24) ; 
  anfang ;
  abheben ;
  start AnimateChef ;
  delay(10) ;
  TelJohn:
   "Hallo Chef?"
  Chef: 
   "Johnson!"
   "Jackson!"
   "Warum hat das so lange gedauert?"
   "Wo ist Hobler?"
  TelJack:
   "Wir haben ihn in der Ausgrabungsst#tte eingesperrt."
   "Hehehehehehe..."
 
  delay(10) ;
  Chef: 
   wuetend = true ;
   "IHR HABT WAS?"
   delay(10) ;
   "Hatte ich mich nicht klar und deutlich ausgedr]ckt?" 
   delay(10) ;
   wuetend = false ;
 
  TelJack:
   "Aber John meinte, Sie w]rden sich freuen."
  Chef:
   wuetend = true ;
   "Ruhe!"
   "Wof]r bezahle ich euch beide eigentlich?"
   wuetend = false ;
  TelJohn:
   "Entschuldigung Chef."
  Chef:  
   delay(10) ;
   "Ich rate euch beiden bloss daf]r zu sorgen, dass Hobler das Grab nie wieder verl#sst."
   "Habt ihr das verstanden?"
  TelJohn:
   "Jawohl Chef."
  Chef:
   "Das will ich f]r euch hoffen."
   killEvents(CHEF_GROUP) ;
   auflegen ;
   delay 60 ;  
   doEnter(GrabSonnenraum) ;
   return ;
  } 
  
 if (CurrentAct == 4) {
  delay(24) ; 
  anfang ;
  abheben ;
  start AnimateChef ;
  delay(10) ;
  Chef:
   "Was gibt es?"
  TelefonO:
   "Er ist im Security-Bereich."
  delay 10 ;
  Chef:
   wuetend = true ;
   "WAS?"
  delay 10 ;
   "Das kann doch nicht sein!"
  delay 5 ;
   "Wie hat er das geschafft?"   
  TelefonO:
   "Er hat sich maskiert und als einer unserer Wissenschaftler ausgegeben."
   "Wollen Sie die Bilder der {berwachungskamera?"
  delay 2 ;
  wuetend = false ;
  delay 5 ;
  Chef:
   "Lassen Sie gut sein."
   "Ich k]mmere mich um ihn."
  delay 2 ;
  killEvents(CHEF_GROUP) ;
  auflegen ;
  delay 10 ;  
  doEnter(nextScene) ;
  return ;
 } 
  
}

object TelefonO {
 positionX = 320 ;
 positionY = 80 ;
 captionY = 0 ;
 captionX = 50 ;
 captionWidth = 400 ;	
 captionColor = COLOR_CHEFPHONE ;
}

object txt {
 enabled = false ;
 visible = true ;
 Priority = 255 ;
 member MyAlpha = 0 ;
} 

event paint txt {
 drawingTextColor = RGBA(255, 255, 0, MyAlpha) ;
 drawingPriority = 255 ;
 drawingFont = Fonts::Akt1_font ;
 drawingJustify = 1 ;
 drawWrappedText(320,440-WrapText("Einige Versuche sp#ter...",300) / 2) ;
 static int up = true ;
 if (up) MyAlpha = min(MyAlpha + 1 + ((MyAlpha) / 20),255) ;
 if ((up) and (MyAlpha >= 255)) up = false ;
 if (!up) MyAlpha = max(MyAlpha - 1 - ((255-MyAlpha) / 20),0) ;
 if ((!up) and (MyAlpha <= 0)) txt.enabled = false ;
} 

object TelJack {
 positionX = 320 ;
 positionY = 80 ;
 captionY = 0 ;
 captionX = 50 ;
 captionWidth = 400 ;	
 captionColor = COLOR_JACKJOHNSON ;
}

object TelJohn {
 positionX = 320 ;
 positionY = 80 ;
 captionY = 0 ;
 captionX = 50 ;
 captionWidth = 400 ;	
 captionColor = COLOR_JOHNJACKSON ;
}

object Chef {  
  setAnim(chefanim_sprite) ;
  autoAnimate = false ;
  frame = 0 ;
  captionwidth = 400 ;
  captionX = GetSpriteFrameWidth(Chefanim_sprite,0) / 2 + 60 ;
  captionY = -40 ;
  member wuetend = false ;
  setPosition(76,120) ;
  absolute = true ;
  clickable = true ;
  enabled = true ;
  visible = true ;
  captionColor = COLOR_CHEF ;
}

script anfang {
 Chef:
  frame = 0 ;
  delay 33 ;
  frame = 1 ;
  delay 43 ;
  frame = 0 ;
  soundBoxStart(Music::Phone_wav) ;
  delay 33 ;
  frame = 1 ;
  delay 43 ;
  frame = 0 ;
}

script abheben {
 Chef:
  frame = 0 ;
  delay 10 ;
  frame = 2 ;
  delay 3 ;
  frame = 3 ;
  delay 3 ;
  soundBoxStart(Music::beep_wav) ;
  frame = 4 ;
  delay 10 ;
}

script auflegen {
 Chef:
  delay 10 ;
  frame = 4 ;
  delay 3 ;
  frame = 3 ;
  delay 3 ;
  frame = 2 ;
  delay 3 ;
  frame = 0 ;	
}

script zuhoeren {
 Chef:
  frame = random(2)+5 ;
}

script animateChef {
 activeObject = Chef ;
 eventGroup = CHEF_GROUP ;
 killOnExit = true ;
 loop {
  delay ;	 
  if (animMode == ANIM_STOP) and not (frame == 5 || frame == 6) {
   zuhoeren ;
  } else if (animMode == ANIM_TALK) {
   if (wuetend == false) {
    if not (frame == 5 || frame == 6 || frame == 7 || frame == 8) { frame = 5 ; }
    else if (frame == 5 || frame == 6) { frame = 7 + random(2) ; }
    else frame = random(4)+5 ;
    delay random(2)+1 ;
   } else {
    if not (frame == 9 || frame == 10 || frame == 11 || frame == 12) { frame = 10 ; }
    else frame = random(4)+9 ;
    delay random(2)+1 ;	   
   }
  }  
 }
}