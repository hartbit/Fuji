//
//  FUGraphicsTypes-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <OpenGLES/ES2/gl.h>
#import <GLKit/GLKit.h>


typedef GLushort FUIndex;
#define FU_INDEX_TYPE GL_UNSIGNED_SHORT

typedef struct
{
	GLKVector3 position;
	GLKVector4 color;
	GLKVector2 texCoord;
} FUVertex;


static OBJC_INLINE FUVertex FUVertexMake(GLKVector3 position, GLKVector4 color, GLKVector2 texCoord)
{
	return (FUVertex){ position, color, texCoord };
}
