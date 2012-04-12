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
#import "FUSceneObject-Internal.h"
#import "FUEntity.h"
#import "FUEngine.h"


static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";


@implementation FUComponent

@synthesize entity = _entity;

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

- (id)initWithEntity:(FUEntity*)entity
{
	FUAssert(entity != nil, FUEntityNilMessage);
	
	self = [self initWithScene:[entity scene]];
	if (self == nil) return nil;
	
	[self setEntity:entity];
	return self;
}

#pragma mark - Public Methods

- (void)removeFromEntity
{
	[[self entity] removeComponent:self];
}

#pragma mark - FUInterfaceRotating Methods

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}

@end
