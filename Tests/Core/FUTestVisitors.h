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


@interface FUVisitChildVisitor : NSObject

- (void)visitFUChildSceneObject:(FUChildSceneObject*)sceneObject;

@end


@interface FUVisitParentVisitor : NSObject

- (void)visitFUParentSceneObject:(FUParentSceneObject*)sceneObject;

@end


@interface FUVisitNothingVisitor : NSObject

@end