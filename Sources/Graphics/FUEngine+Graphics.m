//
//  FUEngine+Graphics.m
//  Fuji
//
//  Created by Hart David on 04.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUEngine+Graphics.h"
#import "FUTransform.h"
#import "FUSpriteRenderer.h"


@implementation FUEngine (Graphics)

#pragma mark - Public Methods

- (void)updateTransform:(FUTransform*)transform
{
	[self updateComponent:transform];
}

- (void)drawTransform:(FUTransform*)transform
{
	[self drawComponent:transform];
}

- (void)updateSpriteRenderer:(FUSpriteRenderer*)spriteRenderer
{
	[self updateBehavior:spriteRenderer];
}

- (void)drawSpriteRenderer:(FUSpriteRenderer*)spriteRenderer
{
	[self drawBehavior:spriteRenderer];
}

@end
