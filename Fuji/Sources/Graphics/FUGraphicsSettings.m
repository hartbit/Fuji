//
//  FUGraphicsSettings.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUGraphicsSettings.h"
#import "FUColor.h"


@implementation FUGraphicsSettings

@synthesize backgroundColor = _backgroundColor;

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init]))
	{
		[self setBackgroundColor:FUColorCornflowerBlue];
	}
	
	return self;
}

@end
