// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------


var firstEnter = true ;

event enter {
 if (firstEnter) backgroundImage = null ; 
  else {
    if (endChoice == 1) backgroundImage = Quote1_image ;
     else backGroundImage = Quote2_image ;
  }
 backgroundZBuffer = null ;
 transitionTime = 70 ;
 
 Ego.reflection = false ;
 Ego.enabled = false ;
 Ego.visible = false ;
 Peter.enabled = false ;
 Peter.visible = false ;
  
 forceHideInventory ;
 Darkbar.enabled = false ;
 
 delay transitionTime ;
 delay 20 ;
 
 if (firstEnter) {
   firstEnter = false ;
   doEnter(Finaleende) ;
   return ;
 }
 
  
  
 delay 450 ;
 
 doEnter(Credits) ;
  

}
