//
//  FUComponent.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUComponent-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUDirector-Internal.h"
#import "FUEntity.h"
#import "FUAssert.h"


static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";


@implementation FUComponent

#pragma mark - Class Methods

+ (BOOL)isUnique
{
	return NO;
}

+ (NSSet*)requiredComponents
{
	return [NSSet set];
}

+ (NSSet*)requiredEngines
{
	return [NSSet set];
}

+ (NSSet*)allRequiredComponents
{
	static NSMutableDictionary* sComponents;
	
	if (sComponents == nil) {
		sComponents = [NSMutableDictionary dictionary];
	}
	
	NSMutableSet* classComponents = sComponents[self];
	
	if (classComponents == nil) {
		classComponents = [NSMutableSet setWithSet:[self requiredComponents]];
		
		if (self != [FUComponent class]) {
			NSSet* allSuperclassComponents = [[self superclass] allRequiredComponents];
			[classComponents unionSet:allSuperclassComponents];		
		}
	}
	
	return classComponents;
}

+ (NSSet*)allRequiredEngines
{
	static NSMutableDictionary* sEngines;
	
	if (sEngines == nil) {
		sEngines = [NSMutableDictionary dictionary];
	}
	
	NSMutableSet* classEngines = sEngines[self];
	
	if (classEngines == nil) {
		classEngines = [NSMutableSet setWithSet:[self requiredEngines]];
		
		if (self != [FUComponent class]) {
			NSSet* allSuperclassEngines = [[self superclass] allRequiredEngines];
			[classEngines unionSet:allSuperclassEngines];		
		}
	}
	
	return classEngines;
}

#pragma mark - Initialization

- (id)initWithEntity:(FUEntity*)entity
{
	FUCheck(entity != nil, FUEntityNilMessage);
	
	if ((self = [self initWithScene:[entity scene]])) {
		[self setEntity:entity];
	}
	
	return self;
}

#pragma mark - Public Methods

- (void)removeFromEntity
{
	[[self entity] removeComponent:self];
}

#pragma mark - FUSceneObject Methods

- (void)acceptVisitor:(FUVisitor*)visitor
{
	for (Class engineClass in [[self class] requiredEngines]) {
		[[self director] requireEngineWithClass:engineClass];
	}
	
	[super acceptVisitor:visitor];
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
