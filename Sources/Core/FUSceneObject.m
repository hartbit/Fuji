//
//  FUSceneObject.m
//  Fuji
//
//  Created by Hart David on 11.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUSceneObject.h"
#import "FUSceneObject-Internal.h"
#import "FUScene.h"
#import "FUDirector.h"


static NSString* const FUCreationInvalidMessage = @"Can not create a scene object outside of a scene";
static NSString* const FUSceneNilMessage = @"Expected 'scene' to not be nil";


@interface FUSceneObject ()

@property (nonatomic, getter=isInitializing) BOOL initializing;

@end


@implementation FUSceneObject

@synthesize scene = _scene;
@synthesize initializing = _initializing;

#pragma mark - Initialization

- (id)init
{
	FUAssert([self isInitializing], FUCreationInvalidMessage);
	
	self = [super init];
	return self;
}

- (id)initWithScene:(FUScene*)scene
{
	FUAssert(scene != nil, FUSceneNilMessage);
	
	[self setInitializing:YES];
	
	self = [self init];
	if (self == nil) return nil;
	
	[self setInitializing:NO];
	[self setScene:scene];
	return self;
}

#pragma mark - UIInterfaceRotation Methods

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}

#pragma mark - Internal Methods

- (void)register
{
	[[[self scene] director] registerSceneObject:self];
}

- (void)unregister
{
	[[[self scene] director] unregisterSceneObject:self];
}

@end