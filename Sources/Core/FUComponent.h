//
//  FUComponent.h
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUEngineVisiting.h"
#import "FUInterfaceRotating.h"
#import "FUMacros.h"


@class FUEntity;
@class FUTransform;

@interface FUComponent : NSObject <FUEngineVisiting, FUInterfaceRotating>

@property (nonatomic, WEAK, readonly) FUEntity* entity;

+ (BOOL)isUnique;
+ (NSSet*)requiredComponents;

- (void)removeFromEntity;

@end
