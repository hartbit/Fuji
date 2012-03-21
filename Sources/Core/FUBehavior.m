//
//  FUBehavior.m
//  Fuji
//
//  Created by Hart David on 21.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUBehavior.h"
#import "FUComponent-Internal.h"


@implementation FUBehavior

@synthesize enabled = _enabled;

#pragma mark - Initialization

- (id)initWithGameObject:(FUGameObject*)gameObject
{
	if ((self = [super initWithGameObject:gameObject]))
	{
		[self setEnabled:YES];
	}
	
	return self;
}

@end
