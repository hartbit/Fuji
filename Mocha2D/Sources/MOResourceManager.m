//
//  MOResourceManager.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOResourceManager.h"
#import "MOResourceInfo-Internal.h"
#import "MOTexture-Internal.h"
#import "MOMacros.h"


@interface MOResourceManager ()

@property (nonatomic, strong) NSMutableDictionary* resources;

@end


@implementation MOResourceManager

@synthesize resources = _resources;

#pragma mark - Initialization

+ (MOResourceManager*)sharedManager
{
	MO_SINGLETON_WITH_BLOCK(^{
		return [MOResourceManager new];
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
	NSAssert(MOStringIsValid(name), @"");
	
	MOResourceInfo* resourceInfo = [[self resources] objectForKey:name];
	return [resourceInfo resource] != nil;
}

- (void)purgeResources
{
	[[self resources] enumerateKeysAndObjectsUsingBlock:^(id key, MOResourceInfo* resourceInfo, BOOL* stop) {
		if ([[resourceInfo resource] retainCount] == 1)
		{
			[[self resources] removeObjectForKey:key];
		}
	}];
}

#pragma mark - Texture Loading

- (MOTexture*)textureWithName:(NSString*)name
{
	return [self textureWithName:name lifetime:MOResourceLifetimeShort];
}

- (MOTexture*)textureWithName:(NSString*)name lifetime:(MOResourceLifetime)lifetime
{
	NSAssert(MOStringIsValid(name), @"");
	NSAssert(MOIsInInterval(lifetime, MOResourceLifetimeShort, MOResourceLifetimeApplication), @"");
	
	MOTexture* texture = [self resourceWithName:name type:[MOTexture class] lifetime:lifetime];
	
	if (texture == nil)
	{
		texture = [[MOTexture alloc] initWithName:name];
		[self setResource:texture withName:name lifetime:lifetime];
		[texture release];
	}

	return texture;
}

- (void)textureWithName:(NSString*)name completion:(void (^)(MOTexture* texture))completion;
{
	[self textureWithName:name lifetime:MOResourceLifetimeShort completion:completion];
}

- (void)textureWithName:(NSString*)name lifetime:(MOResourceLifetime)lifetime completion:(void (^)(MOTexture* texture))completion;
{
	NSAssert(MOStringIsValid(name), @"");
	NSAssert(MOIsInInterval(lifetime, MOResourceLifetimeShort, MOResourceLifetimeApplication), @"");
	
	MOTexture* texture = [self resourceWithName:name type:[MOTexture class] lifetime:lifetime];
	
	if (texture == nil)
	{
		[MOTexture textureWithName:name completion:^(MOTexture* texture) {
			[self setResource:texture withName:name lifetime:lifetime];
			completion(texture);
		}];
	}
	else if (completion != NULL)
	{
		completion(texture);
	}
}

#pragma mark - Private Methods

- (id)resourceWithName:(NSString*)name type:(Class)class lifetime:(MOResourceLifetime)lifetime
{
	NSAssert(MOStringIsValid(name), @"");
	NSAssert(class != NULL, @"");
	NSAssert(MOIsInInterval(lifetime, MOResourceLifetimeShort, MOResourceLifetimeApplication), @"");
	
	MOResourceInfo* resourceInfo = [[self resources] objectForKey:name];
	
	if (resourceInfo != nil)
	{
		if (![[resourceInfo resource] isKindOfClass:class])
		{
			NSAssert(nil, @"Invalid resource type");
			return nil;
		}
		
		if (lifetime > [resourceInfo lifetime])
		{
			[resourceInfo setLifetime:lifetime];
		}
	}
	
	return [resourceInfo resource];
}

- (void)setResource:(id)resource withName:(NSString*)name lifetime:(MOResourceLifetime)lifetime
{
	NSAssert(resource != nil, @"");
	NSAssert(MOStringIsValid(name), @"");
	NSAssert(MOIsInInterval(lifetime, MOResourceLifetimeShort, MOResourceLifetimeApplication), @"");
	
	MOResourceInfo* resourceInfo = [[MOResourceInfo alloc] initWithResource:resource lifetime:lifetime];
	[[self resources] setObject:resourceInfo forKey:name];
	[resourceInfo release];
}

@end
