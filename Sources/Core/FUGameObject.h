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

- (id)addComponentWithClass:(Class)componentClass;
- (void)removeComponent:(FUComponent*)component;
- (id)componentWithClass:(Class)componentClass;
- (NSSet*)allComponentsWithClass:(Class)componentClass;
- (NSSet*)allComponents;

@end
