//
//  FUAssetStoreSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#include "Prefix.pch"
#import "Fuji.h"
#import "FUAssetStore-Internal.h"
#import "FUTexture-Internal.h"
#import "FUTestSupport.h"


static NSString* const FUNameNilMessage = @"Expected 'name' to not be nil or empty";


@interface FUTexture ()
@property (nonatomic) NSInteger accessCount;
@end


SPEC_BEGIN(FUAssetStore)

describe(@"An asset store", ^{	
	beforeAll(^{
		EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		[EAGLContext setCurrentContext:context];
	});
	
	context(@"initialized", ^{
		__block FUAssetStore* assetStore;
		
		beforeEach(^{
			assetStore = [FUAssetStore new];
		});
		
		it(@"is not nil", ^{
			expect(assetStore).toNot.beNil();
		});
		
		context(@"asking for a nil texture", ^{
			it(@"throws an exception", ^{
				assertThrows([assetStore textureWithName:nil], NSInvalidArgumentException, FUNameNilMessage);
			});
		});
		
		context(@"asking for a empty texture name", ^{
			it(@"throws an exception", ^{
				assertThrows([assetStore textureWithName:@""], NSInvalidArgumentException, FUNameNilMessage);
			});
		});
		
		context(@"asked for a valid texture", ^{
			__block FUTexture* texture;
			
			beforeEach(^{
				assetStore = [FUAssetStore new];
				texture = [assetStore textureWithName:TEXTURE_VALID1];
			});
			
			it(@"is not nil", ^{
				expect(texture).toNot.beNil();
			});
			
			it(@"has an access count of 1", ^{
				expect([texture accessCount]).to.equal(1);
			});
			
			context(@"asking for same texture again", ^{
				it(@"returns a different instance with the same name", ^{
					FUTexture* newTexture = [assetStore textureWithName:TEXTURE_VALID1];
					expect(newTexture).toNot.beIdenticalTo(texture);
					expect([newTexture name]).to.equal([texture name]);
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
});

SPEC_END
