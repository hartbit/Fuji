//
//  FUScene.h
//  Fuji
//
//  Created by Hart David on 28.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUGameObject.h"


@interface FUScene : FUGameObject

+ (FUScene*)scene;

- (FUGameObject*)createGameObject;

@end
