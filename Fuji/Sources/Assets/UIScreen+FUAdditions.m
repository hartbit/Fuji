//
//  UIScreen+FUAdditions.m
//  FUAdditions
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "UIScreen+FUAdditions-Internal.h"


@implementation UIScreen (FUAdditions)

#pragma mark - Public Methods

- (NSString*)scaleSuffix
{
	if ([self scale] != 1) {
		return [NSString stringWithFormat:@"@%ix", (NSUInteger)[self scale]];
	} else {
		return @"";
	}
}

@end
