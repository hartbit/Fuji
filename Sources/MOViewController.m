//
//  MOViewController.m
//  Mocha2D
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOViewController.h"
#import "MOScene.h"


@interface MOViewController ()

@property (nonatomic, strong) EAGLContext* context;
@property (nonatomic, strong) GLKBaseEffect* effect;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;

@end


@implementation MOViewController

@synthesize scene = _scene;
@synthesize context = _context;
@synthesize effect = _effect;
@synthesize projectionMatrix = _projectionMatrix;

#pragma mark - Properties

- (EAGLContext*)context
{
	if (_context == nil)
	{
		EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		[self setContext:context];
	}
	
	if ([EAGLContext currentContext] != _context)
	{
		[EAGLContext setCurrentContext:_context];
	}
	
	return _context;
}

- (void)setContext:(EAGLContext*)context
{
	if (_context != context)
	{
		if ([EAGLContext currentContext] == _context)
		{
			[EAGLContext setCurrentContext:context];
		}
		
		_context = context;
	}
}

- (GLKBaseEffect*)effect
{
	if (_effect == nil)
	{
		GLKBaseEffect* effect = [GLKBaseEffect new];
		[self setEffect:effect];
		
		CGSize viewSize = [[self view] bounds].size;
		GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, viewSize.width, viewSize.height, 0, -1, 1);
		[[effect transform] setProjectionMatrix:projectionMatrix];
	}
	
	return _effect;
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	GLKView* view = (GLKView*)[self view];
	[view setContext:[self context]];
	
	glEnable(GL_CULL_FACE);
}

- (void)viewDidUnload
{
	[self setEffect:nil];
	[self setContext:nil];
	
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

#pragma mark - GLKView and GLKViewController Delegate Methods

- (void)update
{
//	[[self scene] update];
}

- (void)glkView:(GLKView*)view drawInRect:(CGRect)rect
{
	[[self effect] prepareToDraw];
//	[[self scene] render];
}

@end
