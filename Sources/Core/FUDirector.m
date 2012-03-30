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
@property (nonatomic, strong) NSMutableSet* engines;

@end


@implementation FUDirector

@synthesize scene = _scene;
@synthesize context = _context;
@synthesize engines = _engines;

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

- (NSMutableSet*)engines
{
	if (_engines == nil)
	{
		[self setEngines:[NSMutableSet set]];
	}
	
	return _engines;
}

#pragma mark - Public Methods

- (void)addEngine:(id)engine
{
	[[self engines] addObject:engine];
}

- (NSSet*)allEngines
{
	return [NSSet setWithSet:[self engines]];
}

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	GLKView* view = (GLKView*)[self view];
	[view setContext:[self context]];
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

#pragma mark - GLKViewController Methods

- (void)update
{
	for (id engine in [self engines])
	{
		[[self scene] updateVisitor:engine];
	}
}

- (void)glkView:(GLKView*)view drawInRect:(CGRect)rect
{
	for (id engine in [self engines])
	{
		[[self scene] drawVisitor:engine];
	}
}

@end
