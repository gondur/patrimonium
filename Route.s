// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
//   Route.s - Provides class for
//  objects moving along map routes
// ----------------------------------

const RON_MEMBERBASE = 20 ;

script FormatAsRouteMovingObject(Obj) {
 var ao = activeObject ;
 activeObject = Obj ;
 
 member MoveSpeed = floatdiv(1.0,20.0) ;
 member TurnSpeed = floatdiv(1.0,40.0) ;
 member LineColor = RGB(255,0,0) ;
 member NodeColor = RGB(255,0,0) ; 
 member LineRadius = 1 ;
 member NodeRadius = 4 ;
 
 member SourceX = 0 ;
 member SourceY = 0 ;
 member TargetX = 0 ;
 member TargetY = 0 ;
 member Moving = false ;
 member drawOverlay = -1 ;
 
 member CurAngle = 0.0 ;
 member CurStep  = 0.0 ;
 member CurNode  = 0 ;
 
 ObjectAnimationHandler = &RouteObject_AnimationHandler ;	
 activeObject = ao ;
}

script ClearNodes {
 int i = RON_MEMBERBASE ;
 while (GetField(i) != 0) { SetField(i,0); i++; }
 CurNode = 0 ;
}

script AddNode(X,Y) {
 int i = RON_MEMBERBASE ;
 while (GetField(i) != 0) { i++; }
 if (i == RON_MEMBERBASE) { setPosition(X,Y) ; SourceX = X; SourceY = Y; TargetX = X; TargetY = Y; }
 if (i == RON_MEMBERBASE+1) { CurAngle = GetLineAngleF(PositionX,PositionY,X,Y) ; TargetX = X; TargetY = Y; }
 SetField(i,Y*640+X) ;	
}

script TargetNextNode {
 int x = GetField(CurNode+RON_MEMBERBASE+1) ;
 if (x == 0) return 0 ;
	 
    //x = GetField(CurNode+RON_MEMBERBASE+1) ;
   //int v = SourceY*640+SourceX ;
   //if ((x != v) or (x == 0)) return 0 ;
	 
 TargetX = x % 640 ;
 TargetY = x / 640 ;	
}

script RouteObject_AnimationHandler {
 if (CurNode < 0) return 0 ;
 if (not Moving) return 0 ;
	 
 if ((TargetX == SourceX) and (TargetY == SourceY)) { TargetNextNode; return 0; }

 var DesiredAngle = GetLineAngleF(SourceX,SourceY,TargetX,TargetY) ;
 int x = 0 ;

 if FloatCompare(TurnSpeed,GetAngleDiffF(DesiredAngle,CurAngle)) {
   CurStep = FloatAdd(CurStep, MoveSpeed) ;
   x = GetLinePos(SourceX,SourceY,TargetX,TargetY, CurStep) ;
   PositionX = x % 640 ;
   PositionY = x / 640 ;
  } else {
   CurAngle = FloatAdd(CurAngle,FloatMul(GetAngleRotDirF(CurAngle,DesiredAngle),TurnSpeed)) ;
   if FloatCompare(TurnSpeed,GetAngleDiffF(DesiredAngle,CurAngle)) { CurAngle = DesiredAngle ; }   
  } 
  
 if (PositionX == TargetX) and (PositionY == TargetY) {
   SourceX = TargetX ;
   SourceY = TargetY ;
   CurStep = 0.0 ;
   
   x = GetField(CurNode+RON_MEMBERBASE+1) ;
   int v = SourceY*640+SourceX ;
   if ((x != v) or (x == 0)) return 0 ;
	 
   CurNode = CurNode + 1 ;
   TargetNextNode ;
 } 
}

script GetDistF(x1,y1,x2,y2) {
 return FloatSquareRoot( floatadd( floatmul(FloatSub(inttofloat(x1),inttofloat(x2)), FloatSub(inttofloat(x1),inttofloat(x2))), floatmul(FloatSub(inttofloat(y1),inttofloat(y2)), FloatSub(inttofloat(y1),inttofloat(y2))))) ;
}

script GetAngleDiffF(a1,a2) {
 var p = 0.0 ;
 var n = 0.0 ;
 
 if FloatCompare(a1,a2) {
   p = FloatAdd(FloatSub(360.0,a1),a2) ;
   n = FloatSub(a1,a2) ;
 } else {
   p = FloatSub(a2,a1) ;
   n = FloatAdd(FloatSub(360.0,a2),a1) ;
 }
 
 if FloatCompare(p,n) { return n; } else { return p; }
}

script GetAngleRotDirF(a1,a2) {
 var p = 0.0 ;
 var n = 0.0 ;
 
 if FloatCompare(a1,a2) {
   p = FloatAdd(FloatSub(360.0,a1),a2) ;
   n = FloatSub(a1,a2) ;
 } else {
   p = FloatSub(a2,a1) ;
   n = FloatAdd(FloatSub(360.0,a2),a1) ;
 }
 
 if FloatCompare(p,n) { return inttofloat(-1); } else { return inttofloat(1); }
}

script GetLineAngleF(x1,y1,x2,y2) {
 if ((x2 == x1) and (y2 == y1)) return 0 ;
 
 if (y1 == y2) {
  if (abs(x1-x2) > 0) {
   return 0.0 ;
  } else {
   return 180.0 ;
  }
 }
 
 if (x1 == x2) {
  if (abs(y1-y2) > 0) {
   return 90.0 ;
  } else {
   return 270.0 ;
  }
 } 

 var x = inttofloat(abs(x2 - x1)) ;
 var y = inttofloat(abs(y2 - y1)) ;
 var t = 0.0 ;
 var n = 0.0 ;
 var d = 0.0 ;
 int a = 0 ;
 int e_a = 0 ;
 var e_d = inttofloat(2000);
 
 for (a=0;a<359;a++) {
  t = floattangent(floatmul(floatdiv(inttofloat(a),inttofloat(180)),FLOAT_PI)) ;
  n = floatmul(x,t) ;
  d = floatabsolute(floatsub(y,n)) ;
  if floatcompare(e_d,floatmul(d,1.5)) {
   e_a = a ; 
   e_d = d ;
  }   
 }
 
 a = e_a ;
 if (y2<y1) {
  if (x2<x1) { a = 180-a ; }
 } else {
  if (x2<x1) { a = a + 180 ; } else { a = 360 - a ; }
 }
 
 return inttofloat(a) ;   
}

