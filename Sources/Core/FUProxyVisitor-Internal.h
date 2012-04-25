//
//  FUProxyVisitor-Internal.h
//  Fuji
//
//  Created by Hart David on 18.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUVisitor.h"


@interface FUProxyVisitor : FUVisitor

@property (nonatomic, strong, readonly) NSMutableSet* visitors;

@end
