//
//  FUDirector.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUDirector-Internal.h"
#import "FUProxyVisitor-Internal.h"
#import "FUAssetStore.h"
#import "FUScene-Internal.h"
#import "FUEngine-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUGraphicsEngine.h"


static NSString* const FUAssetStoreNilMessage = @"Expected 'assetStore' to not be nil";
static NSString* const FUSceneAlreadyUsedMessage = @"The 'scene=%@' is already showing in another 'director=%@'";
static NSString* const FUEngineNilMessage = @"Expected 'engine' to not be nil";
static NSString* const FUEngineAlreadyUsedMessage = @"The 'engine=%@' is already used in another 'director=%@'";
static NSString* const FUEngineAlreadyInDirector = @"The 'engine=%@' is already used in this director.'";
static NSString* const FUSceneObjectNilMessage = @"Expected 'sceneObject' to not be nil";
static NSString* const FUSceneObjectInvalidMessage = @"Expected 'sceneObject=%@' to have the same 'director=%@'";


@interface FUDirector ()

@property (nonatomic, strong) FUAssetStore* assetStore;
@property (nonatomic, strong) FUScene* scene;
@property (nonatomic, strong) EAGLContext* context;
@property (nonatomic, strong) NSMutableSet* engines;
@property (nonatomic, strong) FUProxyVisitor* registrationVisitor;
@property (nonatomic, strong) FUProxyVisitor* unregistrationVisitor;

@end


@implementation FUDirector

@synthesize assetStore = _assetStore;
@synthesize scene = _scene;
@synthesize context = _context;
@synthesize engines = _engines;
@synthesize registrationVisitor = _registrationVisitor;
@synthesize unregistrationVisitor = _unregistrationVisitor;

#pragma mark - Initialization

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self == nil) return nil;

	[EAGLContext setCurrentContext:[self context]];
	[self addEngine:[FUGraphicsEngine new]];
	return self;
}

- (id)initWithAssetStore:(FUAssetStore*)assetStore;
{
	FUAssert(assetStore != nil, FUAssetStoreNilMessage);
	
	[self setAssetStore:assetStore];
	
	self = [self initWithNibName:nil bundle:nil];
	return self;
}

#pragma mark - Properties

- (FUAssetStore*)assetStore
{
	if (_assetStore == nil)
	{
		[self setAssetStore:[FUAssetStore new]];
	}
	
	return _assetStore;
}

- (EAGLContext*)context
{
	if (_context == nil)
	{
		EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		[self setContext:context];
	}
	
	return _context;
}

- (void)setContext:(EAGLContext*)context
{
	if (_context != context)
	{
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

- (FUProxyVisitor*)registrationVisitor
{
	if (_registrationVisitor == nil)
	{
		[self setRegistrationVisitor:[FUProxyVisitor new]];
	}
	
	return _registrationVisitor;
}

- (FUProxyVisitor*)unregistrationVisitor
{
	if (_unregistrationVisitor == nil)
	{
		[self setUnregistrationVisitor:[FUProxyVisitor new]];
	}
	
	return _unregistrationVisitor;
}

#pragma mark - Public Methods

- (void)addEngine:(FUEngine*)engine
{
	FUAssert(engine != nil, FUEngineNilMessage);
	FUAssert([engine director] != self, FUEngineAlreadyInDirector, engine);
	FUAssert([engine director] == nil, FUEngineAlreadyUsedMessage, engine, [engine director]);
	
	[[self engines] addObject:engine];
	[engine setDirector:self];
	
	FUVisitor* registrationVisitor = [engine registrationVisitor];
	
	if (registrationVisitor != nil)
	{
		[[[self registrationVisitor] visitors] addObject:registrationVisitor];
	}
	
	FUVisitor* unregistrationVisitor = [engine unregistrationVisitor];
	
	if (unregistrationVisitor != nil)
	{
		[[[self unregistrationVisitor] visitors] addObject:unregistrationVisitor];
	}
}

- (NSSet*)allEngines
{
	return [NSSet setWithSet:[self engines]];
}

- (void)loadScene:(FUScene*)scene
{
	FUAssert([scene director] == nil, FUSceneAlreadyUsedMessage, scene, [scene director]);
	
	[self unregisterAll];
	[[self scene] setDirector:nil];
	[self setScene:scene];
	[scene setDirector:self];
	[self didAddSceneObject:scene];
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
	[EAGLContext setCurrentContext:[self context]];
	
	for (FUEngine* engine in [self engines])
	{
		[engine update];
	}
}

- (void)glkView:(GLKView*)view drawInRect:(CGRect)rect
{
	[EAGLContext setCurrentContext:[self context]];
	
	for (FUEngine* engine in [self engines])
	{
		[engine draw];
	}
}

#pragma mark - Internal methods

- (void)didAddSceneObject:(FUSceneObject*)sceneObject
{
	[sceneObject acceptVisitor:[self registrationVisitor]];
}

- (void)willRemoveSceneObject:(FUSceneObject*)sceneObject
{
	[sceneObject acceptVisitor:[self unregistrationVisitor]];
}

#pragma mark - Private Methods

- (void)unregisterAll
{
	for (FUEngine* engine in [self engines])
	{
		[engine unregisterAll];
	}
}

@end
