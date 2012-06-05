//
//  FUDirectorVisitor-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "FUVisitor.h"
#import "FUSupport.h"


@class FUDirector;

@interface FUDirectorVisitor : FUVisitor

- (id)initWithDirector:(FUDirector*)director;

@property (nonatomic, WEAK, readonly) FUDirector* director;
@property (nonatomic, strong, readonly) NSMutableArray* visitors;

@end
