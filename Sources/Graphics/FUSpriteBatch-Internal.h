//
//  FUSpriteBatch-Internal.h
//  Fuji
//
//  Created by David Hart on 4/24/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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
