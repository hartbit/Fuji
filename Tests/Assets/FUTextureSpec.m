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
#import "FUTexture-Internal.h"


#define NONEXISTANT @"Nonexistent.png"
#define INVALID @"Invalid.txt"
#define VALID @"Valid.png"


SPEC_BEGIN(FUTextureSpec)

describe(@"A texture", ^{
	context(@"initializing with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([FUTexture new], nil);
		});
	});
	
	context(@"initializing with a non-existant texture", ^{
		it(@"throws an exception", ^{
			STAssertThrows([[FUTexture alloc] initWithName:NONEXISTANT], nil);
		});
	});
	
	context(@"initializing with an invalid texture", ^{
		it(@"throws an exception", ^{
			STAssertThrows([[FUTexture alloc] initWithName:INVALID], nil);
		});
	});
	
	context(@"initialized with a valid texture", ^{
		__block FUTexture* texture;
		
		beforeEach(^{
			texture = [[FUTexture alloc] initWithName:VALID];
		});
		
		it(@"is not nil", ^{
			expect(texture).toNot.beNil();
		});
		
		it(@"has a valid texture name", ^{
			expect([texture name]).toNot.equal(0);
		});
	});
	
	context(@"asyncronously initialized with a valid texture", ^{
		__block FUTexture* asyncTexture;
		
		beforeEach(^{
			[FUTexture textureWithName:VALID completionHandler:^(FUTexture* texture) {
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
