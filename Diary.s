// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
//  diary.s   -    Wonciek's   diary 
//  presented     as      a     menu
// ----------------------------------

const MAXPAGES = 13 ;
const MAXTABS = 4 ;
const BOOKCENTERX = 314 ;
int   DiaryTabX[MAXTABS] ;
int   DiaryTabY1[MAXTABS] ;
int   DiaryTabY2[MAXTABS] ;
int   DiaryTabY3[MAXTABS] ;
int   DiaryTabIndex[MAXTABS] ;

script drawDiary {
 drawingFont = Fonts::Agastsmall_Font ;
 drawingTextColor = RGB(82,82,82) ;
 drawingJustify = 0 ; 
 
 drawImage(0,0,Graphics::Diary_image) ;
 if (DiaryInv.Page > 0) drawImage(4,306,Graphics::DiaryEdgeL_image) ;
 if (DiaryInv.Page < MAXPAGES-1) drawImage(554,309,Graphics::DiaryEdgeR_image) ;
 
 for (int n=0; n<MAXTABS;n++) {
  if (DiaryTabX[n] < 0) {  
   if (DiaryTabIndex[n] < DiaryInv.Page)  drawRotatedImage(Graphics::pin0_image, DiaryTabY1[n], abs(DiaryTabX[n]), 1000, drawingPriority, FloatMul(inttofloat(-1),1.57) ) ;
   if (DiaryTabIndex[n] == DiaryInv.Page) drawRotatedImage(Graphics::pin1_image, DiaryTabY2[n], abs(DiaryTabX[n]), 1000, drawingPriority, FloatMul(inttofloat(-1),1.57) ) ;
   if (DiaryTabIndex[n] > DiaryInv.Page)  drawRotatedImage(Graphics::pin0_image, DiaryTabY3[n], abs(DiaryTabX[n]), 1000, drawingPriority, 1.57 ) ;
  } else {
   if (DiaryTabIndex[n] < DiaryInv.Page)  drawRotatedImage(Graphics::pin0_image, PutLeft(DiaryTabX[n]), DiaryTabY1[n], 1000, drawingPriority, 0.0) ;
   if (DiaryTabIndex[n] == DiaryInv.Page) drawRotatedImage(Graphics::pin1_image, PutLeft(DiaryTabX[n]), DiaryTabY2[n], 1000, drawingPriority, 0.0) ;
   if (DiaryTabIndex[n] > DiaryInv.Page)  drawRotatedImage(Graphics::pin0_image, PutRight(DiaryTabX[n]), DiaryTabY3[n], 1000, drawingPriority, 0.0) ;
  }   
 } 
 drawingTextColor = RGB(82,82,82) ;
 drawDiaryPage(DiaryInv.Page) ;
 drawingTextColor = RGB(180,180,180) ;
 if (PointInRect(mouseX,mouseY,4,306,3+85,306+79) and (DiaryInv.Page > 0)) drawText (mouseX+10, mouseY-5, "bl#ttern") ;
 else if (PointInRect(mouseX,mouseY,554,309,554+86,309+67) and (DiaryInv.Page < MAXPAGES-1)) drawText (mouseX-60, mouseY-5, "bl#ttern") ;
  else if (mouseY > 400) drawText (mouseX+10, mouseY-5, "zur]ck") ;
} 

script ClickDiary(X,Y) {
 for (int n=0; n<MAXTABS;n++) {
  if (DiaryTabX[n] < 0) {  
   if ((DiaryTabIndex[n] <= DiaryInv.Page) and (PointInRect(DiaryTabY1[n]-X, abs(DiaryTabX[n])-Y, -19,-9,19,9))) GotoDiaryPage(DiaryTabIndex[n]) ;
   if ((DiaryTabIndex[n] <= DiaryInv.Page) and (PointInRect(DiaryTabY2[n]-X, abs(DiaryTabX[n])-Y, -19,-9,19,9))) GotoDiaryPage(DiaryTabIndex[n]) ;
   if ((DiaryTabIndex[n] > DiaryInv.Page)  and (PointInRect(DiaryTabY3[n]-X, abs(DiaryTabX[n])-Y, -19,-9,19,9))) GotoDiaryPage(DiaryTabIndex[n]) ;
  } else {
   if ((DiaryTabIndex[n] < DiaryInv.Page)  and (PointInRect(PutLeft(DiaryTabX[n])-X, abs(DiaryTabY1[n])-Y, -9,-19,9,19))) GotoDiaryPage(DiaryTabIndex[n]) ;
   if ((DiaryTabIndex[n] == DiaryInv.Page) and (PointInRect(PutLeft(DiaryTabX[n])-X, abs(DiaryTabY2[n])-Y, -9,-19,9,19))) GotoDiaryPage(DiaryTabIndex[n]) ;
   if ((DiaryTabIndex[n] > DiaryInv.Page)  and (PointInRect(PutRight(DiaryTabX[n])-X, abs(DiaryTabY3[n])-Y, -9,-19,9,19))) GotoDiaryPage(DiaryTabIndex[n]) ;
  } 	  
 } 

 if (PointInRect(X,Y,4,306,3+85,306+79)) GotoDiaryPage(DiaryInv.Page - 1) ;
 if (PointInRect(X,Y,554,309,554+86,309+67)) GotoDiaryPage(DiaryInv.Page + 1) ;
} 

script GotoDiaryPage(P) {
 if ((P >= 0) and (P < MAXPAGES)) { 
  DiaryInv.Page = P ;
  //start soundBoxPlay(Music::Pageturn_wav) ;
 }
} 

script PointInRect(x,y,x1,y1,x2,y2) {
 return (x >= x1) and (x <= x2) and (y >= y1) and (y <= y2) ;
}

script PutLeft(X) {
 int offset = X - BookCenterX ;
 if (offset > 0) X = BookCenterX - Offset ;
 return X ;
} 

script PutRight(X) {
 int offset = X - BookCenterX ;
 if (offset < 0) X = BookCenterX - Offset ;
 return X ;
} 

script drawDiaryPage(P) {
 int Line = 0 ;
 switch P {
	 
  case 0 : 
   drawingJustify = 0 ;
   line = 50 + WrapText("EINGANSRAUM",240) ;
   drawWrappedText(62,line) ;
   line = 10 + Line + WrapText("Auf den ersten Blick sieht das hier kaum wie ein Geb#ude der ECHNATON-Epoche aus. Die W#nde und S#ulen sind voll mit Kartuschen und Symbolen vieler anderer G[tter. Sonst lie} ECHNATON alle Kartuschen der ''falschen'' G[tter ausmei}eln, um ihnen so die Macht zu nehmen. (Idee: Tarnung bzw. zum Schutz vor der AMUN- Priesterschaft?) Auf dem Boden befinden sich zudem Platten mit verschiedenen Symbolen darauf, deren Sinn ich bis jetzt noch nicht entschl]sseln konnte.",240) ;
   drawWrappedText(62,line) ;
   line = 75 + WrapText("Eine Inschrift scheint den Besucher zu begr]}en:",240) ;
   drawWrappedText(335,line) ;   
   line = 10 + Line + WrapText("WILLKOMMEN, EINZIGER DIENER DES WAHREN GOTTES. NUR WER IN DEINEN FUSSSTAPFEN GEHT, WIRD ERLEUCHTET WERDEN UND DAS EINE LICHT SEHEN.",240) ;
   drawWrappedText(335,line) ;
   
  case 1: 
   drawingJustify = 0 ;
   line = 50 + Line + WrapText("RAUM DES ANUBIS",240) ;
   drawWrappedText(62,line) ;
   line = 15 + Line + WrapText("Die Statue in der zweiten Kammer stellt laut den Kartuschen am Sockel anscheinend ANUBIS dar. Zwischen den F]}en der Statue habe ich den einzigen Hinweis entdeckt, der auf ECHNATON hinweist: Ein kleiner Einlass, der wohl ATON darstellt. Zu welchem Zweck?",240) ;
   drawWrappedText(62,line) ;
   line = 10 + line + WrapText("Auf dem Halsband des ANUBIS befindet sich eine weitere Inschrift:",240) ;
   drawWrappedText(62,line) ;
   line = 10 + line + WrapText("DER WAHRE GOTT HAT DIE MACHT {BER DEN TOD.",230) ;
   drawWrappedText(70,line) ;
   line = 10 + line + WrapText("ER IST ES, DER LEBEN GIBT UND NIMMT.",230) ;
   drawWrappedText(70,line) ;
   line = 50 + WrapText("ER L@SST DIE PFLANZEN GEDEIHEN UND WIEDER VERGEHEN.",230) ;
   drawWrappedText(343,line) ;
   line = 10 + line + WrapText("DAS OPFER SOLL ZUM ZEUGNIS SEINER MACHT WERDEN.",230) ;
   drawWrappedText(343,line) ;
   line = 15 + line + WrapText("Die Inschriften am Sockel sagen:", 240) ;
   drawWrappedText(335,line) ;
   line = 10 + line + WrapText("NUR WER DEN NAMEN DES EINEN, WAHREN GOTTES KENNT, WIRD DAS LICHT SCHAUEN.",230) ;
   drawWrappedText(343,line) ;
   line = 10 + line + WrapText("DIE NAMEN DER FALSCHEN G|TTER F{HREN JEDOCH ZUM SICHEREN TOD.",230) ;
   drawWrappedText(343,line) ;
   line = 15 + line + WrapText("Was wohl damit gemeint ist?",240) ;
   drawWrappedText(335,line) ;   
   line = 10 + Line + WrapText("Uns wurde ausdr]cklich verboten, die Statue zu ber]hren.",240) ;
   drawWrappedText(335,line) ;
    
  case 2:
   drawingJustify = 0 ;	  
   line = 50 +  WrapText("Anscheinend hatte einer meiner Kollegen einen Unfall, als er sie bewegen wollte. Neben der Statue ist ein Durchgang, der vielleicht einmal von der Statue versperrt wurde. Kratzspuren am Boden weisen ebenfalls darauf hin.",240) ;	
   drawWrappedText(62,line) ;   
   line = 50 + WrapText("ANUBIS", 240) ;
   drawImage(515,45,Graphics::Anubis_image) ;
   drawWrappedText(335,line) ;   
   line = 10 + line + WrapText("ANUBIS ist die Gottheit der Totenriten. Er wird meist als Hund oder Schakal dargestellt.",240) ;
   drawWrappedText(335,line) ;   
   line = 10 + line + WrapText("Er ]berwachte die Einbalsamierer und Mumifizierer bei ihrer Arbeit.",240) ;
   drawWrappedText(335,line) ;   
   drawImage(400,160,Graphics::AnubisDiary_image) ;

  case 3: 
   drawingJustify = 0 ;
   line = 50 + WrapText("KRISTALLRAUM",240) ;
   drawWrappedText(62,line) ;
   line = 10 + Line + WrapText("Der Raum ist zw[lfeckig, mit Hieroglyphen an jeder Wandfl#che und einem zentralen, drehbaren (?) Sockel auf welchem sich anscheinend der Kristall befunden hatte. Ein leises, vibrierendes Summen durchdringt den ganzen Raum, und der Raum scheint von selbst zu leuchten. Der Sockel, auf dem sich der Kristall befand, ist aus einem metallischen Material.",240) ;
   drawWrappedText(62,line) ;
   line = 10 + Line + WrapText("An der Decke sind Kratzspuren zu erkennen, vielleicht von einer Klappe die ab und an [ffnet, wom[glich damit der Kristall",240) ;
   drawWrappedText(62,line) ;  
   line = 50 + WrapText("Sonnenlicht und damit Energie tanken kann. Dies entnehme ich einer Inschrift, die ich an der Decke gefunden habe: ''AN JEDEM MORGEN DURCHFLUTET DIE G|TTLICHE KRAFT DEN RAUM AUF GLEICHE WEISE, WENN DIE STUNDE IM HOF DES ERSTEN SONNENLICHTS, DIE MINUTE IM HOF DES LETZTEN SONNENSTRAHLS VERWEILT.''",240) ;
   drawWrappedText(335,line) ;
   line = Line + 10 + WrapText("Was genau mit ''Hof des ersten Sonnenlichts'' gemeint ist, konnte ich nicht herausfinden. Allerdings kann man ''Hof'' auch mit ''Geb#ude'' oder einfach ''Haus'' ]bersetzen. Ich denke au}erdem, dass das ''erste Sonnenlicht'' die Morgensonne ist.''",240) ;
   drawWrappedText(335,line) ;

  case 4: 
   drawingJustify = 0 ;
   line = 50 + WrapText("Der Mechanismus, der die Klappe [ffnet, ist wahrscheinlich ein riesiges Uhrwerk, angetrieben von der Energie des Kristalls. Die Technik dahinter mag der 'Uhr der Sonne' auf einem Platz vor dem gro}en Aton-Tempel in Achet-Aton #hneln.",240) ;
   drawWrappedText(62,line) ; 
   line = 50 + WrapText("Eine andere Inschrift warnt au}erdem: Nur der ''Priester/Diener der Sonne'' ist berechtigt, den Raum des Kristalls zu betreten.",240) ;
   drawWrappedText(335,line) ;
   
  case 5: 
   drawingJustify = 0 ;
   line = 50 + WrapText("ECHNATON",240) ;
   drawWrappedText(62,line) ;
   line = 25 + Line + WrapText("(eigentlich AMENOPHIS IV)",240) ;
   drawWrappedText(62,line) ;
   drawImage(160,48,Graphics::Echnatonkartusche_image) ;
   line = 10 + Line + WrapText("Pharao des alten #gyptens, neues Reich, 18. Dynastie, Sohn von AMENOPHIS III.",240) ;
   drawWrappedText(62,line) ;
   line = 10 + Line + WrapText("Wandte sich vom vorherr- schenden AMUN-Kult (AMUN-RE: ''Hauptgott'' der #gyptischen Mythologie, personifizierter Sonnengott) ab und setzte Aton (Sonnenscheibe / Sonnenenergie) als oberste Gottheit ein. Er begr]ndete somit die erste monotheistische Religion schon im 14.ten Jahrhundert vor Christus!",240) ;
   drawWrappedText(62,line) ;
   line = 50 + WrapText("In den folgenden Jahren gab ECHNATON seiner Lehre einen immer auschlie}licheren Charakter, er ging in dieser {berzeugung soweit, dass er in Tempeln den Namen und die Gestalt des Gottes Amun und anderer G[tter ausmei}eln lie}.",240) ;
   drawWrappedText(335,line) ;	
   line = 10 + Line + WrapText("Die bisherige Hauptstadt THEBEN (das heutige Luxor) verl#}t er u.a. aufgrund schwerwiegender Differenzen mit der Amun- priesterschaft, und gr]ndet in Mittel#gypten seine neue Hauptstadt ''ACHET-ATON'', eine Stadt die ganz auf die Sonne ausgerichtet ist. (heute el-Armana, ein abgelegener Ort in @gypten).",240) ;
   drawWrappedText(335,line) ;	 
   
  case 6: 
   drawingJustify = 0 ;
   line = 50 + WrapText("Der besondere Charakter dieser Stadt zeigt sich auch in der sog. ''Armana-Kunst'' die (im Gegensatz zu den verherrlichenden Darstellungen der ''alten'' Pharaonen) ECHNATON und NOFRETETE naturalistisch darstellen.",240) ;
   drawWrappedText(62,line) ;
   drawImage(65,170,Graphics::AmenophisIV_image) ;
   line = 50 + WrapText("DIE ZEIT NACH ECHNATON",240) ;
   drawWrappedText(335,line) ;	
   line = 10 + Line + WrapText("Nach ECHNATONS Tod ergreift die zur]ckgetriebene AMUN-Priesterschaft erneut die Vorherrschaft und versucht die Epoche ECHNATON aus der Geschichte zu tilgen, nur Weniges bleibt erhalten.",240) ;
   drawWrappedText(335,line) ;	 
   line = 10 + Line + WrapText("Die Geb#ude und Tempel von ACHET-ATON werden abgetragen und zum Bau neuer Kultst#tten verwendet. ECHNATONS loyale Gefolgschaft flieht (wahrscheinlich mit seiner Mumie) aus ACHET-ATON",240) ;
   drawWrappedText(335,line) ;	 
    
   case 7 : 
    drawingJustify = 0 ;
    line = 50 + WrapText("ECHNATONS VERM#CHTNIS",240) ;
    drawWrappedText(62,line) ;
    line = 10 + Line + WrapText("]ber ECHNATONS Verm#chtnis bleiben einige Fragen offen. Wohin zog sich ECHNATONS Gefolgschaft zur]ck? Was ist mit seinem Leichnam geschehen?",240) ;
    drawWrappedText(62,line) ;
    line = 10 + Line + WrapText("K[nnte dieser Tempel ECHNATONS letzte Ruhest#tte sein? Warum dann die Namen der vielen anderen G[tter? Vielleicht zum Schutz vor der AMUN-Priesterschaft?",240) ;
    drawWrappedText(62,line) ;
    
   case 8 : 
    drawingJustify = 0 ;
    line = 50 + WrapText("ACHET-ATON (Tell el-Armana)",240) ;
    drawWrappedText(62,line) ;
    line = 10 + Line + WrapText("Hierzu ist ]berliefert:",240) ; drawWrappedText(62,line) ;
    line = 10 + Line + WrapText("''... ATON, mein Vater, zeigte darauf, da} man es ihm als ACHET-ATON (da) errichtete! Schaut, Pharao sp]rte es auf! ...",240) ; drawWrappedText(62,line) ;
    line = 8 + Line + WrapText("...Schaut, Pharao sp]rte es auf!",240) ; drawWrappedText(62,line) ;
    line = 5 + Line + WrapText("Nicht geh[rt es einem Gott,",240) ; drawWrappedText(62,line) ;
    line = 5 + Line + WrapText("nicht geh[rt es einer G[ttin, ",240) ; drawWrappedText(62,line) ;
    line = 5 + Line + WrapText("nicht geh[rt es einem Herrscher, ",240) ; drawWrappedText(62,line) ;
    line = 5 + Line + WrapText("nicht geh[rt es einer Herrscherin, ",240) ; drawWrappedText(62,line) ;
    line = 5 + Line + WrapText("nicht geh[rt es irgendeinem Beamten oder irgendeinem Menschen, um Anspruch darauf geltend zu machen! ...''",240) ; drawWrappedText(62,line) ;
    line = 50 + WrapText("Was ist ''es''? Spricht er von der Energiequelle oder von der Stadt?",240) ; drawWrappedText(335,line) ;
    drawImage(335, Line+10,Graphics::Karte_image) ;

   case 9:  
    drawingJustify = 0 ;
    drawImage(80,80,Graphics::Tempelbezirk_image) ;
    line = 50 + WrapText("DER TEMPELBEZIRK ACHET-ATONS",240) ; drawWrappedText(62,line) ;
    line = 300 + WrapText("1 - Gro}er Aton-Tempel ",240) ; drawWrappedText(62,line) ;
    line = 50 + WrapText("2 - Altarraum ",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("3 - Schlachthof ",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("4 - Haus des Jubels ",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("5 - K[nigsstra}e, ",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("6 - Kleiner Aton-Tempel",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("7 - Truppenunterk]nfte",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("9 - Staatsarchiv",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("10 - Wohnhaus des K[nigs",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("11 - Waren-Magazin",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("12 - Vorratsh#user",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("13 - Haus des obersten Tempeldieners",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("14 - M]llhalde des Palasts",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("15 - Palast",240) ; drawWrappedText(335,line) ;
    line = 4 + Line + WrapText("16 - Gro}e S#ulen-Halle",240) ; drawWrappedText(335,line) ;    
   
   case 10:
    drawingJustify = 0 ;
    line = 50 + WrapText("DIE PFORTEN VON ACHET-ATON",240) ;
    drawWrappedText(62,line) ;
    line = 10 + Line + WrapText("Mit einer komplizierten Konstruktion wurden in ACHET-ATON jeden morgen vollautomatisch die Pforten ge[ffnet und abends wieder geschlossen. Dabei wurde ausgenutzt, dass Wasser in einem Gef#} verdunstete, sobald die Sonne schien.",240) ;
    drawWrappedText(62,line) ;	 
    line = 50 + WrapText("DIE 'UHR DER SONNE'",240) ;
    drawWrappedText(335,line) ;   
    line = 10 + Line + WrapText("Auf einem Platz vor dem gro}en Aton-Tempel im Tempelbezirk ACHET-ATONS befand sich ein gro}es, mechanischess Uhrwerk. Dieses unterteilte den Tag in 12 Stunden mit jeweils 12 Minuten, was 10-Minuten-Schritten in unserer Zeitrechnung entspricht. Statt Ziffern kennzeichneten einige Hieroglyphen, die f]r Geb#ude des Tempelbezirks standen, die unterschiedlichen Stunden. Einige konnte ich ]bersetzen:",240) ;
    drawWrappedText(335,line) ;	
   
   case 11:  
    drawingJustify = 0 ;
    line = 85 ; 
    int h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,0) ; int h2 = WrapText("Sonnenscheibe, Gro}er Aton-Tempel",236) ; 
    drawSprite(70 ,line - h1,graphics::hieroglyphen_sprite,0) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 25 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,8) ; h2 = WrapText("Sonnenaufgang, Altarraum",236) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,8) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 30 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,9) ; h2 = WrapText("Pfeilspitze, Schlachthof",236) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,9) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 20 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,10) ; h2 = WrapText("Hausgrundriss, Haus des Jubels",200) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,10) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 35 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,11) ; h2 = WrapText("Bein, K[nigsstra}e",236) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,11) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 20 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,12) ; h2 = WrapText("Brotleib, kleiner Aton-Tempel",236) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,12) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 25 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,13) ; h2 = WrapText("Unterarm, Polizeiunterkunft",236) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,13) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 25 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,14) ; h2 = WrapText("L[we, Truppenunterk]nfte",236) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,14) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 25 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,15) ; h2 = WrapText("Hof, Staatsarchiv",236) ; 
    drawSprite(70,line - h1,graphics::hieroglyphen_sprite,15) ; drawWrappedText(100,line - h1/2 + h2/2) ; Line = Line + 25 ;
    line = 85 ; 
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,1) ; h2 = WrapText("Hand, Wohnhaus des K[nigs",236) ; 
    drawSprite(335,line - h1,graphics::hieroglyphen_sprite,1) ; drawWrappedText(365,line - h1/2 + h2/2) ; Line = Line + 25 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,2) ; h2 = WrapText("Korb, Waren-Magazin",236) ; 
    drawSprite(335,line - h1,graphics::hieroglyphen_sprite,2) ; drawWrappedText(365,line - h1/2 + h2/2) ; Line = Line + 25 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,3) ; h2 = WrapText("Fisch, Vorratsh#user",236) ; 
    drawSprite(335,line - h1,graphics::hieroglyphen_sprite,3) ; drawWrappedText(365,line - h1/2 + h2/2) ; Line = Line + 30 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,4) ; h2 = WrapText("Schachbrett, Haus des obersten Tempeldieners",236) ; 
    drawSprite(335,line - h1,graphics::hieroglyphen_sprite,4) ; drawWrappedText(365,line - h1/2 + h2/2) ; Line = Line + 38 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,5) ; h2 = WrapText("Skarab#us, M]llhalde des Palastes",236) ; 
    drawSprite(335,line - h1,graphics::hieroglyphen_sprite,5) ; drawWrappedText(365,line - h1/2 + h2/2) ; Line = Line + 18 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,6) ; h2 = WrapText("Auge, Palast",236) ; 
    drawSprite(335,line - h1,graphics::hieroglyphen_sprite,6) ; drawWrappedText(365,line - h1/2 + h2/2) ; Line = Line + 27 ;
    h1 = GetSpriteFrameHeight(graphics::hieroglyphen_sprite,7) ; h2 = WrapText("Stern, gro}e S#ulen-Halle",236) ; 
    drawSprite(335,line - h1,graphics::hieroglyphen_sprite,7) ; drawWrappedText(365,line - h1/2 + h2/2) ; Line = Line + 25 ;
   
   case 12 : 
    drawingJustify = 0 ;
    line = 50 + WrapText("ATON",240) ;
    drawWrappedText(62,line) ;
    drawImage(95,48,graphics::aton_image) ;
    drawImage(240,48,graphics::atonkartusche_image) ;
    line = 115 + WrapText("Sonnengott, im Gegensatz zu RA/AMUN-RE aber nicht als Personifizierung in Menschengestalt. ATON ist die Sonnenscheibe selbst, sozusagen die Leben spendende Energie der Sonne. Von Echnaton aus dem Nichts zum alleinigen Hauptgott erhoben. Der einzige wirkliche ''Priester'' des ATON war Echnaton selbst.",240) ;
    drawWrappedText(61,line) ;
    line = 50 + WrapText("AMUN-RE",240) ;
    drawWrappedText(335,line) ;
    line = 10+ line +WrapText("Pharaonen nannten sich seit der vierten Dynastie alle ''Sohn des Re'' (au}er nat]rlich ECHNATON). Sp#ter wurde AMUN mit RE zum Hauptgott AMUN-RE verschmolzen.",240) ;
    drawWrappedText(335,line) ;
    line = 35 + Line + WrapText("NOFRETETE",240) ;
    drawWrappedText(335,line) ;
    line = 10 + Line + WrapText("Frau von ECHNATON, oft",240) ;
    drawWrappedText(335,line) ; 
    line = Line +  WrapText("mit ECHNATON zusammen dargestellt. Hatte als Frau wohl eine sehr starken Einfluss auf ECHNATON. {ber ihren Tod gibt es #hnlich wie ]ber den Tod ihres Mannes mehrere Theorien.",240) ;
    drawWrappedText(335,line) ; 
    drawImage(500,140,graphics::Nofretete_image) ;
	 
 }   
} 