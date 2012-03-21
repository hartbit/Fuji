//
//  FUGraphicsEngine.m
//  Fuji
//
//  Created by Hart David on 21.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUGraphicsEngine.h"
#import "FUComponent-Internal.h"
#import "FUColor.h"


@implementation FUGraphicsEngine

@synthesize backgroundColor = _backgroundColor;

#pragma mark - Initialization

- (id)initWithGameObject:(FUGameObject*)gameObject
{
	if ((self = [super initWithGameObject:gameObject]))
	{
		[self setBackgroundColor:FUColorCornflowerBlue];
	}
	
	return self;
}

@end
