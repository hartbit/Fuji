//
//  FUSpriteBuffer-Internal.h
//  Fuji
//
//  Created by Hart David on 23.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@class FUAssetStore;
@class FUSpriteRenderer;

@interface FUSpriteBuffer : NSObject

- (id)initWithAssetStore:(FUAssetStore*)assetStore;
- (id)initWithAssetStore:(FUAssetStore*)assetStore capacity:(NSUInteger)capacity;

- (void)addSprite:(FUSpriteRenderer*)sprite;
- (void)removeSprite:(FUSpriteRenderer*)sprite;
- (void)removeAllSprites;

- (void)drawWithEffect:(GLKBaseEffect*)effect;

@end
