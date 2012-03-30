//
//  FUViewController.m
//  Fuji
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUDirector.h"
#import "FUScene.h"


@interface FUDirector ()

@property (nonatomic, strong) EAGLContext* context;

@end


@implementation FUDirector

@synthesize scene = _scene;
@synthesize context = _context;

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

#pragma mark - Public Methods

- (NSSet*)allEngines
{
	return [NSSet set];
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
	[self setContext:nil];
	
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

@end
