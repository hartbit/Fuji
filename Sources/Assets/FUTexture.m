//
//  FUTexture.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <GLKit/GLKit.h>
#import "FUTexture-Internal.h"
#import "NSBundle+FUAdditions-Internal.h"
#import "FUAssert.h"


static NSString* const FUTextureNonexistantMessage = @"The texture with 'name=%@' does not exist";
static NSString* const FUTextureLoaderMessage = @"The texture couldn't be loaded because of 'error=%@'";
static NSString* NSStringFromGLKTextureLoaderError(GLKTextureLoaderError error);


@interface FUTexture ()

@property (nonatomic, strong) GLKTextureInfo* info;

@end


@implementation FUTexture

#pragma mark - Class Methods

+ (GLKTextureLoader*)asynchronousLoader
{
	static NSMutableDictionary* sTextureLoaders;
	
	if (sTextureLoaders == nil) {
		sTextureLoaders = [NSMutableDictionary dictionary];
	}
	
	EAGLSharegroup* sharegroup = [[EAGLContext currentContext] sharegroup];
	GLKTextureLoader* loader = sTextureLoaders[sharegroup];
	
	if (loader == nil) {
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
	FUCheck(path != nil, FUTextureNonexistantMessage, name);
	
	[[self asynchronousLoader] textureWithContentsOfFile:path options:nil queue:NULL completionHandler:^(GLKTextureInfo* textureInfo, NSError* error) {
		FUAssert(textureInfo != nil, FUTextureLoaderMessage, NSStringFromGLKTextureLoaderError([error code]));
		block([[self alloc] initWithTextureInfo:textureInfo]);
	}];
}

- (id)initWithName:(NSString*)name
{
	NSString* path = [[self class] pathWithName:name];
	FUCheck(path != nil, FUTextureNonexistantMessage, name);
	
	NSError* error;
	GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:path options:nil error:&error];
	FUAssert(textureInfo != nil, FUTextureLoaderMessage, NSStringFromGLKTextureLoaderError([error code]));
	
	return [self initWithTextureInfo:textureInfo];
}

- (id)initWithTextureInfo:(GLKTextureInfo*)textureInfo
{
	if ((self = [super init])) {
		[self setInfo:textureInfo];
	}
	
	return self;
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


static NSString* NSStringFromGLKTextureLoaderError(GLKTextureLoaderError error)
{
	switch (error) {
		case GLKTextureLoaderErrorFileOrURLNotFound: return @"GLKTextureLoaderErrorFileOrURLNotFound";
		case GLKTextureLoaderErrorInvalidNSData: return @"GLKTextureLoaderErrorInvalidNSData";
		case GLKTextureLoaderErrorInvalidCGImage: return @"GLKTextureLoaderErrorInvalidCGImage";
		case GLKTextureLoaderErrorUnknownPathType: return @"GLKTextureLoaderErrorUnknownPathType";
		case GLKTextureLoaderErrorUnknownFileType: return @"GLKTextureLoaderErrorUnknownFileType";
		case GLKTextureLoaderErrorPVRAtlasUnsupported: return @"GLKTextureLoaderErrorPVRAtlasUnsupported";
		case GLKTextureLoaderErrorCubeMapInvalidNumFiles: return @"GLKTextureLoaderErrorCubeMapInvalidNumFiles";
		case GLKTextureLoaderErrorCompressedTextureUpload: return @"GLKTextureLoaderErrorCompressedTextureUpload";
		case GLKTextureLoaderErrorUncompressedTextureUpload: return @"GLKTextureLoaderErrorUncompressedTextureUpload";
		case GLKTextureLoaderErrorUnsupportedCubeMapDimensions: return @"GLKTextureLoaderErrorUnsupportedCubeMapDimensions";
		case GLKTextureLoaderErrorUnsupportedBitDepth: return @"GLKTextureLoaderErrorUnsupportedBitDepth";
		case GLKTextureLoaderErrorUnsupportedPVRFormat: return @"GLKTextureLoaderErrorUnsupportedPVRFormat";
		case GLKTextureLoaderErrorDataPreprocessingFailure: return @"GLKTextureLoaderErrorDataPreprocessingFailure";
		case GLKTextureLoaderErrorMipmapUnsupported: return @"GLKTextureLoaderErrorMipmapUnsupported";
		case GLKTextureLoaderErrorUnsupportedOrientation: return @"GLKTextureLoaderErrorUnsupportedOrientation";
		case GLKTextureLoaderErrorReorientationFailure: return @"GLKTextureLoaderErrorReorientationFailure";
		case GLKTextureLoaderErrorAlphaPremultiplicationFailure: return @"GLKTextureLoaderErrorAlphaPremultiplicationFailure";
		case GLKTextureLoaderErrorInvalidEAGLContext: return @"GLKTextureLoaderErrorInvalidEAGLContext";
	}
	
	FUThrow(@"Invalid GLKTextureLoaderError with 'code=%i'", error);
}
