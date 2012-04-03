//
//  FUSpriteRenderer.m
//  Fuji
//
//  Created by Hart David on 02.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUSpriteRenderer.h"
#import "FUColor.h"


@implementation FUSpriteRenderer

@synthesize color = _color;

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	[self setColor:FUColorWhite];
	
	return self;
}

@end
