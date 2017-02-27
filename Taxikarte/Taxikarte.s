// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

var dir ;

event enter {
	
  backgroundImage = Graphics::Kairo_image ;
  backgroundZBuffer = 0 ;
  Ego:
   path = 0 ;
   setPosition(320,290) ;
   enabled = false ;
   
  forceHideInventory ;
  Darkbar.enabled = false ;

  dir = random(2) ;

  delay transitionTime ;
  
  switch random(3) {
    case 0: Taxi.say("Wo soll's denn hingehen, Effendi?") ;
    case 1: Taxi.say("Wo m[chten Sie hin, Effendi?") ;
    default: Taxi.say("Wohin soll's gehen, Effendi?") ;	    
  }
  
  resume ;
  
}

/* ************************************************************* */

object Taxi {
 setPosition(320,240) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ; 
 captionColor = COLOR_TAXIFAHRER ;
}

/* ************************************************************* */

object Wolke {
 setPosition(random(600)+20,10) ;
 setAnim(Wolke_image) ;
 absolute = false ;
 clickable = false ;
 enabled = true ;
 visible = true ;
 priority = 5 ;
}

event animate wolke {
 if (abs(wolke.positionX) < 1000) {
   if (dir) Wolke.positionX++ ;
    else Wolke.positionX-- ;
 }
}

/* ************************************************************* */

object airport {
 visible = false ;
 enabled = true ;
 absolute = false ;
 clickable = true ;
 setClickArea(491,1,612,90) ;
}

object flugG {
 setPosition(493,0) ;
 setAnim(Flughafen_sprite) ;
 enabled = true ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 priority = 2 ;
 frame = 0 ;
 autoAnimate = false ;
}

event animate flugG { if (mouseIn(491,1,612,90) and (!suspended)) flugG.frame = 1 ; else flugG.frame = 0 ; }


event default -> airport { doEnter(Vorflughafen) ;  Ego.enabled = true ; }

/* ************************************************************* */

object hotel {
 visible = false ;
 enabled = knowsHotel ;
 absolute = false ;
 clickable = true ;
 setClickArea(382,93,435,158) ;
}

object hotelG {
 setPosition(372,105) ;
 setAnim(Hotel_sprite) ;
 enabled = knowsHotel ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 priority = 2 ;
 frame = 0 ;
 autoAnimate = false ;
}

event animate hotelG { if (mouseIn(382,93,435,158) and (!suspended)) hotelG.frame = 1 ; else hotelG.frame = 0 ; }

event default -> hotel { doEnter(Vorhotel) ; Ego.enabled = true ; }

/* ************************************************************* */

object azhar {
 visible = false ;
 enabled = knowsDott ;
 absolute = false ;
 clickable = true ;
 setClickArea(139,14,246,102) ; 
}

object azharG {
 setPosition(144,15) ;
 setAnim(Labor_sprite) ;
 enabled = knowsDott ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 priority = 2 ;
 frame = 0 ;
 autoAnimate = false ;
}

event animate azharG { if (mouseIn(139,14,246,102) and (!suspended)) azharG.frame = 1 ; else azharG.frame = 0 ; }

event default -> azhar { doEnter(Dott) ; Ego.enabled = true ; }

/* ************************************************************* */

object samtec {
 visible = false ;
 enabled = knowsHeadquarters ;
 absolute = false ;
 clickable = true ;
 setClickArea(400,259,478,338) ;
}

object samtecG {
 setPosition(405,262) ;
 setAnim(SamTec_sprite) ;
 enabled = knowsHeadquarters ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 priority = 2 ;
 frame = 0 ;
 autoAnimate = false ;
}

event animate samtecG { if (mouseIn(400,259,478,338) and (!suspended)) samtecG.frame = 1 ; else samtecG.frame = 0 ; }


event default -> samtec { doEnter(VorSamtec) ; Ego.enabled = true ; }

/* ************************************************************* */

object truckverleih {
 visible = false ;
 enabled = knowsExcavation ;
 absolute = false ;
 clickable = true ;
 setClickArea(57,181,167,262) ;
}

object truckG {
 setPosition(56,181) ;
 setAnim(Truck_sprite) ;
 enabled = knowsExcavation ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 priority = 2 ;
 frame = 0 ;
 autoAnimate = false ;
}

event animate truckG { if (mouseIn(57,181,167,262) and (!suspended)) truckG.frame = 1 ; else truckG.frame = 0 ; }

event default -> truckverleih { doEnter(truck) ; Ego.enabled = true ; }

/* ************************************************************* */

object ausgrabungs {
 visible = false ;
 enabled = knowsExcavation ;
 absolute = false ;
 clickable = true ;
 setClickArea(139,273,246,365) ;
}   

object ausgrabungG {
 setPosition(139,274) ;
 setAnim(Ausgrabung_sprite) ;
 enabled = knowsExcavation ;
 visible = true ;
 clickable = false ;
 absolute = false ;
 priority = 2 ;
 frame = 0 ;
 autoAnimate = false ;
}

event animate ausgrabungG { if (mouseIn(139,273,246,365) and (!suspended)) ausgrabungG.frame = 1 ; else ausgrabungG.frame = 0 ; }
  
event default -> ausgrabungs { 
  Taxi:
   "Ich kann mit meinem Taxi nicht quer durch die W]ste fahren."
   "Da brauchen Sie schon ein gr[}eres Gef#hrt."	
  resume ;
}