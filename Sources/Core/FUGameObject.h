//
//  FUGameObject.h
//  Fuji
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUMacros.h"


@class FUScene;
@class FUComponent;

@interface FUGameObject : NSObject

@property (nonatomic, WEAK, readonly) FUScene* scene;

- (FUComponent*)addComponentWithClass:(Class)componentClass;
- (FUComponent*)componentWithClass:(Class)componentClass;

@end
