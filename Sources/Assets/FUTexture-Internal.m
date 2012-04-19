//
//  FUTexture-Internal.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUTexture-Internal.h"
#import <GLKit/GLKit.h>
#import "NSBundle+FUAdditions-Internal.h"
#import "FUSupport.h"


@interface FUTexture ()

@property (nonatomic, assign) GLuint name;

@end


@implementation FUTexture

@synthesize name = _name;

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
	
	[self setName:[textureInfo name]];
	
	return self;
}

@end
