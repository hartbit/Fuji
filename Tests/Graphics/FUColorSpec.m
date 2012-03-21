//
//  FUColorSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"


SPEC_BEGIN(FUColorSpec)

describe(@"The color data type", ^{
	context(@"creating with byte components", ^{
		it(@"returns a GLKVector4 with components divided by 255", ^{
			GLKVector4 color = FUColorWithBytes(255, 128, 0, 255);
			GLKVector4 expectedColor = GLKVector4Make(1.0f, 0.501960784f, 0.0f, 1.0f);
			expect(color.r).to.beCloseTo(expectedColor.r);
			expect(color.g).to.beCloseTo(expectedColor.g);
			expect(color.b).to.beCloseTo(expectedColor.b);
			expect(color.a).to.beCloseTo(expectedColor.a);
		});
	});

	context(@"creating with constants", ^{
		it(@"have the correct color components", ^{
			expect(GLKVector4AllEqualToVector4(FUColorAliceBlue, FUColorWithBytes(240, 248, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAntiqueWhite, FUColorWithBytes(250, 235, 215, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAqua, FUColorWithBytes(0, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAquamarine, FUColorWithBytes(127, 255, 212, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorAzure, FUColorWithBytes(240, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBeige, FUColorWithBytes(245, 245, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBisque, FUColorWithBytes(255, 228, 196, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlack, FUColorWithBytes(0, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlanchedAlmond, FUColorWithBytes(255, 235, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlue, FUColorWithBytes(0, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBlueViolet, FUColorWithBytes(138, 43, 226, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBrown, FUColorWithBytes(165, 42, 42, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorBurlyWood, FUColorWithBytes(222, 184, 135, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCadetBlue, FUColorWithBytes(95, 158, 160, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorChartreuse, FUColorWithBytes(127, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorChocolate, FUColorWithBytes(210, 105, 30, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCoral, FUColorWithBytes(255, 127, 80, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCornflowerBlue, FUColorWithBytes(100, 149, 237, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCornsilk, FUColorWithBytes(255, 248, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCrimson, FUColorWithBytes(220, 20, 60, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorCyan, FUColorWithBytes(0, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkBlue, FUColorWithBytes(0, 0, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkCyan, FUColorWithBytes(0, 139, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkGoldenrod, FUColorWithBytes(184, 134, 11, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkGray, FUColorWithBytes(169, 169, 169, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkGreen, FUColorWithBytes(0, 100, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkKhaki, FUColorWithBytes(189, 183, 107, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkMagenta, FUColorWithBytes(139, 0, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkOliveGreen, FUColorWithBytes(85, 107, 47, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkOrange, FUColorWithBytes(255, 140, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkOrchid, FUColorWithBytes(153, 50, 204, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkRed, FUColorWithBytes(139, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSalmon, FUColorWithBytes(233, 150, 122, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSeaGreen, FUColorWithBytes(143, 188, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSlateBlue, FUColorWithBytes(72, 61, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkSlateGray, FUColorWithBytes(47, 79, 79, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkTurquoise, FUColorWithBytes(0, 206, 209, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDarkViolet, FUColorWithBytes(148, 0, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDeepPink, FUColorWithBytes(255, 20, 147, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDeepSkyBlue, FUColorWithBytes(0, 191, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDimGray, FUColorWithBytes(105, 105, 105, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorDodgerBlue, FUColorWithBytes(30, 144, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorFirebrick, FUColorWithBytes(178, 34, 34, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorFloralWhite, FUColorWithBytes(255, 250, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorForestGreen, FUColorWithBytes(34, 139, 34, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorFuchsia, FUColorWithBytes(255, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGainsboro, FUColorWithBytes(220, 220, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGhostWhite, FUColorWithBytes(248, 248, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGold, FUColorWithBytes(255, 215, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGoldenrod, FUColorWithBytes(218, 165, 32, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGray, FUColorWithBytes(128, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGreen, FUColorWithBytes(0, 128, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorGreenYellow, FUColorWithBytes(173, 255, 47, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorHoneydew, FUColorWithBytes(240, 255, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorHotPink, FUColorWithBytes(255, 105, 180, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorIndianRed, FUColorWithBytes(205, 92, 92, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorIndigo, FUColorWithBytes(75, 0, 130, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorIvory, FUColorWithBytes(255, 255, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorKhaki, FUColorWithBytes(240, 230, 140, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLavender, FUColorWithBytes(230, 230, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLavenderBlush, FUColorWithBytes(255, 240, 245, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLawnGreen, FUColorWithBytes(124, 252, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLemonChiffon, FUColorWithBytes(255, 250, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightBlue, FUColorWithBytes(173, 216, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightCoral, FUColorWithBytes(240, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightCyan, FUColorWithBytes(224, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightGoldenrodYellow, FUColorWithBytes(250, 250, 210, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightGray, FUColorWithBytes(211, 211, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightGreen, FUColorWithBytes(144, 238, 144, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightPink, FUColorWithBytes(255, 182, 193, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSalmon, FUColorWithBytes(255, 160, 122, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSeaGreen, FUColorWithBytes(32, 178, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSkyBlue, FUColorWithBytes(135, 206, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSlateGray, FUColorWithBytes(119, 136, 153, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightSteelBlue, FUColorWithBytes(176, 196, 222, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLightYellow, FUColorWithBytes(255, 255, 224, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLime, FUColorWithBytes(0, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLimeGreen, FUColorWithBytes(50, 205, 50, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorLinen, FUColorWithBytes(250, 240, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMagenta, FUColorWithBytes(255, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMaroon, FUColorWithBytes(128, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumAquamarine, FUColorWithBytes(102, 205, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumBlue, FUColorWithBytes(0, 0, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumOrchid, FUColorWithBytes(186, 85, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumPurple, FUColorWithBytes(147, 112, 219, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumSeaGreen, FUColorWithBytes(60, 179, 113, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumSlateBlue, FUColorWithBytes(123, 104, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumSpringGreen, FUColorWithBytes(0, 250, 154, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumTurquoise, FUColorWithBytes(72, 209, 204, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMediumVioletRed, FUColorWithBytes(199, 21, 133, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMidnightBlue, FUColorWithBytes(25, 25, 112, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMintCream, FUColorWithBytes(245, 255, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMistyRose, FUColorWithBytes(255, 228, 225, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorMoccasin, FUColorWithBytes(255, 228, 181, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorNavajoWhite, FUColorWithBytes(255, 222, 173, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorNavy, FUColorWithBytes(0, 0, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOldLace, FUColorWithBytes(253, 245, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOlive, FUColorWithBytes(128, 128, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOliveDrab, FUColorWithBytes(107, 142, 35, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOrange, FUColorWithBytes(255, 165, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOrangeRed, FUColorWithBytes(255, 69, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorOrchid, FUColorWithBytes(218, 112, 214, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleGoldenrod, FUColorWithBytes(238, 232, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleGreen, FUColorWithBytes(152, 251, 152, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleTurquoise, FUColorWithBytes(175, 238, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPaleVioletRed, FUColorWithBytes(219, 112, 147, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPapayaWhip, FUColorWithBytes(255, 239, 213, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPeachPuff, FUColorWithBytes(255, 218, 185, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPeru, FUColorWithBytes(205, 133, 63, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPink, FUColorWithBytes(255, 192, 203, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPlum, FUColorWithBytes(221, 160, 221, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPowderBlue, FUColorWithBytes(176, 224, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorPurple, FUColorWithBytes(128, 0, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorRed, FUColorWithBytes(255, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorRosyBrown, FUColorWithBytes(188, 143, 143, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorRoyalBlue, FUColorWithBytes(65, 105, 225, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSaddleBrown, FUColorWithBytes(139, 69, 19, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSalmon, FUColorWithBytes(250, 128, 114, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSandyBrown, FUColorWithBytes(244, 164, 96, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSeaGreen, FUColorWithBytes(46, 139, 87, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSeaShell, FUColorWithBytes(255, 245, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSienna, FUColorWithBytes(160, 82, 45, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSilver, FUColorWithBytes(192, 192, 192, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSkyBlue, FUColorWithBytes(135, 206, 235, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSlateBlue, FUColorWithBytes(106, 90, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSlateGray, FUColorWithBytes(112, 128, 144, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSnow, FUColorWithBytes(255, 250, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSpringGreen, FUColorWithBytes(0, 255, 127, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorSteelBlue, FUColorWithBytes(70, 130, 180, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTan, FUColorWithBytes(210, 180, 140, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTeal, FUColorWithBytes(0, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorThistle, FUColorWithBytes(216, 191, 216, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTomato, FUColorWithBytes(255, 99, 71, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTransparentBlack, FUColorWithBytes(0, 0, 0, 0))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTransparentWhite, FUColorWithBytes(255, 255, 255, 0))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorTurquoise, FUColorWithBytes(64, 224, 208, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorViolet, FUColorWithBytes(238, 130, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorWheat, FUColorWithBytes(245, 222, 179, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorWhite, FUColorWithBytes(255, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorWhiteSmoke, FUColorWithBytes(245, 245, 245, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorYellow, FUColorWithBytes(255, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(FUColorYellowGreen, FUColorWithBytes(154, 205, 50, 255))).to.beTruthy();
		});
	});
});

SPEC_END
