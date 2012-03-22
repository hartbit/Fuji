//
//  FUGraphicsEngine.m
//  Fuji
//
//  Created by Hart David on 21.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUGraphicsEngine.h"
#import "FUComponent-Internal.h"
#import "FUColor.h"


@interface FUGraphicsEngine ()

@property (nonatomic, strong) GLKBaseEffect* effect;

@end


@implementation FUGraphicsEngine

@synthesize backgroundColor = _backgroundColor;
@synthesize effect = _effect;

#pragma mark - Initialization

- (id)initWithGameObject:(FUGameObject*)gameObject
{
	if ((self = [super initWithGameObject:gameObject]))
	{
		[self setBackgroundColor:FUColorCornflowerBlue];
	}
	
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

@end
