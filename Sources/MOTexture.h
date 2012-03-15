//
//  FUTexture.h
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>


/** When your game loads textures using the `FUResourceManager` class, the manager returns information about the textures using `FUTexture` objects. Your game never creates `FUTexture` objects directly. */
@interface FUTexture : NSObject

/** The OpenGL texture id. */
@property (nonatomic, readonly) GLuint identifier;

@end
