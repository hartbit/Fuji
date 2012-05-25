//
//  FUTweenAction.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "FUTimedAction.h"


@interface FUTweenAction : FUTimedAction

- (id)initWithObject:(id)object property:(NSString*)property toValue:(NSNumber*)toValue;
- (id)initWithObject:(id)object property:(NSString*)property fromValue:(NSNumber*)fromValue toValue:(NSNumber*)toValue;
- (id)initWithObject:(id)object property:(NSString*)property byValue:(NSNumber*)byValue;

@property (nonatomic, strong, readonly) id object;
@property (nonatomic, copy, readonly) NSString* property;
@property (nonatomic, strong, readonly) NSNumber* fromValue;
@property (nonatomic, strong, readonly) NSNumber* toValue;

@end
