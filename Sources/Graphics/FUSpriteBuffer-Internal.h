//
//  FUSpriteBuffer-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@class FUAssetStore;
@class FUSpriteRenderer;

@interface FUSpriteBuffer : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary* spriteBatches;

- (id)initWithAssetStore:(FUAssetStore*)assetStore;
- (id)initWithAssetStore:(FUAssetStore*)assetStore capacity:(NSUInteger)capacity;

- (void)addSprite:(FUSpriteRenderer*)sprite;
- (void)removeSprite:(FUSpriteRenderer*)sprite;
- (void)removeAllSprites;

- (void)drawWithEffect:(GLKBaseEffect*)effect;

@end
