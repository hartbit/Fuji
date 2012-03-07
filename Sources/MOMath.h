//
//  MOMath.h
//  Mocha2D
//
//  Created by Hart David on 29.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>


static __inline__ GLKVector3 MOColor3WithBytes(GLubyte red, GLubyte green, GLubyte blue)
{
	return (GLKVector3){ red/255.0f, green/255.0f, blue/255.0f };
}

static __inline__ GLKVector4 MOColor4WithBytes(GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha)
{
	return (GLKVector4){ red/255.0f, green/255.0f, blue/255.0f, alpha/255.0f };
}


extern const GLKVector2 GLKVector2Zero;
extern const GLKVector2 GLKVector2One;
