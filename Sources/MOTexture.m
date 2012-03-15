//
//  FUTexture.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTexture.h"
#import <GLKit/GLKit.h>
#import "NSBundle+FUAdditions.h"
#import "FUTexture-Internal.h"
#import "FUMacros.h"


@interface FUTexture ()

@property (nonatomic, assign) GLuint identifier;

@end


@implementation FUTexture

@synthesize identifier = _identifier;

#pragma mark - Class Methods

+ (GLKTextureLoader*)asynchronousLoader
{
	static GLKTextureLoader* sTextureLoader = nil;
	
	if (sTextureLoader == nil)
	{
		EAGLSharegroup* sharegroup = [[EAGLContext currentContext] sharegroup];
		sTextureLoader = [[GLKTextureLoader alloc] initWithSharegroup:sharegroup];
	}
	
	return sTextureLoader;
}

+ (NSString*)pathWithName:(NSString*)name
{
	NSAssert(FUStringIsValid(name), @"");
	
	NSString* nameWithoutExtension = [name stringByDeletingPathExtension];
	NSString* extension = [name pathExtension];
	return [[NSBundle currentBundle] platformPathForResource:nameWithoutExtension ofType:extension];
}

#pragma mark - Initialization

+ (void)textureWithName:(NSString*)name completion:(void (^)(FUTexture* texture))completion
{
	NSAssert(FUStringIsValid(name), @"");
	NSAssert(completion != NULL, @"");
	
	NSString* path = [self pathWithName:name];
	
	[[self asynchronousLoader] textureWithContentsOfFile:path options:nil queue:NULL completionHandler:^(GLKTextureInfo* textureInfo, NSError* error) {
		NSAssert(textureInfo != nil, [error localizedDescription]);
		
		FUTexture* texture = [[self alloc] initWithTextureInfo:textureInfo];
		completion(texture);
	}];
}

- (id)initWithName:(NSString*)name
{
	NSAssert(FUStringIsValid(name), @"");
	
	NSString* path = [[self class] pathWithName:name];
	
	NSError* error = nil;
	GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:path options:nil error:&error];
	NSAssert(textureInfo != nil, [error localizedDescription]);
	
	return [self initWithTextureInfo:textureInfo];
}

- (id)initWithTextureInfo:(GLKTextureInfo*)textureInfo
{
	NSAssert(textureInfo != nil, @"");
	
	if ((self = [super init]))
	{
		[self setIdentifier:[textureInfo name]];
	}
	
	return self;
}

@end
