//
//  FUAssetStore.m
//  Fuji
//
//  Created by Hart David on 17.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUAssetStore.h"
#import "FUAssetStore-Internal.h"
#import "FUTexture-Internal.h"
#import "FUSupport.h"


static NSString* const FUNameNilMessage = @"Expected 'name' to not be nil or empty";


@implementation FUAssetStore

#pragma maek - Internal Methods

- (FUTexture*)textureWithName:(NSString*)name
{
	FUAssert(FUStringIsValid(name), FUNameNilMessage);
	
	return [[FUTexture alloc] initWithName:name];
}

@end
