//
//  FUEntity-Internal.h
//  Fuji
//
//  Created by Hart David on 12.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


@class FUScene;

@interface FUEntity ()

@property (nonatomic, WEAK) FUScene* scene;
@property (nonatomic, strong) NSMutableSet* components;

+ (NSDictionary*)componentProperties;
+ (NSDictionary*)allComponentProperties;

- (id)initWithScene:(FUScene*)scene;

@end