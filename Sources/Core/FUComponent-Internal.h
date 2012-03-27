//
//  FUComponent-Internal.h
//  Fuji
//
//  Created by Hart David on 29.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


@class FUGameObject;

@interface FUComponent ()

@property (nonatomic, WEAK) FUGameObject* gameObject;

+ (NSSet*)allRequiredComponents;

- (id)initWithGameObject:(FUGameObject*)gameObject;

@end