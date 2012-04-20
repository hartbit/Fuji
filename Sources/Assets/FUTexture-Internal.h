//
//  FUTexture-Internal.h
//  Fuji
//
//  Created by Hart David on 26.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
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