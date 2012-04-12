//
//  FUTestEngines.h
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "Fuji.h"


@interface FUGenericEngine : FUEngine

- (void)registerFUSceneObject:(FUSceneObject*)sceneObject;
- (void)unregisterFUSceneObject:(FUSceneObject*)sceneObject;

@end


@interface FUEntityComponentVisitor : NSObject

- (void)updateEnterFUEntity:(FUEntity*)entity;
- (void)updateLeaveFUEntity:(FUEntity*)entity;
- (void)updateFUComponent:(FUComponent*)component;
- (void)drawEnterFUEntity:(FUEntity*)entity;
- (void)drawLeaveFUEntity:(FUEntity*)entity;
- (void)drawFUComponent:(FUComponent*)component;

@end


@interface FUBehaviorVisitor : NSObject

- (void)updateFUBehavior:(FUBehavior*)behavior;
- (void)drawFUBehavior:(FUBehavior*)behavior;

@end