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


static NSString* const FURemovalGameObjectNilMessage = @"Can not remove a component that is not attached to a game object";


@implementation FUComponent

@synthesize gameObject = _gameObject;

#pragma mark - Class Methods

+ (BOOL)isUnique
{
	return NO;
}

+ (NSSet*)requiredComponents
{
	return [NSSet set];
}

+ (NSSet*)allRequiredComponents
{
	static NSMutableDictionary* sComponents = nil;
	
	if (sComponents == nil)
	{
		sComponents = [NSMutableDictionary dictionary];
	}
	
	NSMutableSet* classComponents = [sComponents objectForKey:self];
	
	if (classComponents == nil)
	{
		classComponents = [NSMutableSet setWithSet:[self requiredComponents]];
		
		if (self != [FUComponent class])
		{
			NSSet* allSuperclassComponents = [[self superclass] allRequiredComponents];
			[classComponents unionSet:allSuperclassComponents];		
		}
	}
	
	return classComponents;
}

#pragma mark - Initialization

#pragma mark - Public Methods

- (void)removeFromGameObject
{
	FUAssert([self gameObject] != nil, FURemovalGameObjectNilMessage);
	[[self gameObject] removeComponent:self];
}

- (void)awake
{
}

- (void)update
{
}

@end
