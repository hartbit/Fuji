//
//  FUAssetStore.m
//  Fuji
//
//  Created by Hart David on 17.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "FUAssetStore.h"
#import "FUAssetStore-Internal.h"
#import "FUTexture.h"
#import "FUMacros.h"


static NSString* const FUCreationInvalidMessage = @"Can not create an asset store on it's own";


@implementation FUAssetStore

#pragma mark - Initialization

- (id)init
{
	FUThrow(FUCreationInvalidMessage);
}

- (id)initWithSharegroup:(EAGLSharegroup*)sharegroup
{
	self = [super init];
	if (self == nil) return nil;
	
	return self;
}

#pragma maek - Public Methods

- (FUTexture*)textureWithName:(NSString*)name
{
	return nil;
}

@end
