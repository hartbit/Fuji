//
//  FUComponent.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUComponent.h"
#import "FUComponent-Internal.h"
#import "FUGameObject.h"


static NSString* const FUCreationInvalidMessage = @"Can not create a component outside of a game object";
static NSString* const FUGameObjectNilMessage = @"Expected 'gameObject' to not be nil";


@implementation FUComponent

@synthesize gameObject = _gameObject;

#pragma mark - Class Methods

+ (BOOL)isUnique
{
	return YES;
}

+ (NSSet*)requiredComponents
{
	return [NSSet set];
}

#pragma mark - Initialization

- (id)init
{
	NSAssert(NO, FUCreationInvalidMessage);
	return nil;
}

- (id)initWithGameObject:(FUGameObject*)gameObject
{
	NSAssert(gameObject != nil, FUGameObjectNilMessage);
	
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

- (void)removeFromGameObject
{
	[[self gameObject] removeComponent:self];
}

@end
