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
#import "FUAsset-Internal.h"
#import "FUTexture-Internal.h"


SPEC_BEGIN(FUTexture)

describe(@"A texture", ^{	
	it(@"is an asset", ^{
		expect([FUTexture class]).to.beSubclassOf([FUAsset class]);
	});
	
	context(@"initializing with a non-existant texture", ^{
		it(@"throws an exception", ^{
			STAssertThrows([[FUTexture alloc] initWithName:TEXTURE_NONEXISTANT], nil);
		});
	});
	
	context(@"initializing with an invalid texture", ^{
		it(@"throws an exception", ^{
			STAssertThrows([[FUTexture alloc] initWithName:TEXTURE_INVALID], nil);
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
		
		context(@"ended content access", ^{
			beforeEach(^{
				[texture endContentAccess];
			});
			
			context(@"accessing the name", ^{
				it(@"throws an exception", ^{
					STAssertThrows([texture name], nil);
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
			[FUTexture textureWithName:TEXTURE_VALID1 completionHandler:^(FUTexture* texture) {
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
	});
});

SPEC_END
