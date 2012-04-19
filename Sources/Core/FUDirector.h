//
//  FUViewController.h
//  Fuji
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@class FUAssetStore;
@class FUScene;
@class FUEngine;

@interface FUDirector : GLKViewController <GLKViewDelegate>

@property (nonatomic, strong, readonly) FUScene* scene;

- (id)initAndShareAssetsWithDirector:(FUDirector*)director;

- (void)addEngine:(FUEngine*)engine;
- (NSSet*)allEngines;

- (void)loadScene:(FUScene*)scene;

@end
