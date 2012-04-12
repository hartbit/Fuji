//
//  FUTestEngines.m
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTestEngines.h"


@implementation FUGenericEngine

- (void)registerFUSceneObject:(FUSceneObject*)sceneObject { }
- (void)unregisterFUSceneObject:(FUSceneObject*)sceneObject { }

@end


@implementation FUEntityComponentVisitor

- (void)updateEnterFUEntity:(FUEntity*)entity { }
- (void)updateLeaveFUEntity:(FUEntity*)entity { }
- (void)updateFUComponent:(FUComponent*)component { }
- (void)drawEnterFUEntity:(FUEntity*)entity { }
- (void)drawLeaveFUEntity:(FUEntity*)entity { }
- (void)drawFUComponent:(FUComponent*)component { }

@end


@implementation FUBehaviorVisitor

- (void)updateFUBehavior:(FUBehavior*)behavior { }
- (void)predrawFUBehavior:(FUBehavior*)behavior { }
- (void)drawFUBehavior:(FUBehavior*)behavior { }
- (void)postdrawFUBehavior:(FUBehavior*)behavior { }

@end