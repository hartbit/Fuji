//
//  FUTransform2D.m
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTransform2D.h"
#import "FUMath.h"


@interface FUTransform2D ()

@property (nonatomic) GLKMatrix4 matrix;
@property (nonatomic) BOOL needsUpdate;

@end


@implementation FUTransform2D

@synthesize position = _position;
@synthesize rotation = _rotation;
@synthesize scale = _scale;
@synthesize matrix = _matrix;
@synthesize needsUpdate = _needsUpdate;

#pragma mark - Properties

- (void)setPosition:(GLKVector2)position
{
	_position = position;
	[self setNeedsUpdate:YES];
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

- (void)setRotation:(float)rotation
{
	_rotation = rotation;
	[self setNeedsUpdate:YES];
}

- (void)setScale:(GLKVector2)scale
{
	_scale = scale;
	[self setNeedsUpdate:YES];
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
	if ([self needsUpdate])
	{
		GLKVector2 position = [self position];
		_matrix = GLKMatrix4MakeTranslation(position.x, position.y, 0);
		
		float rotation = [self rotation];
		
		if (rotation != 0)
		{
			_matrix = GLKMatrix4Rotate(_matrix, rotation, 0, 0, 1);
		}
		
		GLKVector2 scale = [self scale];
		
		if (!GLKVector2AllEqualToScalar(scale, 1))
		{
			_matrix = GLKMatrix4Scale(_matrix, scale.x, scale.y, 1);
		}
		
		[self setNeedsUpdate:NO];
	}
	
	return _matrix;
}

#pragma mark - FUComponent Methods

- (void)awake
{
	[super awake];
	[self setScale:GLKVector2One];
}

@end
