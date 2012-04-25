//
//  FUEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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
