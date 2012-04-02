//
//  FUEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUEngine.h"
#import "FUEngine-Internal.h"


@implementation FUEngine

@synthesize director = _director;

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

@end
