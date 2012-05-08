//
//  FUViewController.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@class FUAssetStore;
@class FUScene;
@class FUEngine;

@interface FUDirector : GLKViewController <GLKViewDelegate>

@property (nonatomic, strong, readonly) FUAssetStore* assetStore;
@property (nonatomic, strong, readonly) FUScene* scene;

- (id)initWithAssetStore:(FUAssetStore*)assetStore;

- (void)addEngine:(FUEngine*)engine;
- (NSArray*)allEngines;

- (void)loadScene:(FUScene*)scene;

@end
