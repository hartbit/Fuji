//
//  MOTexture.h
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>


/** When your game loads textures using the `MOResourceManager` class, the manager returns information about the textures using `MOTexture` objects. Your game never creates `MOTexture` objects directly. */
@interface MOTexture : NSObject

/** The OpenGL texture id. */
@property (nonatomic, readonly) GLuint identifier;

@end
