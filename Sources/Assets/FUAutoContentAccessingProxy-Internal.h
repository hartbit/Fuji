//
//  FUAutoContentAccessingProxy-Internal.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//  From: http://stackoverflow.com/a/9182946
//

#import <Foundation/Foundation.h>


@interface FUAutoContentAccessingProxy : NSProxy

@property (nonatomic, strong) id target;

+ (FUAutoContentAccessingProxy*)proxyWithTarget:(id)target;

@end
