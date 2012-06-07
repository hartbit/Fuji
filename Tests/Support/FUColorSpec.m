//
//  FUColorSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"


SPEC_BEGIN(FUColor)

describe(@"The color data type", ^{
	context(@"creating with bytes", ^{
		it(@"converts all components to the range 0..1", ^{
			GLKVector4 color = FUColorFromBytes(255, 102, 204, 0);
			expect(color.r).to.beCloseTo(1.0f);
			expect(color.g).to.beCloseTo(0.4f);
			expect(color.b).to.beCloseTo(0.8f);
			expect(color.a).to.beCloseTo(0.0f);
		});
	});

	context(@"creating with constants", ^{
		it(@"have the correct color components", ^{
			expect(GLKVector4AllEqualToVector4(FUColorAliceBlue, FUColorFromBytes(240, 248, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAntiqueWhite, FUColorFromBytes(250, 235, 215, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAqua, FUColorFromBytes(0, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAquamarine, FUColorFromBytes(127, 255, 212, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAzure, FUColorFromBytes(240, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBeige, FUColorFromBytes(245, 245, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBisque, FUColorFromBytes(255, 228, 196, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlack, FUColorFromBytes(0, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlanchedAlmond, FUColorFromBytes(255, 235, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlue, FUColorFromBytes(0, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlueViolet, FUColorFromBytes(138, 43, 226, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBrown, FUColorFromBytes(165, 42, 42, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBurlyWood, FUColorFromBytes(222, 184, 135, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCadetBlue, FUColorFromBytes(95, 158, 160, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorChartreuse, FUColorFromBytes(127, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorChocolate, FUColorFromBytes(210, 105, 30, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCoral, FUColorFromBytes(255, 127, 80, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCornflowerBlue, FUColorFromBytes(100, 149, 237, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCornsilk, FUColorFromBytes(255, 248, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCrimson, FUColorFromBytes(220, 20, 60, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCyan, FUColorFromBytes(0, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkBlue, FUColorFromBytes(0, 0, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkCyan, FUColorFromBytes(0, 139, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkGoldenrod, FUColorFromBytes(184, 134, 11, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkGray, FUColorFromBytes(169, 169, 169, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkGreen, FUColorFromBytes(0, 100, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkKhaki, FUColorFromBytes(189, 183, 107, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkMagenta, FUColorFromBytes(139, 0, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkOliveGreen, FUColorFromBytes(85, 107, 47, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkOrange, FUColorFromBytes(255, 140, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkOrchid, FUColorFromBytes(153, 50, 204, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkRed, FUColorFromBytes(139, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSalmon, FUColorFromBytes(233, 150, 122, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSeaGreen, FUColorFromBytes(143, 188, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSlateBlue, FUColorFromBytes(72, 61, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSlateGray, FUColorFromBytes(47, 79, 79, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkTurquoise, FUColorFromBytes(0, 206, 209, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkViolet, FUColorFromBytes(148, 0, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDeepPink, FUColorFromBytes(255, 20, 147, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDeepSkyBlue, FUColorFromBytes(0, 191, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDimGray, FUColorFromBytes(105, 105, 105, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDodgerBlue, FUColorFromBytes(30, 144, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorFirebrick, FUColorFromBytes(178, 34, 34, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorFloralWhite, FUColorFromBytes(255, 250, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorForestGreen, FUColorFromBytes(34, 139, 34, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorFuchsia, FUColorFromBytes(255, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGainsboro, FUColorFromBytes(220, 220, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGhostWhite, FUColorFromBytes(248, 248, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGold, FUColorFromBytes(255, 215, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGoldenrod, FUColorFromBytes(218, 165, 32, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGray, FUColorFromBytes(128, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGreen, FUColorFromBytes(0, 128, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGreenYellow, FUColorFromBytes(173, 255, 47, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorHoneydew, FUColorFromBytes(240, 255, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorHotPink, FUColorFromBytes(255, 105, 180, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorIndianRed, FUColorFromBytes(205, 92, 92, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorIndigo, FUColorFromBytes(75, 0, 130, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorIvory, FUColorFromBytes(255, 255, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorKhaki, FUColorFromBytes(240, 230, 140, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLavender, FUColorFromBytes(230, 230, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLavenderBlush, FUColorFromBytes(255, 240, 245, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLawnGreen, FUColorFromBytes(124, 252, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLemonChiffon, FUColorFromBytes(255, 250, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightBlue, FUColorFromBytes(173, 216, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightCoral, FUColorFromBytes(240, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightCyan, FUColorFromBytes(224, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightGoldenrodYellow, FUColorFromBytes(250, 250, 210, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightGray, FUColorFromBytes(211, 211, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightGreen, FUColorFromBytes(144, 238, 144, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightPink, FUColorFromBytes(255, 182, 193, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSalmon, FUColorFromBytes(255, 160, 122, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSeaGreen, FUColorFromBytes(32, 178, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSkyBlue, FUColorFromBytes(135, 206, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSlateGray, FUColorFromBytes(119, 136, 153, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSteelBlue, FUColorFromBytes(176, 196, 222, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightYellow, FUColorFromBytes(255, 255, 224, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLime, FUColorFromBytes(0, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLimeGreen, FUColorFromBytes(50, 205, 50, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLinen, FUColorFromBytes(250, 240, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMagenta, FUColorFromBytes(255, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMaroon, FUColorFromBytes(128, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumAquamarine, FUColorFromBytes(102, 205, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumBlue, FUColorFromBytes(0, 0, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumOrchid, FUColorFromBytes(186, 85, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumPurple, FUColorFromBytes(147, 112, 219, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumSeaGreen, FUColorFromBytes(60, 179, 113, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumSlateBlue, FUColorFromBytes(123, 104, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumSpringGreen, FUColorFromBytes(0, 250, 154, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumTurquoise, FUColorFromBytes(72, 209, 204, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumVioletRed, FUColorFromBytes(199, 21, 133, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMidnightBlue, FUColorFromBytes(25, 25, 112, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMintCream, FUColorFromBytes(245, 255, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMistyRose, FUColorFromBytes(255, 228, 225, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMoccasin, FUColorFromBytes(255, 228, 181, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorNavajoWhite, FUColorFromBytes(255, 222, 173, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorNavy, FUColorFromBytes(0, 0, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOldLace, FUColorFromBytes(253, 245, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOlive, FUColorFromBytes(128, 128, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOliveDrab, FUColorFromBytes(107, 142, 35, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOrange, FUColorFromBytes(255, 165, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOrangeRed, FUColorFromBytes(255, 69, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOrchid, FUColorFromBytes(218, 112, 214, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleGoldenrod, FUColorFromBytes(238, 232, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleGreen, FUColorFromBytes(152, 251, 152, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleTurquoise, FUColorFromBytes(175, 238, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleVioletRed, FUColorFromBytes(219, 112, 147, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPapayaWhip, FUColorFromBytes(255, 239, 213, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPeachPuff, FUColorFromBytes(255, 218, 185, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPeru, FUColorFromBytes(205, 133, 63, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPink, FUColorFromBytes(255, 192, 203, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPlum, FUColorFromBytes(221, 160, 221, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPowderBlue, FUColorFromBytes(176, 224, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPurple, FUColorFromBytes(128, 0, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorRed, FUColorFromBytes(255, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorRosyBrown, FUColorFromBytes(188, 143, 143, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorRoyalBlue, FUColorFromBytes(65, 105, 225, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSaddleBrown, FUColorFromBytes(139, 69, 19, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSalmon, FUColorFromBytes(250, 128, 114, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSandyBrown, FUColorFromBytes(244, 164, 96, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSeaGreen, FUColorFromBytes(46, 139, 87, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSeaShell, FUColorFromBytes(255, 245, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSienna, FUColorFromBytes(160, 82, 45, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSilver, FUColorFromBytes(192, 192, 192, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSkyBlue, FUColorFromBytes(135, 206, 235, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSlateBlue, FUColorFromBytes(106, 90, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSlateGray, FUColorFromBytes(112, 128, 144, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSnow, FUColorFromBytes(255, 250, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSpringGreen, FUColorFromBytes(0, 255, 127, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSteelBlue, FUColorFromBytes(70, 130, 180, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTan, FUColorFromBytes(210, 180, 140, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTeal, FUColorFromBytes(0, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorThistle, FUColorFromBytes(216, 191, 216, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTomato, FUColorFromBytes(255, 99, 71, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTransparentBlack, FUColorFromBytes(0, 0, 0, 0))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTransparentWhite, FUColorFromBytes(255, 255, 255, 0))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTurquoise, FUColorFromBytes(64, 224, 208, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorViolet, FUColorFromBytes(238, 130, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorWheat, FUColorFromBytes(245, 222, 179, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorWhite, FUColorFromBytes(255, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorWhiteSmoke, FUColorFromBytes(245, 245, 245, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorYellow, FUColorFromBytes(255, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorYellowGreen, FUColorFromBytes(154, 205, 50, 255))).to.beTruthy();
		});
	});
});

SPEC_END
