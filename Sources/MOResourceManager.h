//
//  FUResourceManager.h
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUTexture.h"


/** The resource manager manages the life cycle of all media in Fuji. */
@interface FUResourceManager : NSObject

/** @name Accessing the Resource Manager */

/** Returns the resource manager object.
 
 @return A singleton instance of the resource manager.
*/
+ (FUResourceManager*)sharedManager;

- (BOOL)resourceIsLoadedWithName:(NSString*)name;
- (void)purgeResources;

/** @name Loading Textures */

/** Returns, and loads if necessary, the texture identified by the specified name.
 
 This method looks in it's cache for a texture with the specified name and returns that object if it exists. If a matching texture is not already in the cache, this method loads the texture from the specified file, caches it, and then returns the resulting object.

 @param name The name of the texture file. If this is the first time the texture is being loaded, the method looks for a texture with the specified name in the application’s main bundle.
 @return A `FUTexture` object with the texture information.
*/
- (FUTexture*)textureWithName:(NSString*)name;

/** Returns, and loads if necessary, the texture identified by the specified name

 This method looks in it's cache for a texture with the specified name and returns that object if it exists. If a matching texture is not already in the cache, this method loads the texture from the specified file, caches it, and then returns the resulting object.
 
 @param name The name of the texture file. If this is the first time the texture is being loaded, the method looks for a texture with the specified name in the application’s main bundle.
 @param completion A block object to be executed when the texture is loaded. This block has no return value and takes no arguments. This parameter may be NULL.
*/
- (void)textureWithName:(NSString*)name completion:(void (^)(FUTexture* texture))completion;

@end
