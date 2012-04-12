//
//  FUSceneObject.h
//  Fuji
//
//  Created by Hart David on 11.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUInterfaceRotating.h"
#import "FUMacros.h"


@class FUScene;

@interface FUSceneObject : NSObject <FUInterfaceRotating>

@property (nonatomic, WEAK, readonly) FUScene* scene;

@end