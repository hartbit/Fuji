//
//  FUViewController.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>


#define FUOrientationFromInterfaceOrientation(orientation) 1 << ((orientation) - 1)

typedef enum {
	FUOrientationNone = 0,
	FUOrientationPortrait = FUOrientationFromInterfaceOrientation(UIInterfaceOrientationPortrait),
	FUOrientationPortraitUpsideDown = FUOrientationFromInterfaceOrientation(UIInterfaceOrientationPortraitUpsideDown),
	FUOrientationLandscapeLeft = FUOrientationFromInterfaceOrientation(UIInterfaceOrientationLandscapeLeft),
	FUOrientationLandscapeRight = FUOrientationFromInterfaceOrientation(UIInterfaceOrientationLandscapeRight)
} FUOrientation;


@class FUAssetStore;
@class FUScene;
@class FUEngine;

@interface FUDirector : GLKViewController<GLKViewDelegate>

- (id)initWithAssetStore:(FUAssetStore*)assetStore;

@property (nonatomic, strong, readonly) FUAssetStore* assetStore;
@property (nonatomic, strong, readonly) FUScene* scene;
@property (nonatomic) FUOrientation validOrientations;

- (void)loadScene:(FUScene*)scene;

@end
