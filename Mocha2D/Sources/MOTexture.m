//
//  MOTexture.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "MOTexture.h"
#import <GLKit/GLKit.h>
#import "NSBundle+MOAdditions.h"
#import "MOTexture-Internal.h"
#import "MOMacros.h"


@interface MOTexture ()

@property (nonatomic, assign) GLuint identifier;

@end


@implementation MOTexture

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
	NSAssert(MOStringIsValid(name), @"");
	
	NSString* nameWithoutExtension = [name stringByDeletingPathExtension];
	NSString* extension = [name pathExtension];
	return [[NSBundle currentBundle] platformPathForResource:nameWithoutExtension ofType:extension];
}

#pragma mark - Initialization

+ (void)textureWithName:(NSString*)name completion:(void (^)(MOTexture* texture))completion
{
	NSAssert(MOStringIsValid(name), @"");
	
	NSString* path = [self pathWithName:name];
	
	[[self asynchronousLoader] textureWithContentsOfFile:path options:nil queue:NULL completionHandler:^(GLKTextureInfo* textureInfo, NSError* error) {
		NSAssert(textureInfo != nil, [error localizedDescription]);
		
		MOTexture* texture = [[self alloc] initWithTextureInfo:textureInfo];
		completion(texture);
	}];
}

- (id)initWithName:(NSString*)name
{
	NSAssert(MOStringIsValid(name), @"");
	
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
