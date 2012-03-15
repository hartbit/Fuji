//
//  FUComponent.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUComponent.h"
#import "FUComponent-Internal.h"
#import "FULog.h"


@interface FUComponent ()

@property (nonatomic, WEAK) FUGameObject* gameObject;

@end


@implementation FUComponent

@synthesize gameObject = _gameObject;

#pragma mark - Class Methods

+ (BOOL)isUnique
{
	return NO;
}

#pragma mark - Initialization

- (id)init
{
	FULogError(@"Can not create a component outside of a game object.");
	return nil;
}

- (id)initWithGameObject:(FUGameObject*)gameObject
{
	if (gameObject == nil)
	{
		FULogError(@"Expected 'gameObject' to not be nil");
		return nil;
	}
	
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
