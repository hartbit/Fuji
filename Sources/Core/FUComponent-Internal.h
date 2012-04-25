//
//  FUComponent-Internal.h
//  Fuji
//
//  Created by Hart David on 29.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUComponent.h"
#import "FUSupport.h"


@class FUEntity;

@interface FUComponent ()

@property (nonatomic, WEAK) FUEntity* entity;

+ (NSSet*)allRequiredComponents;

- (id)initWithEntity:(FUEntity*)entity;

@end