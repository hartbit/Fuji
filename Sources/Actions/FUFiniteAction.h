//
//  FUFiniteAction.h
//  Fuji
//
//  Created by David Hart on 5/1/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUAction.h"


@interface FUFiniteAction : NSObject <FUAction>

@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic, readonly) BOOL isComplete;

- (FUFiniteAction*)reverse;
- (void)advanceTime:(NSTimeInterval)deltaTime;

@end
