//
//  FUBehavior.m
//  Fuji
//
//  Created by Hart David on 02.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUBehavior.h"


@implementation FUBehavior

@synthesize enabled = _enabled;

- (id)init
{
	self = [super init];
	
	[self setEnabled:YES];
	return self;
}

#pragma mark - FUSceneObject Methods

- (void)updateWithEngine:(FUEngine*)engine
{
	if ([self isEnabled])
	{
		[super updateWithEngine:engine];
	}
}

- (void)drawWithEngine:(FUEngine*)engine
{
	if ([self isEnabled])
	{
		[super drawWithEngine:engine];
	}
}

@end
