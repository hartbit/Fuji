//
//  FUViewController.h
//  Fuji
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>


@class FUScene;
@class FUEngine;
@class FUSceneObject;

/** FUViewController
 * This is the view controller class.
 */
@interface FUDirector : GLKViewController <GLKViewDelegate>

@property (nonatomic, strong) FUScene* scene;

- (id)initAndShareResourcesWithDirector:(FUDirector*)director;

- (void)addEngine:(FUEngine*)engine;
- (NSSet*)allEngines;

- (void)registerSceneObject:(FUSceneObject*)sceneObject;
- (void)unregisterSceneObject:(FUSceneObject*)sceneObject;

@end
