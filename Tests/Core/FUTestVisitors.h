//
//  FUTestVisitors.h
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "Fuji.h"


@interface FUTestSceneObject : FUSceneObject

@end


@interface FUTestVisitor : NSObject

- (void)visitFUSceneObject:(FUSceneObject*)sceneObject;

@end