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


@implementation FUGenericVisitor

- (void)updateFUSceneObject:(FUSceneObject*)sceneObject { }
- (void)drawFUSceneObject:(FUSceneObject*)sceneObject { }

@end


@implementation FUVisitChildVisitor

- (void)updateFUChildSceneObject:(FUChildSceneObject*)sceneObject { }
- (void)drawFUChildSceneObject:(FUChildSceneObject*)sceneObject { }

@end


@implementation FUVisitParentVisitor

- (void)updateFUParentSceneObject:(FUParentSceneObject*)sceneObject { }
- (void)drawFUParentSceneObject:(FUParentSceneObject*)sceneObject { }

@end


@implementation FUVisitNothingVisitor

@end