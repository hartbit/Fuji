//
//  MOTransform.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOTransform.h"
#import "MOMath.h"


@interface MOTransform ()

@end


@implementation MOTransform

@synthesize position = _position;
@synthesize rotation = _rotation;
@synthesize scale = _scale;

#pragma mark - Properties

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

#pragma mark - MOComponent Methods

- (void)awake
{
	[super awake];
	[self setScale:GLKVector2One];
}

@end
