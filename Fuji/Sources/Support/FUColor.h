//
//  FUColor.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <OpenGLES/ES2/gl.h>
#import <GLKit/GLKit.h>


#define FUColorFromBytes(r, g, b, a) (GLKVector4){ (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)/255.0f }


/** A system-defined color with the value R:240 G:248 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorAliceBlue;
/** A system-defined color with the value R:250 G:235 B:215 A:255. */
OBJC_EXPORT const GLKVector4 FUColorAntiqueWhite;
/** A system-defined color with the value R:0 G:255 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorAqua;
/** A system-defined color with the value R:127 G:255 B:212 A:255. */
OBJC_EXPORT const GLKVector4 FUColorAquamarine;
/** A system-defined color with the value R:240 G:255 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorAzure;
/** A system-defined color with the value R:245 G:245 B:220 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBeige;
/** A system-defined color with the value R:255 G:228 B:196 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBisque;
/** A system-defined color with the value R:0 G:0 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBlack;
/** A system-defined color with the value R:255 G:235 B:205 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBlanchedAlmond;
/** A system-defined color with the value R:0 G:0 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBlue;
/** A system-defined color with the value R:138 G:43 B:226 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBlueViolet;
/** A system-defined color with the value R:165 G:42 B:42 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBrown;
/** A system-defined color with the value R:222 G:184 B:135 A:255. */
OBJC_EXPORT const GLKVector4 FUColorBurlyWood;
/** A system-defined color with the value R:95 G:158 B:160 A:255. */
OBJC_EXPORT const GLKVector4 FUColorCadetBlue;
/** A system-defined color with the value R:127 G:255 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorChartreuse;
/** A system-defined color with the value R:210 G:105 B:30 A:255. */
OBJC_EXPORT const GLKVector4 FUColorChocolate;
/** A system-defined color with the value R:255 G:127 B:80 A:255. */
OBJC_EXPORT const GLKVector4 FUColorCoral;
/** A system-defined color with the value R:100 G:149 B:237 A:255. */
OBJC_EXPORT const GLKVector4 FUColorCornflowerBlue;
/** A system-defined color with the value R:255 G:248 B:220 A:255. */
OBJC_EXPORT const GLKVector4 FUColorCornsilk;
/** A system-defined color with the value R:220 G:20 B:60 A:255. */
OBJC_EXPORT const GLKVector4 FUColorCrimson;
/** A system-defined color with the value R:0 G:255 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorCyan;
/** A system-defined color with the value R:0 G:0 B:139 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkBlue;
/** A system-defined color with the value R:0 G:139 B:139 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkCyan;
/** A system-defined color with the value R:184 G:134 B:11 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkGoldenrod;
/** A system-defined color with the value R:169 G:169 B:169 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkGray;
/** A system-defined color with the value R:0 G:100 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkGreen;
/** A system-defined color with the value R:189 G:183 B:107 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkKhaki;
/** A system-defined color with the value R:139 G:0 B:139 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkMagenta;
/** A system-defined color with the value R:85 G:107 B:47 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkOliveGreen;
/** A system-defined color with the value R:255 G:140 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkOrange;
/** A system-defined color with the value R:153 G:50 B:204 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkOrchid;
/** A system-defined color with the value R:139 G:0 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkRed;
/** A system-defined color with the value R:233 G:150 B:122 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkSalmon;
/** A system-defined color with the value R:143 G:188 B:139 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkSeaGreen;
/** A system-defined color with the value R:72 G:61 B:139 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkSlateBlue;
/** A system-defined color with the value R:47 G:79 B:79 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkSlateGray;
/** A system-defined color with the value R:0 G:206 B:209 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkTurquoise;
/** A system-defined color with the value R:148 G:0 B:211 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDarkViolet;
/** A system-defined color with the value R:255 G:20 B:147 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDeepPink;
/** A system-defined color with the value R:0 G:191 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDeepSkyBlue;
/** A system-defined color with the value R:105 G:105 B:105 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDimGray;
/** A system-defined color with the value R:30 G:144 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorDodgerBlue;
/** A system-defined color with the value R:178 G:34 B:34 A:255. */
OBJC_EXPORT const GLKVector4 FUColorFirebrick;
/** A system-defined color with the value R:255 G:250 B:240 A:255. */
OBJC_EXPORT const GLKVector4 FUColorFloralWhite;
/** A system-defined color with the value R:34 G:139 B:34 A:255. */
OBJC_EXPORT const GLKVector4 FUColorForestGreen;
/** A system-defined color with the value R:255 G:0 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorFuchsia;
/** A system-defined color with the value R:220 G:220 B:220 A:255. */
OBJC_EXPORT const GLKVector4 FUColorGainsboro;
/** A system-defined color with the value R:248 G:248 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorGhostWhite;
/** A system-defined color with the value R:255 G:215 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorGold;
/** A system-defined color with the value R:218 G:165 B:32 A:255. */
OBJC_EXPORT const GLKVector4 FUColorGoldenrod;
/** A system-defined color with the value R:128 G:128 B:128 A:255. */
OBJC_EXPORT const GLKVector4 FUColorGray;
/** A system-defined color with the value R:0 G:128 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorGreen;
/** A system-defined color with the value R:173 G:255 B:47 A:255. */
OBJC_EXPORT const GLKVector4 FUColorGreenYellow;
/** A system-defined color with the value R:240 G:255 B:240 A:255. */
OBJC_EXPORT const GLKVector4 FUColorHoneydew;
/** A system-defined color with the value R:255 G:105 B:180 A:255. */
OBJC_EXPORT const GLKVector4 FUColorHotPink;
/** A system-defined color with the value R:205 G:92 B:92 A:255. */
OBJC_EXPORT const GLKVector4 FUColorIndianRed;
/** A system-defined color with the value R:75 G:0 B:130 A:255. */
OBJC_EXPORT const GLKVector4 FUColorIndigo;
/** A system-defined color with the value R:255 G:255 B:240 A:255. */
OBJC_EXPORT const GLKVector4 FUColorIvory;
/** A system-defined color with the value R:240 G:230 B:140 A:255. */
OBJC_EXPORT const GLKVector4 FUColorKhaki;
/** A system-defined color with the value R:230 G:230 B:250 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLavender;
/** A system-defined color with the value R:255 G:240 B:245 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLavenderBlush;
/** A system-defined color with the value R:124 G:252 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLawnGreen;
/** A system-defined color with the value R:255 G:250 B:205 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLemonChiffon;
/** A system-defined color with the value R:173 G:216 B:230 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightBlue;
/** A system-defined color with the value R:240 G:128 B:128 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightCoral;
/** A system-defined color with the value R:224 G:255 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightCyan;
/** A system-defined color with the value R:250 G:250 B:210 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightGoldenrodYellow;
/** A system-defined color with the value R:211 G:211 B:211 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightGray;
/** A system-defined color with the value R:144 G:238 B:144 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightGreen;
/** A system-defined color with the value R:255 G:182 B:193 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightPink;
/** A system-defined color with the value R:255 G:160 B:122 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightSalmon;
/** A system-defined color with the value R:32 G:178 B:170 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightSeaGreen;
/** A system-defined color with the value R:135 G:206 B:250 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightSkyBlue;
/** A system-defined color with the value R:119 G:136 B:153 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightSlateGray;
/** A system-defined color with the value R:176 G:196 B:222 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightSteelBlue;
/** A system-defined color with the value R:255 G:255 B:224 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLightYellow;
/** A system-defined color with the value R:0 G:255 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLime;
/** A system-defined color with the value R:50 G:205 B:50 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLimeGreen;
/** A system-defined color with the value R:250 G:240 B:230 A:255. */
OBJC_EXPORT const GLKVector4 FUColorLinen;
/** A system-defined color with the value R:255 G:0 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMagenta;
/** A system-defined color with the value R:128 G:0 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMaroon;
/** A system-defined color with the value R:102 G:205 B:170 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumAquamarine;
/** A system-defined color with the value R:0 G:0 B:205 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumBlue;
/** A system-defined color with the value R:186 G:85 B:211 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumOrchid;
/** A system-defined color with the value R:147 G:112 B:219 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumPurple;
/** A system-defined color with the value R:60 G:179 B:113 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumSeaGreen;
/** A system-defined color with the value R:123 G:104 B:238 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumSlateBlue;
/** A system-defined color with the value R:0 G:250 B:154 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumSpringGreen;
/** A system-defined color with the value R:72 G:209 B:204 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumTurquoise;
/** A system-defined color with the value R:199 G:21 B:133 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMediumVioletRed;
/** A system-defined color with the value R:25 G:25 B:112 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMidnightBlue;
/** A system-defined color with the value R:245 G:255 B:250 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMintCream;
/** A system-defined color with the value R:255 G:228 B:225 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMistyRose;
/** A system-defined color with the value R:255 G:228 B:181 A:255. */
OBJC_EXPORT const GLKVector4 FUColorMoccasin;
/** A system-defined color with the value R:255 G:222 B:173 A:255. */
OBJC_EXPORT const GLKVector4 FUColorNavajoWhite;
/** A system-defined color with the value R:0 G:0 B:128 A:255. */
OBJC_EXPORT const GLKVector4 FUColorNavy;
/** A system-defined color with the value R:253 G:245 B:230 A:255. */
OBJC_EXPORT const GLKVector4 FUColorOldLace;
/** A system-defined color with the value R:128 G:128 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorOlive;
/** A system-defined color with the value R:107 G:142 B:35 A:255. */
OBJC_EXPORT const GLKVector4 FUColorOliveDrab;
/** A system-defined color with the value R:255 G:165 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorOrange;
/** A system-defined color with the value R:255 G:69 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorOrangeRed;
/** A system-defined color with the value R:218 G:112 B:214 A:255. */
OBJC_EXPORT const GLKVector4 FUColorOrchid;
/** A system-defined color with the value R:238 G:232 B:170 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPaleGoldenrod;
/** A system-defined color with the value R:152 G:251 B:152 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPaleGreen;
/** A system-defined color with the value R:175 G:238 B:238 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPaleTurquoise;
/** A system-defined color with the value R:219 G:112 B:147 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPaleVioletRed;
/** A system-defined color with the value R:255 G:239 B:213 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPapayaWhip;
/** A system-defined color with the value R:255 G:218 B:185 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPeachPuff;
/** A system-defined color with the value R:205 G:133 B:63 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPeru;
/** A system-defined color with the value R:255 G:192 B:203 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPink;
/** A system-defined color with the value R:221 G:160 B:221 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPlum;
/** A system-defined color with the value R:176 G:224 B:230 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPowderBlue;
/** A system-defined color with the value R:128 G:0 B:128 A:255. */
OBJC_EXPORT const GLKVector4 FUColorPurple;
/** A system-defined color with the value R:255 G:0 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorRed;
/** A system-defined color with the value R:188 G:143 B:143 A:255. */
OBJC_EXPORT const GLKVector4 FUColorRosyBrown;
/** A system-defined color with the value R:65 G:105 B:225 A:255. */
OBJC_EXPORT const GLKVector4 FUColorRoyalBlue;
/** A system-defined color with the value R:139 G:69 B:19 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSaddleBrown;
/** A system-defined color with the value R:250 G:128 B:114 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSalmon;
/** A system-defined color with the value R:244 G:164 B:96 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSandyBrown;
/** A system-defined color with the value R:46 G:139 B:87 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSeaGreen;
/** A system-defined color with the value R:255 G:245 B:238 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSeaShell;
/** A system-defined color with the value R:160 G:82 B:45 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSienna;
/** A system-defined color with the value R:192 G:192 B:192 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSilver;
/** A system-defined color with the value R:135 G:206 B:235 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSkyBlue;
/** A system-defined color with the value R:106 G:90 B:205 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSlateBlue;
/** A system-defined color with the value R:112 G:128 B:144 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSlateGray;
/** A system-defined color with the value R:255 G:250 B:250 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSnow;
/** A system-defined color with the value R:0 G:255 B:127 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSpringGreen;
/** A system-defined color with the value R:70 G:130 B:180 A:255. */
OBJC_EXPORT const GLKVector4 FUColorSteelBlue;
/** A system-defined color with the value R:210 G:180 B:140 A:255. */
OBJC_EXPORT const GLKVector4 FUColorTan;
/** A system-defined color with the value R:0 G:128 B:128 A:255. */
OBJC_EXPORT const GLKVector4 FUColorTeal;
/** A system-defined color with the value R:216 G:191 B:216 A:255. */
OBJC_EXPORT const GLKVector4 FUColorThistle;
/** A system-defined color with the value R:255 G:99 B:71 A:255. */
OBJC_EXPORT const GLKVector4 FUColorTomato;
/** A system-defined color with the value R:0 G:0 B:0 A:0. */
OBJC_EXPORT const GLKVector4 FUColorTransparentBlack;
/** A system-defined color with the value R:255 G:255 B:255 A:0. */
OBJC_EXPORT const GLKVector4 FUColorTransparentWhite;
/** A system-defined color with the value R:64 G:224 B:208 A:255. */
OBJC_EXPORT const GLKVector4 FUColorTurquoise;
/** A system-defined color with the value R:238 G:130 B:238 A:255. */
OBJC_EXPORT const GLKVector4 FUColorViolet;
/** A system-defined color with the value R:245 G:222 B:179 A:255. */
OBJC_EXPORT const GLKVector4 FUColorWheat;
/** A system-defined color with the value R:255 G:255 B:255 A:255. */
OBJC_EXPORT const GLKVector4 FUColorWhite;
/** A system-defined color with the value R:245 G:245 B:245 A:255. */
OBJC_EXPORT const GLKVector4 FUColorWhiteSmoke;
/** A system-defined color with the value R:255 G:255 B:0 A:255. */
OBJC_EXPORT const GLKVector4 FUColorYellow;
/** A system-defined color with the value R:154 G:205 B:50 A:255. */
OBJC_EXPORT const GLKVector4 FUColorYellowGreen;
