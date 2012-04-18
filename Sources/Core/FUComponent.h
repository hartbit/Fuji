//
//  FUComponent.h
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUSceneObject.h"
#import "FUMacros.h"


@class FUEntity;

@interface FUComponent : FUSceneObject

@property (nonatomic, WEAK, readonly) FUEntity* entity;

+ (BOOL)isUnique;
+ (NSSet*)requiredComponents;

- (void)removeFromEntity;

@end
