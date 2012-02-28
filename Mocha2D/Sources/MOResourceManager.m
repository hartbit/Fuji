//
//  MOResourceManager.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOResourceManager.h"
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
	MOAssertError(MOStringIsValid(name), @"name=%@", name);
	
	return [[self resources] objectForKey:name] != nil;
}

- (void)purgeResources
{
	[[self resources] enumerateKeysAndObjectsUsingBlock:^(id name, id resource, BOOL* stop) {
		if ([resource retainCount] == 1)
		{
			[[self resources] removeObjectForKey:name];
		}
	}];
}

#pragma mark - Texture Loading

- (MOTexture*)textureWithName:(NSString*)name
{
	MOAssertError(MOStringIsValid(name), @"name=%@", name);
	
	MOTexture* texture = [self resourceWithName:name type:[MOTexture class]];
	
	if (texture == nil)
	{
		texture = [[MOTexture alloc] initWithName:name];
		[self setResource:texture withName:name];
		[texture release];
	}
	
	return texture;
}

- (void)textureWithName:(NSString*)name completion:(void (^)(MOTexture* texture))completion;
{
	MOAssertError(MOStringIsValid(name), @"name=%@", name);
	
	MOTexture* texture = [self resourceWithName:name type:[MOTexture class]];
	
	if (texture == nil)
	{
		[MOTexture textureWithName:name completion:^(MOTexture* texture) {
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
	MOAssertError(MOStringIsValid(name), @"name=%@", name);
	MOAssertError(class != NULL, nil);
	
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
	MOAssertError(resource != nil, nil);
	MOAssertError(MOStringIsValid(name), @"name=%@", name);
	
	[[self resources] setObject:resource forKey:name];
}

@end
