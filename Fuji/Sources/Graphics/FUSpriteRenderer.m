//
//  FUSpriteRenderer.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSpriteRenderer.h"
#import "FUTransform.h"
#import "FUColor.h"


@implementation FUSpriteRenderer

@synthesize texture = _texture;
@synthesize tint = _tint;

#pragma mark - FUComponent Class Methods

+ (NSSet*)requiredComponents
{
	return [NSSet setWithObject:[FUTransform class]];
}

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init])) {
		[self setTint:FUColorWhite];
	}
	
	return self;
}

@end
