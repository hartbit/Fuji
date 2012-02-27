//
//  MOResourceManager.h
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOTexture.h"


/** @constants */

/** The lifetime in the manager cache of game resources. */
typedef enum
{
	/** With this lifetime, the resource can be unloaded at anytime when not in use. These are the first to go when a memory warning is received. */
	MOResourceLifetimeShort,
	/** With this lifetime, the resource is garantueed to stay in the cache until the end of the scene. */
	MOResourceLifetimeScene,
	/** With this lifetime, the resource will never leave the cache and stay in memory for the lifetime of the application.
	 * @warning **Important:** Do not abuse this lifetime unnecessarily so as to let the Resource Manager unload resources as soon as possible.
	 */
	MOResourceLifetimeApplication
} MOResourceLifetime;


/** The resource manager manages the life cycle of all media in Mocha2D. */
@interface MOResourceManager : NSObject

/** @name Accessing the Resource Manager */

/** Returns the resource manager object.
 
 @return A singleton instance of the resource manager.
*/
+ (MOResourceManager*)sharedManager;

- (BOOL)resourceIsLoadedWithName:(NSString*)name;
- (void)purgeResources;

/** @name Loading Textures */

/** Returns, and loads if necessary, the texture identified by the specified name.
 
 This method looks in it's cache for a texture with the specified name and returns that object if it exists. If a matching texture is not already in the cache, this method loads the texture from the specified file, caches it, and then returns the resulting object.

 @param name The name of the texture file. If this is the first time the texture is being loaded, the method looks for a texture with the specified name in the application’s main bundle.
 @return A `MOTexture` object with the texture information.
*/
- (MOTexture*)textureWithName:(NSString*)name;

/** Returns, and loads if necessary, the texture identified by the specified name, and sets it's lifetime.

 This method looks in it's cache for a texture with the specified name and returns that object if it exists. If a matching texture is not already in the cache, this method loads the texture from the specified file, caches it, and then returns the resulting object.

 @param name The name of the texture file. If this is the first time the texture is being loaded, the method looks for a texture with the specified name in the application’s main bundle.
 @param lifetime The guaranteed lifetime the texture will stay in the cache with no objects using it. If the texture already exists in the cache, and if the lifetime parameter is greater than the current lifetime of the texture in the cache, it will update the texture with the new lifetime.
 @return A `MOTexture` object with the texture information.
*/
- (MOTexture*)textureWithName:(NSString*)name lifetime:(MOResourceLifetime)lifetime;

/** Returns, and loads if necessary, the texture identified by the specified name

 This method looks in it's cache for a texture with the specified name and returns that object if it exists. If a matching texture is not already in the cache, this method loads the texture from the specified file, caches it, and then returns the resulting object.
 
 @param name The name of the texture file. If this is the first time the texture is being loaded, the method looks for a texture with the specified name in the application’s main bundle.
 @param completion A block object to be executed when the texture is loaded. This block has no return value and takes no arguments. This parameter may be NULL.
*/
- (void)textureWithName:(NSString*)name completion:(void (^)(MOTexture* texture))completion;

/** Returns, and loads if necessary, the texture identified by the specified name, and sets it's lifetime.
 
 This method looks in it's cache for a texture with the specified name and returns that object if it exists. If a matching texture is not already in the cache, this method loads the texture asynchronously from the specified file, caches it, returning an empty `MOTexture` object meanwhile.

 @param name The name of the texture file. If this is the first time the texture is being loaded, the method looks for a texture with the specified name in the application’s main bundle.
 @param lifetime The guaranteed lifetime the texture will stay in the cache with no objects using it. If the texture already exists in the cache, and if the lifetime parameter is greater than the current lifetime of the texture in the cache, it will update the texture with the new lifetime.
 @param completion A block object to be executed when the texture is loaded. This block has no return value and takes no arguments. This parameter may be NULL.
*/
- (void)textureWithName:(NSString*)name lifetime:(MOResourceLifetime)lifetime completion:(void (^)(MOTexture* texture))completion;

@end
