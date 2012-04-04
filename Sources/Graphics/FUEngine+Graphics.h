//
//  FUEngine+Graphics.h
//  Fuji
//
//  Created by Hart David on 04.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUEngine.h"


@class FUTransform;
@class FUSpriteRenderer;

@interface FUEngine (Graphics)

- (void)updateTransform:(FUTransform*)transform;
- (void)drawTransform:(FUTransform*)transform;

- (void)updateSpriteRenderer:(FUSpriteRenderer*)spriteRenderer;
- (void)drawSpriteRenderer:(FUSpriteRenderer*)spriteRenderer;

@end
