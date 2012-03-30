//
//  FUViewController.h
//  Fuji
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>


@class FUScene;
@class FUEngine;

/** FUViewController
 * This is the view controller class.
 */
@interface FUDirector : GLKViewController <GLKViewDelegate>

@property (nonatomic, strong) FUScene* scene;

- (void)addEngine:(FUEngine*)engine;
- (NSSet*)allEngines;

@end
