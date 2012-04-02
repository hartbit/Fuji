//
//  FUBehavior.m
//  Fuji
//
//  Created by Hart David on 02.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUBehavior.h"
#import "FUSceneObject-Internal.h"


@implementation FUBehavior

@synthesize enabled = _enabled;

- (id)init
{
	self = [super init];
	
	[self setEnabled:YES];
	return self;
}

#pragma mark - FUSceneObject Methods

- (void)acceptVisitor:(id)visitor withSelectorPrefix:(NSString*)prefix
{
	if ([self isEnabled])
	{
		[super acceptVisitor:visitor withSelectorPrefix:prefix];
	}
}

@end
