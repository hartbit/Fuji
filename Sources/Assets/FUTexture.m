//
//  FUTexture.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "FUTexture-Internal.h"
#import "NSBundle+FUAdditions-Internal.h"
#import "FUSupport.h"


@interface FUTexture ()

@property (nonatomic, strong) GLKTextureInfo* info;

@end


@implementation FUTexture

@synthesize info = _info;

#pragma mark - Class Methods

+ (GLKTextureLoader*)asynchronousLoader
{
	static NSMutableDictionary* sTextureLoaders = nil;
	
	if (sTextureLoaders == nil)
	{
		sTextureLoaders = [NSMutableDictionary dictionary];
	}
	
	EAGLSharegroup* sharegroup = [[EAGLContext currentContext] sharegroup];
	GLKTextureLoader* loader = [sTextureLoaders objectForKey:sharegroup];
	
	if (loader == nil)
	{
		loader = [[GLKTextureLoader alloc] initWithSharegroup:sharegroup];
	}
	
	return loader;
}

+ (NSString*)pathWithName:(NSString*)name
{
	NSString* nameWithoutExtension = [name stringByDeletingPathExtension];
	NSString* extension = [name pathExtension];
	return [[NSBundle currentBundle] platformPathForResource:nameWithoutExtension ofType:extension];
}

#pragma mark - Properties

- (GLuint)name
{
	[self verifyAccessibility];
	return [[self info] name];
}

- (GLuint)width
{
	return [[self info] width];
}

- (GLuint)height
{
	return [[self info] height];
}

#pragma mark - Initialization

+ (void)textureWithName:(NSString*)name completionHandler:(void (^)(FUTexture* texture))block
{
	NSString* path = [self pathWithName:name];
	
	[[self asynchronousLoader] textureWithContentsOfFile:path options:nil queue:NULL completionHandler:^(GLKTextureInfo* textureInfo, NSError* error) {
		FUAssert(textureInfo != nil, [error localizedDescription]);
		block([[self alloc] initWithTextureInfo:textureInfo]);
	}];
}

- (id)initWithName:(NSString*)name
{
	NSString* path = [[self class] pathWithName:name];
	
	NSError* error = nil;
	GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:path options:nil error:&error];
	FUAssert(textureInfo != nil, [error localizedDescription]);
	
	return [self initWithTextureInfo:textureInfo];
}

- (id)initWithTextureInfo:(GLKTextureInfo*)textureInfo
{
	self = [super init];
	if (self == nil) return nil;
	
	[self setInfo:textureInfo];
	
	return self;
}

#pragma mark - FUAsset Methods

- (NSUInteger)sizeInBytes
{
	GLKTextureInfo* info = [self info];
	return [info width] * [info height] * 4;
}

- (void)discardContent
{
	GLuint name = [[self info] name];
	glDeleteTextures(1, &name);
}

@end
