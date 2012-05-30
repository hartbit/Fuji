//
//  FUAssetStore.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUAssetStore-Internal.h"
#import "FUTexture-Internal.h"
#import "FUAssert.h"


static NSString* const FUNameNilMessage = @"Expected 'name' to not be nil or empty";


@interface FUAssetStore ()

@property (nonatomic, strong) NSCache* cache;

@end


@implementation FUAssetStore

@synthesize cache = _cache;

#pragma mark - Properties

- (NSCache*)cache
{
	if (_cache == nil) {
		[self setCache:[NSCache new]];
	}
	
	return _cache;
}

#pragma maek - Internal Methods

- (FUTexture*)textureWithName:(NSString*)name
{
	FUCheck(FUStringIsValid(name), FUNameNilMessage);
	
	FUTexture* texture = [[self cache] objectForKey:name];
	
	if (texture == nil) {
		texture = [[FUTexture alloc] initWithName:name];
		[texture endContentAccess];
		
		[[self cache] setObject:texture forKey:name cost:[texture sizeInBytes]];
	}
	
	return [texture autoContentAccessingProxy];
}

@end
