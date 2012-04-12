//
//  FUViewController.m
//  Fuji
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUDirector.h"
#import "FUScene.h"
#import "FUScene-Internal.h"
#import "FUEngine.h"
#import "FUEngine-Internal.h"
#import "FUGraphicsEngine.h"


static NSString* const FUSceneAlreadyUsedMessage = @"The 'scene=%@' is already showing in another 'director=%@'";
static NSString* const FUEngineNilMessage = @"Expected 'engine' to not be nil";
static NSString* const FUEngineAlreadyUsedMessage = @"The 'engine=%@' is already used in another 'director=%@'";
static NSString* const FUEngineAlreadyInDirector = @"The 'engine=%@' is already used in this director.'";


@interface FUDirector ()

@property (nonatomic, strong) EAGLContext* context;
@property (nonatomic, strong) NSMutableSet* engines;

@end


@implementation FUDirector

@synthesize scene = _scene;
@synthesize context = _context;
@synthesize engines = _engines;

#pragma mark - Properties

- (void)setScene:(FUScene*)scene
{
	if (scene != _scene)
	{
		FUAssert([scene director] == nil, FUSceneAlreadyUsedMessage, scene, [scene director]);
		
		[_scene setDirector:nil];
		_scene = scene;
		[scene setDirector:self];
	}
}

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

#pragma mark - Initialization

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self == nil) return nil;

	[self context];
	[self addEngine:[FUGraphicsEngine new]];
	return self;
}

#pragma mark - Public Methods

- (void)addEngine:(FUEngine*)engine
{
	FUAssert(engine != nil, FUEngineNilMessage);
	FUAssert([engine director] != self, FUEngineAlreadyInDirector, engine);
	FUAssert([engine director] == nil, FUEngineAlreadyUsedMessage, engine, [engine director]);
	
	[[self engines] addObject:engine];
	[engine setDirector:self];
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
	[view setDrawableDepthFormat:GLKViewDrawableDepthFormat16];
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	for (FUEngine* engine in [self engines])
	{
		[engine willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	}
	
	[[self scene] willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	for (FUEngine* engine in [self engines])
	{
		[engine willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	}
	
	[[self scene] willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	for (FUEngine* engine in [self engines])
	{
		[engine didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	}
	
	[[self scene] didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - GLKViewController Methods

- (void)update
{
	for (FUEngine* engine in [self engines])
	{
		[engine update];
	}
}

- (void)glkView:(GLKView*)view drawInRect:(CGRect)rect
{
	for (FUEngine* engine in [self engines])
	{
		[engine draw];
	}
}

@end
