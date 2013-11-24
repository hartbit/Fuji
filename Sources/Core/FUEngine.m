//
//  FUEngine.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUEngine-Internal.h"
#import "FUAssert.h"


static NSString* const FUCreationInvalidMessage = @"Can not create an engine object outside of a director";


@interface FUEngine ()

@property (nonatomic, WEAK) FUViewController * director;
@property (nonatomic, getter=isInitializing) BOOL initializing;

@end


@implementation FUEngine

#pragma mark - Initialization Methods

- (id)init
{
	FUAssert([self isInitializing], FUCreationInvalidMessage);
	return [super init];
}

- (id)initWithDirector:(FUViewController *)director
{
	[self setInitializing:YES];
	
	if ((self = [self init])) {
		[self setInitializing:NO];
		[self setDirector:director];
	}
	
	return self;
}

#pragma mark - Public Methods

- (FUVisitor*)registrationVisitor
{
	return nil;
}

- (FUVisitor*)unregistrationVisitor
{
	return nil;
}

- (void)unregisterAll
{
}

- (void)update
{
}

- (void)draw
{
}

#pragma mark - UIInterfaceRotating Methods

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
