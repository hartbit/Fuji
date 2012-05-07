//
//  FUAssetStoreSpec.m
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUAsset-Internal.h"
#import "FUTexture-Internal.h"
#import "FUTestSupport.h"


static NSString* const FUTextureNonexistantMessage = @"The texture with 'name=%@' does not exist";
static NSString* const FUTextureLoaderMessage = @"The texture couldn't be loaded because of 'error=%@'";


SPEC_BEGIN(FUTexture)

describe(@"A texture", ^{	
	it(@"is an asset", ^{
		expect([FUTexture class]).to.beSubclassOf([FUAsset class]);
	});
	
	context(@"initializing with a non-existant texture", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTexture alloc] initWithName:TEXTURE_NONEXISTANT], NSInvalidArgumentException, FUTextureNonexistantMessage, TEXTURE_NONEXISTANT);
		});
	});
	
	context(@"initializing with an invalid texture", ^{
		it(@"throws an exception", ^{
			assertThrows([[FUTexture alloc] initWithName:TEXTURE_INVALID], NSInternalInconsistencyException, FUTextureLoaderMessage, @"GLKTextureLoaderErrorDataPreprocessingFailure");
		});
	});
	
	context(@"initialized with a valid texture", ^{
		__block FUTexture* texture;
		__block GLuint name;
		
		beforeEach(^{
			texture = [[FUTexture alloc] initWithName:TEXTURE_VALID1];
			name = [texture name];
		});
		
		it(@"is not nil", ^{
			expect(texture).toNot.beNil();
		});
		
		it(@"has a valid texture name", ^{
			expect(glIsTexture(name)).to.beTruthy();
		});
		
		it(@"has the correct size", ^{
			expect([texture width]).to.equal(64);
			expect([texture height]).to.equal(100);
		});
		
		context(@"ended content access", ^{
			beforeEach(^{
				[texture endContentAccess];
			});
			
			context(@"accessing the name", ^{
				it(@"throws an exception", ^{
					assertThrows([texture name], NSInternalInconsistencyException, @"Accessing 'asset=%@' without a prior call to 'beginContentAccess'", texture);
				});
			});
			
			context(@"calling discardContentIfPossible", ^{
				it(@"invalidates the texture name", ^{
					[texture discardContentIfPossible];
					expect(glIsTexture(name)).to.beFalsy();
				});
			});
		});
	});
	
	context(@"asyncronously initialized with a valid texture", ^{
		__block FUTexture* asyncTexture;
		
		beforeEach(^{
			[FUTexture textureWithName:TEXTURE_VALID2 completionHandler:^(FUTexture* texture) {
				asyncTexture = texture;
			}];
			FU_WAIT_UNTIL(asyncTexture != nil);
		});
		
		it(@"is not nil", ^{
			expect(asyncTexture).toNot.beNil();
		});
		
		it(@"has a valid texture name", ^{
			expect([asyncTexture name]).toNot.equal(0);
		});
		
		it(@"has the correct size", ^{
			expect([asyncTexture width]).to.equal(80);
			expect([asyncTexture height]).to.equal(64);
		});
	});
});

SPEC_END
