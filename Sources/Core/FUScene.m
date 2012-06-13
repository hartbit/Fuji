//
//  FUScene.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <objc/runtime.h>
#import "FUScene-Internal.h"
#import "FUDirector-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUGraphicsSettings.h"
#import "FUTransform.h"
#import "FUEngine.h"
#import "FUAssert.h"


static NSString* const FUEntityNilMessage = @"Expected 'entity' to not be nil";
static NSString* const FUEntityNonexistentMessage = @"Can not remove a 'entity=%@' that does not exist";


@interface FUScene ()

@property (nonatomic, WEAK) FUGraphicsSettings* graphics;
@property (nonatomic, strong) NSMutableArray* entities;

@end


@implementation FUScene

@synthesize director = _director;

#pragma mark - Class Methods

+ (NSDictionary*)componentProperties
{
	return @{
		@"graphics": [FUGraphicsSettings class]
	};
}

#pragma mark - Initialization

+ (id)scene
{
	FUScene* scene = [self alloc];
	scene = [scene initWithScene:scene];
	return scene;
}

- (id)initWithScene:(FUScene*)scene
{
	if ((self = [super initWithScene:scene])) {
		[self removeComponent:[self transform]];
		[self addComponentWithClass:[FUGraphicsSettings class]];
	}
	
	return self;
}

#pragma mark - Properties

- (NSMutableArray*)entities
{
	if (_entities == nil) {
		[self setEntities:[NSMutableArray array]];
	}
	
	return _entities;
}

#pragma mark - Public Methods

- (FUEntity*)createEntity
{
	FUEntity* entity = [[FUEntity alloc] initWithScene:self];
	[[self entities] addObject:entity];
	[[self director] didAddSceneObject:entity];
	return entity;
}

- (void)removeEntity:(FUEntity*)entity
{
	FUCheck(entity != nil, FUEntityNilMessage);
	FUCheck([[self entities] containsObject:entity], FUEntityNonexistentMessage, entity);
	
	[[self director] willRemoveSceneObject:entity];
	[[self entities] removeObject:entity];
	[entity setScene:nil];
}

- (NSArray*)allEntities
{
	return [NSArray arrayWithArray:[self entities]];
}

#pragma mark - FUSceneObject Methods

- (void)acceptVisitor:(FUVisitor*)visitor
{
	[super acceptVisitor:visitor];
	
	for (FUEntity* entity in [self entities]) {
		[entity acceptVisitor:visitor];
	}
}

#pragma mark - FUInterfaceRotating Methods

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	for (FUEntity* entity in [self entities]) {
		[entity willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	}
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	for (FUEntity* entity in [self entities]) {
		[entity willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
	}
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	for (FUEntity* entity in [self entities]) {
		[entity didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	}
}

@end
