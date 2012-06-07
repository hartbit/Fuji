//
//  FUTransform.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTransform.h"
#import "FUMath.h"


@interface FUTransform ()

@property (nonatomic) GLKMatrix4 matrix;
@property (nonatomic) BOOL matrixNeedsUpdate;

@end


@implementation FUTransform

@synthesize position = _position;
@synthesize depth = _depth;
@synthesize rotation = _rotation;
@synthesize scale = _scale;
@synthesize matrix = _matrix;
@synthesize matrixNeedsUpdate = _matrixNeedsUpdate;

#pragma mark - Initialization

- (id)init
{
	if ((self = [super init])) {
		[self setScale:GLKVector2One];
	}
	
	return self;
}

#pragma mark - Properties

- (void)setPosition:(GLKVector2)position
{
	_position = position;
	[self setMatrixNeedsUpdate:YES];
}

- (float)positionX
{
	return [self position].x;
}

- (void)setPositionX:(float)positionX
{
	GLKVector2 position = [self position];
	position.x = positionX;
	[self setPosition:position];
}

- (float)positionY
{
	return [self position].y;
}

- (void)setPositionY:(float)positionY
{
	GLKVector2 position = [self position];
	position.y = positionY;
	[self setPosition:position];
}

- (void)setDepth:(float)depth
{
	_depth = depth;
	[self setMatrixNeedsUpdate:YES];
}

- (void)setRotation:(float)rotation
{
	_rotation = rotation;
	[self setMatrixNeedsUpdate:YES];
}

- (void)setScale:(GLKVector2)scale
{
	_scale = scale;
	[self setMatrixNeedsUpdate:YES];
}

- (float)scaleX
{
	return [self scale].x;
}

- (void)setScaleX:(float)scaleX
{
	GLKVector2 scale = [self scale];
	scale.x = scaleX;
	[self setScale:scale];
}

- (float)scaleY
{
	return [self scale].y;
}

- (void)setScaleY:(float)scaleY
{
	GLKVector2 scale = [self scale];
	scale.y = scaleY;
	[self setScale:scale];
}

- (GLKMatrix4)matrix
{
	if ([self matrixNeedsUpdate]) {
		GLKVector2 t = [self position];
		float z = [self depth];
		float r = [self rotation];
		float cos = cosf(r);
		float sin = sinf(r);
		GLKVector2 s = [self scale];
		_matrix = GLKMatrix4Make(s.x*cos, s.x*sin, 0, 0, -s.y*sin, s.y*cos, 0, 0, 0, 0, 1, 0, t.x, t.y, z, 1);
		[self setMatrixNeedsUpdate:NO];
	}
	
	return _matrix;
}

@end
