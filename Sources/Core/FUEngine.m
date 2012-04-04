//
//  FUEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUEngine.h"
#import "FUScene.h"
#import "FUBehavior.h"
#import "FUEngine-Internal.h"


@implementation FUEngine

@synthesize director = _director;

#pragma mark - Public Methods

- (void)updateEntityEnter:(FUEntity*)entity
{
}

- (void)updateEntityLeave:(FUEntity*)entity
{
}

- (void)drawEntityEnter:(FUEntity*)entity
{
}

- (void)drawEntityLeave:(FUEntity*)entity
{
}

- (void)updateSceneEnter:(FUScene*)scene
{
	[self updateEntityEnter:scene];
}

- (void)updateSceneLeave:(FUScene*)scene
{
	[self updateEntityLeave:scene];
}

- (void)drawSceneEnter:(FUScene*)scene
{
	[self drawEntityEnter:scene];
}

- (void)drawSceneLeave:(FUScene*)scene
{
	[self drawEntityLeave:scene];
}

- (void)updateComponent:(FUComponent*)component
{
}

- (void)drawComponent:(FUComponent*)component
{
}

- (void)updateBehavior:(FUBehavior*)behavior
{
	[self updateComponent:behavior];
}

- (void)drawBehavior:(FUBehavior*)behavior
{
	[self drawComponent:behavior];
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

@end
