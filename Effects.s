// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------

int nightvalpha = 0 ;

script LightIsOn {
 return (!DarknessEffect.enabled) ;
} 

script ClickHint {
 Ego:
 switch UpCounter(5) {
  case 0 : "Wenn ich auf die Platte trete scheint sie ein St]ck weit nachzugeben und ein Klickger#usch ert[nt..."
  case 1 : "Sie scheint Teil eines Mechanismus zu sein."
	   "Ich frage mich was er bewirkt..."
  case 2 : "Vielleicht muss ich die Platten in einer bestimmten Reihenfolge dr]cken."
  case 3 : "Vielleicht hat der Professor herausgefunden wie der Mechanismus funktioniert."
	   "Ich sollte vielleicht einen Blick in sein Notizbuch werfen..."
  default : "Eine bewegliche Bodenplatte."
 }
} 

object DarknessEffect {
 enabled = false ;
 visible = true ;
 clickable = false ;
 priority = 210 ; 
}

event paint DarknessEffect {
 drawingColor = RGBA(0,0,0,250) ;
 drawRectanglePri(0,0,SCREEN_WIDTH,SCREEN_HEIGHT,Priority) ;   
} 

object nightVision {
 enabled = false ;
 visible = true ;
 clickable = false ;
 priority = PRIORITY_HIGHEST-1 ;
}

event paint nightVision {
 /* 
 for (int i=0; i<= 50+random(100); i++) {
   drawingPriority = PRIORITY_HIGHEST ;
   drawingColor = RGBA( 0, 255, 90, 10+random(5)) ;
   drawHorizontalLine(0,random(360),640) ;
 }

 for (i=0; i<=360; i+=2) {
   drawingPriority = PRIORITY_HIGHEST ;
   drawingColor = RGBA( 0, 0, 0, 150+random(4)-random(4)) ;
   drawHorizontalLine(0,i,640) ;	 
 }
 */
 if (random(7)==2) { nightvalpha = random(8) ; } 
 drawGradientRectangle(0,0,640,360,RGBA(0,255,78,125+nightvalpha),RGBA(0,255,78,115+nightvalpha)) ;
 
}

script nightVisionOn {
 soundBoxStart(Music::Nachtsicht_wav) ;
 nightVision.enabled = true ;
 darknessEffect.enabled = false ;
}

script nightVisionOff {
 if ((currentScene==Securitygef2) || (((currentScene==Securitygang) || (currentScene==Securitylab1) || (currentScene==Securitylab2)) and shortcircuit)) DarknessEffect.enabled = true ;
 nightVision.enabled = false ;
}

object FlashLightEffect {
 enabled = false ;
 visible = true ;
 clickable = false ;
 Priority = 210 ;
 member StretchX = 1.0 ;
 MarkResource(Graphics::TorchFrame_image) ;
} 

event paint FlashLightEffect { PaintLight(MouseX,MouseY,100) ; }

script PaintLight(CurX,CurY,Radius) {
 static int BGAlpha = 0 ;
 static var StretchY = 1.0 ;
 static var Phi = 0.0 ;
 static var Phi2 = 0.0 ;
 static int Alpha2 = 120 ;
 static var timer = 0 ;
 
 if (timer > 2) and (Random(6)==0) { 
  StretchX = FloatDiv(inttofloat(Random(10)),50.0) ;
  BGAlpha = 5 + FloatCeiling(FloatMul(StretchX,50.0));
  StretchX = FloatAdd(0.8,StretchX) ;
  StretchY = StretchX ; 
  Alpha2 = 180+Random(50) ;  
  if (random(2)== 0) Phi = FloatMod(FloatDiv(inttofloat(Random(50)),30.0),1.5) ;
  timer = 0 ;
 } 
 timer++ ;
 
 // Rotate Rectangle
 var p1x = IntToFloat(-Radius) ;
 var p1y = IntToFloat(-Radius) ;
 var p2x = IntToFloat(Radius) ;
 var p2y = IntToFloat(-Radius) ;
 var p3x = IntToFloat(Radius) ;
 var p3y = IntToFloat(Radius) ;
 var p4x = IntToFloat(-Radius) ;
 var p4y = IntToFloat(Radius) ;
 
 var xx = FloatMul(Floatcosine(Phi),FloatMul(stretchX,1.0)) ;
 var yy = FloatMul(xx,FloatMul(stretchY,1.0)) ;
 var xy = FloatMul(FloatSine(Phi),FloatMul(stretchX,1.0)) ;
 var yx = FloatMul(FloatMul(inttofloat(-1),xy),FloatMul(stretchY,1.0)) ;

 var k1x = FloatCeiling(FloatAdd(FloatMul(p1x,xx),FloatMul(p1y,xy))) + CurX ;
 var k1y = FloatCeiling(FloatAdd(FloatMul(p1x,yx),FloatMul(p1y,yy))) + CurY ;
 var k2x = FloatCeiling(FloatAdd(FloatMul(p2x,xx),FloatMul(p2y,xy))) + CurX ;
 var k2y = FloatCeiling(FloatAdd(FloatMul(p2x,yx),FloatMul(p2y,yy))) + CurY ;
 var k3x = FloatCeiling(FloatAdd(FloatMul(p3x,xx),FloatMul(p3y,xy))) + CurX ;
 var k3y = FloatCeiling(FloatAdd(FloatMul(p3x,yx),FloatMul(p3y,yy))) + CurY ;
 var k4x = FloatCeiling(FloatAdd(FloatMul(p4x,xx),FloatMul(p4y,xy))) + CurX ;
 var k4y = FloatCeiling(FloatAdd(FloatMul(p4x,yx),FloatMul(p4y,yy))) + CurY ; 
 
 int kxmin = min(k1x,min(k2x,min(k3x,k4x))) ;
 int kymin = min(k1y,min(k2y,min(k3y,k4y))) ;
 int kxmax = max(k1x,max(k2x,max(k3x,k4x))) ;
 int kymax = max(k1y,max(k2y,max(k3y,k4y))) ;
 
 // draw rectangular boundaries

 drawingColor = RGBA(0,0,0,255-BGAlpha) ;
 PrimitiveTransparencyMode = TRANSPARENCY_ALPHA ;
 drawRectanglePri(0,0,SCREEN_WIDTH,kymin,Priority) ;
 drawRectanglePri(0,kymin,kxmin,kymax,Priority) ;
 drawRectanglePri(kxmax,kymin,SCREEN_WIDTH,kymax,Priority) ;
 drawRectanglePri(0,kymax,SCREEN_WIDTH,SCREEN_HEIGHT,Priority) ;
 
 BlendImage(k1x,k1y,k2x,k2y,k3x,k3y,k4x,k4y,kxmin,kymin,kxmax,kymax,Priority,BGAlpha,Graphics::TorchFrame_image) ; 
} 

script dist(x1,y1,x2,y2) {
 var dx = floatsub(inttofloat(x1),inttofloat(x2)) ;
 var dy = floatsub(inttofloat(y1),inttofloat(y2)) ;
 return floatsquareroot(floatadd(floatmul(dx,dx),floatmul(dy,dy))) ;
} 

script drawRectanglePri(Left, Top, Right, Bottom, pri) {
	ResetVertexBuffer(6);
	
	PrimitiveType = PRIMITIVE_TRIANGLELIST;
	PrimitiveZMode = Z_DRAW_GREATER;
	PrimitiveCount = 2;
	
	TextureSprite = 0;
	TextureFrame = 0;
	
	ActiveVertex = 0;
	SetVertexPosition(Left, Top);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	ActiveVertex = 1;
	SetVertexPosition(Right, Top);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	ActiveVertex = 2;
	SetVertexPosition(Left, Bottom);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	ActiveVertex = 3;
	SetVertexPosition(Left, Bottom);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	ActiveVertex = 4;
	SetVertexPosition(Right, Top);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	ActiveVertex = 5;
	SetVertexPosition(Right, Bottom);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	drawVertexBuffer;
}


script min(x,y) {
 if (x < y) return x ;  
  else return y ; 
}
 
 script BlendImage2(x1, y1, W, H, Pri, Alpha,Res) {	
	ResetVertexBuffer(6);
	
	TextureSprite = Res;
	TextureFrame = 0;
	PrimitiveTransparencyMode = TRANSPARENCY_ALPHA ;
	
	PrimitiveType = PRIMITIVE_TRIANGLELIST;
	PrimitiveZMode = Z_DRAW_GREATER;
	PrimitiveCount = 2;
	
	ActiveVertex = 0;
	SetVertexPosition(x1,y1);
	VertexU = 0.0 ;
	VertexV = 0.0 ;
	SetVertexPriority(pri);
	VertexColor = RGBA(255,255,255,Alpha) ;

	ActiveVertex = 1;
	SetVertexPosition(x1+W,y1);
	VertexU = 1.0 ;
	VertexV = 0.0 ;
	VertexColor = RGBA(255,255,255,Alpha) ;
        SetVertexPriority(pri);
	
	ActiveVertex = 2;
	SetVertexPosition(x1+w,y1+h);
	VertexU = 1.0 ;
	VertexV = 1.0 ;
	SetVertexPriority(pri);
	VertexColor = RGBA(255,255,255,Alpha) ;

	ActiveVertex = 3;
	SetVertexPosition(x1,y1);
	VertexU = 0.0 ;
	VertexV = 0.0 ;
	SetVertexPriority(pri);
        VertexColor = RGBA(255,255,255,Alpha) ;

	ActiveVertex = 4;
	SetVertexPosition(x1+w,y1+h);
	VertexU = 1.0 ;
	VertexV = 1.0 ;
	SetVertexPriority(pri);
        VertexColor = RGBA(255,255,255,Alpha) ;

	ActiveVertex = 5;
	SetVertexPosition(x1,y1+h);
	VertexU = 0.0 ;
	VertexV = 1.0 ;
	VertexColor = RGBA(255,255,255,Alpha) ;
	SetVertexPriority(pri);	
       
        drawVertexBuffer;	
}
 
script BlendImage(x1, y1, x2, y2, x3, y3, x4, y4,xmin,ymin,xmax,ymax,Pri, Alpha,Res) {	
	ResetVertexBuffer(18);
	
	TextureSprite = Res;
	TextureFrame = 0;
	PrimitiveTransparencyMode = TRANSPARENCY_ALPHA ;
	
	PrimitiveType = PRIMITIVE_TRIANGLELIST;
	PrimitiveZMode = Z_DRAW_GREATER;
	PrimitiveCount = 6;
	
	ActiveVertex = 0;
	SetVertexPosition(x1,y1);
	VertexU = 0.0 ;
	VertexV = 0.0 ;
	SetVertexPriority(pri);
	VertexColor = RGBA(255,255,255,255-Alpha) ;

	ActiveVertex = 1;
	SetVertexPosition(x2,y2);
	VertexU = 0.99 ;
	VertexV = 0.0 ;
	VertexColor = RGBA(255,255,255,255-Alpha) ;
        SetVertexPriority(pri);
	
	ActiveVertex = 2;
	SetVertexPosition(x3,y3);
	VertexU = 0.99 ;
	VertexV = 0.99 ;
	SetVertexPriority(pri);
	VertexColor = RGBA(255,255,255,255-Alpha) ;

	ActiveVertex = 3;
	SetVertexPosition(x1,y1);
	VertexU = 0.0 ;
	VertexV = 0.0 ;
	SetVertexPriority(pri);
        VertexColor = RGBA(255,255,255,255-Alpha) ;

	ActiveVertex = 4;
	SetVertexPosition(x3,y3);
	VertexU = 0.99 ;
	VertexV = 0.99 ;
	SetVertexPriority(pri);
        VertexColor = RGBA(255,255,255,255-Alpha) ;

	ActiveVertex = 5;
	SetVertexPosition(x4,y4);
	VertexU = 0.0 ;
	VertexV = 0.99 ;
	VertexColor = RGBA(255,255,255,255-Alpha) ;
	SetVertexPriority(pri);	
	
	ActiveVertex = 6;
	AddVertexUV(x1,y1,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;
        AddVertexUV(xmin,ymin,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;
        AddVertexUV(x2,y2,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;

	AddVertexUV(x2,y2,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;
        AddVertexUV(xmax,ymin,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;
        AddVertexUV(x3,y3,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;

	AddVertexUV(x3,y3,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;
        AddVertexUV(xmax,ymax,0.0,0.0,pri,RGBA(0,0,0,255-Alpha) );
        AddVertexUV(x4,y4,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;

	AddVertexUV(x4,y4,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;
        AddVertexUV(xmin,ymax,0.0,0.0,pri,RGBA(0,0,0,255-Alpha)) ;
        AddVertexUV(x1,y1,0.0,0.0,pri,RGBA(0,0,0,255-Alpha));
       
        drawVertexBuffer;	
}

script drawTriangle(x1, y1, x2, y2, x3, y3,pri) {
	ResetVertexBuffer(3);
	
	TextureSprite = null;
	TextureFrame = 0;
	
	PrimitiveType = PRIMITIVE_TRIANGLELIST;
	PrimitiveZMode = Z_DRAW_GREATER;
	PrimitiveCount = 1;
	
	ActiveVertex = 0;
	SetVertexPosition(x1,y1);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	ActiveVertex = 1;
	SetVertexPosition(x2,y2);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	ActiveVertex = 2;
	SetVertexPosition(x3,y3);
	SetVertexPriority(pri);
	VertexColor = drawingColor;
	
	drawVertexBuffer;	
}

script AddVertex(X,Y,Pri,C) {
 VertexX = IntToFloat(X) ;
 VertexY = IntToFloat(Y) ;
 VertexZ = FloatSub( IntToFloat(1), FloatDiv(IntToFloat(Pri),IntToFloat(1000)) );
 VertexColor = C ; 
 ActiveVertex = ActiveVertex + 1 ;
}

script AddVertexUV(X,Y,U,V,Pri,C) {
 VertexX = IntToFloat(X) ;
 VertexY = IntToFloat(Y) ;
 VertexU = U ;
 VertexV = V ;
 VertexZ = FloatSub( IntToFloat(1), FloatDiv(IntToFloat(Pri),IntToFloat(1000)) );
 VertexColor = C ; 
 ActiveVertex = ActiveVertex + 1 ;
}
