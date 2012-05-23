//
//  FUSceneObject.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUInterfaceRotating.h"
#import "FUSupport.h"


@class FUScene;

@interface FUSceneObject : NSObject<FUInterfaceRotating>

@property (nonatomic, WEAK, readonly) FUScene* scene;

@end