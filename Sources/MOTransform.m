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

@property (nonatomic) GLKVector2 position;
@property (nonatomic) float rotation;
@property (nonatomic) GLKVector2 scale;

@end


@implementation MOTransform

@synthesize position = _position;
@synthesize rotation = _rotation;
@synthesize scale = _scale;

- (void)awake
{
	[super awake];
	[self setScale:GLKVector2One];
}

@end
