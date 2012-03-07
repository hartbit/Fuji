//
//  MOTexture-Internal.h
//  Mocha2D
//
//  Created by Hart David on 26.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


@interface MOTexture ()

+ (void)textureWithName:(NSString*)name completion:(void (^)(MOTexture* texture))completion;
- (id)initWithName:(NSString*)name;

@end