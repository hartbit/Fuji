//
//  FUDirector-Internal.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUDirector.h"


@class FUSceneObject;

@interface FUDirector ()

- (void)didAddSceneObject:(FUSceneObject*)sceneObject;
- (void)willRemoveSceneObject:(FUSceneObject*)sceneObject;

@end