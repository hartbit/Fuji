//
//  FUTexture-Internal.h
//  Fuji
//
//  Created by Hart David on 26.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>


@interface FUTexture : NSObject

@property (nonatomic, readonly) GLuint name;

+ (void)textureWithName:(NSString*)name completionHandler:(void (^)(FUTexture* texture))block;
- (id)initWithName:(NSString*)name;

@end