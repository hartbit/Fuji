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
#import "FUEntity.h"


static NSString* const FUCreationInvalidMessage = @"Can not create a component outside of a game object";
static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";


@interface FUComponent ()

@property (nonatomic, getter=isInitializing) BOOL initializing;

@end


@implementation FUComponent

@synthesize entity = _entity;
@synthesize initializing = _initializing;

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

- (id)init
{
	FUAssert([self isInitializing], FUCreationInvalidMessage);
	
	self = [super init];
	return self;
}

- (id)initWithEntity:(FUEntity*)entity
{
	FUAssert(entity != nil, FUEntityNilMessage);
	
	[self setInitializing:YES];

	self = [self init];
	if (self == nil) return nil;
	
	[self setEntity:entity];
	[self setInitializing:NO];
	return self;
}

#pragma mark - Public Methods

- (void)removeFromEntity
{
	[[self entity] removeComponent:self];
}

@end
