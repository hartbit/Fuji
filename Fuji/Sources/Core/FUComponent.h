//
//  FUComponent.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUSceneObject.h"
#import "FUSupport.h"


@class FUEntity;

@interface FUComponent : FUSceneObject

@property (nonatomic, WEAK, readonly) FUEntity* entity;

+ (BOOL)isUnique;
+ (NSSet*)requiredComponents;

- (void)removeFromEntity;

@end
