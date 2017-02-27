// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var bluffPolice = false ;

event enter {
 backgroundImage = Finalevorhang_image ; 
 backgroundZBuffer = Finalevorhang_zbuffer ;
 
 Ego:
  
 
  reflection = true ; 
  reflectionOffsetY = 185 ; 
  reflectionOffsetX = 0 ;
  reflectionTopColor = RGBA(128,128,255,64) ; 
  reflectionBottomColor = RGBA(128,128,255,64) ; 
  reflectionAngle = 0.0 ; 
  reflectionStretch = 1.0 ;   
  
  lightmap = null ;
  
  forceHideInventory ;
  
  

  setPosition(0,294) ;
  face(DIR_EAST) ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 670 ;
  jukeBox_fadeOut(5) ;
  delay transitionTime ;
  walk(100,294) ;
  path = Finalevorhang_path ;
  pathAutoScale = true ;
  enableEgoTalk ;
  
 doFinale ;

}

/* ************************************************************* */

object Statist1 {
 setAnim(Statist1_sprite) ;
 captionColor = COLOR_PINK ;	 
 setPosition(640,231) ;
 scale = 550 ; 
 clickable = false ;
 autoAnimate = false ;
 name = "Statist" ;
}

var S1i = 0 ;

event animate Statist1 {
 S1i++ ;
 if ((S1i > 78+random(100)) and (random(4)==0)) {
   S1i = 0 ;
   Statist1.frame = random(2) ;
 }
}

/* ************************************************************* */

object Durchgang {
 setupAsStdEventObject(Durchgang,LookAt,100,294,DIR_WEST) ;			
 setClickArea(27,161,98,300) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Durchgang" ;
}

event WalkTo -> Durchgang {
 Ego:
  walkToStdEventObject(Durchgang) ;
 suspend ;
  path = 0 ;
  scale = 670 ;
  pathAutoScale = false ;
  walk(0,294) ;
 delay 10 ;
  pathAutoScale = true ;
 doEnter(Finalebuehne) ;
}

/* ************************************************************* */

object ErkenneDich {
 setClickArea(19,115,82,159) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Erkenne Dich" ;
}

/* ************************************************************* */

object Banner {
 setClickArea(0,0,103,113) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Banner" ;
}

/* ************************************************************* */

object Schild {
 setClickArea(393,160,465,199) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schild" ;
}

/* ************************************************************* */

object Kristall {
 setClickArea(1091,65,1139,126) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Kristall" ;
}

/* ************************************************************* */

object Buehne {
 setClickArea(916,152,1174,298) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "B]hne" ;
}

/* ************************************************************* */

const MOOD_NONE = 0 ;
const MOOD_ASTONISHED = 1 ;
const MOOD_SHOKED = 3 ;
const MOOD_AGGRESSIVE = 4 ;

object Brander { 
 setPosition(908,61) ;
 setClickArea(0,0,180,174) ;
 setAnim(Chef_sprite) ;
 autoAnimate = false ;
 Brander.captionWidth= 400 ;
 Brander.captionX = -(908-750)+ Brander.captionWidth/2 ;
 Brander.captionY = 45 ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 name = "Brander" ;
 member Mood = MOOD_NONE ;
}

var Bi = 0 ;
var BTi = 0 ;

event animate Brander {

  Bi++ ;
  BTi++ ;
  switch Brander.animMode {
   case ANIM_TALK: 
	if ((Bi >= 224+12*random(3)) and (random(3)==0)) {
	  Bi = 0 ;	  
	  Brander.frame = random(4) ;
        }
	if ((BTi >= 2) and (random(2)==0)) { 
	  BranderMund.frame = random(7) ;
	  BTi = 0 ;
	}

   default:
	if ((Brander.frame == 1) or (Brander.frame == 2)) Brander.frame = 3 ;
        
	if ((BranderMund.frame == 0) or (BranderMund.frame == 3) or (BranderMund.frame == 4) or (BranderMund.frame == 5)) {
	 switch random(3) {
	  case 0: BranderMund.frame = 1 ;
	  case 1: BranderMund.frame = 2 ;
	  case 2: BranderMund.frame = 6 ;
	 }
        }
	
	if ((Bi > 177+random(5)*71) and (random(4)==0)) {
	  if (Brander.frame==0) Brander.frame = 3 ;
	   else Brander.frame = 0 ;
	  Bi = 0 ;
	}
	
	switch Brander.Mood {
	  case MOOD_ASTONISHED: BranderMund.frame = 5 ;
	  case MOOD_SHOKED: BranderMund.frame = 3 ;
	  case MOOD_AGGRESSIVE: BranderMund.frame = 0 ;
	}
	
	if (BTi > 92+random(45)) and (random(4)==0) {
          switch random(3) {
	    case 0: BranderMund.frame = 1 ; 
	    case 1: BranderMund.frame = 2 ;
	    case 2: BranderMund.frame = 6 ;
	  }		  
	  BTi = 0 ;
	}
  }	
}

/* ************************************************************* */

object BranderMund {
 setPosition(908+88,61+62) ;
 setAnim(ChefMund_sprite) ;
 autoAnimate = false ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ; 
}

/* ************************************************************* */

event paint ChefClose {
 drawingPriority = 255 ;
 drawingColor = COLOR_WHITE ;
 drawImage(0,0,ChefClose.getAnim(ANIM_STOP,0)) ;
}

var CCi = 0 ;

event animate ChefClose {
 if (!ChefClose.enabled) {
  if ((ChefClose.getAnim(ANIM_STOP,0) == ChefClose1_image) or (ChefClose.getAnim(ANIM_STOP,0) == ChefClose2_image) or (ChefClose.getAnim(ANIM_STOP,0) == ChefClose3_image)) ChefClose.setAnim(null) ;
  return ;
 }
 CCi++ ;
 if (CCi > random(3)+2) {
   
   switch random(3) {
    case 0:  ChefClose.setAnim(ChefClose1_image) ;
    case 1:  ChefClose.setAnim(ChefClose2_image) ;
    default: ChefClose.setAnim(ChefClose3_image) ;	    
   }
   CCi = 0 ;
 }
}

object ChefClose {
 absolute = false ;
 setPosition(0,0) ;
 clickable = false ;
 setAnim(null) ;
 enabled = false ;
 visible = true ; 
 priority = 1 ; 
}

/* ************************************************************* */

script doFinale {
 var ta = 0 ;
 
 initFinale ;
  
 Ego:
  walk(870,260) ;
 delay 10 ;
 
  jukeBox_Stop ;
  jukeBox_Shuffle(false) ;	 
  jukeBox_Enqueue(Music::BG_Feralchase_mp3) ;
  jukeBox_Start ;
 
 delay 5 ;
 Brander: 
  say("Sie habe ich jetzt wirklich nicht erwartet, Herr Hobler.") ;
  delay 5 ;
 ta = dialog1 ;
 delay 4 ;
 dialog2(ta) ;
 Brander.say("Was wollen Sie?") ;
 dialog3 ;
 delay 3 ;
 Brander.say("Am]sant.") ;
 delay 4 ;
 Brander.say("Und was haben Sie mir vorzuwerfen?") ;
 
  jukeBox_fadeOut(10) ;
  jukeBox_Shuffle(false) ;	 
  jukeBox_Enqueue(Music::BG_LongNoteOne_mp3) ;
  jukeBox_Start ;


 chooseEvidence ;
 
 delay 4 ;
 Brander.Mood = MOOD_AGGRESSIVE ;
 delay 13 ;
 Brander.Mood = MOOD_NONE ;
 delay 5 ;
 Brander.say("Haben Sie nichts besseres vorzubringen?") ;
 
 Ego.say("Sie haben nicht nur die #gyptische Bev[lkerung einer gesundheitlichen Gefahr ausgesetzt um mit ihren Medikamenten Gewinn auszuschlagen...") ;
 Ego.say("...Sie planen auch Patrimonium in Waffen einzusetzen.") ;
 delay 5 ;
 Ego.say("Hat Ihre Profitgier irgendwann ein Ende?") ;
 delay 10 ;
 
  jukeBox_fadeOut(8) ;
  jukeBox_Shuffle(true) ;	 
  jukeBox_Enqueue(Music::BG_GraveBlow_mp3) ;
  jukeBox_Start ; 
 
 branderMonolog ;
 delay 5 ;
 Ego.say("Warum leiten Sie Ihren Konzern nicht derart, dass Sie stolz auf ihn sein k[nnen?") ;
 delay 3 ;
 Brander.say("Wie meinen Sie das?") ;
 
 improveDialog ;
 
 delay 5 ;
 Ego.say("Und das sind nur Punkte die mir eben einfielen.") ;
 
  jukeBox_fadeOut(10) ;
  jukeBox_Shuffle(true) ;	 
  jukeBox_Enqueue(Music::BG_Dangerous_mp3) ;
  jukeBox_Start ; 
 
 branderMonolog2 ;

  jukeBox_fadeOut(8) ;

 wonciekWalkIn ;
 
  jukeBox_Shuffle(true) ;	 
  jukeBox_Enqueue(Music::BG_Crisis_mp3) ;
  jukeBox_Start ; 
 
 delay 5 ;
 Brander.say("Professor Wonciek!") ;
 Brander.say("Sch[n, dass Sie unserer kleinen illustren Runde hier beiwohnen m[chten.") ;
 delay 2 ;
 enablePeterTalk ;
 Peter.say("Die Polizei sollte gleich eintreffen.") ;
 delay 2 ; 
 Peter.say("Ich hatte genug mitgeh[rt.") ;
 delay 3 ;
 if (bluffPolice) {
   Brander.say("Dann blufften Sie also nur, Herr Hobler.") ;
   Brander.say("Das gef#llt mir.") ;
   delay 10 ;
 }
 Brander.say("Also, Herr Hobler, was sagen Sie?") ;
 Brander.say("Steigen Sie bei mir ein, und Sie werden nie mehr auch nur einen Hauch eines finanzielles Problem haben.") ;
 Brander.say("Das verspreche ich Ihnen.") ;
 delay 10 ;
 
 Peter.say("Julian!") ;
 delay 2 ;
 Peter.say("Mit den Beweisen die Du gesammelt hast, bringen wir den Mann ins Gef#ngnis.") ;
 delay 3 ;
 Peter.say("Was meinst Du?") ;

 finaleChoice ;
 
}

/* ************************************************************* */

script initFinale {
 delay ;
 disableScrolling ;
 do {
   scrollX += 10 ;
   delay ;
 } until (scrollX >= 560) ;

 scrollX = 560 ;
 Brander.say("...wird aufgrund der Neutronendichte hei}er und die energetische Effizienz der Bombe steigert sich.") ;
 
 delay 2 ;
 
 start {Brander.say("Darin liegt nicht nur ein erheblicher Sicherheitsvorteil des Implosionsprinzips.") ; }
 
 do {
   scrollX -= 10 ;
   delay ;
 } until (scrollX <= 0) ;
 
 enableScrolling ;
}

script dialog1 {
 Ego:
  AddChoiceEchoEx(0, "Sie wissen, wer ich bin?", true) ;
  AddChoiceEchoEx(1, "Kommen wir zur Sache.", true) ;	
  var d = dialogEx ;
  
  switch d {	  
   case 0: delay 4 ;
	   ChefClose.enabled = true ;
	   Brander.say("Ich wei} wie Ihre Oma Sie genannt hat, als Sie f]nf waren.") ; 
	   Brander.say("Sie glauben doch nicht ernsthaft, dass ich nicht ]ber jeden ihrer Schritte in @gypten informiert bin.") ;
	   Brander.say("Bitte sagen Sie mir, dass Sie mich nicht ohne Grund unterbrochen haben.") ;
	   ChefClose.enabled = false ;
	   return 0 ;
   case 1: delay 3 ;
	   Brander.say("Ich mag Ihre Direktheit.") ;           
	   return 1 ;
  }
}

script dialog2(lc) {
 Ego:
  AddChoiceEchoEx(0, "(BLUFF) Genie}en Sie Ihre letzten Minuten in Freiheit, Herr Brander.", false) ;
  if (lc==0) AddChoiceEchoEx(1, "Dann wissen Sie wohl auch, warum ich hier bin.", true) ;	
   else AddChoiceEchoEx(1, "Wissen Sie, warum ich hier bin?", true) ;	
  var d = dialogEx ;
  
  switch d {
   case 0: start {delay 10 ; Brander.Mood = MOOD_ASTONISHED ; }
	   Ego.say("Genie}en Sie ihre letzten Minuten in Freiheit, Herr Brander.") ;
	   bluffPolice = true ;
	   delay 10 ;
	   Brander.Mood = MOOD_NONE ;
	   delay 10 ;
	   Brander.say("Ich muss sagen, Sie haben mich ein zweites mal ]berrascht.") ; 
	   delay 5 ;
	   Brander.say("Vielleicht habe ich Sie untersch#tzt.") ;
	   delay 10 ;
	   	   
   case 1: delay 4 ;	   
	   Brander.say("Einbruch...") ;
	   Brander.say("Diebstahl...") ;
	   Brander.say("Widerrechtlicher Zugriff auf ein Computersystem...") ;
	   Brander.say("Sachbesch#digung...") ;	   
	   Brander.say("Betrug...") ;
	   Brander.say("Missbr#uchliches Abfangen von Daten...") ;	   
	   Brander.say("Auskundschaftung von Betriebsgeheimnissen.") ;	   
	   Brander.say("Sie sind geliefert.") ;
	   Brander.say("Ich kann Sie auf der Stelle verhaften lassen, wenn Sie das m[chten.") ;	   
	   delay 5 ;
	   Brander.say("Aber deswegen sind Sie nicht hier.") ;
	   delay 4 ;
  }
}

script dialog3 {
 var BD3b = false ;
 var BD3c = false ;
 loop {
   Ego:
    addChoiceEchoEx(0, "Ich bringe Sie hinter Gitter.", true) ;
    addChoiceEchoEx(1, "Johnson und Jackson sind Vollidioten. Einer unf#higer als der andere.", true) unless (BD3b) ;
    addChoiceEchoEx(2, "Ich suche das Dart-Brett.", true) unless (BD3c) ;
   var d = dialogEx ;
 
   switch d {
     case 0: return ;
     case 1: delay 2 ;
	     Brander.say("Da sind wir einer Meinung.") ;
	     delay 2 ;
	     Brander.say("Es ist schwierig, heutzutage noch gutes Personal zu bekommen, das die Schmutzarbeit erledigt.") ;
	     delay 4 ;
	     dialog31 ;
	     Brander.say("Sie sind nicht den weiten weg gekommen, um mir das mitzuteilen.") ;
	     delay 1 ;
	     Brander.say("Wozu sind Sie hier?") ;
	     BD3b = true ;
     case 2: delay 4 ;
	     Brander.say("Immer einen schlechten Witz auf Lager, wie?") ;
	     delay 2 ;
	     Brander.Mood = MOOD_AGGRESSIVE ;
	     delay 10 ;
	     Brander.Mood = MOOD_NONE ;
	     Brander.say("Warum sind Sie gekommen?") ;
	     BD3c = true ;
   }
 }
}

script dialog31 {
 Ego:
  walk(Ego.positionX-100, Ego.positionY) ;
  delay 4 ;
  AddChoiceEchoEx(0, "(BLUFF) Wenigstens werden die zwei nicht mehr st[ren.", false) ;
  AddChoiceEchoEx(1, "(WARTE)", false) ;	
  var d = dialogEx ;
  
  switch d {	  
   case 0: start {delay 10 ; Brander.Mood = MOOD_ASTONISHED ; }
	   Ego.say("Wenigstens werden die zwei nicht mehr st[ren.") ;
	   delay 13 ;
	   Brander.Mood = MOOD_NONE ;
	   delay 5 ;
	   Brander.say("Ich h#tte Sie an ihrer Stelle einstellen sollen.") ;
   case 1: delay 13 ;
  }	
  
  walk(Ego.positionX+100, Ego.positionY) ;
  delay 5 ;
  
}

script chooseEvidence {
 var CEa = false ;
 var CEb = false ;
 loop {
  return if (CEa and CEb) ;
  Ego:
   addChoiceEchoEx(0, "Sie haben den Nil mit mutagenen Substanzen versehen und damit das Trinkwasser vergiftet um mehr Profit aus Ihrem Tochterunternehmen SamTec-Pharmaceuticals zu schlagen.", false) unless (CEa) ;
   addChoiceEchoEx(1, "Freiheitsberaubung und Entf]hrung.", true) unless (CEb) ;
   
  var d = dialogEx ;
  
  switch d {
   case 0: start {delay 11 ; Brander.Mood = MOOD_ASTONISHED ; }
	   Ego.say("Sie haben den Nil mit mutagenen Substanzen versehen und damit das Trinkwasser vergiftet...") ;	   
	   Ego.say("... um mehr Profit aus Ihrem Tochterunternehmen SamTec-Pharmaceuticals zu schlagen.") ;
	   delay 8 ;
	   Brander.Mood = MOOD_NONE ;
	   delay 5 ;
	   Brander.say("Und was bringt Sie zu dieser waghalsigen Annahme?") ;
	   chooseIntoxication ;
	   CEa = true ;
	   if (!CEb) { 
	     Brander.say("Haben Sie mir noch etwas vorzuwerfen?") ;
	     Ego.say("Ja.") ;
	     Brander.say("Und was?") ;
           }
   case 1: Brander.say("K[nnen Sie das konkretisieren?") ;
	   chooseImprisonment ;
	   CEb = true ;
	   if (!CEa) { 
	     Brander.say("Haben Sie mir noch etwas vorzuwerfen?") ;
	     Ego.say("Ja.") ;
	     Brander.say("Und was?") ;
           }
	   
  }
   
 }
}

script chooseIntoxication {
 var CIa = false ;
 var CIb = false ;
 var CIc = false ;
 
 loop {
	 
  return if (CIa and CIb and CIc) ;
	  
  Ego:
   AddChoiceEchoEx(0, "Diese Genoxit#tstests belegen die mutagene Wirkung der Chemikalien die Sie in einen Seitenarm des Nils haben aussch]tten lassen.", true) unless(CIa) ;
   AddChoiceEchoEx(1, "Einer Ihrer Mitarbeiter ist nach der oralen Einnahme mutiert.", true) unless (CIb) ;	
   AddChoiceEchoEx(2, "Hier habe ich einen Ausdruck vom SamTec-Zentralrechner der beweist, dass Sie konkrete Anweisungen dazu gegeben haben.", true) unless (CIc) ;
   var d = dialogEx ;
  
   switch d {	  
    case 0: delay 4 ; 
	    Brander.say("Diese Tests bringen Ihnen gar nichts.") ;
	    Brander.say("Die Chemikalien sind zwar nach internationalen Kriterien mutagen - in @gypten herrscht aber ein eigenes Gesetz.") ;
	    if (CIc) Brander.say("Ich hoffe, Sie haben noch etwas Stichhaltigeres zu bieten. Sie verschwenden meine Zeit.") ;
	      else Brander.say("Au}erdem werden Sie die Aussch]ttung der Chemikalien nicht mit mir in Verbindung bringen k[nnen.") ;
	    CIa = true ;
    case 1: delay 3 ;
	    Brander.say("Und jetzt wollen Sie mich f]r die D#mlichkeit meiner Mitarbeiter verantwortlich machen?") ;
	    delay 4 ;
	    Brander.say("Ich bitte Sie.") ;
	    CIb = true ;
    case 2: delay 5 ;
	    if (CIa) {
	      Brander.say("Wie ich schon sagte, gelten in @gypten eigene Gesetze was Genotoxit#t angeht.") ;
	      Brander.say("Die dort verwendeten Insektizide sind viel mutagener und immernoch legal.") ;
            } 
	    Brander.say("Diesen Ausdruck k[nnten Sie ebenso gef#lscht haben, um mir etwas anzulasten.") ;
	    CIc = true ;
	    
   }	
   
 }
}

script chooseImprisonment {
 var CPa = false ;
 var CPb = false ;
 
 loop {
	 
  return if (CPa and CPb) ;
	  
  Ego:
   AddChoiceEchoEx(0, "Sie haben einen Ihrer Mitarbeiter in den Sicherheitsbereich einsperren lassen weil er herausfand, dass Sie mit Voltan Firearms eine Kooperation anstreben.", true) unless(CPa) ;
   AddChoiceEchoEx(1, "Sie haben mich in Echnatons Grabmal und in Ihren Sicherheitsbereich einsperren lassen.", true) unless (CPb) ;	

   var d = dialogEx ;
  
   switch d {	  
    case 0: delay 4 ; 
	    Brander.say("Ich habe ihn weder eingesperrt, noch die Anweisung dazu gegeben.") ;
	    delay 3 ;
	    Brander.say("Die Sache hat sich ganz von allein erledigt.") ;
	    CPa = true ;
    case 1: delay 3 ;
	    if (CPa) Brander.say("Auch hier muss ich Sie entt#uschen.") ;
	     else Brander.say("Ich muss sie an dieser Stelle entt#uschen, Herr Hobler.") ;
	    delay 2 ;
	    Brander.say("Das habe ich niemals angeordnet.") ;
	    Brander.say("Ich m[chte mich aber hiermit bei Ihnen ausdr]cklich f]r meine Mitarbeiter entschuldigen.") ;
	    CPb = true ;
	    
   }	
   
 }	
}

script branderMonolog {
 ChefClose.enabled = true ;
 Brander.say("Herr Hobler, ich bin Gesch#ftsmann.") ;
 Brander.say("Ich habe mehr Geld auf dem Konto, als Sie in Ihrem ganzen Leben jemals verdienen werden.") ;
 Brander.say("Und Sie reden von meiner Profitgier?") ;
 ChefClose.enabled = false ;
 delay 13 ;
 Brander.say("Es ist die Profitgier der Pharmaindustrie, deren Ausma} jeden Heilungsauftrag ]bersteigt.") ;
 Brander.say("@rzte werden im Rahmen von Schein-Studien bezahlt - f]r die Verordnung bestimmter Medikamente.") ; 
 Ego.turn(DIR_WEST) ;
 delay 4 ;
 Peter.visible = true ;
 Peter.enabled = true ;
 Peter.filter = RGBA(255,255,255,255) ;
 Peter.priority = PRIORITY_AUTO ;
 Peter.positionX = 104 ;
 Peter.positionY = 294 ;
 Peter.pathAutoScale = false ;
 Peter.scale = 780 ;
 Peter.face(DIR_EAST) ;
 disableScrolling ;
 scrollX = 0 ;
 
 delay 7 ; 
 
 Peter.walk(0,294) ;
 Peter.visible = false ;
 Peter.enabled = false ;
 
 enableScrolling ;
 delay 3 ;
 Ego.turn(DIR_EAST) ;
 
 Brander.say("Entwicklungsl#nder verlangen eine Aufweichung des Patentschutzes f]r lebenswichtige Medikamente unter anderem gegen Aids oder Malaria.") ;
 Brander.say("Sie argumentieren, die [ffentliche Gesundheit w]rde ]ber kommerziellen Interessen stehen.") ;
 delay 3 ;
 Brander.say("In Europa verl#ngert man den Patentschutz f]r Arzneistoffe zugunsten der Industrie.") ;  
 delay 5 ;
 Brander.say("Es werden vergleichsweise harmlose Grippe-Arten zu Pandemien erkl#rt und die Impfungen bezahlen Krankenkassen oder gar der Staat.") ;
 Brander.say("Dadurch entstehen enge Verflechtungen der Pharmabranche mit ihrer wichtigsten Kontrollinstanz.") ;
 delay 7 ;
 Brander.say("Die Industrie kontrolliert das Gesundheitssystem.") ;
 delay 14 ;
 Brander.say("Ebenso ist es die Profitgier der R]stungsindustrie") ;
 delay 5 ;
 Brander.say("Wo es keinen Markt gibt, erschaft man sich einen.") ;
 Brander.say("Ein Land r]stet im Kampf gegen Terrorismus auf, andere ziehen nach.") ;
 Brander.say("Es entsteht eine Kettenreaktion die in einer aufw#rts weisenden R]stungsspirale endet.") ;
 delay 3 ;
 Brander.say("Die globale Konfrontationssituation versch#rft sich.") ;
 Brander.say("Milit#rausgaben auf der Welt sind seit Ende der neunziger Jahre um etwa 90 Prozent gestiegen.") ;
 delay 7 ;
 Brander.say("Selbst Weltwirtschaftskrisen k[nnen der R]stungsindustrie nichts anhaben.") ;
 Brander.say("Man diskutiert heutzutage bereits ]ber die Einf]hrung einer Kriegssteuer.") ;
  
 delay 5 ;
 ChefClose.enabled = true ;
 Brander.say("Ich bitte Sie, Herr Hobler.") ;
 delay 3 ;
 Brander.say("Ich kann mir die Zust#nde auf der Welt leider nicht aussuchen.") ;
 ChefClose.enabled = false ;
 delay 4 ;
 Brander.say("Aber ich kann mich den Zust#nden anpassen, oder ich bin als Gesch#ftsmann in diesen Branchen gestorben.") ;
 Brander.say("Dieses Prinzip gilt nicht nur in der Natur.") ;
 delay 4 ;
 Brander.say("Letztendlich gie}e ich lediglich Wasser in die M]hle.") ;
 delay 2 ;
 Brander.say("Und ich habe es akzeptiert, darauf nicht stolz sein zu k[nnen.") ;
}

script improveDialog {
 var IDa = false ;
 var IDb = false ;
 
 loop {
	 
  return if (IDa and IDb) ;
	  
  Ego:
   AddChoiceEchoEx(0, "Sie k[nnen Sich einsetzen f]r eine st#rkere Regulierung des Staates im Gesundheitswesen.", true) unless(IDa) ;
   AddChoiceEchoEx(1, "Verzichten Sie darauf, Patrimonium in Waffen zu verwenden und konzentrieren Sie sich auf andere Anwendungsbereiche.", true) unless(IDb) ;
   
   var d = dialogEx ;
  
   switch d {	  
    case 0: delay ;
	    Brander.say("Was stellen Sie sich darunter vor?") ;
	    improvePharma ;
	    if (!IDb) Brander.say("Was haben Sie noch vorzuschlagen?") ;
	    IDa = true ;
    case 1: delay 3 ;
	    Brander.say("Auf welche Anwedungsgebiete?") ;
	    delay ;
	    Ego.say("Saubere, nachhaltige Energieproduktion, Entwicklungshilfe, Transport oder Expansion?") ;
	    delay 10 ;
	    Brander.say("Ich muss gestehen, dass allein in diesen Zweigen unwahrscheinlich viel Geld zu holen ist.") ;
	    delay 5 ;
	    if (!IDa) Brander.say("Was haben Sie noch vorzuschlagen?") ;
	    IDb = true ;
	    
   }	
   
 }
}

script improvePharma {
 var IPa = false ;
 var IPb = false ;
 var IPc = false ;
 
 loop {
  return if (IPa and IPb and IPc) ;
  Ego:
   AddChoiceEchoEx(0, "W]rde eine geregelte Preisbindung f]r Medikamente der Pharma-Lobby nicht einen Strich durch die Rechnung machen?", true) unless(IPa) ;
   AddChoiceEchoEx(1, "Arzneimittelpreise sollten generell f]r besonders Bed]rftigte gesenkt werden.", true) unless(IPb)  ;	
   AddChoiceEchoEx(2, "Eine Subventionierung von Arzneimitteln kann derart strukturiert werden, dass den Unternehmen politische Einflussnahme verwehrt bleibt.", true) unless(IPc) ;	
   
   var d = dialogEx ;
   
   switch d {
    case 0: delay ;
	    Brander.say("Hmmmm....") ;
	    IPa = true ;
    case 1: delay ; 
	    Brander.say("Ich glaube ich wei}, worauf Sie hinauswollen.") ;
	    IPb = true ;
    case 2: delay ;
	    Brander.say("Das ist ein guter Punkt.") ;
	    IPc = true ;
   }
   
   if (not (IPa and IPb and IPc)) Brander.say("Was noch?") ;
 }
}

script wonciekWalkIn {
 Peter:
  positionX = 300 ;
  positionY = 280 ;
  enabled = true ;
  visible = true ;  
  pathAutoScale = false ;
  path = null ;
  scale = 900 ;
  walk(727,302) ;  
  turn(DIR_EAST) ;
}

script branderMonolog2 {
 Brander.say("Ich merke schon, Sie sind ein schlaues K[pfchen.") ;
 Brander.say("Sie haben eine naive, weltverbesserische Ader.") ;
 Brander.say("Aber Ihre Vorstellungen von Moral sind ]beraus unnat]rlich.") ;
 delay 7 ;
 Ego.say("Unnat]rlich? Was meinen Sie damit?") ;
 delay 5 ;
 Brander.say("Die Natur wertet nicht, Herr Hobler.") ;
 delay 10 ;
 Brander.say("Sie weist weder Lebewesen oder Dingen einen bestimmten Wert zu, noch unterscheidet sie zwischen gut und schlecht, fair und unfair.") ;
 Brander.say("Der Natur ist alles gleichg]ltig.") ;
 Brander.say("Am Ende ]berlebt der Bessere, das ist die einzige und einfachste Regel.") ;
 Brander.say("Meine Regel.") ;
 
 delay 3 ;
 Brander.Mood = MOOD_AGGRESSIVE ;
 delay 13 ;
 Brander.Mood = MOOD_NONE ;
 delay 2 ;
 Brander.say("Ihre Werte, Ihre Ansichten und Ihre Prinzipien, Herr Hobler, sind alle k]nstlich und unnat]rlich.") ;
 Brander.say("Sie existieren nur in Ihrem Kopf, nur in Ihren gedanklichen Geb#ude.") ;
 ChefClose.enabled = true ;
 Brander.say("Und Sie ma}en sich an, mit diesem k]nstlichen, anerzogenen Konstrukt, das sie Gewissen nennen, ]ber mich zu richten?") ;
 Brander.say("Wollen Sie sich ]ber die Natur stellen?") ;
 ChefClose.enabled = false ;
 delay 8 ;
 Ego:
  addChoiceEchoEx(1, "Ich...", false) ;
  addChoiceEchoEx(2, "@hm...", false) ;
 dialogEx ; 
 Brander.say("Trotzdem kann ich Sie irgendwie verstehen.") ;
 Brander.say("Vielleicht erinnern Sie mich an mich selbst, als ich so jung war wie Sie.") ;
 delay 5 ;
 Brander.say("Ich glaube, wir k[nnten viel voneinander lernen.") ;
 start { Brander.say("Ich k[nnte Sie mir gut neben mir als Berater vorstellen.") ; }
}

script finaleChoice {
 Ego.turn(DIR_WEST) ;
 loop {
   Ego:
    addChoiceEchoEx(0, "Brander hat Recht. Ich bin dabei.", true) ;
    addChoiceEchoEx(1, "Bringen wir ihn hinter Gitter.", true) ;
    
    var d = dialogEx ;
    
    switch d {
     case 0: delay 15 ;
	     Peter.say("Ist das dein letztes Wort, Julian?") ;
	     finaleChoiceB ;
     case 1: Brander.Mood = MOOD_AGGRESSIVE ;
	     delay 15 ;
	     Peter.say("Ich bin froh ]ber deine Entscheidung.") ;
	     finaleChoiceW ;
	     Brander.Mood = MOOD_NONE ;
    }
 }
 
}

script finaleChoiceB {
 Ego:
  addChoiceEchoEx(0, "Wir k[nnten beide zusammenarbeiten und gemeinsam Einfluss auf die Unternehmenspolitik nehmen. Machen wir das Beste daraus.", true) ;
  addChoiceEchoEx(1, "Nein, ich bin mir noch nicht sicher.", true) ;
  var d = dialogEx ;
  switch d {
    case 0: delay 10 ;
	    Ego.turn(DIR_EAST) ;
	    delay 5 ;	    
	    Brander.say("Eine weise Entscheidung, Herr Hobler.") ;
	    delay 5 ;
	    Brander.say("Machen wir das Beste daraus.") ;	    
	    endChoice = 0 ;
            jukeBox_fadeOut(10) ;
	    doEnter(Finaleende) ;
	    finish ;
    case 1: delay 5 ;
	    Brander.say("Warum nicht? Ich biete Ihnen den Griff nach den Sternen und sie z[gern?") ;
	    delay 10 ;	    
  }
}

script finaleChoiceW {
 Ego:
  addChoiceEchoEx(0,"Sorgen wir daf]r, dass Brander f]r seine Taten zur Rechenschaft gezogen wird.", true) ;
  addChoiceEchoEx(1,"Lass mich das nochmal ]berdenken...", true) ;
  var d = dialogEx ;
  switch d {
   case 0: delay 10 ;
	   Ego.turn(DIR_EAST) ;
	   delay 5 ;
	   Brander.say("Diese Entscheidung werden Sie Ihr ganzes Leben lang bereuen, Herr Hobler.") ;	  
	   endChoice = 1 ;
           jukeBox_fadeOut(10) ;
	   doEnter(Finaleende) ;
	   finish ;
   case 1: delay 5 ;
	   Brander.say("Kommen Sie zur Vernunft. Gemeinsam k[nnen wir Gro}es erreichen.") ;
	   delay 10 ;
  }
}

script finaleChoiceA {
}