//
//  FUTestVisitors.m
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTestVisitors.h"


@implementation FUParentSceneObject @end
@implementation FUChildSceneObject @end


@implementation FUGenericEngine

- (void)updateFUSceneObject:(FUSceneObject*)sceneObject { }
- (void)predrawFUSceneObject:(FUSceneObject*)sceneObject { }
- (void)drawFUSceneObject:(FUSceneObject*)sceneObject { }
- (void)postdrawFUSceneObject:(FUSceneObject*)sceneObject { }

@end


@implementation FUVisitChildVisitor

- (void)updateFUChildSceneObject:(FUChildSceneObject*)sceneObject { }
- (void)predrawFUChildSceneObject:(FUChildSceneObject*)sceneObject { }
- (void)drawFUChildSceneObject:(FUChildSceneObject*)sceneObject { }
- (void)postdrawFUChildSceneObject:(FUChildSceneObject*)sceneObject { }

@end


@implementation FUVisitParentVisitor

- (void)updateFUParentSceneObject:(FUParentSceneObject*)sceneObject { }
- (void)predrawFUParentSceneObject:(FUParentSceneObject*)sceneObject { }
- (void)drawFUParentSceneObject:(FUParentSceneObject*)sceneObject { }
- (void)postdrawFUParentSceneObject:(FUParentSceneObject*)sceneObject { }

@end


@implementation FUVisitNothingVisitor

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