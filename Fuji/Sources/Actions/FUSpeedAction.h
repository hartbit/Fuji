//
//  FUSpeedAction.h
//  Fuji
//
//  Created by Hart David on 10.05.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUAction.h"


@interface FUSpeedAction : NSObject <FUAction>

@property (nonatomic, strong, readonly) id<FUAction> action;
@property (nonatomic) float speed;

- (id)initWithAction:(id<FUAction>)action;
- (id)initWithAction:(id<FUAction>)action speed:(float)speed;

@end
