// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var MasterVolume = 255 ;

/* ************************************************************* */

object jukeBox_LoadedResources ;

/* ************************************************************* */

object jukeBox { 
 enabled = true ; 
 visible = false ; 
 visible = true ;
 clickable = false ; 
 SoundVolume = VOLUME_FULL ;
 SoundPan = PAN_STEREO ;
 member running = false ;
 member shuffle = true ;
 member current = -1 ; 
 member next = -1 ;
 member curRes = -1 ;
} 

script SetupjukeBox {
 setupAsContainer(jukeBox) ;
 setupAsContainer(jukeBox_LoadedResources) ;
}     

script jukeBox_Shuffle(sshuffle) { jukeBox.shuffle = sshuffle ; } 

script jukeBox_AddIn(res, ticks) {
 //if (jukeBox.running) 
 jukeBox_FadeOut(ticks) ;
 jukeBox_Enqueue(res) ;
 jukeBox_Start ; 
 jukeBox.shuffle = false ;
}

script jukeBox_Fadeout(ticks) {
  int dec = floatCeiling(floatDiv(intToFloat(soundMasterVolume), intToFloat(ticks))) ;
  for (int i = 0 ; i < ticks ; i++) {
    soundMasterVolume -= dec ;
    delay 1 ;
  }
  soundMasterVolume = 0 ;
  jukeBox_Stop ;
  soundMasterVolume = VOLUME_FULL ;
}
	  
script jukeBox_Stop {      
 if (jukeBox.Current < 0) return ;
 UnmarkAllButRunning ;
 StopAllMusic; 
 UnMarkResource(jukeBox.curRes); 
 jukeBox.current = -1 ; 
 jukeBox.curRes = -1 ;  
 jukeBox.running = false ;
 soundMasterVolume = VOLUME_FULL ;
 resetContainer(jukeBox) ;
} 

script jukeBox_Start { jukeBox.Running = true ; }

script jukeBox_Enqueue(SoundRes) { 
 if (!isInsideContainer(jukeBox,SoundRes)) { 
   addToContainer(jukeBox, SoundRes) ; 
   markResource(SoundRes) ; 
 } 
 return GetContainerSize(jukeBox)-1; 	
}
 
script GetDuration(Res) {
 var dur = 0 ;
 if (Res == Music::BG_Theme_mp3 )       dur =  109000 ;
 if (Res == Music::BG_Brander_mp3 )     dur =  50400 ;	 
 
 if (Res == Music::BG_Menu_ogg )        dur =  39000 ;
	 
 if (Res == Music::BG_Fuell1_mp3 )      dur =  55000 ;
 if (Res == Music::BG_Fuell2_mp3 )      dur =  49000 ;
 if (Res == Music::BG_Fuell3_mp3 )      dur =  30500 ;
 if (Res == Music::BG_Fuell4_mp3 )      dur =  43000 ;	 
 if (Res == Music::BG_Fuell5_mp3 )      dur =  26871 ;	 	 
 if (Res == Music::BG_Fuell6_mp3 )      dur =  31170 ;	 
 
 if (Res == Music::BG_Fuell8_mp3 )      dur =  32611 ;
 if (Res == Music::BG_Fuell9_mp3)       dur =  13583 ;	 	 //76
	 
 if (Res == Music::BG_Grab1_ogg )       dur =  72000;
 if (Res == Music::BG_Grab2_ogg )       dur =  72000 ;
 if (Res == Music::BG_Grab3_mp3 )       dur =  98500 ; 
 if (Res == Music::BG_Dott_mp3)         dur =  217000 ;
 if (Res == Music::BG_Vorflughafen_ogg) dur =  79800 ;
 if (Res == Music::BG_Hotel_ogg)        dur =  70000 ;
 if (Res == Music::BG_SamTec_mp3)       dur =  94900 ;	 
 if (Res == Music::BG_Bad_mp3)		dur =  71500 ;
 if (Res == Music::BG_Barnett_mp3)      dur =  76500 ;
 if (Res == Music::BG_Mystic_mp3 )      dur =  49500 ;	 	 	 	 	 	 	 
	 
 if (Res == Music::BG_Short1_mp3)       dur =  4231 ;	 	 	 
 if (Res == Music::BG_Short2_mp3)       dur =  5295 ;	 	 	 
 if (Res == Music::BG_Short3_mp3)       dur =  9978 ;	 	 	 
 if (Res == Music::BG_Short4_mp3)       dur =  11412 ;	 	 
 if (Res == Music::BG_Short7_mp3)       dur =  7805 ;	 	 
 if (Res == Music::BG_Short8_mp3)       dur =  5196 ;	 	 	  
 
 
 if (Res == Music::BG_Dwin_mp3)         dur =  7846 ;	 
 if (Res == Music::BG_Dlose1_mp3)       dur =  5221 ;	 
 if (Res == Music::BG_Dlose2_mp3)       dur =  5183 ;	 	 
 if (Res == Music::BG_Dlose3_mp3)       dur =  4622 ;	 	 	 
 if (Res == Music::BG_Dlose4_mp3)       dur =  3362 ;	 	 	 	 
 if (Res == Music::BG_Dlose5_mp3)       dur =  4340 ;	 	 	 	 	 
	 
 if (Res == Music::BG_Ende_mp3)         dur =  90000 ;	 	 
	 
 if (Res == Music::BG_Ambush_mp3)       dur =  41500 ;	 	 
 if (Res == Music::BG_Action_mp3)       dur =  49500 ;	 	 	 
 if (Res == Music::BG_Desertcity_mp3)   dur =  88500 ;	 	 	 	  
 if (Res == Music::BG_Fuell7_mp3)       dur =  7500 ;
 if (Res == Music::BG_Interloper_mp3)   dur =  261500 ;	 
 if (Res == Music::BG_Rounddrums_mp3)   dur =  52500 ;	 	 
 if (Res == Music::BG_Smokinggun_mp3)   dur =  187500 ;	 	 	 
	 
 if (Res == Music::BG_Gustavsting_mp3)    dur =  10400 ;	 	 	 	 
 if (Res == Music::BG_Serpentinetrek_mp3) dur =  104700 ;	 	 	 	 	  
 if (Res == Music::BG_TheReveal_mp3)      dur =  57500 ;	 	 	 	 	 	 	 
	 
 if (res == Music::BG_Alchemist_mp3)  dur = 56500 ;	 
 if (res == Music::BG_Homebase_mp3)   dur = 21750 ;	 
 if (res == Music::BG_JustAsSoon_mp3) dur = 216000 ;	 
	 
 if (res == Music::BG_AmountOfEvil_mp3)  dur = 109500 ;	 	 
 if (res == Music::BG_FeralChase_mp3)    dur = 69500 ;	 	 	 	 
 if (res == Music::BG_ToTheEnds_mp3)     dur = 103500 ;	 	 	 
 if (res == Music::BG_LongNoteTwo_mp3)    dur = 501000 ;	 	 	 	 
 if (res == Music::BG_LongNoteOne_mp3)    dur = 439500 ;	 	 	 	 	 
 if (res == Music::BG_GraveBlow_mp3)    dur = 101500 ;	 	 	 	 	 	 
 if (res == Music::BG_Crisis_mp3)       dur = 85500 ;	 	 	 	 	 	 	 
 if (res == Music::BG_Dangerous_mp3)    dur = 57500 ;	 	 	 	 	 	 	 	 
 
 return dur ;
}
 
script Max(a,b) { if (a > b) { return a; } else { return b; } }
 
event paint jukeBox { jukeBox_Run ; } 
 
script jukeBox_Run {

 static int lastmusicpos = -1 ;
 if (!jukeBox.running) lastMusicPos = 0 ;
 int MusicPos = lastmusicpos ;
 var MusicFinished = true ;
 
 if (jukeBox.Current >= 0) {
   MusicPos = GetMusicPosition(jukeBox.CurRes) ;
   MusicFinished = (MusicPos >= GetDuration(jukeBox.CurRes)) ;
 }
 
 if (ShowDebugInfo) { // DEBUG
  drawingPriority = 255 ; 
  drawingColor=RGBA(250,50,50,230); 
  drawRectangle(20,10,20+FloatCeiling(FloatMul( FloatDiv(200.0,inttofloat(VOLUME_FULL) ),inttofloat(SoundMasterVolume))),35) ;
  var mystr2 ;
  stringPrint(mystr2, "%d", soundMasterVolume) ;
  
  drawText(20,35,"VOLUME") ;
  if (SoundMasterVolume == VOLUME_FULL) drawText(20,35,"VOLUME: FULL") ;
	   else drawText(120,35, mystr2) ;
  if (!MusicFinished) drawText(20,60,"PLAYING") ;
  if (lastmusicpos == MusicPos) drawText(20,90,"PAUSED") ;
  var mystr ;
  stringPrint(mystr, "CONTAINERSIZE %d", GetContainerSize(jukeBox)) ;
  drawtext(20,120, mystr) ;
  stringPrint(mystr, "MUSICPOS: %d / %d", musicpos, GetDuration(jukeBox.CurRes)) ;
  drawtext(20,150, mystr) ;
  stringClear(mystr) ;
 }

 return if (!jukeBox.running) ;

 if (MusicFinished) {
   
   int Count = GetContainerSize(jukeBox) ;
   if (!jukeBox.shuffle) jukeBox.running = false ;
   if (Count > 0) {
     StopAllMusic ;
     jukeBox.Current = (jukeBox.Current + 1) ;
     
     if (jukeBox.Current >= Count) jukeBox.Current = 0 ;
     
     jukeBox.CurRes = GetFromContainer(jukeBox,jukeBox.Current) ;
     StartMusic(jukeBox.CurRes) ;     
     
   }
 }
  
 lastMusicPos = musicPos ;
}

script UnmarkAllButRunning {
  for (int i=0; i<GetContainerSize(jukeBox); i++) {
    if (i != jukeBox.Current) UnmarkResource(GetFromContainer(jukeBox,i)) ;
  }
} 

script Mark(i) {
  if (isInsideContainer(jukeBox_LoadedResources,i)) return 0 ;
   else { 
     markResource(GetFromContainer(jukeBox,i)) ;
     addToContainer(jukeBox_LoadedResources,i) ; 
   }
} 

script Unmark(i) {
  if (!isInsideContainer(jukeBox_LoadedResources,i)) return 0 ;
  unMarkResource(GetFromContainer(jukeBox,i)) ;
  removeFromContainer(jukeBox_LoadedResources,i); 
} 

script unmarkAll {
  for (int i=0; i<GetContainerSize(jukeBox_LoadedResources); i++) { 
    unmarkResource(GetFromContainer(jukeBox,GetFromContainer(jukeBox_LoadedResources,i))) ;
  }
  resetContainer(jukeBox_LoadedResources) ;
} 

/* ************************************************************* */

script catchSecMusic {
 killOnExit = false ;
 jukeBox_Shuffle(false) ; 	
 jukeBox_Stop ;
 jukeBox_enqueue(Music::BG_Gustavsting_mp3) ;                     	  
 jukeBox_Start ;
 delay 2 ;
 jukeBox_Shuffle(false) ; 	
}

/* ************************************************************* */

object soundBox { 
 enabled = true ; 
 visible = false ; 
 clickable = false ; 
 //SoundVolume = MASTERVOLUME ;
 soundVolume = -255 ;
 SoundPan = PAN_STEREO ;
}  
 
script soundBoxPlay(SoundRes) {  
 markResource(SoundRes) ;
 soundBox.PlaySound(SoundRes) ; 
 unMarkResource(SoundRes) ;
}  
 
script soundBoxStart(SoundRes) { 
  start soundBoxPlay(SoundRes) ;
} 

script setsoundBoxVolume(vol) {
  soundBox.soundVolume = -vol ;
}
