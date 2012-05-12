//
//  FUBehavior.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUBehavior.h"


@implementation FUBehavior

@synthesize enabled = _enabled;

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init]))
	{
		[self setEnabled:YES];
	}
	
	return self;
}

@end
