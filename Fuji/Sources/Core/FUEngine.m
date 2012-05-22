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


@implementation FUEngine

@synthesize director = _director;

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
