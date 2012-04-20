//
//  FUAsset-Internal.h
//  Fuji
//
//  Created by David Hart on 4/20/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FUAsset : NSObject <NSDiscardableContent>

- (NSUInteger)sizeInBytes;
- (void)verifyAccessibility;
- (void)discardContent;

@end
