//
//  FUAutoContentAccessingProxy-Internal.h
//  Fuji
//
//  Created by David Hart on 4/20/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//  From: http://stackoverflow.com/a/9182946
//

#import <Foundation/Foundation.h>


@interface FUAutoContentAccessingProxy : NSProxy

@property (nonatomic, strong) id target;

+ (FUAutoContentAccessingProxy*)proxyWithTarget:(id)target;

@end
