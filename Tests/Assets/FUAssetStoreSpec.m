//
//  FUAssetStoreSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FUTestFunctions.h"
#import "Fuji.h"
#import "FUAssetStore-Internal.h"
#import "FUTexture-Internal.h"


SPEC_BEGIN(FUAssetStore)

describe(@"An asset store", ^{	
	beforeAll(^{
		EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		[EAGLContext setCurrentContext:context];
	});
	
	context(@"initialized", ^{
		__block FUAssetStore* assetStore = nil;
		
		beforeEach(^{
			assetStore = [FUAssetStore new];
		});
		
		it(@"is not nil", ^{
			expect(assetStore).toNot.beNil();
		});
		
		context(@"asking for a nil texture", ^{
			it(@"throws an exception", ^{
				STAssertThrows([assetStore textureWithName:nil], @"Expected 'name' to not be nil or empty", nil);
			});
		});
		
		context(@"asking for a empty texture name", ^{
			it(@"throws an exception", ^{
				STAssertThrows([assetStore textureWithName:@""], nil);
			});
		});
		
		context(@"asked for a valid texture", ^{
			__block FUTexture* texture;
			
			beforeEach(^{
				texture = [assetStore textureWithName:TEXTURE_VALID1];
			});
			
			it(@"is not nil", ^{
				expect(texture).toNot.beNil();
			});
			
			context(@"asking for same texture again", ^{
				it(@"returns the same instance", ^{
					FUTexture* newTexture = [assetStore textureWithName:TEXTURE_VALID1];
					expect(newTexture).to.beIdenticalTo(texture);
				});
			});
			
			context(@"asking for a different texture", ^{
				it(@"returns a different instance with a different name", ^{
					FUTexture* newTexture = [assetStore textureWithName:TEXTURE_VALID2];
					expect(newTexture).toNot.beIdenticalTo(texture);
					expect([newTexture name]).toNot.equal([texture name]);
				});
			});
		});
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
