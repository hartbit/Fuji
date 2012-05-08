//
//  FUColorSpec.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUColor)

describe(@"The color data type", ^{
	context(@"created a color", ^{
		__block FUColor color;
		
		beforeEach(^{
			color = FUColorMake(255, 89, 187, 145);
		});
		
		it(@"the components return the components at creation", ^{
			expect(color.red).to.equal(255);
			expect(color.green).to.equal(89);
			expect(color.blue).to.equal(187);
			expect(color.alpha).to.equal(145);
		});
		
		context(@"creating a color with the same values as the first color", ^{
			it(@"they are equal", ^{
				FUColor color2 = FUColorMake(255, 89, 187, 145);
				expect(FUColorAreEqual(color, color2)).to.beTruthy();
			});
		});
		
		context(@"creating a color with a different red component", ^{
			it(@"they are not equal", ^{
				FUColor color2 = FUColorMake(58, 89, 187, 145);
				expect(FUColorAreEqual(color, color2)).to.beFalsy();
			});
		});
		
		context(@"creating a color with a different green component", ^{
			it(@"they are not equal", ^{
				FUColor color2 = FUColorMake(255, 128, 187, 145);
				expect(FUColorAreEqual(color, color2)).to.beFalsy();
			});
		});
		
		context(@"creating a color with a different blue component", ^{
			it(@"they are not equal", ^{
				FUColor color2 = FUColorMake(255, 89, 212, 145);
				expect(FUColorAreEqual(color, color2)).to.beFalsy();
			});
		});
		
		context(@"creating a color with a different alpha component", ^{
			it(@"they are not equal", ^{
				FUColor color2 = FUColorMake(255, 89, 187, 15);
				expect(FUColorAreEqual(color, color2)).to.beFalsy();
			});
		});
		
		context(@"creating a color with all components different", ^{
			it(@"they are not equal", ^{
				FUColor color2 = FUColorMake(69, 125, 45, 115);
				expect(FUColorAreEqual(color, color2)).to.beFalsy();
			});
		});
		
		context(@"converting to a GLKVector4", ^{
			it(@"returns a vector 4 with values in the range (0, 1)", ^{
				GLKVector4 vectorColor = FUVector4FromColor(color);
				expect(vectorColor.r).to.beCloseToWithin(255 / 255.0f, FLT_EPSILON);
				expect(vectorColor.g).to.beCloseToWithin(89 / 255.0f, FLT_EPSILON);
				expect(vectorColor.b).to.beCloseToWithin(187 / 255.0f, FLT_EPSILON);
				expect(vectorColor.a).to.beCloseToWithin(145 / 255.0f, FLT_EPSILON);
			});
		});
	});

	context(@"creating with constants", ^{
		it(@"have the correct color components", ^{
			expect(FUColorAreEqual(FUColorAliceBlue, FUColorMake(240, 248, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorAntiqueWhite, FUColorMake(250, 235, 215, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorAqua, FUColorMake(0, 255, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorAquamarine, FUColorMake(127, 255, 212, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorAzure, FUColorMake(240, 255, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBeige, FUColorMake(245, 245, 220, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBisque, FUColorMake(255, 228, 196, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBlack, FUColorMake(0, 0, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBlanchedAlmond, FUColorMake(255, 235, 205, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBlue, FUColorMake(0, 0, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBlueViolet, FUColorMake(138, 43, 226, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBrown, FUColorMake(165, 42, 42, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorBurlyWood, FUColorMake(222, 184, 135, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorCadetBlue, FUColorMake(95, 158, 160, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorChartreuse, FUColorMake(127, 255, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorChocolate, FUColorMake(210, 105, 30, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorCoral, FUColorMake(255, 127, 80, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorCornflowerBlue, FUColorMake(100, 149, 237, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorCornsilk, FUColorMake(255, 248, 220, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorCrimson, FUColorMake(220, 20, 60, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorCyan, FUColorMake(0, 255, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkBlue, FUColorMake(0, 0, 139, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkCyan, FUColorMake(0, 139, 139, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkGoldenrod, FUColorMake(184, 134, 11, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkGray, FUColorMake(169, 169, 169, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkGreen, FUColorMake(0, 100, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkKhaki, FUColorMake(189, 183, 107, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkMagenta, FUColorMake(139, 0, 139, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkOliveGreen, FUColorMake(85, 107, 47, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkOrange, FUColorMake(255, 140, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkOrchid, FUColorMake(153, 50, 204, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkRed, FUColorMake(139, 0, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkSalmon, FUColorMake(233, 150, 122, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkSeaGreen, FUColorMake(143, 188, 139, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkSlateBlue, FUColorMake(72, 61, 139, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkSlateGray, FUColorMake(47, 79, 79, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkTurquoise, FUColorMake(0, 206, 209, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDarkViolet, FUColorMake(148, 0, 211, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDeepPink, FUColorMake(255, 20, 147, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDeepSkyBlue, FUColorMake(0, 191, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDimGray, FUColorMake(105, 105, 105, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorDodgerBlue, FUColorMake(30, 144, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorFirebrick, FUColorMake(178, 34, 34, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorFloralWhite, FUColorMake(255, 250, 240, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorForestGreen, FUColorMake(34, 139, 34, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorFuchsia, FUColorMake(255, 0, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorGainsboro, FUColorMake(220, 220, 220, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorGhostWhite, FUColorMake(248, 248, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorGold, FUColorMake(255, 215, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorGoldenrod, FUColorMake(218, 165, 32, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorGray, FUColorMake(128, 128, 128, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorGreen, FUColorMake(0, 128, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorGreenYellow, FUColorMake(173, 255, 47, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorHoneydew, FUColorMake(240, 255, 240, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorHotPink, FUColorMake(255, 105, 180, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorIndianRed, FUColorMake(205, 92, 92, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorIndigo, FUColorMake(75, 0, 130, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorIvory, FUColorMake(255, 255, 240, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorKhaki, FUColorMake(240, 230, 140, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLavender, FUColorMake(230, 230, 250, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLavenderBlush, FUColorMake(255, 240, 245, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLawnGreen, FUColorMake(124, 252, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLemonChiffon, FUColorMake(255, 250, 205, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightBlue, FUColorMake(173, 216, 230, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightCoral, FUColorMake(240, 128, 128, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightCyan, FUColorMake(224, 255, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightGoldenrodYellow, FUColorMake(250, 250, 210, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightGray, FUColorMake(211, 211, 211, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightGreen, FUColorMake(144, 238, 144, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightPink, FUColorMake(255, 182, 193, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightSalmon, FUColorMake(255, 160, 122, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightSeaGreen, FUColorMake(32, 178, 170, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightSkyBlue, FUColorMake(135, 206, 250, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightSlateGray, FUColorMake(119, 136, 153, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightSteelBlue, FUColorMake(176, 196, 222, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLightYellow, FUColorMake(255, 255, 224, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLime, FUColorMake(0, 255, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLimeGreen, FUColorMake(50, 205, 50, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorLinen, FUColorMake(250, 240, 230, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMagenta, FUColorMake(255, 0, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMaroon, FUColorMake(128, 0, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumAquamarine, FUColorMake(102, 205, 170, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumBlue, FUColorMake(0, 0, 205, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumOrchid, FUColorMake(186, 85, 211, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumPurple, FUColorMake(147, 112, 219, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumSeaGreen, FUColorMake(60, 179, 113, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumSlateBlue, FUColorMake(123, 104, 238, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumSpringGreen, FUColorMake(0, 250, 154, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumTurquoise, FUColorMake(72, 209, 204, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMediumVioletRed, FUColorMake(199, 21, 133, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMidnightBlue, FUColorMake(25, 25, 112, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMintCream, FUColorMake(245, 255, 250, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMistyRose, FUColorMake(255, 228, 225, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorMoccasin, FUColorMake(255, 228, 181, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorNavajoWhite, FUColorMake(255, 222, 173, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorNavy, FUColorMake(0, 0, 128, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorOldLace, FUColorMake(253, 245, 230, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorOlive, FUColorMake(128, 128, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorOliveDrab, FUColorMake(107, 142, 35, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorOrange, FUColorMake(255, 165, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorOrangeRed, FUColorMake(255, 69, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorOrchid, FUColorMake(218, 112, 214, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPaleGoldenrod, FUColorMake(238, 232, 170, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPaleGreen, FUColorMake(152, 251, 152, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPaleTurquoise, FUColorMake(175, 238, 238, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPaleVioletRed, FUColorMake(219, 112, 147, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPapayaWhip, FUColorMake(255, 239, 213, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPeachPuff, FUColorMake(255, 218, 185, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPeru, FUColorMake(205, 133, 63, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPink, FUColorMake(255, 192, 203, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPlum, FUColorMake(221, 160, 221, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPowderBlue, FUColorMake(176, 224, 230, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorPurple, FUColorMake(128, 0, 128, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorRed, FUColorMake(255, 0, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorRosyBrown, FUColorMake(188, 143, 143, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorRoyalBlue, FUColorMake(65, 105, 225, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSaddleBrown, FUColorMake(139, 69, 19, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSalmon, FUColorMake(250, 128, 114, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSandyBrown, FUColorMake(244, 164, 96, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSeaGreen, FUColorMake(46, 139, 87, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSeaShell, FUColorMake(255, 245, 238, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSienna, FUColorMake(160, 82, 45, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSilver, FUColorMake(192, 192, 192, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSkyBlue, FUColorMake(135, 206, 235, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSlateBlue, FUColorMake(106, 90, 205, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSlateGray, FUColorMake(112, 128, 144, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSnow, FUColorMake(255, 250, 250, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSpringGreen, FUColorMake(0, 255, 127, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorSteelBlue, FUColorMake(70, 130, 180, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorTan, FUColorMake(210, 180, 140, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorTeal, FUColorMake(0, 128, 128, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorThistle, FUColorMake(216, 191, 216, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorTomato, FUColorMake(255, 99, 71, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorTransparentBlack, FUColorMake(0, 0, 0, 0))).to.beTruthy();
			expect(FUColorAreEqual(FUColorTransparentWhite, FUColorMake(255, 255, 255, 0))).to.beTruthy();
			expect(FUColorAreEqual(FUColorTurquoise, FUColorMake(64, 224, 208, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorViolet, FUColorMake(238, 130, 238, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorWheat, FUColorMake(245, 222, 179, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorWhite, FUColorMake(255, 255, 255, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorWhiteSmoke, FUColorMake(245, 245, 245, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorYellow, FUColorMake(255, 255, 0, 255))).to.beTruthy();
			expect(FUColorAreEqual(FUColorYellowGreen, FUColorMake(154, 205, 50, 255))).to.beTruthy();
		});
	});
});

SPEC_END
