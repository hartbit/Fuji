//
//  FUResourceManagerSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "Fuji.h"


#define NONEXISTANT @"Nonexistent.png"
#define INVALID @"Invalid.txt"
#define VALID @"Valid.png"


SPEC_BEGIN(FUResourceManagerSpec)

describe(@"FUResourceManager", ^{
	__block FUResourceManager* resourceManager = [FUResourceManager sharedManager];
	
	beforeAll(^{
		EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		[EAGLContext setCurrentContext:context];
	});
	
	afterEach(^{
		[resourceManager purgeResources];
	});	
	/*
	it(@"should return a valid singleton instance", ^{
		expect(resourceManager).toNot.beNil();
	});
	
	context(@"resourceIsLoadedWithName:", ^{
		it(@"should not load textures beforehand", ^{
			expect([resourceManager resourceIsLoadedWithName:NONEXISTANT]).to.beFalsy();
			expect([resourceManager resourceIsLoadedWithName:INVALID]).to.beFalsy();
			expect([resourceManager resourceIsLoadedWithName:VALID]).to.beFalsy();
		});
	});
	
	context(@"textureWithName:", ^{
		it(@"should raise when loading a texture that does not exist", ^{
			STAssertThrows([resourceManager textureWithName:NONEXISTANT], nil);
			expect([resourceManager resourceIsLoadedWithName:NONEXISTANT]).to.beFalsy();
		});
		
		it(@"should raise when loading an invalid texture", ^{
			STAssertThrows([resourceManager textureWithName:INVALID], nil);
			expect([resourceManager resourceIsLoadedWithName:INVALID]).to.beFalsy();
		});
		
		it(@"should load a valid texture", ^{
			FUTexture* texture = [resourceManager textureWithName:VALID];
			expect(texture).toNot.beNil();
			expect([resourceManager resourceIsLoadedWithName:VALID]).to.beTruthy();
		});
	});
	
    context(@"textureWithName:completion:", ^{
		pending(@"should raise when loading a texture that does not exist");
		pending(@"should raise when loading an invalid texture");

		it(@"should load a texture asynchronously", ^{
			__block FUTexture* asyncTexture = nil;
			
			[resourceManager textureWithName:VALID completion:^(FUTexture* texture) {
				asyncTexture = texture;
			}];
			
			expect(asyncTexture).willNot.beNil();
			expect([resourceManager resourceIsLoadedWithName:VALID]).will.beTruthy();
		});
		
		it(@"should accept NULL block", ^{
			[resourceManager textureWithName:VALID completion:NULL];
			[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
		});
		
		it(@"should accept NULL block once in the cache", ^{
			[resourceManager textureWithName:VALID];
			[resourceManager textureWithName:VALID completion:NULL];
		});
	});
	
	context(@"purgeResources", ^{
		it(@"should remove resources from the cache", ^{
			[resourceManager textureWithName:VALID];
			[resourceManager purgeResources];
			expect([resourceManager resourceIsLoadedWithName:VALID]).will.beFalsy();
		});
	});*/
});

SPEC_END
