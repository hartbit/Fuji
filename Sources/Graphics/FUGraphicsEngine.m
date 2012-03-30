//
//  FUGraphicsEngine.m
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUGraphicsEngine.h"
#import "FUGraphicsSettings.h"


@interface FUGraphicsEngine ()

@property (nonatomic, strong) GLKBaseEffect* effect;

@end


@implementation FUGraphicsEngine

@synthesize effect = _effect;

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	glEnable(GL_CULL_FACE);
	
	return self;
}

#pragma mark - Properties

- (GLKBaseEffect*)effect
{
	if (_effect == nil)
	{
		GLKBaseEffect* effect = [GLKBaseEffect new];
		[self setEffect:effect];
 
 //		CGSize viewSize = [[self view] bounds].size;
 //		GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, viewSize.width, viewSize.height, 0, -1, 1);
 //		[[effect transform] setProjectionMatrix:projectionMatrix];
	}
 
	return _effect;
}

#pragma mark - Drawing

- (void)drawFUGraphicsSettings:(FUGraphicsSettings*)graphicsSettings
{
	GLKVector4 backgroundColor = [graphicsSettings backgroundColor];
	glClearColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a);
	glClear(GL_COLOR_BUFFER_BIT);
}

@end
