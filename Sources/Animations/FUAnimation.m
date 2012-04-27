//
//  FUAnimation.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUAnimation.h"


@interface FUAnimation ()

@property (nonatomic) float speed;
@property (nonatomic, getter=isPlaying) BOOL playing;

@end


@implementation FUAnimation

@synthesize speed = _speed;
@synthesize playing = _playing;

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init]))
	{
		[self setSpeed:1];
	}
	
	return self;
}

#pragma mark - Public Methods

- (NSTimeInterval)duration
{
	return 0;
}

@end
