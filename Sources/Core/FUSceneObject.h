//
//  FUSceneObject.h
//  Fuji
//
//  Created by David Hart on 3/27/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FUInterfaceRotation.h"


@interface FUSceneObject : NSObject <FUInterfaceRotation>

- (void)updateVisitor:(id)visitor;
- (void)drawVisitor:(id)visitor;

@end
