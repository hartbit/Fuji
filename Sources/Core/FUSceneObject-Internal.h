//
//  FUSceneObject-Internal.h
//  Fuji
//
//  Created by Hart David on 30.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


@interface FUSceneObject ()

- (void)acceptVisitor:(id)visitor withSelectorPrefix:(NSString*)prefix;

@end