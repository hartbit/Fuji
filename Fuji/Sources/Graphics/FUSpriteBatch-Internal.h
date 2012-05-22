//
//  FUSpriteBatch-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>


@class FUTexture;
@class FUSpriteRenderer;

@interface FUSpriteBatch : NSObject <NSFastEnumeration>

@property (nonatomic) NSUInteger drawIndex;
@property (nonatomic) NSUInteger drawCount;
@property (nonatomic, strong, readonly) FUTexture* texture;
@property (nonatomic, readonly) NSUInteger count;

- (id)initWithTexture:(FUTexture*)texture;

- (void)addSprite:(FUSpriteRenderer*)sprite;
- (void)removeSprite:(FUSpriteRenderer*)sprite;

@end
