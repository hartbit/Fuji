//
//  FUEngine.h
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUMacros.h"
#import "FUInterfaceRotating.h"


@class FUDirector;
@class FUEntity;
@class FUScene;
@class FUComponent;
@class FUBehavior;

@interface FUEngine : NSObject <FUInterfaceRotating>

@property (nonatomic, WEAK, readonly) FUDirector* director;

- (void)updateEntityEnter:(FUEntity*)entity;
- (void)updateEntityLeave:(FUEntity*)entity;
- (void)drawEntityEnter:(FUEntity*)entity;
- (void)drawEntityLeave:(FUEntity*)entity;

- (void)updateSceneEnter:(FUScene*)scene;
- (void)updateSceneLeave:(FUScene*)scene;
- (void)drawSceneEnter:(FUScene*)scene;
- (void)drawSceneLeave:(FUScene*)scene;

- (void)updateComponent:(FUComponent*)component;
- (void)drawComponent:(FUComponent*)component;

- (void)updateBehavior:(FUBehavior*)behavior;
- (void)drawBehavior:(FUBehavior*)behavior;

@end
