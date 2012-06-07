//
//  FUUpdatableComponent.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUUpdatableComponent.h"
#import "FUUpdateEngine.h"


@implementation FUUpdatableComponent

#pragma mark - FUComponent Class Methods

+ (NSSet*)requiredEngines
{
	return [NSSet setWithObject:[FUUpdateEngine class]];
}

#pragma mark - Public Methods

- (void)update
{
}

@end
