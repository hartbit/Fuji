//
//  FUAssetStore-Internal.h
//  Fuji
//
//  Created by Hart David on 17.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUAssetStore.h"


@class FUTexture;

@interface FUAssetStore ()

- (FUTexture*)textureWithName:(NSString*)name;

@end
