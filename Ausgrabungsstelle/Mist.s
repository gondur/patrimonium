// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// Mist.s - adapted from AGAST demo
//          game
// ----------------------------------


script initMist(initPositionX, initPositionY, initPriority) {
  positionX = initPositionX ;
  positionY = initPositionY ;
  priority = initPriority ;
  visible = true ;
  setAnim(Mist_image) ;
}

object Mist1 {
  initMist(0, 0, 40) ;
  moveMist ;
}

object Mist2 {
  initMist(799, 0, 40) ;
}

object Mist3 {
  initMist(0, -120, 70) ;
}

object Mist4 {
  initMist(799, -120, 70)  ;
}

script moveMist {
  start {
    loop {
      Mist1: PositionX = PositionX - 1;
      Mist2: PositionX = PositionX - 1;
      if (Mist2.PositionX <= 0) {
	Mist1.PositionX = 0;
	Mist2.PositionX = 799;
      }
      delay ;
    }
  }
  start {
    loop {
      Mist3: PositionX = PositionX - 4;
      Mist4: PositionX = PositionX - 4;
      if (Mist4.PositionX <= 0) {
        Mist3.PositionX = 0;
        Mist4.PositionX = 799;
      }
      delay ;
    }
  }
}





