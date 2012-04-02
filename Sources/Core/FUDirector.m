//
//  FUViewController.m
//  Fuji
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUDirector.h"
#import "FUScene.h"
#import "FUEngine.h"
#import "FUEngine-Internal.h"


static NSString* const FUEngineNilMessage = @"Expected 'engine' to not be nil";
static NSString* const FUEngineAlreadyUsedMessage = @"The 'engine' is already used in another 'director=%@'";


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

#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self == nil) return nil;
	
	[self initialize];
	return self;
}

- (id)initWithCoder:(NSCoder*)decoder
{
	self = [super initWithCoder:decoder];
	if (self == nil) return nil;
	
	[self initialize];
	return self;
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self == nil) return nil;
	
	[self initialize];
	return self;
}

- (void)initialize
{
	[self setScene:[FUScene new]];
}

#pragma mark - Public Methods

- (void)addEngine:(FUEngine*)engine
{
	FUAssert(engine != nil, FUEngineNilMessage);
	FUAssert([engine director] == nil, FUEngineAlreadyUsedMessage, [engine director]);
	
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
