//
//  FUEngine.h
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUInterfaceRotating.h"
#import "FUMacros.h"


@class FUDirector;
@class FUVisitor;

@interface FUEngine : NSObject <FUInterfaceRotating>

@property (nonatomic, WEAK, readonly) FUDirector* director;

- (FUVisitor*)registrationVisitor;
- (FUVisitor*)unregistrationVisitor;

- (void)unregisterAll;
- (void)update;
- (void)draw;

@end
