//
//  FUGraphicsSettings.m
//  Fuji
//
//  Created by Hart David on 21.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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
