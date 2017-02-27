// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// Vertex.s - Supplementary scripts
//         for vertex buffer
//   adapted from AGAST sample game    
// ----------------------------------

script SetVertexPosition(x,y) {
  VertexX = IntToFloat(x) ;
  VertexY = IntToFloat(y) ;
}

script SetVertexPriority(pri) {
  VertexZ = FloatSub(IntToFloat(1), FloatDiv(IntToFloat(pri),IntToFloat(1000))) ;
}

script SetVertexTexturePixel(PixelX,PixelY) {
  VertexU = FloatDiv(IntToFloat(PixelX), IntToFloat(GetSpriteFrameWidth(TextureSprite,  TextureFrame))) ;
  VertexV = FloatDiv(IntToFloat(PixelY), IntToFloat(GetSpriteFrameHeight(TextureSprite,  TextureFrame))) ;
}
