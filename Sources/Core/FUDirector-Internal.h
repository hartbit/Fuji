//
//  FUDirector-Internal.h
//  Fuji
//
//  Created by Hart David on 18.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


@class FUSceneObject;

@interface FUDirector ()

- (void)didAddSceneObject:(FUSceneObject*)sceneObject;
- (void)willRemoveSceneObject:(FUSceneObject*)sceneObject;

@end