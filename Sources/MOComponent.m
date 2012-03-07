//
//  MOComponent.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOComponent.h"
#import "MOComponent-Internal.h"
#import "MOMacros.h"


@interface MOComponent ()

@property (nonatomic, weak) MOGameObject* gameObject;

@end


@implementation MOComponent

@synthesize gameObject = _gameObject;

#pragma mark - Initialization

- (id)init
{
	MOFail(@"Can not create a component outside of a Game Object.");
	return nil;
}

- (id)initWithGameObject:(MOGameObject*)gameObject
{
	if ((self = [super init]))
	{
		[self setGameObject:gameObject];
	}
	
	return self;
}

#pragma mark - Public Methods

- (void)awake
{
}

@end
