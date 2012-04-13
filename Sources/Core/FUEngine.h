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

@interface FUEngine : NSObject <FUInterfaceRotating>

@property (nonatomic, WEAK, readonly) FUDirector* director;

- (void)unregisterAll;
- (void)update;
- (void)draw;

@end
