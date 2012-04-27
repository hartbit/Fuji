//
//  FUEngine.h
//  Fuji
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUInterfaceRotating.h"
#import "FUSupport.h"


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
