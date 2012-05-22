//
//  FUTexture-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import "FUAsset-Internal.h"


@interface FUTexture : FUAsset

@property (nonatomic, readonly) GLuint name;
@property (nonatomic, readonly) GLuint width;
@property (nonatomic, readonly) GLuint height;

+ (void)textureWithName:(NSString*)name completionHandler:(void (^)(FUTexture* texture))block;
- (id)initWithName:(NSString*)name;

@end