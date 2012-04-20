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


@interface FUAssetStore ()

@property (nonatomic, strong) NSCache* cache;

@end


@implementation FUAssetStore

@synthesize cache = _cache;

#pragma mark - Properties

- (NSCache*)cache
{
	if (_cache == nil)
	{
		[self setCache:[NSCache new]];
	}
	
	return _cache;
}

#pragma maek - Internal Methods

- (FUTexture*)textureWithName:(NSString*)name
{
	FUAssert(FUStringIsValid(name), FUNameNilMessage);
	
	FUTexture* texture = [[self cache] objectForKey:name];
	
	if (texture == nil)
	{
		texture = [[FUTexture alloc] initWithName:name];
		[texture endContentAccess];
		
		[[self cache] setObject:texture forKey:name];
	}
	
	return [texture autoContentAccessingProxy];
}

@end
