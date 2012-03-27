//
//  FUTestVisitors.h
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import "Fuji.h"


@interface FUTestVisitor : NSObject

- (void)visitFUVisitable:(FUVisitable*)visitable;

@end