//
//  FUSceneObject.h
//  Fuji
//
//  Created by Hart David on 11.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUInterfaceRotating.h"


@class FUEngine;

@interface FUSceneObject : NSObject <FUInterfaceRotating>

- (void)registerWithEngine:(FUEngine*)engine;
- (void)unregisterFromEngine:(FUEngine*)engine;

@end