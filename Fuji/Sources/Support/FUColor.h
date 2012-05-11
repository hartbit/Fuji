//
//  FUColor.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <OpenGLES/ES2/gl.h>
#import <GLKit/GLKit.h>


typedef struct
{
	GLubyte red;
	GLubyte green;
	GLubyte blue;
	GLubyte alpha;
} FUColor;


/** A system-defined color with the value R:240 G:248 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorAliceBlue;
/** A system-defined color with the value R:250 G:235 B:215 A:255. */
OBJC_EXPORT const FUColor FUColorAntiqueWhite;
/** A system-defined color with the value R:0 G:255 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorAqua;
/** A system-defined color with the value R:127 G:255 B:212 A:255. */
OBJC_EXPORT const FUColor FUColorAquamarine;
/** A system-defined color with the value R:240 G:255 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorAzure;
/** A system-defined color with the value R:245 G:245 B:220 A:255. */
OBJC_EXPORT const FUColor FUColorBeige;
/** A system-defined color with the value R:255 G:228 B:196 A:255. */
OBJC_EXPORT const FUColor FUColorBisque;
/** A system-defined color with the value R:0 G:0 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorBlack;
/** A system-defined color with the value R:255 G:235 B:205 A:255. */
OBJC_EXPORT const FUColor FUColorBlanchedAlmond;
/** A system-defined color with the value R:0 G:0 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorBlue;
/** A system-defined color with the value R:138 G:43 B:226 A:255. */
OBJC_EXPORT const FUColor FUColorBlueViolet;
/** A system-defined color with the value R:165 G:42 B:42 A:255. */
OBJC_EXPORT const FUColor FUColorBrown;
/** A system-defined color with the value R:222 G:184 B:135 A:255. */
OBJC_EXPORT const FUColor FUColorBurlyWood;
/** A system-defined color with the value R:95 G:158 B:160 A:255. */
OBJC_EXPORT const FUColor FUColorCadetBlue;
/** A system-defined color with the value R:127 G:255 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorChartreuse;
/** A system-defined color with the value R:210 G:105 B:30 A:255. */
OBJC_EXPORT const FUColor FUColorChocolate;
/** A system-defined color with the value R:255 G:127 B:80 A:255. */
OBJC_EXPORT const FUColor FUColorCoral;
/** A system-defined color with the value R:100 G:149 B:237 A:255. */
OBJC_EXPORT const FUColor FUColorCornflowerBlue;
/** A system-defined color with the value R:255 G:248 B:220 A:255. */
OBJC_EXPORT const FUColor FUColorCornsilk;
/** A system-defined color with the value R:220 G:20 B:60 A:255. */
OBJC_EXPORT const FUColor FUColorCrimson;
/** A system-defined color with the value R:0 G:255 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorCyan;
/** A system-defined color with the value R:0 G:0 B:139 A:255. */
OBJC_EXPORT const FUColor FUColorDarkBlue;
/** A system-defined color with the value R:0 G:139 B:139 A:255. */
OBJC_EXPORT const FUColor FUColorDarkCyan;
/** A system-defined color with the value R:184 G:134 B:11 A:255. */
OBJC_EXPORT const FUColor FUColorDarkGoldenrod;
/** A system-defined color with the value R:169 G:169 B:169 A:255. */
OBJC_EXPORT const FUColor FUColorDarkGray;
/** A system-defined color with the value R:0 G:100 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorDarkGreen;
/** A system-defined color with the value R:189 G:183 B:107 A:255. */
OBJC_EXPORT const FUColor FUColorDarkKhaki;
/** A system-defined color with the value R:139 G:0 B:139 A:255. */
OBJC_EXPORT const FUColor FUColorDarkMagenta;
/** A system-defined color with the value R:85 G:107 B:47 A:255. */
OBJC_EXPORT const FUColor FUColorDarkOliveGreen;
/** A system-defined color with the value R:255 G:140 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorDarkOrange;
/** A system-defined color with the value R:153 G:50 B:204 A:255. */
OBJC_EXPORT const FUColor FUColorDarkOrchid;
/** A system-defined color with the value R:139 G:0 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorDarkRed;
/** A system-defined color with the value R:233 G:150 B:122 A:255. */
OBJC_EXPORT const FUColor FUColorDarkSalmon;
/** A system-defined color with the value R:143 G:188 B:139 A:255. */
OBJC_EXPORT const FUColor FUColorDarkSeaGreen;
/** A system-defined color with the value R:72 G:61 B:139 A:255. */
OBJC_EXPORT const FUColor FUColorDarkSlateBlue;
/** A system-defined color with the value R:47 G:79 B:79 A:255. */
OBJC_EXPORT const FUColor FUColorDarkSlateGray;
/** A system-defined color with the value R:0 G:206 B:209 A:255. */
OBJC_EXPORT const FUColor FUColorDarkTurquoise;
/** A system-defined color with the value R:148 G:0 B:211 A:255. */
OBJC_EXPORT const FUColor FUColorDarkViolet;
/** A system-defined color with the value R:255 G:20 B:147 A:255. */
OBJC_EXPORT const FUColor FUColorDeepPink;
/** A system-defined color with the value R:0 G:191 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorDeepSkyBlue;
/** A system-defined color with the value R:105 G:105 B:105 A:255. */
OBJC_EXPORT const FUColor FUColorDimGray;
/** A system-defined color with the value R:30 G:144 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorDodgerBlue;
/** A system-defined color with the value R:178 G:34 B:34 A:255. */
OBJC_EXPORT const FUColor FUColorFirebrick;
/** A system-defined color with the value R:255 G:250 B:240 A:255. */
OBJC_EXPORT const FUColor FUColorFloralWhite;
/** A system-defined color with the value R:34 G:139 B:34 A:255. */
OBJC_EXPORT const FUColor FUColorForestGreen;
/** A system-defined color with the value R:255 G:0 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorFuchsia;
/** A system-defined color with the value R:220 G:220 B:220 A:255. */
OBJC_EXPORT const FUColor FUColorGainsboro;
/** A system-defined color with the value R:248 G:248 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorGhostWhite;
/** A system-defined color with the value R:255 G:215 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorGold;
/** A system-defined color with the value R:218 G:165 B:32 A:255. */
OBJC_EXPORT const FUColor FUColorGoldenrod;
/** A system-defined color with the value R:128 G:128 B:128 A:255. */
OBJC_EXPORT const FUColor FUColorGray;
/** A system-defined color with the value R:0 G:128 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorGreen;
/** A system-defined color with the value R:173 G:255 B:47 A:255. */
OBJC_EXPORT const FUColor FUColorGreenYellow;
/** A system-defined color with the value R:240 G:255 B:240 A:255. */
OBJC_EXPORT const FUColor FUColorHoneydew;
/** A system-defined color with the value R:255 G:105 B:180 A:255. */
OBJC_EXPORT const FUColor FUColorHotPink;
/** A system-defined color with the value R:205 G:92 B:92 A:255. */
OBJC_EXPORT const FUColor FUColorIndianRed;
/** A system-defined color with the value R:75 G:0 B:130 A:255. */
OBJC_EXPORT const FUColor FUColorIndigo;
/** A system-defined color with the value R:255 G:255 B:240 A:255. */
OBJC_EXPORT const FUColor FUColorIvory;
/** A system-defined color with the value R:240 G:230 B:140 A:255. */
OBJC_EXPORT const FUColor FUColorKhaki;
/** A system-defined color with the value R:230 G:230 B:250 A:255. */
OBJC_EXPORT const FUColor FUColorLavender;
/** A system-defined color with the value R:255 G:240 B:245 A:255. */
OBJC_EXPORT const FUColor FUColorLavenderBlush;
/** A system-defined color with the value R:124 G:252 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorLawnGreen;
/** A system-defined color with the value R:255 G:250 B:205 A:255. */
OBJC_EXPORT const FUColor FUColorLemonChiffon;
/** A system-defined color with the value R:173 G:216 B:230 A:255. */
OBJC_EXPORT const FUColor FUColorLightBlue;
/** A system-defined color with the value R:240 G:128 B:128 A:255. */
OBJC_EXPORT const FUColor FUColorLightCoral;
/** A system-defined color with the value R:224 G:255 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorLightCyan;
/** A system-defined color with the value R:250 G:250 B:210 A:255. */
OBJC_EXPORT const FUColor FUColorLightGoldenrodYellow;
/** A system-defined color with the value R:211 G:211 B:211 A:255. */
OBJC_EXPORT const FUColor FUColorLightGray;
/** A system-defined color with the value R:144 G:238 B:144 A:255. */
OBJC_EXPORT const FUColor FUColorLightGreen;
/** A system-defined color with the value R:255 G:182 B:193 A:255. */
OBJC_EXPORT const FUColor FUColorLightPink;
/** A system-defined color with the value R:255 G:160 B:122 A:255. */
OBJC_EXPORT const FUColor FUColorLightSalmon;
/** A system-defined color with the value R:32 G:178 B:170 A:255. */
OBJC_EXPORT const FUColor FUColorLightSeaGreen;
/** A system-defined color with the value R:135 G:206 B:250 A:255. */
OBJC_EXPORT const FUColor FUColorLightSkyBlue;
/** A system-defined color with the value R:119 G:136 B:153 A:255. */
OBJC_EXPORT const FUColor FUColorLightSlateGray;
/** A system-defined color with the value R:176 G:196 B:222 A:255. */
OBJC_EXPORT const FUColor FUColorLightSteelBlue;
/** A system-defined color with the value R:255 G:255 B:224 A:255. */
OBJC_EXPORT const FUColor FUColorLightYellow;
/** A system-defined color with the value R:0 G:255 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorLime;
/** A system-defined color with the value R:50 G:205 B:50 A:255. */
OBJC_EXPORT const FUColor FUColorLimeGreen;
/** A system-defined color with the value R:250 G:240 B:230 A:255. */
OBJC_EXPORT const FUColor FUColorLinen;
/** A system-defined color with the value R:255 G:0 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorMagenta;
/** A system-defined color with the value R:128 G:0 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorMaroon;
/** A system-defined color with the value R:102 G:205 B:170 A:255. */
OBJC_EXPORT const FUColor FUColorMediumAquamarine;
/** A system-defined color with the value R:0 G:0 B:205 A:255. */
OBJC_EXPORT const FUColor FUColorMediumBlue;
/** A system-defined color with the value R:186 G:85 B:211 A:255. */
OBJC_EXPORT const FUColor FUColorMediumOrchid;
/** A system-defined color with the value R:147 G:112 B:219 A:255. */
OBJC_EXPORT const FUColor FUColorMediumPurple;
/** A system-defined color with the value R:60 G:179 B:113 A:255. */
OBJC_EXPORT const FUColor FUColorMediumSeaGreen;
/** A system-defined color with the value R:123 G:104 B:238 A:255. */
OBJC_EXPORT const FUColor FUColorMediumSlateBlue;
/** A system-defined color with the value R:0 G:250 B:154 A:255. */
OBJC_EXPORT const FUColor FUColorMediumSpringGreen;
/** A system-defined color with the value R:72 G:209 B:204 A:255. */
OBJC_EXPORT const FUColor FUColorMediumTurquoise;
/** A system-defined color with the value R:199 G:21 B:133 A:255. */
OBJC_EXPORT const FUColor FUColorMediumVioletRed;
/** A system-defined color with the value R:25 G:25 B:112 A:255. */
OBJC_EXPORT const FUColor FUColorMidnightBlue;
/** A system-defined color with the value R:245 G:255 B:250 A:255. */
OBJC_EXPORT const FUColor FUColorMintCream;
/** A system-defined color with the value R:255 G:228 B:225 A:255. */
OBJC_EXPORT const FUColor FUColorMistyRose;
/** A system-defined color with the value R:255 G:228 B:181 A:255. */
OBJC_EXPORT const FUColor FUColorMoccasin;
/** A system-defined color with the value R:255 G:222 B:173 A:255. */
OBJC_EXPORT const FUColor FUColorNavajoWhite;
/** A system-defined color with the value R:0 G:0 B:128 A:255. */
OBJC_EXPORT const FUColor FUColorNavy;
/** A system-defined color with the value R:253 G:245 B:230 A:255. */
OBJC_EXPORT const FUColor FUColorOldLace;
/** A system-defined color with the value R:128 G:128 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorOlive;
/** A system-defined color with the value R:107 G:142 B:35 A:255. */
OBJC_EXPORT const FUColor FUColorOliveDrab;
/** A system-defined color with the value R:255 G:165 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorOrange;
/** A system-defined color with the value R:255 G:69 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorOrangeRed;
/** A system-defined color with the value R:218 G:112 B:214 A:255. */
OBJC_EXPORT const FUColor FUColorOrchid;
/** A system-defined color with the value R:238 G:232 B:170 A:255. */
OBJC_EXPORT const FUColor FUColorPaleGoldenrod;
/** A system-defined color with the value R:152 G:251 B:152 A:255. */
OBJC_EXPORT const FUColor FUColorPaleGreen;
/** A system-defined color with the value R:175 G:238 B:238 A:255. */
OBJC_EXPORT const FUColor FUColorPaleTurquoise;
/** A system-defined color with the value R:219 G:112 B:147 A:255. */
OBJC_EXPORT const FUColor FUColorPaleVioletRed;
/** A system-defined color with the value R:255 G:239 B:213 A:255. */
OBJC_EXPORT const FUColor FUColorPapayaWhip;
/** A system-defined color with the value R:255 G:218 B:185 A:255. */
OBJC_EXPORT const FUColor FUColorPeachPuff;
/** A system-defined color with the value R:205 G:133 B:63 A:255. */
OBJC_EXPORT const FUColor FUColorPeru;
/** A system-defined color with the value R:255 G:192 B:203 A:255. */
OBJC_EXPORT const FUColor FUColorPink;
/** A system-defined color with the value R:221 G:160 B:221 A:255. */
OBJC_EXPORT const FUColor FUColorPlum;
/** A system-defined color with the value R:176 G:224 B:230 A:255. */
OBJC_EXPORT const FUColor FUColorPowderBlue;
/** A system-defined color with the value R:128 G:0 B:128 A:255. */
OBJC_EXPORT const FUColor FUColorPurple;
/** A system-defined color with the value R:255 G:0 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorRed;
/** A system-defined color with the value R:188 G:143 B:143 A:255. */
OBJC_EXPORT const FUColor FUColorRosyBrown;
/** A system-defined color with the value R:65 G:105 B:225 A:255. */
OBJC_EXPORT const FUColor FUColorRoyalBlue;
/** A system-defined color with the value R:139 G:69 B:19 A:255. */
OBJC_EXPORT const FUColor FUColorSaddleBrown;
/** A system-defined color with the value R:250 G:128 B:114 A:255. */
OBJC_EXPORT const FUColor FUColorSalmon;
/** A system-defined color with the value R:244 G:164 B:96 A:255. */
OBJC_EXPORT const FUColor FUColorSandyBrown;
/** A system-defined color with the value R:46 G:139 B:87 A:255. */
OBJC_EXPORT const FUColor FUColorSeaGreen;
/** A system-defined color with the value R:255 G:245 B:238 A:255. */
OBJC_EXPORT const FUColor FUColorSeaShell;
/** A system-defined color with the value R:160 G:82 B:45 A:255. */
OBJC_EXPORT const FUColor FUColorSienna;
/** A system-defined color with the value R:192 G:192 B:192 A:255. */
OBJC_EXPORT const FUColor FUColorSilver;
/** A system-defined color with the value R:135 G:206 B:235 A:255. */
OBJC_EXPORT const FUColor FUColorSkyBlue;
/** A system-defined color with the value R:106 G:90 B:205 A:255. */
OBJC_EXPORT const FUColor FUColorSlateBlue;
/** A system-defined color with the value R:112 G:128 B:144 A:255. */
OBJC_EXPORT const FUColor FUColorSlateGray;
/** A system-defined color with the value R:255 G:250 B:250 A:255. */
OBJC_EXPORT const FUColor FUColorSnow;
/** A system-defined color with the value R:0 G:255 B:127 A:255. */
OBJC_EXPORT const FUColor FUColorSpringGreen;
/** A system-defined color with the value R:70 G:130 B:180 A:255. */
OBJC_EXPORT const FUColor FUColorSteelBlue;
/** A system-defined color with the value R:210 G:180 B:140 A:255. */
OBJC_EXPORT const FUColor FUColorTan;
/** A system-defined color with the value R:0 G:128 B:128 A:255. */
OBJC_EXPORT const FUColor FUColorTeal;
/** A system-defined color with the value R:216 G:191 B:216 A:255. */
OBJC_EXPORT const FUColor FUColorThistle;
/** A system-defined color with the value R:255 G:99 B:71 A:255. */
OBJC_EXPORT const FUColor FUColorTomato;
/** A system-defined color with the value R:0 G:0 B:0 A:0. */
OBJC_EXPORT const FUColor FUColorTransparentBlack;
/** A system-defined color with the value R:255 G:255 B:255 A:0. */
OBJC_EXPORT const FUColor FUColorTransparentWhite;
/** A system-defined color with the value R:64 G:224 B:208 A:255. */
OBJC_EXPORT const FUColor FUColorTurquoise;
/** A system-defined color with the value R:238 G:130 B:238 A:255. */
OBJC_EXPORT const FUColor FUColorViolet;
/** A system-defined color with the value R:245 G:222 B:179 A:255. */
OBJC_EXPORT const FUColor FUColorWheat;
/** A system-defined color with the value R:255 G:255 B:255 A:255. */
OBJC_EXPORT const FUColor FUColorWhite;
/** A system-defined color with the value R:245 G:245 B:245 A:255. */
OBJC_EXPORT const FUColor FUColorWhiteSmoke;
/** A system-defined color with the value R:255 G:255 B:0 A:255. */
OBJC_EXPORT const FUColor FUColorYellow;
/** A system-defined color with the value R:154 G:205 B:50 A:255. */
OBJC_EXPORT const FUColor FUColorYellowGreen;


static OBJC_INLINE FUColor FUColorMake(GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha)
{
	return (FUColor){ red, green, blue, alpha };
}

static OBJC_INLINE BOOL FUColorAreEqual(FUColor left, FUColor right)
{
	return (left.red == right.red) && (left.green == right.green) && (left.blue == right.blue) && (left.alpha == right.alpha);
}

static OBJC_INLINE GLKVector4 FUVector4FromColor(FUColor color)
{
	return GLKVector4Make(color.red / 255.0f, color.green / 255.0f, color.blue / 255.0f, color.alpha / 255.0f);
}
