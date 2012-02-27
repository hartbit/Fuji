//
//  MOResourceInfo-Internal.h
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOResourceManager.h"


@interface MOResourceInfo : NSObject

@property (nonatomic, strong, readonly) id resource;
@property (nonatomic, assign) MOResourceLifetime lifetime;

- (id)initWithResource:(id)resource lifetime:(MOResourceLifetime)lifetime;

@end
