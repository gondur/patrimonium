// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

static var visitedBuehne = false ;
static var madeBuehneComment = false ;

event enter {
 backgroundImage = Finalesaal_image ; 
 backgroundZBuffer = Finalesaal_zbuffer ;
 
 if (! mutatedPeter) mutatePeter ;

 forceShowInventory ;

 Peter:
  enabled = true ;
  visible = true ;
  filter = RGBA(170,170,170,255) ;
  enablePeterTalk ;
  captionWidth = 360 ;  
  scale = 500 ;
  setPosition(1211,222) ;
  path = 0 ;
  pathAutoScale = false ;
  face(DIR_SOUTH) ;
  face(DIR_WEST) ;
 // captionClick = false ;
  captionY = -100;
  priority = 2 ;
 
 Ego:
 
  reflection = true ; 
  reflectionOffsetY = 185 ; 
  reflectionOffsetX = 0 ;
  reflectionTopColor = RGBA(128,128,255,64) ; 
  reflectionBottomColor = RGBA(128,128,255,64) ; 
  reflectionAngle = 0.0 ; 
  reflectionStretch = 1.0 ; 
  
  lightmap = Lightmap_image ;
  lightmapAutoFilter = true ;    
 
 static var firstEnter = false ;
 
 if (!firstEnter) {
  firstEnter = true ;
  firstEnterCutscene ;
 } else if (previousScene==Finaleeingang) {
  scrollX = 0 ;
   pathAutoScale = false ;
   path = 0 ;
   scale = 850 ;
   setPosition(4,321) ;
   face(DIR_EAST) ;
  delay transitionTime ;
   walk(179,329) ;
   path = Finalesaal_path ;
   pathAutoScale = true ;
   
  start WonciekTalk ;     
   
 } else if (previousScene==Finaletoilette) {
 if (hasItem(Ego, Seife)) forceHideInventory ;
  scrollX = 2232-640 ;
   pathAutoScale = false ;
   path = 0 ;
   scale = 923 ;
   setPosition(2229,322) ;
   face(DIR_WEST) ;
  delay transitionTime ;
  soundBoxStart(Music::Tuerauf3_wav) ;
  TuerGra.enabled = true ;
  delay 2 ;
   
  // Hat Julian die Seife eingesteckt, will sie der Trinker zurück
   
  if (hasItem(Ego, Seife)) {
    walk(2067,344) ;
    delay 2 ;
    turn(DIR_EAST) ;
    TrinkerSeife.enabled = true ;
    delay 3 ;
    TrinkerSeife.autoAnimate = true ;
    TrinkerSeife.say("Geben Sie bitte die Seife wieder her!") ;
    TrinkerSeife.autoAnimate = false ;
    TrinkerSeife.frame = 0 ;
    delay 4 ;
    Ego.say("Na gut.") ;
    delay 1 ;
    EgoStartUse ;
    dropItem(Ego, Seife) ;
    drySoap(false) ;
    EgoStopUse ;
    soundBoxStart(Music::Tuerzu2_wav) ;  
    TuerGra.enabled = false ;
    TrinkerSeife.enabled = false ;
  } else {
    walk(2079,344) ;
    delay 2 ;
    turn(DIR_EAST) ;
    EgoStartUse ;
    delay 2 ;
    soundBoxStart(Music::Tuerzu2_wav) ;  
    TuerGra.enabled = false ;
    EgoStopUse ;
  }
   Ego:
   turn(DIR_WEST) ;
   path = Finalesaal_path ;
   pathAutoScale = true ;
  forceShowInventory ;
   
  start WonciekTalk ;     
   
 } else {
  scrollX = 1000-320 ;
   setPosition(983,236) ;
   face(DIR_EAST) ; 
   path = 0 ;
   pathAutoScale = false ;
   scale = 400 ;
  delay transitionTime ;   
   walk(1044,247) ;
   path = Finalesaal_path ;
   pathAutoScale = true ; 
  
  if (!hasItem(Ego, IDCard)) { 
	  
    if (!madeBuehneComment) {
      say("Wie unfreundlich!") ;
      delay 3 ;
      say("Ich frage mich, was da hinten hinter verschlossener T]r stattfindet.") ;
      say("Dazu ben[tige ich wohl eine Identifikationskarte.") ;    
      madeBuehneComment = true ;
    } else Ego.say("Ich ben[tige eine Identifikationskarte.") ;
    
  }
	  
  start WonciekTalk ;     
   
 }
  
 if (Trinker.enabled) start trinkerTrinkt ;
  
 clearAction ;
}

/* ************************************************************* */

script trinkerTrinkt {
 killOnExit = true ;
 loop {
   delay 180 ;
   delay random(80) ;   
   
   if ((talkToTrinker==false) and (random(2)==0)) or (trinkerIntoxicated) {
     Drink.enabled = false ;
     Trinker.doAnimate = false ;
     Trinker.frame = 1 ;
     delay 4+random(3) ;
     Trinker.frame = 6 ;
     delay 6+random(7) ;
     
     if (random(2)==0) Trinker.playSound(Music::Schluck1_wav) ;
       else Trinker.playSound(Music::Schluck2_wav) ;
     
     delay ;
     Trinker.frame = 1 ;
     if (random(2)==0) {
       delay 10+random(5) ;
       Trinker.frame = 6 ;
       delay 6+random(7) ;
       
       if (random(2)==0) Trinker.playSound(Music::Schluck1_wav) ;
         else Trinker.playSound(Music::Schluck2_wav) ;
		 
       delay ;
       Trinker.frame = 1 ;
     }
     delay 4+random(3) ;
     if (trinkerIntoxicated) {
       delay 8 ;
       Trinker.frame = 7 ;
       delay 20 ;
       Trinker.frame = 8 ;
       delay 6 ;
       Trinker.frame = 9 ;
       delay 6 ;
       Trinker.frame = 10 ;
       delay 6 ;
       Trinker.frame = 11 ;
       delay 23 ;
       Trinker:
        setAnim(TrinkerGeht_sprite) ;                
	frame = 1 ;
	doAnimate = true ;
       Saft.enabled = true ;
       Drink.enabled = false ;
       Karte.enabled = false ;
       Trinker.walk(1474,356) ;
       Trinker.walk(1800,356) ;
       Trinker.enabled = false ;
       trinkerAtToilet = true ;       
       Drink.setField(0, false) ;
       forceShowInventory ;
       clearAction ;
       return ;
     }
     Trinker.doAnimate = true ;
     Drink.enabled = true ;
   }
   delay 1 ;
 }
}

/* ************************************************************* */

script firstEnterCutscene {
  Leinwand.frame = 0 ;
  Ego:
  scrollX = 0 ;
   pathAutoScale = false ;
   path = 0 ;
   scale = 850 ;
   setPosition(4,321) ;
   face(DIR_EAST) ;
  forceHideInventory ;
  delay transitionTime ;
   walk(179,329) ;
   
   path = Finalesaal_path ;
   pathAutoScale = true ;

  
   walk(1130,287) ;
   setPosition(1130,287) ;
   turn(DIR_NORTH) ;
   
  delay 23 ;
  
  introText ;
  
  start WonciekTalk ;
  
  forceShowInventory ;
  
}

/* ************************************************************* */

event paint ProfClose {
 drawingPriority = 255 ;
 drawingColor = COLOR_WHITE ;
 drawImage(0,0,ProfClose.getAnim(ANIM_STOP,0)) ;
}

var PCi = 0 ;

event animate ProfClose {
 if (!profClose.enabled) {
  if ((profClose.getAnim(ANIM_STOP,0) == ProfClose1_image) or (profClose.getAnim(ANIM_STOP,0) == ProfClose2_image)) profClose.setAnim(null) ;
  return ;
 }
	
 PCi++ ;
 if (PCi > random(3)+2) {
   
   if (ProfClose.getAnim(ANIM_STOP,0) == ProfClose1_image) ProfClose.setAnim(ProfClose2_image) ;
    else ProfClose.setAnim(ProfClose1_image) ;
   PCi = 0 ;
 }
}

object ProfClose {
 absolute = false ;
 setPosition(0,0) ;
 clickable = false ;
 setAnim(null) ;
 enabled = false ;
 visible = true ; 
 priority = 1 ; 
}

script introText {
 Peter.say("Meine Damen und Herren, lassen Sie mich Sie herzlich willkommen hei}en.") ;
 delay 7 ;
 Peter.say("Ich m[chte Ihnen zu Beginn eine Frage stellen.") ;
 delay 3 ;
 Peter.say("Was ist Energie?") ;
 delay 14 ;

 profClose.enabled = true ;
 Peter.say("Energie der Schl]ssel zum Wohlstand.") ;
 delay 4 ;
 Peter.say("Eine gro}e Energieverf]gbarkeit resultiert in einem h[heren Lebensstandard.") ;
 delay 4 ;
 profClose.enabled = false ;
 delay 2 ;
 Peter.say("Energieverbrauch stand jedoch die l#ngste Zeit in krassem Widerspruch mit einer nachhaltigen Entwicklung.") ;
 delay 4 ;
 Peter.say("Aus diesem Grund werden weltweit Milliarden in die Erforschung regenerativer Energiequellen gesteckt.") ;
 delay 5 ;
 profClose.enabled = true ;
 Peter.say("Das hat ab jetzt ein Ende.") ;
 delay 10 ;
 Peter.say("Unser Team ist stolz, Ihnen die Ergebnisse unserer langwierigen und intensiven Untersuchungen an einem...") ;
 Peter.say("...k]rzlich entdeckten neuen Material - das wir 'Patrimonium' tauften - zu pr#sentieren.") ;
 profClose.enabled = false ;
 delay 10 ;
 Peter.say("Die Zukunft der Energieversorgung beginnt am heutigen Tag.") ;
 delay 12 ;
 
 Ego:
  walk(1160,353) ;
  turn(DIR_SOUTH) ;
  say("Ich sollte den Professor jetzt lieber nicht unterbrechen, um nicht unn[tig die Aufmerksamkeit auf mich zu lenken.") ;
  say("Diese zwei gro}en Affen sind bestimmt schon auf der Suche nach mir.") ;
 delay 2 ;  
  say("Die Empfangsdame sprach davon, dass hier irgendwo der SamTec-Vorstand eine kleine Privatparty feiert.") ;
  say("Ich sollte mich dazugesellen und ihn mit meinen Anschuldigungen konfrontieren.") ;
  say("Ich sehe mich besser mal um...") ;
 delay 3 ;
  turn(DIR_NORTH) ;
 delay 5 ;
 
}

/* ************************************************************* */

static var talkStage = 0 ;
static var convStage = 0 ;
static var phaseStage = 0 ;

script wonciekTalk {
  Peter.caption = 0 ;
  Peter.captionClick = false ;
  killOnExit = true ;
  loop {
    switch talkStage {
      case 0,1,2,3,4,5: 
	switch convStage {
	  case 0:  doTalk(talkStage) ; 
	  case 1:  answerQuestions(talkStage) ; 
	  default: doLeadOver(talkStage) ; 
	}
      default: say ("TEST") ;
    }
    if (talkStage > 5) finish ;
  }
}

script doTalk(stage) {
  Leinwand.frame = stage + 1 ;
  delay 10 ;
  if (talkStage == 0) 
   switch phaseStage {
    case 0:  phaseStage++ ; Peter.say("Fangen wir damit an, warum die Zukunft unserer Energieversorgung Patrimonium hei}en wird.") ; delay random(5) ;
    case 1:  phaseStage++ ; Peter.say("Schon bald nach der Entdeckung wurden uns die physikalisch verbl]ffenden Eigenschaften dieses Materials offensichtlich.") ; delay random(5) ;
    case 2:  phaseStage++ ; Peter.say("Es besteht aus einer Kombination bisher unbekannter Elemente.") ; delay random(5) ;
    case 3:  phaseStage++ ; Peter.say("Diese scheinen unendlich hohe Ionisationsenergien zu besitzen - jedenfalls ist es und bisher...") ; delay random(5) ;	    
    case 4:  phaseStage++ ; Peter.say("...noch nicht gelungen auch nur ein Elektron aus dem Material zu entfernen.") ; delay random(5) ;
    case 5:  phaseStage++ ; Peter.say("Durch Sonneneinstrahlung l#dt sich Patrimonium in einen energetisch immer h[heren Zustand auf.") ;
    case 6:  phaseStage++ ; Peter.say("Und diese Energie wird frei, wenn man das Material in direkten Kontakt...") ; delay random(5) ;
    case 7:  phaseStage++ ; Peter.say("...mit einfachem Dihydrogenmonooxid - oder Wasser f]r die Laien unter Ihnen - bringt.") ; delay random(5) ;
    case 8:  phaseStage++ ; Peter.say("Die innere Energie des H2Os steigt dabei, es erhitzt sich.") ; delay random(5) ;	    
    case 9:  phaseStage++ ; Peter.say("Und diesen Effekt nutzen wir zur Energiegewinnung.") ; delay 10 ;
    case 10: phaseStage++ ; Peter.say("Patrimonium ist in der Lage, mehr als den weltweiten Energiebedarf zu decken...") ; delay random(5) ;
    case 11: phaseStage++ ; Peter.say("...und erf]llt dabei alle wichtige Kriterien einer nachhaltigen Entwicklung. ") ; delay 10 ;	    
    case 12: phaseStage++ ; Peter.say("Ich sehe ein paar fragende Gesichtsausdr]cke!") ; delay random(5) ;    
    default: phaseStage = 0 ; convStage = 1 ;
   }
  else if (talkStage == 1)
   switch phaseStage {
     case 0: phaseStage++ ; Peter.say("Die Energiegewinnung mit dem Kristall ist effizienter als jede Solarzelle und jedes solarthermisches Kraftwerk.") ; delay random(5) ;
     case 1: phaseStage++ ; Peter.say("Etwa ein Kubikmillimeter des Kristalls reicht aus, um etwa...") ; delay random(5) ;
     case 2: phaseStage++ ; Peter.say("...eine Millionen Haushalte mit Energie zu versorgen - sofern das Wetter mitspielt.") ; delay random(5) ;
     case 3: phaseStage++ ; Peter.say("Unsere Forschungsabteilung ist momentan mit der Entwicklung eines Satelliten-Systems besch#ftigt....") ; delay random(5) ;	     
     case 4: phaseStage++ ; Peter.say("...das die Energiegewinnung zu jeder Tageszeit und bei jeder Wetterlage sichert.") ; delay 10 ;	     	     
     case 5: phaseStage++ ; Peter.say("Gibt es Fragen an dieser Stelle?") ; delay 10 ;	     	     	     
     default: phaseStage = 0 ; convStage = 1 ;
   }
  else if (talkStage == 2)
   switch phaseStage {
     case 0: phaseStage++ ; Peter.say("Patrimonium l#sst sich als Energiequelle in den verschiedensten Bereichen einsetzen...") ; delay random(5) ;
     case 1: phaseStage++ ; Peter.say("...und liefert kostenfreie Energie ohne C02-Aussto}.") ; delay random(5) ;
     case 2: phaseStage++ ; Peter.say("Dies sch]tzt unsere Umwelt und wirkt dem menschlich verschuldeten Klimawandel entgegen.") ; delay 5+random(5) ;
     case 3: phaseStage++ ; Peter.say("Regenerierbare lebende Ressourcen sollten nur in dem Ma} genutzt werden, wie Best#nde nat]rlich nachwachsen.") ; delay random(5) ;	     
     case 4: phaseStage++ ; Peter.say("Patrimonium ist keine lebendige Ressource und wird bei der Energiegewinnung nicht verbraucht.") ; delay random(5) ;	     	     	     
     case 5: phaseStage++ ; Peter.say("Auf andere Energiequellen k[nnen wir in Zukunft sogar komplett verzichten.") ; delay random(5) ;	     	     	     	     
     case 6: phaseStage++ ; Peter.say("Nach aktuellen Forschungsergebnissen sind selbst Biotreibstoffe nicht zwingend umweltfreundlicher...") ; delay random(5) ;
     case 7: phaseStage++ ; Peter.say("...als ihre fossile Vertreter.") ; delay random(5) ;
     case 8: phaseStage++ ; Peter.say("Und Erdgas bleibt aufgrund mangelnder Preisstabilit#t und Versorgungssicherheit weiterhin eine unsichere Energiequelle.") ; delay random(5) ;	     
     case 9: phaseStage++ ; Peter.say("Das macht Patrimonium aufgrund seiner Effizienz, perfekter Nachhaltigkeit und Sauberkeit zur ersten Wahl.") ; delay random(5) ;
     default: phaseStage = 0 ; convStage = 1 ;
   }
  else if (talkStage == 3)
   switch phaseStage {
     case 0: phaseStage++ ; Peter.say("Da Energieverf]gbarkeit einem h[heren Lebensstandard gleichzusetzen ist, kann...") ; delay random(5) ;
     case 1: phaseStage++ ; Peter.say("...Patrimonium eingesetzt werden, um die wirtschaftlichen, sozialen, [kologischen und...") ; delay random(5) ;
     case 2: phaseStage++ ; Peter.say("...letztendlich politischen Verh#ltnisse in Entwicklungsl#ndern nachhaltig zu verbessern.") ; delay random(5) ;
     case 3: phaseStage++ ; Peter.say("Als unmittelbare Folgen sind die Bek#mpfung von Armut sowie eine...") ; delay random(5) ;		     
     case 4: phaseStage++ ; Peter.say("...[kologisch tragf#hige Gestaltung der Globalisierung zu nennen.") ; delay random(5) ;	     
     case 5: phaseStage++ ; Peter.say("Dies sichert die Zukunft unseres gesamten Planeten.") ; delay random(5) ;	     	     
     default: phaseStage = 0 ; convStage = 1 ;
   }
  else if (talkStage == 4)
   switch phaseStage {
     case 0: phaseStage++ ; Peter.say("Sauberer, sicherer, schneller und sch[ner - so fahren die Autos der Zukunft, die Patrimonium als Energiequelle verwenden.") ; delay random(5) ;
     case 1: phaseStage++ ; Peter.say("Auch Nutzfahrzeuge, Schienenfahrzeuge oder Arbeitsmaschinen f]r Land- und Forstwirtschaft..."); delay random(5) ;
     case 2: phaseStage++ ; Peter.say("...werden auf unsere Technologie bauen.") ; delay random(5) ;	     
     case 3: phaseStage++ ; Peter.say("Patrimonium wird schon bald auf Stra}e, Schiene, Luft, Wasser und Rohrleitungen breite Verwendung finden.") ; delay random(5) ;	     	          
     default: phaseStage = 0 ; convStage = 1 ;
   }
  else if (talkStage == 5)
   switch phaseStage {
     case 0: phaseStage++ ; Peter.say("Aber nicht nur hier auf unserem Heimatplaneten wird Patrimonium das Leben aller revolutionieren.") ; delay random(5) ;
     case 1: phaseStage++ ; Peter.say("Selbstverst#ndlich k[nnen wir die Energiequelle auch zur Epansion ins All einsetzen.") ; delay random(5) ;
     case 2: phaseStage++ ; Peter.say("Wir k[nnen beliebig von Sonnensystem zu Sonnensystem reisen und dabei jedesmal den Energievorrat einfach wieder aufladen.") ; delay random(5) ;	     
     case 3: phaseStage++ ; Peter.say("Oder wir bauen komplette Raumstationen die ihre Energie ]ber Patrimonium beziehen und als neuer Lebensraum dienen.") ; delay random(5) ;	     	     
     case 4: phaseStage++ ; Peter.say("Unserer Phantasie sind hierbei keine Grenzen gesetzt.") ; delay random(5) ;	     	     	     
     default: phaseStage = 0 ; convStage = 1 ;
   }
  
  delay 10 ;
}

script answerQuestions(stage) {

  delay 5 + random(15) ;
  
  
  if (talkStage == 0) {
	  
   switch phaseStage {
    case 0:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Wie wechselwirkt Patrimonium mit Wasser?") ; 
	       delay 17 ;
	       Peter.say("Es beschleunigt die Wassermolek]le durch elektrodynamische Kr#fte.") ;
             }
	     
    case 1:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Wie wurde der Kristall technisch erzeugt?") ; 
	       delay 17 ;
	       Peter.say("Das wissen wir nicht. Wir haben den Kristall gefunden.") ;
             }
	     
    case 2:  phaseStage++ ;
	     Guest3.say("Kann es sein, dass der Kristall au}erirdischem Ursprungs ist?") ; 
	     delay 17 ;
	     Peter.say("Ausschlie}en kann ich das nicht") ;
	     Peter.say("Allerdings muss sich der Kristall schon seit Jahrtausenden auf der Erde befunden haben.") ;
	     
    case 3:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("K[nnten Sie nochmal etwas zur Zusammensetzung des Kristalls sagen?") ; 
	       delay 17 ;
	       Peter.say("Nicht viel.") ;
	       Peter.say("Wir haben es hier mit auf der Erde sonst noch nicht entdeckten Elementen zu tun.") ;
	       Peter.say("Nach unseren bisherigen Untersuchungen und nach unserem physikalischen Verst#ndnis...") ;
               Peter.say("...d]rften diese Elemente eigentlich gar nicht stabil sein.") ;
             }
	     
    case 4:  phaseStage++ ;
	     Guest4.say("Wie wird dann aus den beschleunigten Wassermolek]len Energie gewonnen?") ; 
	     delay 17 ;
	     Peter.say("Zum Beispiel mit einer Dampfdruck-Turbine.") ;
	     
    default: phaseStage = 0 ; 
	     convStage = 2 ; 
   }
   
  } else if (talkStage == 1) {
	  
   switch phaseStage {
    case 0:  phaseStage++ ;
	     Guest4.say("Wieviel von dem Kristall wurde gefunden?") ; 
	     delay 17 ;
	     Peter.say("Etwa einen Kubikmeter.") ;
	     
    case 1:  phaseStage++ ;
	     Guest3.say("Kann die gesamte Menschheit durch Patrimonium mit Energie versorgt werden?") ; 
	     delay 17 ;
	     Peter.say("Auf jeden Fall. Es blieben sogar noch viel Kapazit#ten ]brig.") ;
	     
    case 2:  phaseStage++ ;
	     Guest4.say("Wie soll das Satelliten-System hei}en?") ; 
	     delay 17 ;
	     Peter.say("Dar]ber haben wir uns noch keine Gedanken gemacht.") ;
	     
    case 3:  phaseStage++ ;
	     Guest4.say("Was ist, wenn die Sonne verschwindet?") ; 
	     delay 17 ;
	     Peter.say("Dann wird es dunkel.") ;
	     
    case 4:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Was ist der Unterschied zwischen einer Ente?") ; 
	       delay 27 ;
	       Peter.say("Was ist denn mit Ihnen los?") ;	     
             }
	     
    default: phaseStage = 0 ; 
	     convStage = 2 ; 
   }
   
  } else if (talkStage == 2) {
	  
   switch phaseStage {
    case 0:  phaseStage++ ;	     
	     delay until (talkToTrinker==false) ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Sollten wir dann auf landwirtschaftliche Treibstoffproduktion komplett verzichten?") ; 
	       delay 17 ;	     	     
	       Peter.say("Wir w#ren dazu in der Lage, aber ich pers[nlich finde die Idee toll, Milch und Energie vom Bauernhof zu bekommen.") ;
	       if (!trinkerAtToilet) {
  	         delay until (Trinker.doAnimate and Drink.enabled) ;
	         talkToTrinker = true ;
	         Trinker.say("BUUUU@@@@@HHH! MILCH!") ;
	         Trinker.say("Ich hasse Milch!") ;
	         talkToTrinker = false ;
	         if ((Ego.positionX > 1070) and (Ego.positionY < 1710) and (!knowsMilk)) start makeMilkComment ;
	       }
             }
	     
    case 1:  phaseStage++ ;
	     delay 5 ;
	     delay until(!suspended) ;
	     Guest4.say("Und der Kristall verbraucht sich wirklich nicht mit der Zeit?") ; 
	     delay 17 ;
	     Peter.say("Kein St]ck.") ;
	     
    case 2:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Wenn Patrimonium die Energieversorgung der kompletten Menschheit ]bernehmen kann...") ; 
	       Guest1.say("...was ist dann mit unseren alten Energiequellen? Wird das nicht zu wirtschaftlichen Problemen f]hren?") ; 
	       delay 17 ;
	       Peter.say("Das garantiert. Wir werden dadurch viele Feinde gewinnen.") ;
             }
	     
    case 3:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Perfekte Nachhaltigkeit klingt ja viel zu gut, um wahr zu sein. Wo liegt der Haken?") ; 
	       delay 17 ;
	       Peter.say("Wir haben bisher noch keinen gefunden.") ;
             }
	     
    case 4:  phaseStage++ ;
	     Guest3.say("Kennen Sie einen guten Witz?") ; 
	     delay 17 ;
	     Peter.say("Da f#llt mir momentan keiner ein.") ;
	     
    default: phaseStage = 0 ; 
	     convStage = 2 ; 
   }
   
  } else if (talkStage == 3) {
	  
   switch phaseStage {
    case 0:  phaseStage++ ;
	     Guest3.say("Wer entscheidet, welches Entwicklungsland wieviel von dem Kristall zu welchem Preis erh#lt?") ; 
	     delay 17 ;
	     Peter.say("Das obliegt der Entscheidungsmacht der Firma SamTec. Wie genau das geregelt wird, wei} ich nicht.") ;
	     
    case 1:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Wird Patrimonium auch in einem Land funktionieren, in dem die Sonne nicht scheint?") ; 
	       delay 17 ;
	       Peter.say("Nicht so effizient zumindest. Aber gibt es ein Land auf unserer Erde, auf das die Sonne nicht scheint?") ;
             }
	     
    case 2:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("K[nnte man vielleicht Maulw]rfen diese Technologie ]berlassen, um besser sehen zu k[nnen?") ; 
	       delay 17 ;
	       Peter.say("Vorstellen kann ich mir das nicht.") ;
             }
	     
    case 3:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Wird durch die Verwendung des Kristalls endlich die globale Erw#rmung zur]ckgehen?") ; 
	       delay 17 ;
	       Peter.say("Wahrscheinlich nicht.") ;
             }
	     
    case 4:  phaseStage++ ;
	     Guest3.say("Und die Umweltverschmutzung?") ; 
	     delay 17 ;
	     Peter.say("Das auf jeden Fall.") ;
	     
    default: phaseStage = 0 ; 
	     convStage = 2 ; 
   }
   
  } else if (talkStage == 4) {
	  
   switch phaseStage {
    case 0:  phaseStage++ ;
	     Guest4.say("Werden wir dann ]berhaupt noch Stra}en brauchen?") ; 
	     delay 17 ;
	     Peter.say("Ja, damit sich die Fahrzeuge effizient fortbewegen k[nnen.") ;
	     
    case 1:  phaseStage++ ;
	     Guest3.say("Werden neue soziale Fragen aufkommen?") ; 
	     delay 17 ;
	     Peter.say("Dar]ber kann ich leider noch keine Auskunft geben.") ;
	     
    case 2:  phaseStage++ ;
	     Guest4.say("Wieviel kostet denn ein Pferd?") ; 
	     delay 17 ;
	     Peter.say("Ich w]rde mal mit ca. 5000 Euro rechnen.") ;
	     
    case 3:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Wielange dauert es, bis man einen Reiterpass machen kann?") ; 
	       delay 17 ;
	       Peter.say("Das sollten Sie mal besser Ihren Reitlehrer fragen.") ;
             }
	     
    case 4:  phaseStage++ ;
	     Guest4.say("Wird Patrimonium die Anzahl der Ufo-Sichtungen verringern k[nnen?") ; 
	     delay 17 ;
	     Peter.say("Ja. Definitiv.") ;
	     
    default: phaseStage = 0 ; 
	     convStage = 2 ; 
   }
   
  } else if (talkStage == 5) {
	  
   switch phaseStage {
    case 0:  phaseStage++ ;
	     Guest3.say("Werden wir endlich einen Warp-Antrieb realisieren k[nnen?") ; 
	     delay 17 ;
	     Peter.say("Nein, Warp-Antriebe bleiben vorerst noch fiktiv.") ;
	     
    case 1:  phaseStage++ ;
	     Guest3.say("Was ist, wenn auf unseren Erkundungen des Universums Au}erirdische Gefallen an dieser Technologie finden?") ; 
	     delay 17 ;
	     Peter.say("Das ist nat]rlich eine gute Frage. N#chste Frage.") ;
	     
    case 2:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Sind Reisen ]ber astrononmisch gro}e Entfernungen m[glich?") ; 
	       delay 17 ;
	       Peter.say("Prinzipiell ja. Aber nicht in einer nach menschnlichen Ma}st#ben kurzen Zeit.") ;
             }
	     
    case 3:  phaseStage++ ;
	     Guest4.say("Warum kontrahieren wir nicht einfach die Raumzeit vor unseren Raumschiffen und expandieren sie dahinter, zum Beispiel mit exotischer Materie?") ; 
	     delay 17 ;
	     Peter.say("Soweit ich wei}, wurde exotische Materie mit negativer Energiedichte noch nicht beobachtet.") ;
	     
    case 4:  phaseStage++ ;
	     if (!Guest1.talkToEgo) {
	       Guest1.say("Ist das ein drittes Ohr auf Ihrer Stirn, Herr Wonciek?") ; 
	       delay 17 ;
	       Peter.say("In der Tat. Mein H[rverm[gen hat sich dadurch extrem verbessert.") ;
             }
	     
    default: phaseStage = 0 ; 
	     convStage = 2 ; 
   }
   
  } else talkStage = 0 ;     

  delay 10 ;
}

script doLeadOver(stage) {
  talkStage++ ; 
  convStage = 0 ;	
  delay 10 ;

  if (stage < 4) {
    switch random(4) {
      case 0:  Peter.say("Sofern alle Fragen beantworten wurden, machen wir mit dem n#chsten Thema weiter...") ;
      case 1:  Peter.say("Wenn es keine weiteren Fragen mehr gibt, m[chte ich nun fortfahren...") ;
      case 2:  Peter.say("Da nun alle Fragen zu diesem Thema gekl#rt sind, schreiten wir zum n#chsten Thema voran...") ;
      default: Peter.say("Damit w#ren wir beim n#chsten Thema angelangt...") ;
    }
  } else if (stage == 4) Peter.say("Damit sind wir auch schon beim letzten Thema...") ;
  else { Peter.say("Wenn es jetzt bei einigen noch ein paar Unklarheiten gibt...") ; talkStage = 0 ; }
  
  delay 10 ;
}

static var knowsMilk = false ;
static var knowsLactose = false ;

script makeMilkComment {
  delay until(!suspended) ;
  forceHideInventory ;
  suspend ;
  Ego.caption = null ;
  Ego.stop ;
  Ego.turn(Ego.findDirection(Trinker.positionX, Trinker.positionY)) ;
  Ego.say("Da mag wohl jemand keine Milch.") ;
  knowsMilk = true ;
  forceShowInventory ;
  clearAction ;
}

/* ************************************************************* */

const DRINK_NONE = 0 ;
const DRINK_COFFEE = 1 ;
const DRINK_APPLE = 2 ;
const DRINK_ORANGE = 3 ;
const DRINK_BEER = 4 ;
const DRINK_GROG = 5 ;

script switchButler(ndrink) {
  Butler:
  if (ndrink == DRINK_NONE) {
	 setWalkAnim2H(ButlerWalkRt_sprite, ButlerWalkLt_sprite) ;
	 setStopAnim2H(ButlerStatRt_sprite, ButlerStatLt_sprite) ;
	 setTurnAnim2H(ButlerStatRt_sprite, ButlerStatLt_sprite) ;
	 setTalkAnim2H(ButlerTalkRt_sprite, ButlerStatLt_sprite) ;
  } else if (ndrink == DRINK_COFFEE) {
	 setWalkAnim2H(ButlerWalkRta_sprite, ButlerWalkLta_sprite) ;
	 setStopAnim2H(ButlerStatRta_sprite, ButlerStatLta_sprite) ;
	 setTurnAnim2H(ButlerStatRta_sprite, ButlerStatLta_sprite) ;
	 setTalkAnim2H(ButlerTalkRta_sprite, ButlerStatLta_sprite) ;
  } else {
	 setWalkAnim2H(ButlerWalkRtb_sprite, ButlerWalkLtb_sprite) ;
	 setStopAnim2H(ButlerStatRtb_sprite, ButlerStatLtb_sprite) ;
	 setTurnAnim2H(ButlerStatRtb_sprite, ButlerStatLtb_sprite) ;
	 setTalkAnim2H(ButlerTalkRtb_sprite, ButlerStatLtb_sprite) ;
  }
}

object Butler {
 setupAsActor ;
 setupAsStdEventObject(Butler,TalkTo,960,342,DIR_WEST) ;
 pathAutoScale = true ;
 path = FinalesaalButler_path ;
 setWalkAnim2H(ButlerWalkRt_sprite, ButlerWalkLt_sprite) ;
 setStopAnim2H(ButlerStatRt_sprite, ButlerStatLt_sprite) ;
 setTurnAnim2H(ButlerStatRt_sprite, ButlerStatLt_sprite) ;
 setTalkAnim2H(ButlerTalkRt_sprite, ButlerStatLt_sprite) ;
 lightmap = Lightmap_image ;
 lightmapAutoFilter = true ;    
 walkAnimDelay = 2 ;
 talkAnimDelay = 3 ;
 setPosition(880,322) ;
 captionWidth = 350 ;
 setClickArea(-30,-180,30,5) ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 captionFont = defaultFont ;
 captionY = -160 ;
 captionX = 0 ; 
 name = "Butler" ;
 turn(DIR_EAST) ;
}

event TalkTo -> Butler {
  static var askedDart = false ;
  Ego:
   walkToStdEventObject(Butler) ;
  suspend ;
  delay 3 ;
  
  Butler:
   "Sie w]nschen?"
  addChoiceEchoEx(6, "Ich suche das Dart-Brett.", true) if (!askedDart) ;
  if (!hasItem(Ego, Drinkbier))   addChoiceEchoEx(DRINK_BEER, "Ein Bier.", true) ;
  if (!hasItem(Ego, Drinkapfel))  addChoiceEchoEx(DRINK_APPLE, "Apfelsaftschorle.", true) ;
  if (!hasItem(Ego, Drinkgrog))   addChoiceEchoEx(DRINK_GROG, "Grog.", true) ;
  if (!hasItem(Ego, Drinkorange)) addChoiceEchoEx(DRINK_ORANGE, "Einen Orangensaft.", true) ;
  if (!hasItem(Ego, Drinkkaffee)) addChoiceEchoEx(DRINK_COFFEE, "Einen Kaffee.", true) ;  
  addChoiceEchoEx(DRINK_NONE, "Gerade nichts, danke.", true) ;
   
  var dChoice = dialogEx ;
  
  if (dChoice == 6) {
    Butler.say("Wir haben hier kein Dart-Brett, Sir.") ;
    askedDart = true ;
    clearAction ;
    return ;
  }
  
  Butler:
  if (flipCounter) say("Sehr wohl, Sir.") ;
    else say("Wie es dem Herrn beliebt.") ;
  if (dChoice != DRINK_NONE) {
    forceHideInventory ;
    start {
	    delay 5 ;
	    Ego.turn(DIR_EAST) ;
    }
    Butler:
    delay 1 ;
    walk(1270,280) ;
    delay 10 ;
    switchButler(dChoice) ;
    delay 3 ;
    start {
	    delay 35 ;
	    Ego.turn(DIR_WEST) ;
    }
    Butler:
    walk(880,322) ;
    turn(DIR_EAST) ;
    say("Bitte sch[n, Sir.") ;
    forceShowInventory ;
    delay ;
    EgoStartUse ;
    switchButler(DRINK_NONE) ;
    switch (dChoice) {
      case DRINK_APPLE: takeItem(Ego, Drinkapfel) ;
      case DRINK_COFFEE: takeItem(Ego, Drinkkaffee) ; takeItem(Ego, Kondensmilch) ; 
      case DRINK_GROG: takeItem(Ego, Drinkgrog) ;
      case DRINK_ORANGE: takeItem(Ego, Drinkorange) ;
      case DRINK_BEER: takeItem(Ego, DrinkBier) ;
    }
    
    EgoStopUse ;
    Ego.say("Danke.") ;
  }
  clearAction ;
}

script butlerTakeBack {
    forceHideInventory ;
    start {
	    delay 5 ;
	    Ego.turn(DIR_EAST) ;
    }
    Butler:
    delay 1 ;
    walk(1270,280) ;
    delay 10 ;
    switchButler(DRINK_NONE) ;
    delay 3 ;
    start {
	    delay 35 ;
	    Ego.turn(DIR_WEST) ;
    }
    Butler:
    walk(880,322) ;
    turn(DIR_EAST) ;    
    forceShowInventory ;
}

event DrinkApfel -> Butler {
 Ego:
  walkToStdEventObject(Butler) ;
 suspend ;
  "K[nnten Sie das abr#umen?"
 Butler.say("Aber selbtvert#ndlich.") ;
 EgoStartUse ;
 dropItem(Ego, DrinkApfel) ;
 switchButler(DRINK_APPLE) ;
 EgoStopUse ;
 butlerTakeBack ;
 clearAction ;
}

event DrinkOrange -> Butler {
 Ego:
  walkToStdEventObject(Butler) ;
 suspend ;
  "K[nnten Sie das abr#umen?"
 Butler.say("Aber selbtvert#ndlich.") ;
 EgoStartUse ;
 dropItem(Ego, DrinkOrange) ;
 switchButler(DRINK_ORANGE) ;
 EgoStopUse ;
 butlerTakeBack ;
 clearAction ;
}

event DrinkBier -> Butler {
 Ego:
  walkToStdEventObject(Butler) ;
 suspend ;
  "K[nnten Sie das abr#umen?"
 Butler.say("Aber selbtvert#ndlich.") ;
 EgoStartUse ;
 dropItem(Ego, DrinkBier) ;
 switchButler(DRINK_BEER) ;
 EgoStopUse ;
 butlerTakeBack ;
 clearAction ;
}

event DrinkGrog -> Butler {
 Ego:
  walkToStdEventObject(Butler) ;
 suspend ;
  "K[nnten Sie das abr#umen?"
 Butler.say("Aber selbtvert#ndlich.") ;
 EgoStartUse ;
 dropItem(Ego, DrinkGrog) ;
 switchButler(DRINK_GROG) ;
 EgoStopUse ;
 butlerTakeBack ;
 clearAction ;
}


event DrinkKaffee -> Butler {
 Ego:
  walkToStdEventObject(Butler) ;
 suspend ;
  "K[nnten Sie das abr#umen?"
 Butler.say("Aber selbtvert#ndlich.") ;
 EgoStartUse ;
 dropItem(Ego, DrinkKaffee) ;
 switchButler(DRINK_COFFEE) ;
 EgoStopUse ;
 butlerTakeBack ;
 clearAction ;
}

event LookAt -> Butler {
 Ego:
  walkToStdEventObject(Butler) ;
  say("Dieser betagte Herr sieht so aus, als ob er f]r die Getr#nke zust#ndig ist.") ;
}

event Push -> Butler {
 Ego:
  walkToStdEventObject(Butler) ;
  say("Das w]rde ihm nicht gefallen.") ;
}

event Pull -> Butler {
 triggerObjectOnObjectEvent(Push, Butler) ;
}

/* ************************************************************* */

object Guest { 
 pathAutoScale = false ;
 path = 0 ;
 setAnim(Actors::ProfStatUp_sprite) ;
 captionClick = false ;
 captionWidth = 350 ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 captionFont = defaultFont ;
 captionY = -120 ;
 captionX = 0 ; 
 name = "Gast" ;
}

/* ************************************************************* */

object Guest1 { 
 class = Guest ;
 setupAsStdEventObject(Guest1,TalkTo,1158,330,DIR_WEST) ;						
 setAnim(Gast3_sprite) ;
 captionColor = RGB(100,255,100) ;
 setPosition(1085,327) ;
 filter = RGBA(230,230,230,255) ;
 scale = 799 ;
 setClickArea(-38,-158,30,3) ;
 name = "Mann mit Brille" ;
 autoAnimate = false ;
 captionY = -170 ;
 member talkToEgo = false ;
}

var G1i = 0 ;
var G1j = 0 ;

event animate Guest1 {
  G1i++ ;
  G1j++ ;
  switch Guest1.animMode {
   case ANIM_TALK: ;
     if (talkToEgo) {
       if (Guest1.frame < 6) Guest1.frame = random(2)*4+6 ;
       if ((G1i >= 122+random(8)) and (random(3)==0)) {
         G1i = 0 ;
         if ((Guest1.frame < 10) and (random(2)==0)) Guest1.frame = Guest1.frame + 4 ;
	   else Guest1.frame = Guest1.frame - 4 ;
       }
       if ((G1j >= 3) and (random(5)==0)) {
         G1j = 0 ;
         if (Guest1.frame < 10) Guest1.frame = 6 + random(4) ;
           else Guest1.frame = 10 + random(4) ;
       }
     } else {
       if (Guest1.frame < 3) Guest1.frame = 1 ;
         else Guest1.frame = 4 ;	     
     }
   default:
     if (Guest1.frame > 5) Guest1.frame = 1 ;
     if ((G1i >= 122+random(8)) and (random(3)==0)) {
       G1i = 0 ;
       if ((Guest1.frame < 3) and (random(2)==0)) Guest1.frame = Guest1.frame + 3 ;
	 else Guest1.frame = Guest1.frame - 3 ;
     }
     if ((G1j >= 46+random(5)) and (random(5)==0)) {
       G1j = 0 ;
       if (Guest1.frame==1) or (Guest1.frame ==4) {
         Guest1.frame = Guest1.frame + random(3) - 1 ;
       } else {
         if ((Guest1.frame==0) or (Guest1.frame==2)) Guest1.frame = 1 ;
         if ((Guest1.frame==3) or (Guest1.frame==5)) Guest1.frame = 4 ;
       }
     }
     if (Guest1.talkToEgo) {
       if (Guest1.frame < 3) Guest1.frame = 0 ;
         else Guest1.frame = 3 ;
     } else if (Guest3.animMode == ANIM_TALK) {
       if (Guest1.frame < 3) Guest1.frame = 2 ;
         else Guest1.frame = 5 ;
     }
  }
}

static var talkG1First = true ;

event talkTo -> Guest1 {
 Ego:
  walkToStdEventObject(Guest1) ;
 suspend ;
 Guest1.talkToEgo = true ;
 Guest1.captionClick = true ;
 Peter.captionColor = RGBA(221,068,221,125) ; 
 if (talkG1First) {
   G1Dfirst ;
   talkG1First = false ;
 } else
 switch random(3) {
   case 0 : Ego.say("Hi.") ;
   case 1 : Ego.say("Hallo nochmals.") ;
   case 2 : Ego.say("Ich bin wieder hier.") ;
 }
 G1D ;  
 Peter.captionColor = RGBA(221,068,221,255) ;
 Guest1.talkToEgo = false ;
 Guest1.captionClick = false ;
 clearAction ;
}

event invDrinks -> Guest1 {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Guest1) ;
 suspend ;
 if (used) {
   say("Ih m[chte das Getr#nk jetzt nicht ]ber ihn leeren.") ;
   
 } else {
   say("M[chten Sie ein Getr#nk?") ;
   Guest1.say("Vielen Dank, ich habe eben schon etwas getrunken.") ;
 }
 clearAction ;
}

event Pull -> Guest1 {
 Ego:
  walkToStdEventObject(Guest1) ;
  say("Das w]rde ihm nicht gefallen.") ;
  say("Au}erdem gibt es daf]r gar keinen Grund.") ;
}

event Push -> Guest1 {
 triggerObjectOnObjectEvent(Pull, Guest1) ;
}

event lookAt -> Guest1 {
 Ego:
  walkToStdEventObject(Guest1) ;
 suspend ;
  say("Er sieht wie der Prototyp eines durchgeknallten Wissenschaftlers mit einer Sehschw#che aus.") ;
 clearAction ;
}

event Use -> Guest1 {
 triggerObjectOnObjectEvent(Take, Guest1) ;
}

event Take -> Guest1 {
 Ego:
  walkToStdEventObject(Guest1) ;
 suspend ;
  say("Gar nicht mein Typ.") ;
 clearAction ;
}

/* ************************************************************* */

object Guest3 {
 class = Guest ;
 setAnim(Gast2_sprite) ;
 captionColor = COLOR_PINK ;	 
 setPosition(970,295) ;
 scale = 720 ;
 filter = RGBA(200,200,200,255) ;
 clickable = false ;
 autoAnimate = false ;
 name = "Dummer Typ" ;
}

var G3i = 0 ;

event animate Guest3 {
 G3i++ ;
 if ((G3i > 56) and (random(4)==0)) {
   G3i = 0 ;
   Guest3.frame = random(3) ;
 }
}

/* ************************************************************* */

object Guest5 {
 class = Guest ;
 setAnim(Gast4_sprite) ;
 captionColor = COLOR_PINK ;	 
 setPosition(1242,266) ;
 scale = 600 ;
 filter = RGBA(180,180,180,255) ;
 clickable = false ;
 autoAnimate = false ;
 name = "Mann mit Schirm" ;
}

var G5i = 0 ;

event animate Guest5 {
 G5i++ ;
 if ((G5i > 66) and (random(4)==0)) {
   G5i = 0 ;
   Guest5.frame = random(2) ;
 }
}

/* ************************************************************* */

object Guest4 {
 class = Guest ;
 setAnim(Gast1_sprite) ;	 
 captionColor = COLOR_ORANGE ;	 
 
 setPosition(1181,273) ;
 filter = RGBA(180,180,180,255) ;
 scale = 559 ;
 clickable = false ;
 autoAnimate = false ;
 name = "Mario" ;
}

var G4i = 0 ;

event animate Guest4{
  G4i++ ;
  
  if ((G4i>97+random(32)) and (random(8)==0)) {
   G4i = 0 ;
   if (Guest4.frame < 2) Guest4.frame = 2 ;
    else Guest4.frame = 1 ;
  }
  
  if ((Guest.frame==0) and (random(3)==0)) Guest.frame = 1 ;
  if ((Guest.frame==3) and (random(3)==0)) Guest.frame = 2 ;	  
  
  if ((G4i>32) and (random(18)==0)) {
   if (Guest4.frame==1) Guest4.frame = random(2) ;
   if (Guest4.frame==2) Guest4.frame = random(2)+2 ;
  }
}

/* ************************************************************* */

static var spottedIDCard = false ;

object Karte {
 setupAsStdEventObject(Karte,Take,1285,350,DIR_EAST) ;					
 setClickArea(1337,247,1337+19,247+22) ;
 absolute = false ;
 clickable = true ;
 enabled = (!trinkerAtToilet) ;
 visible = false ;
 priority = 200 ;
 name = "Karte" ;
}

event LookAt -> Karte {
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 say("Sieht mir nach einer Art Sicherheitskarte zur Personenidentifizierung aus.") ;
 if (knowsIDCard) { 
   Ego.say("Vermutlich so eine wie man sie dahinten links von der B]hne ben[tigt.") ;   
   spottedIDCard = true ;
   Ego.say("Vielleicht komme ich mir so einer Karte in den hinteren Bereich.") ;
 }
 clearAction ;
}

event Pull -> Karte {
 triggerObjectOnObjectEvent(Take, Karte) ;
}

event Haarklammer -> Karte {
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 say("Mit der Klammer k[nnte ich die Karte greifen...") ;	
 triggerObjectOnObjectEvent(Take, Karte) ;
}

event Stock -> Karte {
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 triggerObjectOnObjectEvent(Take, Karte) ;
}

event StockKlammer -> Karte {
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 triggerObjectOnObjectEvent(Take, Karte) ;
}

event Take -> Karte {
 Ego:
  walkToStdEventObject(Karte) ;
 suspend ;
 EgoStartUse ;
 delay until(Trinker.doAnimate) ;
 talkToTrinker = true ;
 Trinker.say("Hey!") ;
 Trinker.say("Nehmen Sie da sofort ihre Finger weg!") ;
 delay 2 ;
 Ego.say("Entschuldigen Sie.") ;
 Ego.say("Das war ein Versehen.") ;
 talkToTrinker = false ;
 EgoStopUse ;
 delay 6 ;
 Ego.turn(DIR_SOUTH) ;
 switch upCounter(5) {
   case 0:  Ego.say("Er hat mich erwischt. Ich sollte vorsichtiger sein.") ;
   case 1:  Ego.say("Er hat mich schon wieder erwischt.") ;
   case 2:  Ego.say("Er passt einfach zu gut auf seine Karte auf.") ;
   default: Ego.say("So hilft mir das nicht weiter. Er kann sp]ren, wenn ich die Karte nehmen will.") ;
 }
 
 clearAction ;
}


/* ************************************************************* */

object Saft {
 setPosition(1384,230) ;
 priority = 1 ;
 setAnim(Saft_image) ;
 absolute = false ;
 enabled = trinkerAtToilet ;
 visible = true ;
 clickable = false ;
} 


object Trinker { 
 setupAsStdEventObject(Trinker,TalkTo,1276,326,DIR_EAST) ; 		
 pathAutoScale = false ;
 path = 0 ;
 setAnim(Trinker_sprite) ;
 setPosition(1338,328) ;
 clickable = true ;
 enabled = (!trinkerAtToilet) ;
 visible = true ;
 captionwidth = 400 ;
 captionX = 5  ;
 captionY = -150 ;
 captionColor = COLOR_LANGE ; 
 setClickArea(-30,-131,30,9) ; 
 autoAnimate = false ;
 if (getField(0)==0) name = "Mann mit Getr#nk" ;
  else name = "Dr. Lange" ;
 frame = 0 ;
 member doAnimate = true ;
}

var Ti = 0 ;

event animate Trinker {
	
  // Lautstärke des Schluck-Geräuschs anpassen	
  
  var dist = findDistance(Trinker.positionX, Trinker.positionY, Ego.positionX, Ego.positionY) ;
  dist /= 2 ;
  var vol = VOLUME_FULL - dist ;
  if (vol < 0) vol = 0 ;
  Trinker.soundVolume = vol ;	
	
  return if (!Trinker.doAnimate) ;
  Ti++ ;
  switch Trinker.animMode {
   case ANIM_TALK: 
	if ((Ti >= 4) and (random(3)==0)) {
	  Ti = 0 ;
	  if (Trinker.frame<4) Trinker.frame = random(2)+4 ;
	    else Trinker.frame = random(2)+2 ;
        }
	if ((Ti >= 2) and (random(5)==0)) { 
	  if (Trinker.frame<4) Trinker.frame = random(2)+4 ;
	    else Trinker.frame = random(2)+2 ;
	}
   case ANIM_WALK:
	if (Ti >= 3) {
	  Ti = 0 ;
	  Trinker.frame = Trinker.frame + 1 ;
	  if (Trinker.frame > 3) Trinker.frame = 0 ;
	}
   default:
	if (Trinker.frame>3) Trinker.frame = 2 ;
	if (talkToTrinker) {
	  if (Trinker.frame<2) Trinker.frame = 2 ;
          if ((Ti >= 15+random(15)) and (random(4)==0)) {
	    Ti = 0 ;
	    Trinker.frame = random(2)+2 ;
          }
	} else {
	  if (Ti >= 35+random(15)) and (random(8)==0) {
            Ti = 0 ;		
	    if ((Trinker.frame==1) or (Trinker.frame==2) or (Trinker.frame==3)) Trinker.frame = 0 ;
	      else Trinker.frame = random(3)+1 ;
	  }
        }
	if ((Trinker.frame>1) and (random(6)==0)) Trinker.frame = random(2)+2 ;
  }
}

event LookAt -> Trinker {
  Ego:
   walkToStdEventObject(Trinker) ;
  suspend ;
  if (Trinker.getField(0)) say("Das ist Dr. Samuel Lange.") ;
   say("Ein kurzer #lterer Herr mit freundlichem Gesicht und einem Getr#nk in der Hand.") ;
  delay 4 ;
   say("Ihm ragt etwas aus seiner hinteren Hosentasche heraus.") ;
  clearAction ;
}

static var talkTrinkerFirst = true ;
var talkToTrinker = false ;

event TalkTo -> Trinker {
  Ego:
   walkToStdEventObject(Trinker) ;
  suspend ;
  delay until (Trinker.doAnimate) ;
  talkToTrinker = true ;
  Peter.captionColor = RGBA(221,068,221,125) ;
  if (talkTrinkerFirst) {
   TDfirst() ;
   talkTrinkerFirst = false ;
  } else
  switch random(3) {
    case 0 : Ego.say("Hi nochmal.") ;
    case 1 : Ego.say("Hallo!") ;
    case 2 : Ego.say("Hier bin ich schon wieder.") ;
  }
  TD ;  
  Peter.captionColor = RGBA(221,068,221,255) ;
  talkToTrinker = false ;
  clearAction ;
}

event Use -> Trinker {
 triggerObjectOnObjectEvent(Take, Trinker) ;
}

event Take -> Trinker {
 Ego:
  walkToStdEventObject(Trinker) ;
 suspend ;
  say("Nicht mein Typ.") ;
 clearAction ;
}

event Push -> Trinker {
 Ego:
  walkToStdEventObject(Trinker) ;
 suspend ;
 EgoUse ;
  delay 3 ;
 delay until (Trinker.doAnimate) ;
 talkToTrinker = true ;
 Trinker: "Lassen Sie das!"
 talkToTrinker = false ;
 clearAction ;
}

event Kondensmilch -> Trinker {
 Ego:
 if (did(give)) {
   walkToStdEventObject(Trinker) ;
   suspend ;
    say("Hier, nehmen Sie das.") ;
   EgoUse ;
   delay until(Drink.enabled) ;
   Trinker.say("Oh Gott, nein!") ;
   Trinker.say("Ich HASSE Milch!") ;
   knowsMilk = true ;
 } else {
   walkToStdEventObject(Trinker) ;
   suspend ;
   if (knowsLactose) {
     say("Wenn ich die Packung [ffne und ]ber ihn leere, bringt mir das gar nichts.") ;
     say("Au}er einer Rechnung von der Reinigung vielleicht.") ;
   } else say("Wie soll mir das weiterhelfen?") ;
 }
 clearAction ;
}

event invDrinks -> Trinker {
 var used = did(use) ;
 Ego:
  walkToStdEventObject(Trinker) ;
 suspend ;
 if (used) {
   say("Ih m[chte das Getr#nk jetzt nicht ]ber ihn leeren.") ;
   
 } else {
   say("Darf ich Ihnen dieses Getr#nk hier anbieten?") ;
   delay until (Trinker.doAnimate and Drink.enabled) ;
   Trinker.say("Nein danke, ich habe schon einen Apfelsaft.") ;
 }
 clearAction ;
}



/* ************************************************************* */

script trinkerIntoxicated {
  return Drink.getField(0) ;
}

object Drink {
 setupAsStdEventObject(Drink,WalkTo,1424,351,DIR_NORTH) ;
 setClickArea(1379,229,1379+22,229+27) ;
 absolute = false ;
 clickable = true ;
 enabled = (!trinkerAtToilet)  ;
 visible = false ;
 name = "Getr#nk" ;
}

event LookAt -> Drink {
 Ego:
  walkToStdEventObject(Drink) ;
 suspend ;
  say("Das sieht nach einem Glas Apfelsaft aus.") ;
 clearAction ;
}

event Take -> Drink {
 Ego:
  walkToStdEventObject(Drink) ;
 suspend ;
  say("Ich m[chte dem Mann das nicht wegnehmen.") ;
  say("Au}erdem glaube ich nicht, dass er damit einverstanden w#re.") ;
 clearAction ;	
}

event Close -> Drink {
 Ego:
  walkToStdEventObject(Drink) ;
 suspend ;
  say("Das Glas l#sst sich nicht schlie}en.") ;
 clearAction ;	
}

event Open -> Drink {
 Ego:
  walkToStdEventObject(Drink) ;
 suspend ;
  say("Das Glas l#sst sich nicht [ffnen. Es hat oben bereits eine |ffnung.") ;
 clearAction ;	
}

event Kondensmilch -> Drink {
 Ego:
  walkToStdEventObject(Drink) ;
 suspend ;
 if (!knowsLactose) {
   say("Warum sollte mir das weiterhelfen?") ;
   clearAction ;
   return ;
 }
 if (!poisoningEnabled) {
   say("Ich kann den guten laktoseintoleranten Mann doch nicht einfach grundlos vergiften!") ;
   if (knowsIDCard) {
     say("Auf der anderen Seite w]rde mir seine Identifikationskarte weiterhelfen.") ;
     say("Vielleicht leiht er sie mir ja kurz aus...") ;
   }
   clearAction ;
   return ;
 }
 if (!Drink.enabled) delay until (Drink.enabled) ;
 EgoStartUse ;
 if ((Trinker.frame==2) or (Trinker.frame==3)) {
   soundBoxStart(Music::Kondens_wav) ;
   delay 5 ;
   dropItem(Ego, Kondensmilch) ;
   Drink.setField(0, true) ;
   EgoStopUse ;
   forceHideInventory ;
   Ego.walk(1290,351) ;
   Ego.turn(DIR_EAST) ;
 } else { 
   delay until (Trinker.doAnimate) ;
   talkToTrinker = true ;
   Trinker.doAnimate = false ;
   Trinker.frame = 0 ;
   Trinker.say("Was machen Sie da?") ;
   EgoStopUse ;
   Ego.say("@hm...") ;
   Trinker.say("Finger weg!") ;
   delay 5 ;
   Trinker.frame = 1 ;
   Ego.turn(DIR_SOUTH) ;
   delay 2 ;
   pujaTipp ;
   Trinker.doAnimate = true ;
   talkToTrinker = false ;
   clearAction ;
 }
}

script pujaTipp {
 Ego:
 switch upCounter(3) {
  case 0: Ego.say("Ich sollte mich nicht erwischen lassen.") ;   
  case 1: Ego.say("Er hat mich schon wieder gesehen.") ;   
  default: Ego.say("Ich sollte damit warten, bis er in die andere Richtung schaut.") ;   
 }
}

/* ************************************************************* */

object Drinks {
 setupAsStdEventObject(Drinks,LookAt,1265,278,DIR_EAST) ;
 setClickArea(1290,198,1330,230) ;
 absolute = false ;
 enabled = true ;
 visible = true ;
 name = "Getr#nke" ;
}

event LookAt -> Drinks {
 Ego:
  walkToStdEventObject(Drinks) ;
 say("Auf dem Glastisch stehen eine Reihe unterschiedliche Flaschen mit Getr#nken.") ;
}

event Use -> Drinks {
 Ego:
  walkToStdEventObject(Drinks) ;
  say("Ich bin nicht durstig.") ;
}

script scrollToButler {
    int i = 0 ;
    loop {
      i++ ;
      if (Butler.PositionX < ScrollX + 300) {
        ScrollX = ScrollX - (((ScrollX + 300) - Butler.PositionX) / 8) ;
      } 
      delay  ;
      return if (i >= 33) ;
    }
}

event Pull -> Drinks {
 triggerObjectOnObjectEvent(Push, Drinks) ;
}

event Push -> Drinks {
 Ego:
  walkToStdEventObject(Drinks) ;
 suspend ;
  say("Ich m[chte jetzt keine Sauerei veranstalten.") ;
 clearAction ;
}

event Take -> Drinks {
 Ego:
  walkToStdEventObject(Drinks) ;
 suspend ;
 forceHideInventory ;
 EgoStartUse ; 
 
 delay 3 ;
 disableScrolling ;
 scrollToButler ;
 Butler.say("Hier ist keine Selbstbedienung, junger Mann!") ;
 enableScrolling ;
 delay 3 ;
 if ((random(3)==0) and (Trinker.doAnimate)) {  
   talkToTrinker = true ;
   Trinker.say("Was f]r eine Unversch#mtheit!") ;
   talkToTrinker = false ;
 }
 delay 2 ;
 EgoStopUse ;
 forceShowInventory ;
 clearAction ;
}

/* ************************************************************* */

object Durchgang {
 setupAsStdEventObject(Durchgang,WalkTo,179,329,DIR_WEST) ;
 setClickArea(41,112,120,324) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Durchgang" ;
}

event LookAt -> Durchgang {
 clearAction ;
 Ego:
  turn(DIR_WEST) ;
  say("Dort geht es zur Empfangshalle.") ;
}

event Use -> Durchgang {
 triggerObjectOnObjectEvent(WalkTo, Durchgang) ;
}

event Close -> Durchgang {
 clearAction ;
 Ego:
  turn(DIR_WEST) ;
  say("Da kann man nichts schlie}en.") ;
}

event WalkTo -> Durchgang {
 Ego:
  walkToStdEventObject(Durchgang) ;
 suspend ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 850 ;
  walk(4,321) ;
 delay 10 ;
  pathAutoScale = true ;
  reflection = false ;
  lightmap = null ;
  lightmapAutoFilter = false ;      
 doEnter(Finaleeingang) ;
 
}

/* ************************************************************* */

object Bild1 {
 setupAsStdEventObject(Bild1,LookAt,290,337,DIR_NORTH) ;
 setClickArea(245,102,356,247) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Gem#lde" ;
}

event LookAt -> Bild1 {
 Ego:
  walkToStdEventObject(Bild1) ;
 suspend ;
 Ego.say("Francisco de Goya: Saturn verschlingt eines seiner Kinder.") ;
 clearAction ;
}

event Take -> Bild1 {
 Ego:
  walkToStdEventObject(Bild1) ;
 suspend ;
 Ego.say("Ich m[chte es nicht mit mir herumtragen.") ;
 clearAction ;	
}

event Push -> Bild1 {
 Ego:
  walkToStdEventObject(Bild1) ;
 suspend ;
 EgoUse ;
 Ego.say("Es ist gut befestigt.") ;
 clearAction ;
}

event Pull -> Bild1 {
 triggerObjectOnObjectEvent(Push, Bild1) ;
}

/* ************************************************************* */

object Schaubild1 {
 setupAsStdEventObject(Schaubild1,LookAt,450,338,DIR_NORTH) ;
 setClickArea(406,122,515,256) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schaubild" ;
}

event LookAt -> Schaubild1 {
 Ego:
  walkToStdEventObject(Schaubild1) ;
 suspend ;
 Ego.say("Auf dem Schaubild ist die Leistung aller Plutonium-Kernkraftwerke pro Jahr aufgetragen.") ;
 clearAction ;
}

event Take -> Schaubild1 {
 Ego:
  walkToStdEventObject(Schaubild1) ;
 suspend ;
 Ego.say("Ich m[chte es nicht mit mir herumtragen.") ;
 clearAction ;	
}

event Push -> Schaubild1 {
 Ego:
  walkToStdEventObject(Schaubild1) ;
 suspend ;
 EgoUse ;
 Ego.say("Lieber nicht.") ;
 clearAction ;
}

event Pull -> Schaubild1 {
 triggerObjectOnObjectEvent(Push, Schaubild1) ;
}

/* ************************************************************* */

object Bild2 {
 setupAsStdEventObject(Bild2,LookAt,623,345,DIR_NORTH) ;
 setClickArea(545,120,705,247) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Gem#lde" ;
}

event LookAt -> Bild2 {
 Ego:
  walkToStdEventObject(Bild2) ;
 suspend ;
 Ego.say("Nummer 39 aus Goyas Radierfolge 'Die Schrecken des Krieges'.") ;
 clearAction ;
}

event Take -> Bild2 {
 Ego:
  walkToStdEventObject(Bild2) ;
 suspend ;
 Ego.say("Ich m[chte es nicht mit mir herumtragen.") ;
 clearAction ;	
}

event Push -> Bild2 {
 Ego:
  walkToStdEventObject(Bild2) ;
 suspend ;
 EgoUse ;
 Ego.say("Es ist gut befestigt.") ;
 clearAction ;
}

event Pull -> Bild2 {
 triggerObjectOnObjectEvent(Push, Bild2) ;
}

/* ************************************************************* */

object Feuerschild {
 setupAsStdEventObject(Feuerschild,LookAt,170,340,DIR_WEST) ;
 setClickArea(49,76,104,103) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Notausgangs-Schild" ;
}

event LookAt -> Feuerschild {
 Ego:
  walkToStdEventObject(Feuerschild) ;
 suspend ;
  say("Wenn es brennt, hier lang.") ;
 clearAction ;
}

event Take -> Feuerschild {
 Ego:
  walkToStdEventObject(Feuerschild) ;
 suspend ;
  say("Ich komme nicht ran.") ;
 clearAction ;	
}

event Push -> Feuerschild {
 triggerObjectOnObjectEvent(Take, Feuerschild) ;
}

event Pull -> Feuerschild {
 triggerObjectOnObjectEvent(Take, Feuerschild) ;
}


/* ************************************************************* */

object Banner {
 setupAsStdEventObject(Banner,LookAt,1090,287,DIR_NORTH) ;
 setClickArea(1040,103,1258,136) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Banner" ;
}

event LookAt -> Banner {
 Ego:
  walkToStdEventObject(Banner) ;
 suspend ;
  say("Auf dem Banner steht in Gro}buchstaben: 'The Future of Power'.") ;
 clearAction ;
}

event Take -> Banner {
 Ego:
  walkToStdEventObject(Banner) ;
 suspend ;
  say("Ich komme nicht ran.") ;
 clearAction ;	
}

event Push -> Banner {
 triggerObjectOnObjectEvent(Take, Banner) ;
}

event Pull -> Banner {
 triggerObjectOnObjectEvent(Take, Banner) ;
}

/* ************************************************************* */

object Bild3 {
 setupAsStdEventObject(Bild3,LookAt,1624,348,DIR_NORTH) ;
 setClickArea(1558,119,1672,271) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Gem#lde" ;
}

event LookAt -> Bild3 {
 Ego:
  walkToStdEventObject(Bild3) ;
 suspend ;
 Ego.say("Francisco de Goya: Der Kolo}.") ;
 Ego.say("Menschen und Tiere fl]chten in wilder Panik vor dem Riesen.") ;
 Ego.say("Seine ballende Faust droht in Richtung Horizont.") ;
 clearAction ;
}

event Take -> Bild3 {
 Ego:
  walkToStdEventObject(Bild3) ;
 suspend ;
 Ego.say("Ich m[chte es nicht mit mir herumtragen.") ;
 clearAction ;	
}

event Push -> Bild3 {
 Ego:
  walkToStdEventObject(Bild3) ;
 suspend ;
 EgoUse ;
 Ego.say("Es ist gut befestigt.") ;
 clearAction ;
}

event Pull -> Bild3 {
 triggerObjectOnObjectEvent(Push, Bild3) ;
}

/* ************************************************************* */

object Schaubild2 {
 setupAsStdEventObject(Schaubild2,LookAt,1780,346,DIR_NORTH) ;
 setClickArea(1726,133,1836,273) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Schaubild" ;
}

event LookAt -> Schaubild2 {
 Ego:
  walkToStdEventObject(Schaubild2) ;
 suspend ;
 Ego.say("Auf dem Schaubild ist die Leistung eines Kubikzentimeter Patrimonium-Kristalls pro sonnigem Jahr aufgetragen.") ;
 clearAction ;
}

event Take -> Schaubild2 {
 Ego:
  walkToStdEventObject(Schaubild2) ;
 suspend ;
 Ego.say("Ich m[chte es nicht mit mir herumtragen.") ;
 clearAction ;	
}

event Push -> Schaubild2 {
 Ego:
  walkToStdEventObject(Schaubild2) ;
 suspend ;
 EgoUse ;
 Ego.say("Lieber nicht.") ;
 clearAction ;
}

event Pull -> Schaubild2 {
 triggerObjectOnObjectEvent(Push, Schaubild2) ;
}

/* ************************************************************* */

object Bild4 {
 setupAsStdEventObject(Bild4,LookAt,1960,343,DIR_NORTH) ;
 setClickArea(1872,136,2016,246) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Gem#lde" ;
}

event LookAt -> Bild4 {
 Ego:
  walkToStdEventObject(Bild4) ;
 suspend ;
 Ego.say("Nummer 15 aus Goyas Radierfolge 'Die Schrecken des Krieges'.") ;
 clearAction ;
}

event Take -> Bild4 {
 Ego:
  walkToStdEventObject(Bild4) ;
 suspend ;
 Ego.say("Ich m[chte es nicht mit mir herumtragen.") ;
 clearAction ;	
}

event Push -> Bild4 {
 Ego:
  walkToStdEventObject(Bild4) ;
 suspend ;
 EgoUse ;
 Ego.say("Es ist gut befestigt.") ;
 clearAction ;
}

event Pull -> Bild4 {
 triggerObjectOnObjectEvent(Push, Bild4) ;
}

/* ************************************************************* */

object TrinkerSeife {
 setPosition(2095,183) ;
 setAnim(TrinkerSeife_sprite) ;
 absolute = false ;
 clickable = true ;
 visible = true ;
 enabled = false ;
 stopAnimDelay = 2 ;
 talkAnimDelay = 2 ;
 captionWidth = 272 ;
 captionY = - 60 ;
 captionColor = COLOR_LANGE ;
 priority = 2 ;
 autoAnimate = false ;
 frame = 0 ;
}

/* ************************************************************* */

object Tuer {
 setupAsStdEventObject(Tuer,Open,2079,344,DIR_EAST) ;
 setClickArea(2115,125,2189,338) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "T]r" ;
}

event Close -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
  say("Die T]r ist schon geschlossen.") ;
}

event LookAt -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
  say("Diese T]r f]hrt dem Schild nach zu urteilen zu den Toiletten.") ;
}

event Push -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
  EgoUse ;
  delay 2 ;
  say("Ich sollte die T]r mit der Klinke [ffnen.") ;
 clearAction ;
}

event Pull -> Tuer {
 triggerObjectOnObjectEvent(Push, Tuer) ;
}

event TalkTo -> Tuer {
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
  say("Hallo, T]r?") ;
  delay 10 ;
 clearAction ;
}

event Open -> Tuer {
 static var firstEnterToilette = false ;
 Ego:
  walkToStdEventObject(Tuer) ;
 suspend ;
 if ((!firstEnterToilette)and(!trinkerAtToilet)) {
   turn(DIR_SOUTH) ;
   say("Entschuldige mich mal bitte.") ;
   turn(DIR_EAST) ;
 }
 EgoStartUse ;
 soundBoxStart(Music::Tuerauf3_wav) ;
 TuerGra.enabled = true ;
 EgoStopUse ;
  path = 0 ;
  pathAutoScale = false ;
  scale = 923 ;
 delay 3 ;
  walk(2229,322) ;
  reflection = false ;
 delay 10 ;
 soundBoxStart(Music::Tuerzu2_wav) ;
 TuerGra.enabled = false ;
 delay 5 ;
 if ((!firstEnterToilette) and (!trinkerAtToilet)) {
   delay 100 ;
    pathAutoScale = false ;
    path = 0 ;
    scale = 923 ;
    setPosition(2229,322) ;
    face(DIR_WEST) ;   
    reflection = true ;
   soundBoxStart(Music::Tuerauf3_wav) ;
   TuerGra.enabled = true ;
   delay 2 ;
    walk(2079,344) ;
   delay 2 ;
    turn(DIR_EAST) ;
   EgoStartUse ;
   delay 2 ;
   soundBoxStart(Music::Tuerzu2_wav) ;
   TuerGra.enabled = false ;
   EgoStopUse ;
    turn(DIR_WEST) ;
    path = Finalesaal_path ;
    pathAutoScale = true ;
   firstEnterToilette = true ;
   say("Hat das gut getan.") ;
   delay 3 ;
   say("Diese bl[de Flugbegleiterin!") ;
   clearAction ;
 } else {
    pathAutoScale = true ;
    
   lightmap = null ;
   lightmapAutoFilter = false ;        
   doEnter(Finaletoilette) ;
 }
}

object TuerGra {
 setPosition(2011,118) ;
 priority = 1 ;
 setAnim(TuerOffen_image) ;
 absolute = false ;
 enabled = false ;
 visible = true ;
 clickable = false ;
} 

/* ************************************************************* */

object ZumFinale {
 setupAsStdEventObject(ZumFinale,WalkTo,1044,247,DIR_WEST) ;
 setClickArea(1022,133,1056,247) ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = false ;
 name = "Durchgang" ;
}

event Use -> ZumFinale {
 triggerObjectOnObjectEvent(WalkTo, ZumFinale) ;
}

event LookAt -> ZumFinale {
 Ego: 
  say("Neben der B]hne befindet sich noch ein kleiner Vorraum.") ;
 clearAction ;
}

event WalkTo -> ZumFinale {
 Ego:
  walkToStdEventObject(ZumFinale) ;
 suspend ;
  path = 0 ;
  scale = 400 ;
  pathAutoScale = false ;
  walk(983,236) ;  
  pathAutoScale = true ;
 visitedBuehne = true ;
  lightmap = null ;
  lightmapAutoFilter = false ;
 doEnter(Finalebuehne) ;
}

/* ************************************************************* */

object Leinwand {
 setupAsStdEventObject(Leinwand,LookAt,1110,267,DIR_NORTH) ;
 setPosition(1106,139) ;
 setClickArea(0,0,88,71) ;
 setAnim(Beamer_sprite) ;
 frame = talkStage + 1 ;
 autoAnimate = false ;
 absolute = false ;
 clickable = true ;
 enabled = true ;
 visible = true ;
 name = "Leinwand" ;
}

event LookAt -> Leinwand {
 Ego:
  walkToStdEventObject(Leinwand) ;
 suspend ;
  say("Auf die Leinwand werden die Pr#sentationsfolien von Peter projeziert.") ;
  say("Der Titel der aktuellen Folie lautet: ") ;
  
 switch (Leinwand.frame) {
  case 0: say("The Future of Power begins Today.") ;
  case 1: say("Die Zukunft der Energieversorgung.") ;
  case 2: say("Energieeffizienz.") ;
  case 3: say("Saubere Energie.") ;
  case 4: say("Entwicklungshilfe.") ;
  case 5: say("Transport.") ;
  default: say("Expansion.") ;
 }

 clearAction ;
}

event Take -> Leinwand {
 Ego:
  walkToStdEventObject(Leinwand) ;
 suspend ;
  say("Die Leinwand w#hrend der Pr#sentation einfach abzurei}en halte ich f]r keine gute Idee.") ;
 clearAction ;
}

event Pull -> Leinwand {
 triggerObjectOnObjectEvent(Take, Leinwand) ;
}

/* ************************************************************* */

object Kameras {
  enabled = true ;
} 

event paint Kameras {
 static int blink = 0 ;
  if (blink <= 10) {
   drawingColor = RGBA(255,00,00,130) ;
   drawingPriority = 255 ;
   drawCircle(194-scrollX,64,2) ;
   drawCircle(2043-scrollX,87,2) ;
  } 
  blink = blink + 1 ;
  if (blink >= 20) blink = 0 ;
} 

/* ************************************************************* */

script G1Dfirst {
 Ego:
  "Guten Abend."
 Guest1:
  "Ebenfalls!"
 Ego:
 delay ;
  "Darf ich fragen, wer Sie sind?"
 Guest1:
 delay ;
  "Doktor Rudolf Kranich, ich arbeite f]r ein renommiertes Wissenschaftsblatt."
 Guest1.name = "Doktor Kranich" ;
 Guest1.setField(0,1) ;
  "Ich nehme an, Sie sind auch von der Presse?"
 delay 2 ;
 Ego:  
  "Nein, ich bin Julian Holber, ein guter Freund von Professor Wonciek."
 delay 1 ;
 Guest1:
  "Ahh, Sie kennen den Herrn Professer Wonciek n#her?"
  "K[nnen Sie mir etwas mehr zu seiner wissenschaftlichen Arbeit erz#hlen?"
  "Ich finde diesen Vortrag nicht sehr aufschlussreich. Zu popul#rwissenschaftlich."
 delay 2 ;
 Ego:
 delay 2 ;
  "Da kann ich Ihnen leider nicht weiterhelfen."
  "Ich bin mit der Materie nicht gut vertraut."
 Guest1:
  "Schade."
}

script G1D {

 static var tda = false ;
 static var tdb = false ;
 static var tdc = false ; 
 static var tdd = false ;


 loop {
  Ego:
  AddChoiceEchoEx(1, "F]r welches Wissenschaftsblatt arbeiten Sie denn?", true) if (tda==false) ;
  AddChoiceEchoEx(1, "Was machen Sie hier nochmal?", true) if (tda) ;
  AddChoiceEchoEx(2, "K[nnen Sie mir etwas ]ber die anderen G#ste erz#hlen?", true) if (tdb==false) ;
  AddChoiceEchoEx(3, "Wie denken Sie ]ber diese Energiequelle Patrimonium?", true) if (tdc==false) ;
  AddChoiceEchoEx(3, "Wie halten Sie nochmal von dieser Energiequelle Patrimonium?", true) if (tdc) ;
  AddChoiceEchoEx(4, "Wissen Sie, was da vorne hinter der bewachten T]r stattfindet?", true) if (visitedBuehne and (!tdd)) ;
  AddChoiceEchoEx(9, "Auf wiedersehen.", true) ;
   
  var c = dialogEx () ;
  
  switch (c) {
   case 1: 
     Guest1:
     if (tda==false) {
       "Es hei}t 'Forschung Aktuell'."
       "Sie haben sicherlich schon davon geh[rt."
      Ego:
       "Nein, habe ich nicht."
      Guest1:
       "Unser Themenspektrum fokussiert sich auf den naturwissenschaftlichen Bereich."
       "Ich soll einen Artikel ]ber diese neue Energiequelle schreiben."
       "Au}erdem brauchen wir f]r die Klatsch-Sparte einen kleinen Bericht ]ber diesen dreiohrigen Professor da dr]ben."
      delay 3 ;
       "Wissen Sie, wie das passiert ist?"
      Ego:       
       "Schreiben Sie einfach, es war ein Arbeitsunfall."
      delay 2 ;
      Guest1:
       "Das werde ich machen."
      delay ;
      Ego:
       "Hehehehehe..."
       tda = true ;
     } else {
       "Ich soll f]r das Magazin 'Forschung Aktuell' einen Artikel ]ber diese neue Energiequelle schreiben."
     }
   case 2: 
     Guest1:
      "Ich habe den Eindruck, dass der Dicke da vom Fernsehen ist."
      "Er redet aber nicht mit mir."
      "Die anderen geh[ren meiner Vermutung nach auch zur Presse."
     tdb = true ;
   case 3: 
     if (!tdc) {
      Guest1:
       "Wenn dieser dreiohrige Professor Recht haben sollte, stehen wir kurz... "
       "...vor einem Quantensprung in der Entwicklungsgeschichte der Menschheit."
      tdc = true ;
     } else { 
      Guest1:
       "Wenn dieser dreiohrige Professor Recht haben sollte, stehen wir kurz... "
       "...vor einem Quantensprung in der Entwicklungsgeschichte der Menschheit."	     
     }
   case 4: 
     Guest1: 
      "Tut mir leid, junger Mann, das wei} ich auch nicht."
      "Vielleicht geht es dort zum Buffet."      
     tdd = true ;
   default:
     Guest1:
      "Auf wiedersehen!"
     return ;
  }
 }

}


/* ************************************************************* */

// get random names for Julian

script getName {
 switch random(19) {
  case 0:  return "Hommel" ;
  case 1:  return "Hobel" ;
  case 2:  return "Hobusch" ;
  case 3:  return "Hoek" ;
  case 4:  return "Hofbauer" ;
  case 5:  return "Hofer" ;
  case 6:  return "Hochh#user" ;
  case 7:  return "Hobrack" ;
  case 8:  return "Hoffner" ;
  case 9:  return "Holzapfel" ;
  case 10: return "Heibel" ;
  case 11: return "Heigel" ;
  case 12: return "Huckelmann" ;
  case 13: return "H]bler" ;
  case 14: return "K]bel" ;
  case 15: return "H]bel" ;
  case 16: return "Hummel" ;
  case 17: return "Hummer" ;
  default: return "Humpelbein" ;
 }
}

script TDfirst {
 Ego:
  "Hi."
 Trinker:
  "Einen sch[nen guten Abend w]nsche ich Ihnen!"
 Ego:
 delay ;
  "Darf ich fragen, wer Sie sind?"
 Trinker:
 delay ;
  "Doktor Samuel Lange ist mein Name."
 Trinker.name = "Dr. Lange" ;
 Trinker.setField(0,1) ;
  "Und mit wem habe ich das Vergn]gen?"
 delay 2 ;
 Ego:  
  "Hobler."
 delay 1 ;
  "Julian Hobler."
 delay 2 ;
 Trinker:
  "Was f]hrt Sie hier her?"
 Ego:
 delay 2 ;
  "Professor Wonciek hat mich eingeladen."
 Trinker:
  "Professor Wonciek?"
 Ego:
  "Ja, der Mann da vorne, der die Pr#sentation h#lt."
 Trinker:
  "Ach ja...richtig!"
 var line = "Ich habe es nicht so mit Namen m]ssen Sie wissen Herr " ;
 stringAppend(line, getName) ;
 stringAppendChar(line, '.') ;
 Trinker.say(line) ;
 delay 3 ;
 Ego:
  "Das merke ich."
}

static var poisoningEnabled = false ;

script TD {

 static var tda = false ;
 static var tdb = false ;
 static var tdc = false ; 
 static var tdd = false ;
 static var tdd2 = false ;

 loop {
  Ego:
  AddChoiceEchoEx(1, "Und was f]hrt Sie hier her?", true) if (tda==false) ;
  AddChoiceEchoEx(1, "Warum sind Sie nochmal hier?", true) if (tda) ;
  AddChoiceEchoEx(2, "K[nnen Sie mir was ]ber die anderen G#ste erz#hlen?", true) if (tdb==false) ;
  AddChoiceEchoEx(3, "Wie denken Sie ]ber diese Energiequelle Patrimonium?", true) if (tdc==false) ;
  AddChoiceEchoEx(3, "Nochmal zu dieser Energiequelle...", true) if (tdc) ;
  AddChoiceEchoEx(4, "Wissen Sie, was da vorne hinter der bewachten T]r stattfindet?", true) if (visitedBuehne and (!tdd)) ;
  AddChoiceEchoEx(5, "Was ist das da in Ihrer Hosentasche?", true) if (tdd and (!tdd2)) ;
  AddChoiceEchoEx(5, "Was ist das nochmal, da in Ihrer Hosentasche?", true) if (tdd and (tdd2)) ;
  AddChoiceEchoEx(6, "Was trinken Sie da?", true) ;
  AddChoiceEchoEx(7, "Erz#hlen Sie mir etwas ]ber die Navortis AG.", true) if (tda) ;
  AddChoiceEchoEx(8, "Warum sind Sie auf Milch nicht so gut zu sprechen?", true) if (knowsmilk and (!knowsLactose)) ;
  AddChoiceEchoEx(8, "Weshalb nochmal waren Sie auf Milch nicht so gut zu sprechen?", true) if (knowsmilk and (knowsLactose)) ;
  AddChoiceEchoEx(9, "Auf wiedersehen.", true) ;
   
  var c = dialogEx () ;
  
  switch (c) {
   case 1: 
     Trinker:
     if (tda==false) {
       "Ich arbeite in einem Unternehmen namens 'Navortis' als CNC-Maschinenoperateur und Programmierer."
       "Die Navortis AG ist ein international erfolgreicher Technologiekonzern in den M#rkten f]r Motoren und Wehrtechnik."
       "Und eigentlich vertrete ich einen kranken Kollegen, und soll mir die Angebote von Samtec bez]glich Kooperationsm[glichkeiten anh[ren."
       tda = true ;
     } else {
       "Ich vertrete einen kranken Kollegen und soll mir die Angebote von Samtec bez]glich Kooperationsm[glichkeiten anh[ren."
     }
   case 2: 
     Trinker:
      "Hier ist ziemlich viel Presse anwesend sowie einige Vertreter von an Kooperationen interessierter Unternehmen."
      "Mehr kann ich Ihnen auch nicht sagen, Sie sind der erste, mit dem ich mich hier unterhalte."
      "Bis auf die nette Dame am Empfang..."
     delay 5 ;
      "Ich glaube sie hei}t Rosa."
      "Ein sch[ner Name, finden Sie nicht?"
     delay 2 ;
     Ego:
      "Absolut."
     tdb = true ;
   case 3: 
     if (!tdc) {
      Trinker:
       "In welcher Hinsicht?"
      tdc = true ;
     } else Trinker.say("Ja?") ;
     TDPatri ;
   case 4: 
     Trinker: 
      "Dort haben nur bestimmte Unternehmensvertreter Zugang, um mit dem Samtec-Vorstand ]ber m[gliche Kooperationen zu diskutieren."
      "Unter Ausschluss der |ffentlichkeit und damit der Presse, versteht sich."
      "Deswegen haben alle Reporter dort keinen Zugang."      
     Ego:
      "Wie kommt man da rein?"
     Trinker:
      "Sie ben[tigen eine Sicherheitskarte zur Identifikation, und m]ssen Ihre Identit#t noch mit ihrem Fingerabdruck best#tigen."
     tdd = true ;
     knowsIDCard = true ;
   case 5: ;
     Trinker:
      "Das ist meine Sicherheitskarte die mir den Zugang zum internen Bereich hier verschafft."
     TDKarte ;
   case 6: 
     Trinker:
      "Frisch gepressten Apfelsaft."     
      "Was anderes mag ich nicht."            
   case 7:
     Trinker:
      "Die Navortis AG ist ein substanzstarkes Traditionsunternehmen mit ]ber 20.000 Mitarbeitern weltweit."
      "Wir sind Marktf]hrer in unseren Kernkompetenzen Motoren und Wehrtechnik."
      "Im letzten Jahr konnten wir einen Jahresumsatz von ]ber vier Milliarden Euro verbuchen."
      "Wertsteigerung durch profitables Wachstum steht im Mittelpunkt unserer weiteren Unternehmensentwicklung."
      TDNavortis ;
   case 8:
     Trinker:
      "Ich leide an einer angeborenen Milchzuckerunvertr#glichkeit."
      "Schon bei kleinsten Mengen Lactose bekomme ich heftigen Durchfall."
      knowsLactose = true ;
     var line = "" ;
     stringClear(line) ;
     stringAppend(line,"Und dann m[chten Sie garantiert nicht in meiner Haut stecken, Herr ") ;
     stringAppend(line, getName) ;
     stringAppendChar(line, '!') ;
     say(line) ;      
   default:
     Trinker:
      "Auf wiedersehen!"
     return ;
  }
 }

}

script TDKarte {
 static var TDKa = false ;
 static var TDKb = false ;


 loop {
  Ego:
   AddChoiceEchoEx(1, "Woher haben Sie diese Karte?", true) ;
   AddChoiceEchoEx(2, "Kann ich mir Ihre Karte mal ausleihen?", true) ;
   AddChoiceEchoEx(3, "Genug dar]ber.", true) ;
   
   
  var d = dialogEx () ;
  
  switch d {
   case 1: 
     if (TDKa==false) {
       Trinker:
        "Ich habe sie vorab am Eingang von dieser netten Empfangsdame erhalten."
        "Ich glaube sie hei}t Roswita..."
       var line = "Ein sch[ner Name, finden Sie nicht Herr " ;
       stringAppend(line, getName) ;
       stringAppendChar(line, '?') ;
       say(line) ;
       delay 2 ;
       Ego:
        "Definitiv."      
       delay 3 ;
       Trinker:
        "Au}erdem wurde mein Fingerabdruck mit einem Leseger#t gescannt..."
        "...und im Computer gespeichert."
       delay 3 ;
	"Unglaublich, diese Technik heutzutage..."
       TDKa = true ;
     } else {
       Trinker:
        "Wie ich schon sagte, von der netten jungen Dame im Eingangsbereich."
     }
   case 2:   
       Trinker:
       var line2 = "" ;
       stringClear(line2) ;
       stringAppend(line2,"Auf keinen Fall, Herr ") ;
       poisoningEnabled = true ;
       stringAppend(line2, getName) ;
       stringAppendChar(line2, '!') ;
        say(line2) ;
	
     if (TDKb==false) {
        "Au}erdem w]rde Ihnen die Karte gar nichts n]tzen, ohne meinen Finger."
       delay 8 ;
       Ego.turn(DIR_SOUTH) ;
       delay 10 ;
       Ego.say("Hmmmm...") ;
       delay 5 ;
       Ego.turn(DIR_EAST) ;
       Ego.say("Verstehe.") ;
       TDKb = true ;
     }
   case 3: return ;
  }
 }
}
 
 
 
script TDPatri {
 static var TDPa = false ;
 static var TDPc = false ;


 loop {
  Ego:
   AddChoiceEchoEx(1, "Glauben Sie, dass Patrimonium so effizient ist, wie hier angeprie}en?", true) ;
   AddChoiceEchoEx(2, "Hat Patrimonium gro}en Einfluss auf unsere Zukunft?", true) ;
   AddChoiceEchoEx(3, "K[nnen Sie sich vorstellen, dass Patrimonium auch f]r schlechte Dinge missbraucht wird?", true) ;
   AddChoiceEchoEx(4, "Vergessen Sie's.", true) ;
   
   
  var d = dialogEx () ;
  
  switch d {
   case 1: 
     if (TDPa==false) {
       Trinker:        
        "Mir will zwar noch nicht so recht einleuten, wie genau diese Energiequelle funktioniert..."
        "...und warum sie ausgerechnet nur mit Wasser genutzt werden kann, aber ich kann mir durchaus vorstellen..."
       var line = "...dass Patrimonium effizienter als andere Methoden zur Energiegewinnung ist, Herr " ;
       stringAppend(line, getName) ;
       stringAppendChar(line, '.') ;
       say(line) ;
       TDPa = true ;
     } else {
       Trinker:
        "Wie gesagt, das halte ich nicht f]r unm[glich."
     }
   case 2:   
     Trinker:
     var line2 = "" ;
     stringClear(line2) ;
     stringAppend(line2,"Ja, Herr ") ;
     stringAppend(line2, getName) ;
     stringAppendChar(line2, '!') ;
     say(line2) ;
     "Wenn Patrimonium das leisten kann, was hier versprochen wird..."
     "...stehen wir momentan kurz davor ein neues Zeitalter zu betreten."
   case 3:
     Trinker:
      "Dieses Problem besteht nat]rlich wie mit jeder anderen technologischen Errungenschaft."
     if (!tdpc) {
        "Wir werden sehen, was die Zukunft bringt, Herr..."
        "Wie war doch gleich Ihr Name?"
       Ego:
        var line3 = getName ;
        stringAppendChar(line3, '.') ;
        say(line3) ;
        var line4 = "Julian " ;
        stringAppend(line4, line3) ;
        say(line4) ;
       Trinker:
        "Ach ja...richtig!"
       TDPc = true ;
     }
    
   case 4: return ;
  }
 }
}

script TDNavortis {
 static var TDNa = false ;
 static var TDNb = false ;
 static var TDNc = false ;


 loop {
  Ego:
   AddChoiceEchoEx(1, "Was leistet Novartis im Unternehmensbereich Wehrtechnik?", true) if (!TDNa) ;
   AddChoiceEchoEx(1, "Was leistet Novartis nochmal im Unternehmensbereich Wehrtechnik?", true) if (TDNa) ;
   AddChoiceEchoEx(2, "Wie l#uft das Gesch#ft mit den Motoren?", true) if (!TDNb) ;
   AddChoiceEchoEx(2, "Wie l#uft das Gesch#ft mit den Motoren nochmal?", true) if (TDNb) ;
   AddChoiceEchoEx(3, "Was f]r Kooperationsm[glichkeiten bestehen mit dem Samtec-Konzern?", true) if (!TDNc) ;
   AddChoiceEchoEx(4, "Kommen wir auf etwas anders zu sprechen.", true) ;
   
   
  var d = dialogEx () ;
  
  switch d {
   case 1: 
     Trinker:        
      "Novartis entwickelt Fahrzeugsysteme, insbesondere gepanzerte Rad- und Kettenfahrzeuge sowie Unterst]tzungs- und Minenr#umsysteme."
     var line = "" ;
     stringClear(line) ;
     stringAppend(line,"Au}erdem produzieren wir Flugabwehrsysteme und Hochleistungsradare, Herr ") ;
     stringAppend(line, getName) ;
     stringAppendChar(line, '.') ;
      say(line) ;     
     if (!TDNa) 
      say("Wir sind eine namhafte und gro}e Adressen der internationalen Verteidigungs- und Sicherheitsindustrie.") ;
     TDNa = true ;      
   case 2:   
     Trinker:
     var line2 = "" ;
     stringClear(line2) ;
     stringAppend(line2,"Ausgezeichnet, Herr ") ;
     stringAppend(line2, getName) ;
     stringAppendChar(line2, '!') ;
      say(line2) ;
      "Unsere Motoren kommen zum Beispiel zum Einsatz in den Fahrzeugsystemen unserer Wehrtechnik-Abteilung..."
      "...bei Schiffsantrieben, in Anlagen zur Stromerzeugung..."
      "...sowie als Antrieb f]r die unterschiedlichsten Bahn-, Bau-, Bergbau,- und Agrarfahrzeuge."
     if (!TDNb) {
       Ego:
        "Einfach ausgedr]ckt: in Baggern und Traktoren?"
       Trinker:
        "Ja, aber ich hasse die Bezeichnung 'Traktoren'."
        "Dabei muss ich immer an Bauernh[fe und K]he und Milch denken, und ich HASSE Milch!"
       knowsMilk = true ;
       TDNb = true ;
     }
   case 3:
     Trinker:
      "Ich bin hier um das in Erfahrung zu bringen. Konkrete Pl#ne existieren noch nicht."
     if (!TDNc) {        
        "Wie war eigentlich nochmal Ihr Name?"
       Ego:
        var line3 = getName ;
        stringAppendChar(line3, '.') ;
        say(line3) ;
        var line4 = "Julian " ;
        stringAppend(line4, line3) ;
        say(line4) ;
       Trinker:
        "Ach ja...richtig!"
       TDNc = true ;
     }
    
   case 4: return ;
  }
 }
}
