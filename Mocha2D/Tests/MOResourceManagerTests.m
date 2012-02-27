//
//  MOResourceManagerTests.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OpenGLES/EAGL.h>
#import "MOResourceManager.h"
#import "MOTexture.h"
#import "MOTestMacros.h"


#define NONEXISTANT @"Nonexistent.png"
#define INVALID @"Invalid.txt"
#define VALID @"Valid.png"


@interface MOResourceManagerTests : SenTestCase
@end


@implementation MOResourceManagerTests

- (void)setUp
{
	EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	[EAGLContext setCurrentContext:context];
}

- (void)tearDown
{
	[[MOResourceManager sharedManager] purgeResources];
	[EAGLContext setCurrentContext:nil];
}

- (void)testLoadingNonexistentTexture
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	STAssertFalse([resourceManager resourceIsLoadedWithName:NONEXISTANT], nil);
	STAssertThrows([resourceManager textureWithName:NONEXISTANT], nil);
	STAssertFalse([resourceManager resourceIsLoadedWithName:NONEXISTANT], nil);
}

- (void)testLoadingInvalidTexture
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	STAssertFalse([resourceManager resourceIsLoadedWithName:INVALID], nil);
	STAssertThrows([resourceManager textureWithName:INVALID], nil);
	STAssertFalse([resourceManager resourceIsLoadedWithName:INVALID], nil);
}

- (void)testLoadingTexture
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	STAssertFalse([resourceManager resourceIsLoadedWithName:VALID], nil);
	MOTexture* texture = [resourceManager textureWithName:VALID];
	STAssertNotNil(texture, nil);
	STAssertTrue([resourceManager resourceIsLoadedWithName:VALID], nil);
}

- (void)testLoadingTextureAsynchronously
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	STAssertFalse([resourceManager resourceIsLoadedWithName:VALID], nil);
	
	__block BOOL hasLoaded = NO;
	[resourceManager textureWithName:VALID completion:^(MOTexture* texture) {
		STAssertNotNil(texture, nil);
		STAssertTrue([resourceManager resourceIsLoadedWithName:VALID], nil);
		hasLoaded = YES;
	}];
	
	MO_WAIT_FOR_FLAG(hasLoaded, 0.5);
	STAssertTrue(hasLoaded, nil);
}

- (void)testLoadingTextureAsynchronouslyAcceptsNullBlock
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	[resourceManager textureWithName:VALID completion:NULL];
	MO_WAIT_FOR_FLAG(NO, 0.5);
}

- (void)testLoadingTextureAsynchronouslyAcceptsNullBlockAfterLoaded
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	[resourceManager textureWithName:VALID];
	[resourceManager textureWithName:VALID completion:NULL];
}

- (void)testPurgingResourcesRemovesUnusedResources 
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	
	[resourceManager textureWithName:VALID];
	STAssertTrue([resourceManager resourceIsLoadedWithName:VALID], nil);
	[resourceManager purgeResources];
	STAssertFalse([resourceManager resourceIsLoadedWithName:VALID], nil);
}

- (void)testPurgingResourcesDoesNotRemoveUsedResources
{
	MOResourceManager* resourceManager = [MOResourceManager sharedManager];
	
	MOTexture* texture __attribute((unused)) = [resourceManager textureWithName:VALID];
	STAssertTrue([resourceManager resourceIsLoadedWithName:VALID], nil);
	[resourceManager purgeResources];
	STAssertTrue([resourceManager resourceIsLoadedWithName:VALID], nil);
}

@end