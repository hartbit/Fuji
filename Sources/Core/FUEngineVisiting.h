//
//  FUEngineVisiting.h
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FUEngine;

@protocol FUEngineVisiting <NSObject>

- (void)updateWithEngine:(FUEngine*)engine;
- (void)drawWithEngine:(FUEngine*)engine;

@end
