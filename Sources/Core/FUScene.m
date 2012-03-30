//
//  FUScene.m
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUScene.h"
#import "FUTransform.h"
#import "FUGraphicsSettings.h"
#import "FUEntity-Internal.h"
#import "FUMacros.h"


static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";
static NSString* const FUEntityNonexistentMessage = @"Can not remove a 'entity=%@' that does not exist";


@interface FUScene ()

@property (nonatomic, WEAK) FUGraphicsSettings* graphics;
@property (nonatomic, strong) NSMutableSet* entitys;

@end


@implementation FUScene

@synthesize graphics = _graphics;
@synthesize entitys = _entitys;

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

- (NSMutableSet*)entitys
{
	if (_entitys == nil)
	{
		[self setEntitys:[NSMutableSet set]];
	}
	
	return _entitys;
}

#pragma mark - Public Methods

- (id)createEntity
{
	FUEntity* entity = [[FUEntity alloc] initWithScene:self];
	[[self entitys] addObject:entity];
	return entity;
}

- (void)removeEntity:(FUEntity*)entity
{
	FUAssert(entity != nil, FUEntityNilMessage);
	
	if (![[self entitys] containsObject:entity])
	{
		FUThrow(FUEntityNonexistentMessage, entity);
	}
	
	[[self entitys] removeObject:entity];
	[entity setScene:nil];
}

- (NSSet*)allEntitys
{
	return [NSSet setWithSet:[self entitys]];
}

@end
