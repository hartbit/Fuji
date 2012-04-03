//
//  FUScene.m
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUScene.h"
#import "FUScene-Internal.h"
#import "FUTransform.h"
#import "FUGraphicsSettings.h"
#import "FUSceneObject-Internal.h"
#import "FUEntity-Internal.h"
#import "FUMacros.h"


static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";
static NSString* const FUEntityNonexistentMessage = @"Can not remove a 'entity=%@' that does not exist";


@interface FUScene ()

@property (nonatomic, WEAK) FUGraphicsSettings* graphics;
@property (nonatomic, strong) NSMutableSet* entities;

@end


@implementation FUScene

@synthesize director = _director;
@synthesize graphics = _graphics;
@synthesize entities = _entities;

#pragma mark - Class Methods

+ (NSDictionary*)componentProperties
{
	return [NSDictionary dictionaryWithObjectsAndKeys:[FUGraphicsSettings class], @"graphics", nil];
}

#pragma mark - Initialization

- (id)init
{
	self = [super initWithScene:self];
	if (self == nil) return nil;
	
	[self removeComponent:[self transform]];
	[self addComponentWithClass:[FUGraphicsSettings class]];
	return self;
}

#pragma mark - Properties

- (NSMutableSet*)entities
{
	if (_entities == nil)
	{
		[self setEntities:[NSMutableSet set]];
	}
	
	return _entities;
}

#pragma mark - Public Methods

- (FUEntity*)createEntity
{
	FUEntity* entity = [[FUEntity alloc] initWithScene:self];
	[[self entities] addObject:entity];
	return entity;
}

- (void)removeEntity:(FUEntity*)entity
{
	FUAssert(entity != nil, FUEntityNilMessage);
	
	if (![[self entities] containsObject:entity])
	{
		FUThrow(FUEntityNonexistentMessage, entity);
	}
	
	[[self entities] removeObject:entity];
	[entity setScene:nil];
}

- (NSSet*)allEntities
{
	return [NSSet setWithSet:[self entities]];
}

#pragma mark - FUSceneObject Methods

- (void)acceptVisitor:(id)visitor withSelectorPrefix:(NSString*)prefix
{
	[super acceptVisitor:visitor withSelectorPrefix:prefix];
	
	for (FUEntity* entity in [self entities])
	{
		[entity acceptVisitor:visitor withSelectorPrefix:prefix];
	}
}

@end
