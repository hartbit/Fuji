//
//  MOViewController.h
//  Mocha2D
//
//  Created by Hart David on 22.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <GLKit/GLKit.h>


@class MOScene;

/** MOViewController
 * This is the view controller class.
 */
@interface MOViewController : GLKViewController <GLKViewDelegate>

@property (nonatomic, strong) MOScene* scene;

@end
