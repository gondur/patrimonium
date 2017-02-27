// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// Random.s - random stuff 
// ----------------------------------
 
script initRandom {
 int k = 0;
 int p = 0;
 while (k < 9) {
  TelNums[k] = 0 ;
  for (int i=0; i < MaxTelLen; i++) { TelNums[k] = TelNums[k] + Random(10) * pot(10,i) ; }
  for (i = 0; i < k; i++) { if ((TelNums[i] == TelNums[k]) or (TelNums[i] == 345823)) { p = 1; } }
  if (p == 0) k++ ; 
 } 
 surizaPuzzle = random(4) ;
 deviceMode = random(6) ;
 keycardPos = random(3) ;
}