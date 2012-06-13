//
//  FUComponent-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUComponent.h"
#import "FUSupport.h"


@class FUEntity;

@interface FUComponent ()

@property (nonatomic, WEAK) FUEntity* entity;

+ (NSSet*)allRequiredComponents;
+ (NSSet*)allRequiredEngines;

- (id)initWithEntity:(FUEntity*)entity;

@end
