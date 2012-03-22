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
#import "FUGraphicsEngine.h"
#import "FUGameObject-Internal.h"
#import "FUMacros.h"


static NSString* const FUGameObjectNilMessage = @"Expected 'gameObject' to not be nil";
static NSString* const FUGameObjectNonexistentMessage = @"Can not remove a 'gameObject=%@' that does not exist";


@interface FUScene ()

@property (nonatomic, WEAK) FUGraphicsEngine* graphics;
@property (nonatomic, strong) NSMutableSet* gameObjects;

@end


@implementation FUScene

@synthesize graphics = _graphics;
@synthesize gameObjects = _gameObjects;

#pragma mark - Class Methods

+ (NSDictionary*)componentProperties
{
	return [NSDictionary dictionaryWithObjectsAndKeys:[FUGraphicsEngine class], @"graphics", nil];
}

#pragma mark - Initialization

- (id)init
{
	if ((self = [super initWithScene:self]))
	{
		[self removeComponent:[self transform]];
		[self addComponentWithClass:[FUGraphicsEngine class]];
	}
	
	return self;
}

#pragma mark - Properties

- (NSMutableSet*)gameObjects
{
	if (_gameObjects == nil)
	{
		[self setGameObjects:[NSMutableSet set]];
	}
	
	return _gameObjects;
}

#pragma mark - Public Methods

- (id)createGameObject
{
	FUGameObject* gameObject = [[FUGameObject alloc] initWithScene:self];
	[[self gameObjects] addObject:gameObject];
	return gameObject;
}

- (void)removeGameObject:(FUGameObject*)gameObject
{
	FUAssert(gameObject != nil, FUGameObjectNilMessage);
	
	if (![[self gameObjects] containsObject:gameObject])
	{
		FUThrow(FUGameObjectNonexistentMessage, gameObject);
	}
	
	[[self gameObjects] removeObject:gameObject];
	[gameObject setScene:nil];
}

- (NSSet*)allGameObjects
{
	return [NSSet setWithSet:[self gameObjects]];
}

#pragma mark - GLKViewControllerDelegate Methods

- (void)glkViewControllerUpdate:(GLKViewController*)controller
{
}

- (void)glkView:(GLKView*)view drawInRect:(CGRect)rect
{
}

@end
