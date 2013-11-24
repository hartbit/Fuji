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


@class FUAssetStore;
@class FUScene;
@class FUEngine;

/** The `FUViewController` class is a `GLKViewController` subclass that manages the game view. It is your responsability to instantiate it with the `init` method and add it to the view-controller hierarchy.
 *
 * In some cases you may wish to share assets with another `FUViewController`: in that case, initialize it with the `initWithAssetStore:` method. This can happen if you use an external display without mirroring and want to share some assets. */
@interface FUViewController : GLKViewController<GLKViewDelegate>

/** @name Creating a Director with an Asset Store */

/** Initialize with the given asset store.
 * @param assetStore The `FUAssetStore` instance to use. */
- (id)initWithAssetStore:(FUAssetStore*)assetStore;

/** The `FUAssetStore` instance that the game uses to cache all media. */
@property (nonatomic, strong, readonly) FUAssetStore* assetStore;

/** @name Loading Scenes */

/** Loads a new scene.
 * @param scene The new scene to run. */
- (void)loadScene:(FUScene*)scene;

/** The currently running scene. */
@property (nonatomic, strong, readonly) FUScene* scene;

@end
