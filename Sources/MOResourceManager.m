//
//  FUResourceManager.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUResourceManager.h"
#import "FUTexture-Internal.h"
#import "FUMacros.h"


@interface FUResourceManager ()

@property (nonatomic, strong) NSMutableDictionary* resources;

@end


@implementation FUResourceManager

@synthesize resources = _resources;

#pragma mark - Initialization

+ (FUResourceManager*)sharedManager
{
	FU_SINGLETON_WITH_BLOCK(^{
		return [FUResourceManager new];
	});
}

#pragma mark - Properties

- (NSMutableDictionary*)resources
{
	if (_resources == nil)
	{
		[self setResources:[NSMutableDictionary dictionary]];
	}
	
	return _resources;
}

#pragma mark - Public Methods

- (BOOL)resourceIsLoadedWithName:(NSString*)name
{
	FUAssertError(FUStringIsValid(name), @"name=%@", name);
	
	return [[self resources] objectForKey:name] != nil;
}

- (void)purgeResources
{
	[[self resources] removeAllObjects];
/*
	[[self resources] enumerateKeysAndObjectsUsingBlock:^(id name, id resource, BOOL* stop) {
		if ([resource retainCount] == 1)
		{
			[[self resources] removeObjectForKey:name];
		}
	}];
*/
}

#pragma mark - Texture Loading

- (FUTexture*)textureWithName:(NSString*)name
{
	FUAssertError(FUStringIsValid(name), @"name=%@", name);
	
	FUTexture* texture = [self resourceWithName:name type:[FUTexture class]];
	
	if (texture == nil)
	{
		texture = [[FUTexture alloc] initWithName:name];
		[self setResource:texture withName:name];
	}
	
	return texture;
}

- (void)textureWithName:(NSString*)name completion:(void (^)(FUTexture* texture))completion;
{
	FUAssertError(FUStringIsValid(name), @"name=%@", name);
	
	FUTexture* texture = [self resourceWithName:name type:[FUTexture class]];
	
	if (texture == nil)
	{
		[FUTexture textureWithName:name completion:^(FUTexture* texture) {
			[self setResource:texture withName:name];
			
			if (completion != NULL)
			{
				completion(texture);
			}
		}];
	}
	else if (completion != NULL)
	{
		completion(texture);
	}
}

#pragma mark - Private Methods

- (id)resourceWithName:(NSString*)name type:(Class)class
{
	FUAssertError(FUStringIsValid(name), @"name=%@", name);
	FUAssertError(class != NULL, nil);
	
	id resource = [[self resources] objectForKey:name];
	
	if ((resource != nil) && ![resource isKindOfClass:class])
	{
		NSAssert(nil, @"Invalid resource type");
		return nil;
	}
	
	return resource;
}

- (void)setResource:(id)resource withName:(NSString*)name
{
	FUAssertError(resource != nil, nil);
	FUAssertError(FUStringIsValid(name), @"name=%@", name);
	
	[[self resources] setObject:resource forKey:name];
}

@end
