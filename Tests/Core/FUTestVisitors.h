//
//  FUTestVisitors.h
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "Fuji.h"


@interface FUParentSceneObject : FUSceneObject @end
@interface FUChildSceneObject : FUParentSceneObject @end


@interface FUGenericEngine : FUEngine

- (void)updateFUSceneObject:(FUSceneObject*)sceneObject;
- (void)drawFUSceneObject:(FUSceneObject*)sceneObject;

@end


@interface FUVisitChildVisitor : NSObject

- (void)updateFUChildSceneObject:(FUChildSceneObject*)sceneObject;
- (void)drawFUChildSceneObject:(FUChildSceneObject*)sceneObject;

@end


@interface FUVisitParentVisitor : NSObject

- (void)updateFUParentSceneObject:(FUParentSceneObject*)sceneObject;
- (void)drawFUParentSceneObject:(FUParentSceneObject*)sceneObject;

@end


@interface FUVisitNothingVisitor : NSObject

@end


@interface FUBehaviorVisitor : NSObject

- (void)updateFUBehavior:(FUBehavior*)behavior;
- (void)drawFUBehavior:(FUBehavior*)behavior;

@end