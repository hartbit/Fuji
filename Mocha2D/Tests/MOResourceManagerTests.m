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
	STAssertThrows([[MOResourceManager sharedManager] textureWithName:@"Nonexistent.png"], @"The resource manager should assert when loading a texture that does not exist.");
	STAssertFalse([[MOResourceManager sharedManager] resourceIsLoadedWithName:@"Nonexistent.png"], @"The resource manager should not load a texture that does not exist.");
}

- (void)testLoadingInvalidTexture
{
	STAssertThrows([[MOResourceManager sharedManager] textureWithName:@"Invalid.txt"], @"The resource manager should assert when loading an invalid texture file.");
	STAssertFalse([[MOResourceManager sharedManager] resourceIsLoadedWithName:@"Nonexistent.png"], @"The resource manager should not load a texture that is invalid.");
}

- (void)testLoadingTexture
{
	STAssertFalse([[MOResourceManager sharedManager] resourceIsLoadedWithName:@"Valid.png"], @"The resource manager should not have a texture loaded to start with.");
	MOTexture* texture = [[MOResourceManager sharedManager] textureWithName:@"Valid.png"];
	STAssertNotNil(texture, @"The resource manager should load a valid texture file.");
	STAssertTrue([[MOResourceManager sharedManager] resourceIsLoadedWithName:@"Valid.png"], @"The resource manager should have loaded a texture that is valid.");
}

- (void)testLoadingTextureAsynchronously
{
	STAssertFalse([[MOResourceManager sharedManager] resourceIsLoadedWithName:@"Valid.png"], @"The resource manager should not have a texture loaded to start with.");
	
	__block BOOL hasLoaded = NO;
	
	[[MOResourceManager sharedManager] textureWithName:@"Valid.png" completion:^(MOTexture* texture) {
		STAssertNotNil(texture, @"The resource manager should have loaded a valid texture asynchronously by the time the completion block is called.");
		STAssertTrue([[MOResourceManager sharedManager] resourceIsLoadedWithName:@"Valid.png"], @"The resource manager should have loaded a texture that is valid.");
		hasLoaded = YES;
	}];
	
	MO_WAIT_FOR_FLAG(hasLoaded, 0.5);
	STAssertTrue(hasLoaded, @"The resource manager should have loaded the texture under 500ms.");
}

- (void)testLoadingTextureAsynchronouslyAcceptsNullBlock
{
	STAssertNoThrow([[MOResourceManager sharedManager] textureWithName:@"Valid.png" completion:NULL], @"The resource manager should accept a null completion block.");
}

@end
