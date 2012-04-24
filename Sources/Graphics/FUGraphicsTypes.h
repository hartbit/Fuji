//
//  FUGraphicsTypes.h
//  Fuji
//
//  Created by David Hart on 4/24/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"


typedef GLushort FUIndex;
#define FU_INDEX_TYPE GL_UNSIGNED_SHORT

typedef struct
{
	GLKVector3 position;
	GLKVector4 color;
	GLKVector2 texCoord;
} FUVertex;


static inline FUVertex FUVertexMake(GLKVector3 position, GLKVector4 color, GLKVector2 texCoord)
{
	return (FUVertex){ position, color, texCoord };
}