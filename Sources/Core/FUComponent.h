//
//  FUComponent.h
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUUpdateable.h"
#import "FUMacros.h"


@class FUGameObject;
@class FUTransform;

@interface FUComponent : NSObject <FUUpdateable>

@property (nonatomic, WEAK, readonly) FUGameObject* gameObject;

+ (BOOL)isUnique;
+ (NSSet*)requiredComponents;

- (void)removeFromGameObject;

- (void)awake;
- (void)update;

@end
