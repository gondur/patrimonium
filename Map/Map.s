// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

event enter {
 
 scrollX = 0 ;
 backgroundImage = Map_image ;
 backgroundZBuffer = 0 ;
 Ego.enabled = false ;
 forceHideInventory ; 
 darkbar.enabled = false ;
 
 if (currentAct<=2) {
   delay 20 ;
   soundBoxStart(Music::Airplane_wav) ;
   delay 30 ;
   Stimme: "Sie k[nnen doch nicht einfach die Gep#ckf#cher der G#ste [ffnen, Herr Hobler!" ;
   while (Flugzeug.CurNode < 1) delay(1) ;
   delay(100) ;
   Stimme: "WER HAT DAS EI IN DIE MIKROWELLE GETAN?" ;
 } else {
   delay 20 ;
   soundBoxStart(Music::Airplane_wav) ;
   delay 30 ;
   Stimme: "Herr Hobler, Sie bleiben sitzen!"
   delay 10 ;
   Stimme: "Und es ist mir egal ob Sie auf die Toilette m]ssen!"
 }
 
 while (Flugzeug.CurNode < 2) delay(1) ;
 delay 23 ;
 if (currentAct==1) doEnter(Chefbuero) ;
  else doEnter(Finaledavor) ;
}

object Flugzeug {
 name = "Flugzeug" ;
 enabled = true ;
 visible = true ;
 clickable = true ;  
 MarkResource(Flugzeug_image) ;
 FormatAsRouteMovingObject(Flugzeug) ;
 clearNodes ;
 if (currentAct == 1) {
   addNode(107,023) ;
   addNode(506,206) ;
   addNode(513,458) ;
 } else {
   addNode(513,458) ;	 
   addNode(113,180) ;
   addNode(004,135) ;
 }
 scale = 450 ;
 drawOverlay = -1 ;
 MoveSpeed = 2.0 ;
 TurnSpeed = 4.0 ; 
 Moving = true ; 
} 

event paint Flugzeug {
  drawRotatedImage(Flugzeug_image,PositionX,PositionY,scale,256,floatsub(floatmul(2.0,FLOAT_PI),FloatMul(FloatDiv(CurAngle,180.0),FLOAT_PI))) ;	
}

object Stimme {
 positionX = 320 ;
 positionY = 40 ;
 captionY = 30 ;
 captionX = 10 ;
 captionWidth = 620 ;
}

