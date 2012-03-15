//
//  FUGameObject.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUGameObject.h"
#import "FUGameObject-Internal.h"
#import "FUScene.h"
#import "FUComponent.h"
#import "FUComponent-Internal.h"
#import "FULog.h"


@interface FUGameObject ()

@property (nonatomic, WEAK) FUScene* scene;

@end


@implementation FUGameObject

@synthesize scene = _scene;

#pragma mark - Initialization

- (id)init
{
	FULogError(@"Can not create a game object outside of a scene.");
	return nil;
}

- (id)initWithScene:(FUScene*)scene
{
	if (scene == nil)
	{
		FULogError(@"Expected 'scene' to not be nil");
		return nil;
	}
	
	if ((self = [super init]))
	{
		[self setScene:scene];
	}
	
	return self;
}

#pragma mark - Public Methods

- (FUComponent*)addComponentWithClass:(Class)componentClass
{
	if (![componentClass isSubclassOfClass:[FUComponent class]] || (componentClass == [FUComponent class]))
	{
		FULogError(@"Expected 'componentClass' to be a subclass of FUComponent, got '%@'", NSStringFromClass(componentClass));
		return nil;
	}
	
	FUComponent* component = [[componentClass alloc] initWithGameObject:self];
	[component awake];
	return component;
}

- (FUComponent*)componentWithClass:(Class)componentClass
{
	if (![componentClass isSubclassOfClass:[FUComponent class]] || (componentClass == [FUComponent class]))
	{
		FULogError(@"Expected 'componentClass' to be a subclass of FUComponent, got '%@'", NSStringFromClass(componentClass));
		return nil;
	}
	
	return nil;
}

@end
