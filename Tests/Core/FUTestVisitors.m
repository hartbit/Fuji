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


@implementation FUVisitChildVisitor

- (void)visitFUChildSceneObject:(FUChildSceneObject*)sceneObject
{
}

@end


@implementation FUVisitParentVisitor

- (void)visitFUParentSceneObject:(FUParentSceneObject*)sceneObject
{
}

@end


@implementation FUVisitNothingVisitor

@end