//
//  FUDirector.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUDirector-Internal.h"
#import "FUDirectorVisitor-Internal.h"
#import "FUAssetStore.h"
#import "FUScene-Internal.h"
#import "FUEngine-Internal.h"
#import "FUSceneObject-Internal.h"
#import "FUGraphicsEngine.h"
#import "FUAssert.h"


static NSString* const FUAssetStoreNilMessage = @"Expected 'assetStore' to not be nil";
static NSString* const FUOrientationInvalidMessage = @"Expected 'validOrientations=%i' to be greater than 0 and less than 16";
static NSString* const FUSceneAlreadyUsedMessage = @"The 'scene=%@' is already showing in another 'director=%@'";
static NSString* const FUSceneAlreadyInDirector = @"The 'scene=%@' is already showing in this director";
static NSString* const FUEngineClassNullMessage = @"Expected 'engineClass' to not be NULL";
static NSString* const FUEngineClassInvalidMessage = @"Expected 'engineClass=%@' to be a subclass of FUEngine (excluded)";
static NSString* const FUEngineAlreadyUsedMessage = @"The 'engine=%@' is already used in another 'director=%@'";
static NSString* const FUEngineAlreadyInDirector = @"The 'engine=%@' is already used in this director.'";
static NSString* const FUSceneObjectNilMessage = @"Expected 'sceneObject' to not be nil";
static NSString* const FUSceneObjectInvalidMessage = @"Expected 'sceneObject=%@' to have the same 'director=%@'";


@interface FUDirector ()

@property (nonatomic, strong) FUAssetStore* assetStore;
@property (nonatomic, strong) FUScene* scene;
@property (nonatomic, strong) EAGLContext* context;
@property (nonatomic, strong) NSMutableArray* engines;
@property (nonatomic, strong) FUDirectorVisitor* registrationVisitor;
@property (nonatomic, strong) FUDirectorVisitor* unregistrationVisitor;

@end


@implementation FUDirector

@synthesize assetStore = _assetStore;
@synthesize scene = _scene;
@synthesize validOrientations = _validOrientations;
@synthesize context = _context;
@synthesize engines = _engines;
@synthesize registrationVisitor = _registrationVisitor;
@synthesize unregistrationVisitor = _unregistrationVisitor;

#pragma mark - Initialization

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		[EAGLContext setCurrentContext:[self context]];
		
		[self setValidOrientations:FUOrientationPortrait |
		 FUOrientationPortraitUpsideDown |
		 FUOrientationLandscapeLeft |
		 FUOrientationLandscapeRight];
	}
	
	return self;
}

- (id)initWithAssetStore:(FUAssetStore*)assetStore;
{
	FUCheck(assetStore != nil, FUAssetStoreNilMessage);
	
	if ((self = [self initWithNibName:nil bundle:nil])) {
		[self setAssetStore:assetStore];
	}
	
	return self;
}

#pragma mark - Properties

- (FUAssetStore*)assetStore
{
	if (_assetStore == nil) {
		[self setAssetStore:[FUAssetStore new]];
	}
	
	return _assetStore;
}

- (void)setValidOrientations:(FUOrientation)validOrientations
{
	FUCheck((validOrientations > 0) && (validOrientations < 16), FUOrientationInvalidMessage, validOrientations);
	_validOrientations = validOrientations;
}

- (EAGLContext*)context
{
	if (_context == nil) {
		EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		[self setContext:context];
	}
	
	return _context;
}

- (void)setContext:(EAGLContext*)context
{
	if (_context != context) {
		_context = context;
	}
}

- (NSMutableArray*)engines
{
	if (_engines == nil) {
		[self setEngines:[NSMutableArray array]];
	}
	
	return _engines;
}

- (FUDirectorVisitor*)registrationVisitor
{
	if (_registrationVisitor == nil) {
		[self setRegistrationVisitor:[FUDirectorVisitor new]];
	}
	
	return _registrationVisitor;
}

- (FUDirectorVisitor*)unregistrationVisitor
{
	if (_unregistrationVisitor == nil) {
		[self setUnregistrationVisitor:[FUDirectorVisitor new]];
	}
	
	return _unregistrationVisitor;
}

#pragma mark - Public Methods

- (void)loadScene:(FUScene*)scene
{
	FUCheck([scene director] != self, FUSceneAlreadyInDirector, scene);
	FUCheck([scene director] == nil, FUSceneAlreadyUsedMessage, scene, [scene director]);
	
	[self unregisterAll];
	[[self scene] setDirector:nil];
	[self setScene:scene];
	[scene setDirector:self];
	[self didAddSceneObject:scene];
}

#pragma mark - Internal Methods

- (FUEngine*)requireEngineWithClass:(Class)engineClass;
{
	FUCheck(engineClass != NULL, FUEngineClassNullMessage);
	FUCheck([engineClass isSubclassOfClass:[FUEngine class]] && (engineClass != [FUEngine class]), FUEngineClassInvalidMessage, engineClass);
	
	for (FUEngine* engine in [self engines]) {
		if ([engine isKindOfClass:engineClass]) {
			return engine;
		}
	}
	
	FUEngine* engine = [[engineClass alloc] initWithDirector:self];
	[[self engines] addObject:engine];
	
	FUVisitor* registrationVisitor = [engine registrationVisitor];
	
	if (registrationVisitor != nil) {
		[[[self registrationVisitor] visitors] addObject:registrationVisitor];
	}
	
	FUVisitor* unregistrationVisitor = [engine unregistrationVisitor];
	
	if (unregistrationVisitor != nil) {
		[[[self unregistrationVisitor] visitors] addObject:unregistrationVisitor];
	}
	
	return engine;
}

- (NSArray*)allEngines
{
	return [NSArray arrayWithArray:[self engines]];
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
	return ([self validOrientations] & FUOrientationFromInterfaceOrientation(toInterfaceOrientation)) != FUOrientationNone;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	for (FUEngine* engine in [self engines]) {
		[engine willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	}
	
	[[self scene] willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	for (FUEngine* engine in [self engines]) {
		[engine willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	}
	
	[[self scene] willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	for (FUEngine* engine in [self engines]) {
		[engine didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	}
	
	[[self scene] didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - GLKViewController Methods

- (void)update
{
	[EAGLContext setCurrentContext:[self context]];
	
	for (FUEngine* engine in [self engines]) {
		[engine update];
	}
}

- (void)glkView:(GLKView*)view drawInRect:(CGRect)rect
{
	[EAGLContext setCurrentContext:[self context]];
	
	for (FUEngine* engine in [self engines]) {
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
	for (FUEngine* engine in [self engines]) {
		[engine unregisterAll];
	}
}

@end
