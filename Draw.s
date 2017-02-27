// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// draw.s -   includes some drawing 
//            functions
//   adapted from AGAST sample game    
// ----------------------------------

script drawImage(ScreenX, ScreenY, Image) { drawSprite(ScreenX,  ScreenY,  Image,  0); }

script drawScaledSprite(X,Y,an,fr,sc) { 
 var floatScale = FloatDiv(IntToFloat(sc), IntToFloat(1000));
 
 X = X - GetSpriteHandleX(an) ; 
 Y = Y - GetSpriteHandleY(an) ; 
 
 var width  = FloatToInt( FloatMul( IntToFloat(GetSpriteFrameWidth(an, fr)), floatScale) ); 
 var height = FloatToInt( FloatMul( IntToFloat(GetSpriteFrameHeight(an, fr)), floatScale) );  
 
 ResetVertexBuffer(6); 
 PrimitiveType = PRIMITIVE_TRIANGLELIST; 

 PrimitiveCount = 2; 
 PrimitiveZMode = Z_DRAW_GREATER;   
 TextureSprite = an; 
 TextureFrame = fr;  
 
 var baseU = IntToFloat(0); 
 var baseV = IntToFloat(0); 

 
 var endU = IntToFloat(1); 
 var endV = IntToFloat(1); 
  
 var pri = 256;  
 
 ActiveVertex = 0; 
 SetVertexPosition(X, Y); 
 SetVertexPriority(pri); 
 VertexColor = drawingColor;
 VertexU = baseU; 
 VertexV = baseV;
 
 ActiveVertex = 1; 
 SetVertexPosition(X + Width, Y); 
 SetVertexPriority(pri); 
 VertexColor = drawingColor;
 VertexU = endU; 
 VertexV = baseV;  
 
 ActiveVertex = 2; 
 SetVertexPosition(X, Y + Height); 
 SetVertexPriority(pri); 
 VertexColor = drawingColor;
 VertexU = BaseU; 
 VertexV = EndV; 
  
 ActiveVertex = 3; 
 SetVertexPosition(X + Width, Y); 
 SetVertexPriority(pri); 
 VertexColor = drawingColor;
 VertexU = EndU; 
 VertexV = baseV;
 
 ActiveVertex = 4; 
 SetVertexPosition(X + Width, Y + Height); 
 SetVertexPriority(pri); 
 VertexColor = drawingColor;
 VertexU = endU; 
 VertexV = endV;  
 
 ActiveVertex = 5; 
 SetVertexPosition(X, Y + Height); 
 SetVertexPriority(pri); 
 VertexColor = drawingColor;
 VertexU = BaseU; 
 VertexV = endV; 
  
 drawVertexBuffer;  
} 

script drawCircleOutline( x1, y1, radius ) {	
	int x = 0;
	int y = radius;
	int flag = 3 - 2 * radius;

    	do {		
		int xPlusXCenter = 	x1 + x;
		int yPlusYCenter = 	y1 + y;
		
		int xMinusXCenter = x1 - x;
		int yMinusYCenter = y1 - y;

		int xPlusYCenter = 	x1 + y;
		int yPlusXCenter = 	y1 + x;

		int xMinusYCenter = x1 - y;
		int yMinusXCenter = y1 - x;

		drawLine( xPlusXCenter, yPlusYCenter, xPlusXCenter + 1, yPlusYCenter + 1 );
		drawLine( xPlusXCenter, yMinusYCenter, xPlusXCenter + 1, yMinusYCenter + 1 );		
		drawLine( xMinusXCenter, yPlusYCenter, xMinusXCenter + 1, yPlusYCenter + 1 );
		drawLine( xMinusXCenter, yMinusYCenter, xMinusXCenter + 1, yMinusYCenter + 1 );
		drawLine( xPlusYCenter, yPlusXCenter, xPlusYCenter + 1, yPlusXCenter + 1 );
		drawLine( xPlusYCenter, yMinusXCenter, xPlusYCenter + 1, yMinusXCenter + 1 );
		drawLine( xMinusYCenter, yPlusXCenter, xMinusYCenter + 1, yPlusXCenter + 1 );
		drawLine( xMinusYCenter, yMinusXCenter, xMinusYCenter + 1, yMinusXCenter + 1 );
		
		if ( flag < 0 ) 
			flag = flag + ( 4 * x ) + 6;
		else
		{
			flag = flag + ( 4 * (x - y) ) + 10;
			y -= 1;
		}
		
		x += 1;
		
	}
	while ( x <= y );	
}

script drawCircle( x1, y1, radius ) {
	int x = 0;
	int y = radius;
	int flag = 3 - 2 * radius;

    	do {
		int xPlusXCenter = 	x1 + x;
		int yPlusYCenter = 	y1 + y;
		
		int xMinusXCenter = x1 - x;
		int yMinusYCenter = y1 - y;

		int xPlusYCenter = 	x1 + y;
		int yPlusXCenter = 	y1 + x;

		int xMinusYCenter = x1 - y;
		int yMinusXCenter = y1 - x;

		drawLine( xPlusXCenter, yPlusYCenter, xPlusXCenter, yMinusYCenter );
		drawLine( xMinusXCenter, yPlusYCenter, xMinusXCenter, yMinusYCenter );
		drawLine( xPlusYCenter, yPlusXCenter, xPlusYCenter, yMinusXCenter );
		drawLine( xMinusYCenter, yPlusXCenter, xMinusYCenter, yMinusXCenter );
		

		if ( flag < 0 ) 
			flag = flag + ( 4 * x ) + 6;
		else
		{
			flag = flag + ( 4 * (x - y) ) + 10;
			y -= 1;
		}
		
		x += 1;
		
	}
	while ( x <= y );	
}

script drawLine(x1, y1, x2, y2) {
	ResetVertexBuffer(2);
	
	TextureSprite = null;
	TextureFrame = 0;
	
	var pri = drawingPriority;
	
	PrimitiveType = PRIMITIVE_LINELIST;
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
	
	drawVertexBuffer;	
}

script drawVerticalLine(PointsCommonX,  PointAY,  PointBY) {
	drawLine(PointsCommonX,  PointAY,  PointsCommonX, PointBY);
}

script drawHorizontalLine(PointAX,  PointsCommonY,  PointBX) {
	drawLine(PointAX,  PointsCommonY,  PointBX,  PointsCommonY);
}

script drawRectangle(Left, Top, Right, Bottom) {
	ResetVertexBuffer(6);
	
	var pri = 256;
	
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

script drawShadeRectangle(Left, Top, Right, Bottom) {
	var OlddrawingColor = drawingColor;
	
	drawingColor = RGBA( GetR(drawingColor),
				      GetG(drawingColor),
				      GetB(drawingColor),
				      128);
				      
	drawRectangle(Left, Top, Right, Bottom);
	
	drawingColor = OlddrawingColor;
}

script BLEND_COLOR_HALF(colorLeft, colorRight) {
	var deltaR = GetR(colorRight) - GetR(colorLeft);
	var deltaG = GetG(colorRight) - GetG(colorLeft);
	var deltaB = GetB(colorRight) - GetB(colorLeft);
	var deltaA = GetA(colorRight) - GetA(colorLeft);
	
	deltaR /= 2;
	deltaG /= 2;
	deltaB /= 2;
	deltaA /= 2;
	
	var result = RGBA( GetR(colorLeft) + deltaR,
				   GetG(colorLeft) + deltaG,
				   GetB(colorLeft) + deltaB,
				   GetA(colorLeft) + deltaA );

	return result;

}

script drawGradientRectangle(left, top, right, bottom, topColor,  bottomColor) {
	var middleX = left + ((right - left) / 2);
	var middleY = top + ((bottom - top) / 2);
	var middleColor = BLEND_COLOR_HALF(topColor, bottomColor);
	
	ResetVertexBuffer(12);
	
	var pri = 256;
	
	PrimitiveType = PRIMITIVE_TRIANGLELIST;
	PrimitiveZMode = Z_DRAW_GREATER;
	PrimitiveCount = 4;
	
	TextureSprite = null;
	TextureFrame = 0;
	
	ActiveVertex = 0;
	SetVertexPosition(left, top);
	SetVertexPriority(pri);
	VertexColor = topColor;
	
	ActiveVertex = 1;
	SetVertexPosition(right, top);
	SetVertexPriority(pri);
	VertexColor = topColor;
	
	ActiveVertex = 2;
	SetVertexPosition(middleX, middleY);
	SetVertexPriority(pri);
	VertexColor = middleColor;
	
	ActiveVertex = 3;
	SetVertexPosition(left, top);
	SetVertexPriority(pri);
	VertexColor = topColor;
	
	ActiveVertex = 4;
	SetVertexPosition(middleX, middleY);
	SetVertexPriority(pri);
	VertexColor = middleColor;
	
	ActiveVertex = 5;
	SetVertexPosition(left, bottom);
	SetVertexPriority(pri);
	VertexColor = bottomColor;
	
	ActiveVertex = 6;
	SetVertexPosition(right, bottom);
	SetVertexPriority(pri);
	VertexColor = bottomColor;
	
	ActiveVertex = 7;
	SetVertexPosition(middleX, middleY);
	SetVertexPriority(pri);
	VertexColor = middleColor;
	
	ActiveVertex = 8;
	SetVertexPosition(right, top);
	SetVertexPriority(pri);
	VertexColor = topColor;
	
	ActiveVertex = 9;
	SetVertexPosition(middleX, middleY);
	SetVertexPriority(pri);
	VertexColor = middleColor;
	
	ActiveVertex = 10;
	SetVertexPosition(right, bottom);
	SetVertexPriority(pri);
	VertexColor = bottomColor;
	
	ActiveVertex = 11;
	SetVertexPosition(left, bottom);
	SetVertexPriority(pri);
	VertexColor = bottomColor;
	
	drawVertexBuffer;
}

script drawRotatedSprite(an, fr, x, y, sc, pri, floatAngle) {
	var cX = GetSpriteHandleX(an);
	var cY = GetSpriteHandleY(an);
	
	drawRotatedFrame(an, fr, x, y, sc, pri, floatAngle, cX, cY);
}

script drawRotatedImage(an, x, y, sc, pri, floatAngle) {
	var cX = GetSpriteFrameWidth(an, 0) / 2;
	var cY = GetSpriteFrameHeight(an, 0) / 2;
	
	drawRotatedFrame(an, 0, x, y, sc, pri, floatAngle, cX, cY);
}

script drawRotatedFrame(an, fr, x, y, sc, pri, floatAngle, cX, cY) {
	var floatScale = FloatDiv(IntToFloat(sc), IntToFloat(1000));
	
	var CenterX = FloatToInt( FloatMul( IntToFloat(cX),  floatScale ));
	var CenterY = FloatToInt( FloatMul( IntToFloat(cY),  floatScale ));
	
	var ScreenX = x ;
	var ScreenY = y ;
	
	unless drawingabsolute {		
		ScreenX -= ScrollX;
		ScreenY -= ScrollY;
	}
	
	var width;
	var height;
	
	width = FloatToInt( FloatMul( IntToFloat(GetSpriteFrameWidth(an, fr)), floatScale) );
	height = FloatToInt( FloatMul( IntToFloat(GetSpriteFrameHeight(an, fr)), floatScale) );
	
	ResetVertexBuffer(6);
	PrimitiveType = PRIMITIVE_TRIANGLELIST;
	PrimitiveTransparencyMode = TRANSPARENCY_ALPHA;
	PrimitiveCount = 2;
	PrimitiveZMode = Z_DRAW_GREATER;
	
	TextureSprite = an;
	TextureFrame = fr;
	
	var leftColor = COLOR_WHITE;//GetPathRGBA(ScreenX, ScreenY + height);
	var rightColor = COLOR_WHITE;//GetPathRGBA(ScreenX + width, ScreenY + height);
	
	var baseU = IntToFloat(0);
	var baseV = IntToFloat(0);
	
	var endU = IntToFloat(1);
	var endV = IntToFloat(1);
	
	var startX = 0 - CenterX;
	var startY = 0 - CenterY;
	var endX   = width - CenterX;
	var endY   = height - CenterY;
	
	ActiveVertex = 0;
	SetVertexPosition(startX, startY);
	SetVertexPriority(pri);
	VertexColor = leftColor;
	VertexU = baseU;
	VertexV = baseV;
	
	ActiveVertex = 1;
	SetVertexPosition(endX, startY);
	SetVertexPriority(pri);
	VertexColor = rightColor;
	VertexU = endU;
	VertexV = baseV;
	
	ActiveVertex = 2;
	SetVertexPosition(startX, endY);
	SetVertexPriority(pri);
	VertexColor = leftColor;
	VertexU = baseU;
	VertexV = endV;
	
	ActiveVertex = 3;
	SetVertexPosition(startX, endY);
	SetVertexPriority(pri);
	VertexColor = leftColor;
	VertexU = baseU;
	VertexV = endV;
	
	ActiveVertex = 4;
	SetVertexPosition(endX,  startY);
	SetVertexPriority(pri);
	VertexColor = rightColor;
	VertexU = endU;
	VertexV = baseV;
	
	ActiveVertex = 5;
	SetVertexPosition(endX,  endY);
	SetVertexPriority(pri);
	VertexColor = rightColor;
	VertexU = endU;
	VertexV = endV;
	
	RotateVertexBuffer(floatAngle,  ScreenX, ScreenY);
	
	drawVertexBuffer;
}

script RotateVertexBuffer(floatAngle, ScreenX, ScreenY) {
	
	for(int i = 0; i < VertexCount; i++) {
		ActiveVertex = i;
		
		var angle = floatAngle;
		
		var rotateX;
		var rotateY;
		
		rotateX = FloatSub(FloatMul( VertexX, FloatCosine(angle)), FloatMul( VertexY, FloatSine(angle)));
		rotateY = FloatAdd(FloatMul( VertexX, FloatSine(angle)), FloatMul( VertexY, FloatCosine(angle)));
		rotateX = FloatAdd(IntToFloat(ScreenX), rotateX);
		rotateY = FloatAdd(IntToFloat(ScreenY), rotateY);
					  
		VertexX = rotateX;
		VertexY = rotateY;
	}
}

script drawLineR(x1,y1,x2,y2,color,radius) {
 int r = radius ; /// 2 ;
 int o = radius % 2 ;
 int s = 0 ;
 drawingColor = color;
 
 for (s=-r;s<=r;s++) {
  drawLine(x1+s,y1,x2+s,y2) ;
  drawLine(x1,y1+s,x2,y2+s) ;
 }
}

script GetLinePos(X1,Y1,X2,Y2,Distance) {
 int IX = -1 ;
 int IY = -1 ;
 if (X1 < X2) { IX = 1; }
 if (Y1 < Y2) { IY = 1; }
 
 var XS = inttofloat(X2-X1) ; 
 var YS = inttofloat(Y2-Y1) ;
 if (Y1 != Y2) { XS = floatdiv(inttofloat(X2-X1) , inttofloat(abs(Y2-Y1))) ; }
 if (X1 != X2) { YS = floatdiv(inttofloat(Y2-Y1) , inttofloat(abs(X2-X1))) ; }

 int CX = X1 ;
 int CY = Y1 ;
 var NX = IntToFloat(X1) ;
 var NY = IntToFloat(Y1) ;
 
 if (abs(X1-X2) > abs(Y1-Y2)) {
   while (CX != X2) {
     CY = FloatCeiling(NY) ;
     NY = FloatAdd(NY,YS) ;
     CX = CX + IX ;  
     if (CX==X2) return (X2+Y2*640);
     if (FloatCompare(GetDistF(X1,Y1,CX,CY),Distance)) return (CX+CY*640); ;
   }
 } else {
   while (CY != Y2) {
     CX = FloatCeiling(NX) ;
     NX = FloatAdd(NX,XS) ;
     CY = CY + IY ;
     if (CY==Y2) return (X2+Y2*640);
     if (FloatCompare(GetDistF(X1,Y1,CX,CY),Distance)) return (CX+CY*640); ;
  } 
 }
}

script drawDottedLine(X1,Y1,X2,Y2,C,R,Distance) {
 int IX = -1 ;
 int IY = -1 ;
 if (X1 < X2) { IX = 1; }
 if (Y1 < Y2) { IY = 1; }
 
 var XS = inttofloat(X2-X1) ; 
 var YS = inttofloat(Y2-Y1) ;
 if (Y1 != Y2) { XS = floatdiv(inttofloat(X2-X1) , inttofloat(abs(Y2-Y1))) ; }
 if (X1 != X2) { YS = floatdiv(inttofloat(Y2-Y1) , inttofloat(abs(X2-X1))) ; }

 int CX = X1 ;
 int CY = Y1 ;
 var NX = IntToFloat(X1) ;
 var NY = IntToFloat(Y1) ;
 
 drawingColor = C ;
 
 if (abs(X1-X2) > abs(Y1-Y2)) {
   while (CX != X2) {
     while (CY != FloatCeiling(NY)) {
       CY = CY + IY ;
      // drawCircle(CX,CY,R) ;
     }
     NY = FloatAdd(NY,YS) ;
     CX = CX + IX ;
    // drawCircle(CX,CY,R) ;
    drawLineR(X1,Y1,CX,CY,C,R) ;
     if ((CX==X2) or FloatCompare(GetDistF(X1,Y1,CX,CY),Distance)) { return (CX+CY*640); }
   }
 } else {
   while (CY != Y2) {
     while (CX != FloatCeiling(NX)) {
       CX = CX + IX ;
     //  drawCircle(CX,CY,R) ;
     }
     CX = FloatCeiling(NX) ;
     NX = FloatAdd(NX,XS) ;
     CY = CY + IY ;
    // drawCircle(CX,CY,R) ;
    drawLineR(X1,Y1,CX,CY,C,R) ;
     if ((CY==Y2) or FloatCompare(GetDistF(X1,Y1,CX,CY),Distance)) { return (CX+CY*640); } 
   } 
 }
}
