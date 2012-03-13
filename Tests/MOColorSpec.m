//
//  MOSceneSpec.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "Mocha2D.h"


SPEC_BEGIN(MOColorSpec)

describe(@"MOColor", ^{
	context(@"MOColorWithBytes", ^{
		it(@"should create a GLKVector4 with components divided by 255", ^{
			GLKVector4 color = MOColorWithBytes(255, 128, 0, 255);
			GLKVector4 expectedColor = GLKVector4Make(1.0f, 0.501960784f, 0.0f, 1.0f);
			expect(color.r).to.beCloseTo(expectedColor.r);
			expect(color.g).to.beCloseTo(expectedColor.g);
			expect(color.b).to.beCloseTo(expectedColor.b);
			expect(color.a).to.beCloseTo(expectedColor.a);
		});
	});
	context(@"Constants", ^{
		it(@"should have the correct color components", ^{
			expect(GLKVector4AllEqualToVector4(MOColorAliceBlue, MOColorWithBytes(240, 248, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorAntiqueWhite, MOColorWithBytes(250, 235, 215, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorAqua, MOColorWithBytes(0, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorAquamarine, MOColorWithBytes(127, 255, 212, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorAzure, MOColorWithBytes(240, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBeige, MOColorWithBytes(245, 245, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBisque, MOColorWithBytes(255, 228, 196, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBlack, MOColorWithBytes(0, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBlanchedAlmond, MOColorWithBytes(255, 235, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBlue, MOColorWithBytes(0, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBlueViolet, MOColorWithBytes(138, 43, 226, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBrown, MOColorWithBytes(165, 42, 42, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorBurlyWood, MOColorWithBytes(222, 184, 135, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorCadetBlue, MOColorWithBytes(95, 158, 160, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorChartreuse, MOColorWithBytes(127, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorChocolate, MOColorWithBytes(210, 105, 30, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorCoral, MOColorWithBytes(255, 127, 80, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorCornflowerBlue, MOColorWithBytes(100, 149, 237, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorCornsilk, MOColorWithBytes(255, 248, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorCrimson, MOColorWithBytes(220, 20, 60, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorCyan, MOColorWithBytes(0, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkBlue, MOColorWithBytes(0, 0, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkCyan, MOColorWithBytes(0, 139, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkGoldenrod, MOColorWithBytes(184, 134, 11, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkGray, MOColorWithBytes(169, 169, 169, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkGreen, MOColorWithBytes(0, 100, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkKhaki, MOColorWithBytes(189, 183, 107, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkMagenta, MOColorWithBytes(139, 0, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkOliveGreen, MOColorWithBytes(85, 107, 47, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkOrange, MOColorWithBytes(255, 140, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkOrchid, MOColorWithBytes(153, 50, 204, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkRed, MOColorWithBytes(139, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkSalmon, MOColorWithBytes(233, 150, 122, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkSeaGreen, MOColorWithBytes(143, 188, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkSlateBlue, MOColorWithBytes(72, 61, 139, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkSlateGray, MOColorWithBytes(47, 79, 79, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkTurquoise, MOColorWithBytes(0, 206, 209, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDarkViolet, MOColorWithBytes(148, 0, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDeepPink, MOColorWithBytes(255, 20, 147, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDeepSkyBlue, MOColorWithBytes(0, 191, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDimGray, MOColorWithBytes(105, 105, 105, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorDodgerBlue, MOColorWithBytes(30, 144, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorFirebrick, MOColorWithBytes(178, 34, 34, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorFloralWhite, MOColorWithBytes(255, 250, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorForestGreen, MOColorWithBytes(34, 139, 34, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorFuchsia, MOColorWithBytes(255, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorGainsboro, MOColorWithBytes(220, 220, 220, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorGhostWhite, MOColorWithBytes(248, 248, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorGold, MOColorWithBytes(255, 215, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorGoldenrod, MOColorWithBytes(218, 165, 32, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorGray, MOColorWithBytes(128, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorGreen, MOColorWithBytes(0, 128, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorGreenYellow, MOColorWithBytes(173, 255, 47, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorHoneydew, MOColorWithBytes(240, 255, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorHotPink, MOColorWithBytes(255, 105, 180, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorIndianRed, MOColorWithBytes(205, 92, 92, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorIndigo, MOColorWithBytes(75, 0, 130, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorIvory, MOColorWithBytes(255, 255, 240, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorKhaki, MOColorWithBytes(240, 230, 140, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLavender, MOColorWithBytes(230, 230, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLavenderBlush, MOColorWithBytes(255, 240, 245, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLawnGreen, MOColorWithBytes(124, 252, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLemonChiffon, MOColorWithBytes(255, 250, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightBlue, MOColorWithBytes(173, 216, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightCoral, MOColorWithBytes(240, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightCyan, MOColorWithBytes(224, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightGoldenrodYellow, MOColorWithBytes(250, 250, 210, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightGray, MOColorWithBytes(211, 211, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightGreen, MOColorWithBytes(144, 238, 144, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightPink, MOColorWithBytes(255, 182, 193, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightSalmon, MOColorWithBytes(255, 160, 122, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightSeaGreen, MOColorWithBytes(32, 178, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightSkyBlue, MOColorWithBytes(135, 206, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightSlateGray, MOColorWithBytes(119, 136, 153, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightSteelBlue, MOColorWithBytes(176, 196, 222, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLightYellow, MOColorWithBytes(255, 255, 224, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLime, MOColorWithBytes(0, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLimeGreen, MOColorWithBytes(50, 205, 50, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorLinen, MOColorWithBytes(250, 240, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMagenta, MOColorWithBytes(255, 0, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMaroon, MOColorWithBytes(128, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumAquamarine, MOColorWithBytes(102, 205, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumBlue, MOColorWithBytes(0, 0, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumOrchid, MOColorWithBytes(186, 85, 211, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumPurple, MOColorWithBytes(147, 112, 219, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumSeaGreen, MOColorWithBytes(60, 179, 113, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumSlateBlue, MOColorWithBytes(123, 104, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumSpringGreen, MOColorWithBytes(0, 250, 154, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumTurquoise, MOColorWithBytes(72, 209, 204, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMediumVioletRed, MOColorWithBytes(199, 21, 133, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMidnightBlue, MOColorWithBytes(25, 25, 112, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMintCream, MOColorWithBytes(245, 255, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMistyRose, MOColorWithBytes(255, 228, 225, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorMoccasin, MOColorWithBytes(255, 228, 181, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorNavajoWhite, MOColorWithBytes(255, 222, 173, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorNavy, MOColorWithBytes(0, 0, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorOldLace, MOColorWithBytes(253, 245, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorOlive, MOColorWithBytes(128, 128, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorOliveDrab, MOColorWithBytes(107, 142, 35, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorOrange, MOColorWithBytes(255, 165, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorOrangeRed, MOColorWithBytes(255, 69, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorOrchid, MOColorWithBytes(218, 112, 214, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPaleGoldenrod, MOColorWithBytes(238, 232, 170, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPaleGreen, MOColorWithBytes(152, 251, 152, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPaleTurquoise, MOColorWithBytes(175, 238, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPaleVioletRed, MOColorWithBytes(219, 112, 147, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPapayaWhip, MOColorWithBytes(255, 239, 213, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPeachPuff, MOColorWithBytes(255, 218, 185, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPeru, MOColorWithBytes(205, 133, 63, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPink, MOColorWithBytes(255, 192, 203, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPlum, MOColorWithBytes(221, 160, 221, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPowderBlue, MOColorWithBytes(176, 224, 230, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorPurple, MOColorWithBytes(128, 0, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorRed, MOColorWithBytes(255, 0, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorRosyBrown, MOColorWithBytes(188, 143, 143, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorRoyalBlue, MOColorWithBytes(65, 105, 225, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSaddleBrown, MOColorWithBytes(139, 69, 19, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSalmon, MOColorWithBytes(250, 128, 114, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSandyBrown, MOColorWithBytes(244, 164, 96, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSeaGreen, MOColorWithBytes(46, 139, 87, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSeaShell, MOColorWithBytes(255, 245, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSienna, MOColorWithBytes(160, 82, 45, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSilver, MOColorWithBytes(192, 192, 192, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSkyBlue, MOColorWithBytes(135, 206, 235, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSlateBlue, MOColorWithBytes(106, 90, 205, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSlateGray, MOColorWithBytes(112, 128, 144, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSnow, MOColorWithBytes(255, 250, 250, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSpringGreen, MOColorWithBytes(0, 255, 127, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorSteelBlue, MOColorWithBytes(70, 130, 180, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorTan, MOColorWithBytes(210, 180, 140, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorTeal, MOColorWithBytes(0, 128, 128, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorThistle, MOColorWithBytes(216, 191, 216, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorTomato, MOColorWithBytes(255, 99, 71, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorTransparentBlack, MOColorWithBytes(0, 0, 0, 0))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorTransparentWhite, MOColorWithBytes(255, 255, 255, 0))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorTurquoise, MOColorWithBytes(64, 224, 208, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorViolet, MOColorWithBytes(238, 130, 238, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorWheat, MOColorWithBytes(245, 222, 179, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorWhite, MOColorWithBytes(255, 255, 255, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorWhiteSmoke, MOColorWithBytes(245, 245, 245, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorYellow, MOColorWithBytes(255, 255, 0, 255))).to.beTruthy();
			expect(GLKVector4AllEqualToVector4(MOColorYellowGreen, MOColorWithBytes(154, 205, 50, 255))).to.beTruthy();
		});
	});
});

SPEC_END
