// ----------------------------------
//           PATRIMONIUM
//   an old school adventure game
//           (C) 2003-09
//     http://www.patrimonium.de
// ----------------------------------
// Constants.s - File for constants
//   adapted from AGAST sample game    
// ----------------------------------

const SCREEN_HEIGHT = 480 ;
const SCREEN_WIDTH  = 640 ;

// Animation Modes
const ANIM_STOP = 0 ;
const ANIM_WALK = 1 ;
const ANIM_TURN = 2 ;
const ANIM_TALK = 3 ;
const ANIM_PLAY = 4 ;

// Print Styles
const STYLE_SOLID   = 0 ;
const STYLE_TRANS   = 1 ;
const STYLE_SHADE   = 2 ;
const STYLE_CLASSIC = 3 ;

// Print Justifications
const JUSTIFY_LEFT   = 0 ;
const JUSTIFY_RIGHT  = 1 ;
const JUSTIFY_CENTER = 2 ;

// Print Base 
const BASE_ABOVE  = 0 ;
const BASE_BELOW  = 1 ;
const BASE_CENTER = 2 ;

// Directions
const DIR_NORTH = 0 ;
const DIR_EAST  = 3 ;
const DIR_SOUTH = 6 ;
const DIR_WEST  = 9 ;


// Color masks - handy for blending
const ALPHA_MASK = 0xFF000000 ;
const RED_MASK   = 0xFF0000 ;
const GREEN_MASK = 0xFF00 ;
const BLUE_MASK  = 0xFF ;

// Colors
const COLOR_BLACK       = constrgb(000, 000, 000) ;
const COLOR_DARK_BLUE   = constrgb(000, 000, 184) ;
const COLOR_GREEN       = constrgb(000, 184, 000) ;
const COLOR_LIGHTGREEN  = constrgb(000, 230, 000) ;
const COLOR_AQUA        = constrgb(000, 240, 080) ;
const COLOR_BROWN       = constrgb(184, 000, 000) ;
const COLOR_PURPLE      = constrgb(184, 000, 184) ;
const COLOR_ORANGE      = constrgb(255, 164, 000) ;
const COLOR_GRAY        = constrgb(204, 204, 204) ;
const COLOR_GREY        = constrgb(204, 204, 204) ;
const COLOR_DARKGREY    = constrgb(099, 099, 099) ;
const COLOR_CHARCOAL    = constrgb(127, 127, 127) ;
const COLOR_BLUE        = constrgb(000, 127, 255) ;
const COLOR_LIGHT_GREEN = constrgb(127, 255, 000) ;
const COLOR_CYAN        = constrgb(086, 255, 255) ;
const COLOR_RED         = constrgb(255, 000, 000) ;
const COLOR_PINK        = constrgb(255, 150, 204) ;
const COLOR_YELLOW      = constrgb(255, 255, 000) ;  
const COLOR_WHITE       = constrgb(255, 255, 255) ;
const COLOR_PLAYER      = constrgb(219, 219, 000) ;
const COLOR_PROF        = constrgb(221, 068, 221) ;
const COLOR_JOHNJACKSON = constrgb(204, 204, 204) ;
const COLOR_JACKJOHNSON = constrgb(134, 067, 000) ;
const COLOR_FPERSONAL   = constrgb(150, 200, 080) ;
const COLOR_TECHNICIAN  = constrgb(200, 020, 020) ;
const COLOR_CHEFPHONE   = constrgb(080, 150, 080) ;
const COLOR_ABPHONE     = constrgb(255, 200, 255) ;
const COLOR_CHEF        = constrgb(255, 255, 255) ;
const COLOR_TAXIFAHRER  = constrgb(252, 255, 070) ;
const COLOR_SCHLEMIEL   = constrgb(170, 025, 030) ;
const COLOR_CONCIERGE   = constrgb(161, 172, 152) ;
const COLOR_HOTELGAST   = constrgb(200, 155, 100) ;
const COLOR_STAN        = constrgb(170, 025, 030) ;
const COLOR_WOOD        = constrgb(100, 068, 032) ;
const COLOR_LECHUCK     = constrgb(187, 221, 255) ;
const COLOR_SCIENTIST   = constrgb(022, 081, 120) ;
const COLOR_ROSA        = constrgb(106, 188, 227) ;
const COLOR_LANGE       = constrgb(000, 240, 255) ;
const COLOR_STEHER      = constrgb(070, 100, 200) ;

// Transition Effects
const EFFECT_NONE        = 0 ;
const EFFECT_BLEND       = 1 ;
const EFFECT_FADE        = 2 ;
const EFFECT_FADE_IN     = 3 ;
const EFFECT_FADE_OUT    = 4 ;
const EFFECT_BLANK       = 5 ;
const EFFECT_BLANK_IN    = 6 ;
const EFFECT_BLANK_OUT   = 7 ;
const EFFECT_BOX_IN      = 8 ;
const EFFECT_BOX_OUT     = 9 ;
const EFFECT_WIPE_UP     = 10 ;
const EFFECT_WIPE_DOWN   = 11 ;
const EFFECT_WIPE_LEFT   = 12 ;
const EFFECT_WIPE_RIGHT  = 13 ;
const EFFECT_ZOOM_OUT    = 14 ;
const EFFECT_ZOOM_IN     = 15 ;
const EFFECT_SLIDE_UP    = 16 ;
const EFFECT_SLIDE_DOWN  = 17 ;
const EFFECT_SLIDE_LEFT  = 18 ;
const EFFECT_SLIDE_RIGHT = 19 ;

// Linear Sound Panning
const PAN_LEFT     = 0 ;
const PAN_CENTER   = 127 ;
const PAN_RIGHT    = 255 ;
const PAN_SURROUND = 256 ;
const PAN_STEREO   = 257 ;

// Sound Frequencies
const FREQ_RESOURCE = 0 ;
const FREQ_MIN      = 100 ;
const FREQ_MAX      = 705600 ;

// Sound Volume
const VOLUME_MUTE = 0 ;
const VOLUME_HALF = 127 ;
const VOLUME_FULL = 255 ;

// Sound Looping
const LOOP_NONE    = 0 ;
var   LOOP_FOREVER = -1 ;

// Priority Constants
const PRIORITY_LOWEST  = 0 ;
const PRIORITY_HIGHEST = 255 ;
const PRIORITY_AUTO    = 256 ;

// Transparency Modes
const TRANSPARENCY_ALPHA    = 1 ;
const TRANSPARENCY_ADDITIVE = 2 ;

// ZBuffer modes for use with the vertex buffer
const Z_IGNORE       = 0 ;
const Z_DRAW_GREATER = 1 ;
                                         
// Primitive types for use with the vertex buffer
const PRIMITIVE_TRIANGLELIST = 0 ;
const PRIMITIVE_LINELIST     = 1 ;
const PRIMITIVE_POINTLIST    = 2 ;

// Math 
const FLOAT_PI = 3.1415926 ;

// Riddles (used in Act IV) 
const RIDDLE_NONE       = 0 ;
const RIDDLE_MOTHER     = 1 ;
const RIDDLE_PIGEON     = 2 ;
const RIDDLE_NUMBER     = 3 ;
const RIDDLE_CHESS      = 4 ;
const RIDDLE_ROPELADDER = 5 ;
const RIDDLE_PARADOX    = 6 ;
const RIDDLE_INTEGER    = 7 ;
const RIDDLE_SHANDY     = 8 ;
