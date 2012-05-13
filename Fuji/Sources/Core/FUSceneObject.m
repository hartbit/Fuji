//
//  FUSceneObject.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUSceneObject-Internal.h"
#import "FUVisitor-Internal.h"


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
	
	return [super init];
}

- (id)initWithScene:(FUScene*)scene
{
	FUCheck(scene != nil, FUSceneNilMessage);
	
	[self setInitializing:YES];
	
	if ((self = [self init])) {
		[self setInitializing:NO];
		[self setScene:scene];
	}
	
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

- (void)acceptVisitor:(FUVisitor*)visitor
{
	[visitor visitSceneObject:self];
}

@end