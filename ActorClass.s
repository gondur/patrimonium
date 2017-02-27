// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// Actorclass.s -  class for actors
//   adapted from AGAST sample game    
// ----------------------------------

object ActorClass { 
  enabled = false ; 
    
  member lastscale          = scale ;
  member lightmap           = null ; 
  member lightmapAutoFilter = false ;
  member reflection         = false ;
  member reflectionOffsetY  = 0 ;
  member reflectionOffsetX  = 0 ;
  member reflectionTopColor = RGBA(128,128,255,64) ;
  member reflectionBottomColor = RGBA(128,128,255,64) ;
  member reflectionAngle = 0.0 ;
  member reflectionStretch = 1.0 ;
  member walking            = false ;
} 

script SetupAsActor { 
  class = actorClass ; 
  enabled = true ;
  objectPaintingHandler = &actor_paintHandler ;
}

script actor_paintHandler {
  actor_paintActor ;
  if (reflection) actor_PaintReflection;
}

script actor_paintActor {
  var an = GetAnim(animMode, Direction) ;
  var fr  = frame ;
	
  if (!an) return ;
	
  var sc = scale ;
 	
  if (pathAutoScale) scale = GetPathScale(PositionX, PositionY) ;
 
  if (scale < 10) { 
	scale = lastscale ; 
  } else {
	lastscale = scale;
  } 
  
  var floatScale = FloatDiv(IntToFloat(sc), IntToFloat(1000)) ;
  var CenterX = FloatToInt(FloatMul(IntToFloat(GetSpriteHandleX(an)), floatScale)) ;
  var CenterY = FloatToInt(FloatMul(IntToFloat(GetSpriteHandleY(an)), floatScale)) ;
  var ScreenX = PositionX - CenterX ;
  var ScreenY = PositionY - CenterY ;
	
  unless absolute {			
    ScreenX -= ScrollX ;
    ScreenY -= ScrollY ;
  }
	
  var width ;
  var height ;
	
  width = FloatToInt(FloatMul(IntToFloat(GetSpriteFrameWidth(an, fr)), floatScale)) ;
  height = FloatToInt(FloatMul(IntToFloat(GetSpriteFrameHeight(an, fr)), floatScale)) ;
	
  var pri = priority ;
	
  if (priority == PRIORITY_AUTO) pri = (PositionY / 8) ;
	
  ResetVertexBuffer(6) ;
	
  PrimitiveType = PRIMITIVE_TRIANGLELIST ;
  PrimitiveCount = 2 ;
	
  PrimitiveTransparencyMode = TRANSPARENCY_ALPHA ;
  PrimitiveZMode = Z_DRAW_GREATER ;
	
  TextureSprite = an ;
  TextureFrame = fr ;
	
  var leftColor ;
  var rightColor ;
	
  if (lightmapAutoFilter) {
    //leftColor = actor_getLightMapValue(screenX + scrollX, screenY + scrollY + height) ;
    //rightColor = actor_getLightMapValue(screenX + scrollX + width, screenY + scrollY + height) ;
    leftColor  = actor_getLightMapValue(positionX, positionY) ;
    rightColor = leftColor ;
  } else {
    leftColor = filter ;
    rightColor = filter ;
  }
	
  var baseU = IntToFloat(0) ;
  var baseV = IntToFloat(0) ;
  var endU = IntToFloat(1) ;
  var endV = IntToFloat(1) ;
	
  ActiveVertex = 0 ;
  SetVertexPosition(ScreenX, ScreenY) ;
  SetVertexPriority(pri) ;
  VertexColor = leftColor ;
  VertexU = baseU ;
  VertexV = baseV ;
	
  ActiveVertex = 1 ;
  SetVertexPosition(ScreenX + width, ScreenY) ;
  SetVertexPriority(pri) ;
  VertexColor = rightColor ;
  VertexU = endU ;
  VertexV = baseV ;
	
  ActiveVertex = 2 ;
  SetVertexPosition(ScreenX, ScreenY + height) ;
  SetVertexPriority(pri) ;
  VertexColor = leftColor ;
  VertexU = baseU ;
  VertexV = endV ;
  
	
  ActiveVertex = 3 ;
  SetVertexPosition(ScreenX, ScreenY + height) ;
  SetVertexPriority(pri) ;
  VertexColor = leftColor ;
  VertexU = baseU ;
  VertexV = endV ;
	
  ActiveVertex = 4 ;
  SetVertexPosition(ScreenX + width,  ScreenY) ;
  SetVertexPriority(pri) ;
  VertexColor = rightColor ;
  VertexU = endU ;
  VertexV = baseV ;
	
  ActiveVertex = 5 ;
  SetVertexPosition(ScreenX + width,  ScreenY + height) ;
  SetVertexPriority(pri) ;
  VertexColor = rightColor ;
  VertexU = endU ;
  VertexV = endV ;
	
  drawVertexBuffer ;
}

script actor_paintReflection {
  var an = GetAnim(animMode, Direction) ;
  var fr  = frame ;
	
  if (! an) return ;
	
  var sc ;
	
  if (pathAutoScale) sc = GetPathScale(PositionX, PositionY) ;
   else	sc = Scale ;
		
  var floatScale = FloatDiv(IntToFloat(sc), IntToFloat(1000)) ;

  var width = FloatMul(IntToFloat(GetSpriteFrameWidth(an, fr)), floatScale) ;
  var height = FloatMul(IntToFloat(GetSpriteFrameHeight(an, fr)), floatScale) ;
  var widthdiv2 = floatdiv(width,2.0) ;
  
  var CenterX = FloatToInt(Floatsub(FloatMul(IntToFloat(GetSpriteHandleX(an)), floatScale),widthdiv2))  ;
  var CenterY = FloatToInt(FloatMul(IntToFloat(GetSpriteHandleY(an)), floatScale)) ;
	
  var ScreenX = PositionX - CenterX + reflectionOffsetX ;
  var ScreenY = PositionY - CenterY + FloatToInt(FloatMul(inttofloat(reflectionOffsetY),floatScale)) ; 
	
  unless absolute {
    ScreenX -= ScrollX ;
    ScreenY -= ScrollY ;
  }
	
  	
  var pri = 10 ;
	
  ResetVertexBuffer(6) ;
  PrimitiveType = PRIMITIVE_TRIANGLELIST ;
  PrimitiveCount = 2 ;
  PrimitiveTransparencyMode = TRANSPARENCY_ALPHA ;
  PrimitiveZMode = Z_DRAW_GREATER ;
	
  TextureSprite = an ;
  TextureFrame = fr ;
	
  var TopColor = ReflectionTopColor ; 
  var BottomColor = ReflectionBottomColor ; 
  var baseU = IntToFloat(0) ;
  var baseV = IntToFloat(1) ;	
  var endU = IntToFloat(1) ;
  var endV = IntToFloat(0) ;
  
  /////
 var p2x = widthdiv2 ;
 var p2y = 0.0 ;
 var p1x = FloatMul(p2x,IntToFloat(-1)) ;
 var p1y = 0.0 ;
 var p3x = p2x ;
 var p3y = FloatMul(height,reflectionstretch) ;
 var p4x = p1x ;
 var p4y = p3y ;
 
 var xx = Floatcosine(ReflectionAngle) ;
 var yy = xx ;
 var xy = FloatSine(ReflectionAngle) ;
 var yx = FloatMul(inttofloat(-1),xy) ;
 var k1x = FloatCeiling(FloatAdd(FloatMul(p1x,xx),FloatMul(p1y,xy))) + ScreenX ;
 var k1y = FloatCeiling(FloatAdd(FloatMul(p1x,yx),FloatMul(p1y,yy))) + ScreenY ;
 var k2x = FloatCeiling(FloatAdd(FloatMul(p2x,xx),FloatMul(p2y,xy))) + ScreenX ;
 var k2y = FloatCeiling(FloatAdd(FloatMul(p2x,yx),FloatMul(p2y,yy))) + ScreenY ; 
 
 var k3x = FloatCeiling(FloatAdd(FloatMul(p3x,xx),FloatMul(p3y,xy))) + ScreenX ;
 var k3y = FloatCeiling(FloatAdd(FloatMul(p3x,yx),FloatMul(p3y,yy))) + ScreenY ;
 var k4x = FloatCeiling(FloatAdd(FloatMul(p4x,xx),FloatMul(p4y,xy))) + ScreenX ;
 var k4y = FloatCeiling(FloatAdd(FloatMul(p4x,yx),FloatMul(p4y,yy))) + ScreenY ; 
 /////
	
  ActiveVertex = 0 ;
  SetVertexPosition(k1x, k1y) ;
  SetVertexPriority(pri) ;
  VertexColor = TopColor ;
  VertexU = baseU ;
  VertexV = baseV ;
	
  ActiveVertex = 1 ;
  SetVertexPosition(k2x, k2y) ;
  SetVertexPriority(pri) ;
  VertexColor = TopColor ;
  VertexU = endU ;
  VertexV = baseV ;
	
  ActiveVertex = 2 ;
  SetVertexPosition(k3x, k3y) ;
  SetVertexPriority(pri) ;
  VertexColor = BottomColor ;
  VertexU = endU ;
  VertexV = endV ;
	

  ActiveVertex = 3 ;
  SetVertexPosition(k1x,k1y) ;
  SetVertexPriority(pri) ;
  VertexColor = TopColor ;
  VertexU = baseU ;
  VertexV = baseV ;
	
  ActiveVertex = 4 ;
  SetVertexPosition(k3x,k3y) ;
  SetVertexPriority(pri) ;
  VertexColor = BottomColor ;
  VertexU = endU ;
  VertexV = endV ;
	
  ActiveVertex = 5 ;
  SetVertexPosition(k4x,k4y) ;
  SetVertexPriority(pri) ;
  VertexColor = BottomColor ;
  VertexU = baseU ;
  VertexV = endV ;
	
  drawVertexBuffer ;
}

script actor_GetLightMapValue(x, y) {
  if (! backgroundImage || ! lightmap) return COLOR_WHITE ;
	
  var bWidth ;
  var bHeight ;
  var iWidth ;
  var iHeight ;
  var iX ;
  var iY ;
	
  bWidth = GetSpriteFrameWidth(backgroundImage, 0) ; 
  bHeight = GetSpriteFrameHeight(backgroundImage, 0) ; 
  iWidth = GetSpriteFrameWidth(lightmap, 0) ; 
  iHeight = GetSpriteFrameHeight(lightmap, 0) ; 
          
  var widthScale = FloatDiv(IntToFloat(bWidth),IntToFloat(iWidth)) ; 
  var heightScale = FloatDiv(IntToFloat(bHeight),IntToFloat(iHeight)) ; 
          
  iX = FloatToInt(FloatDiv(IntToFloat(x),  widthScale)) ; 
  iY = FloatToInt(FloatDiv(IntToFloat(y),  heightScale)) ; 
          
  return GetSpriteFramePixel(lightmap, 0, iX, iY) ; 
}