//
//  MOResourceInfo-Internal.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOResourceInfo-Internal.h"


@interface MOResourceInfo ()

@property (nonatomic, strong) id resource;

@end


@implementation MOResourceInfo

@synthesize resource = _resource;
@synthesize lifetime = _lifetime;

#pragma mark - Initialization

- (id)initWithResource:(id)resource lifetime:(MOResourceLifetime)lifetime
{
	if ((self = [super init]))
	{
		[self setResource:resource];
		[self setLifetime:lifetime];
	}
	
	return self;
}

@end
