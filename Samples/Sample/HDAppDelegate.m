//
//  HDAppDelegate.m
//  Sample
//
//  Created by Hart David on 02.04.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "HDAppDelegate.h"
#import "Fuji.h"


@implementation HDAppDelegate

@synthesize window = _window;

#pragma mark - Properties

- (UIWindow*)window
{
	if (_window == nil)
	{
		CGRect frame = [[UIScreen mainScreen] bounds];
		UIWindow* window = [[UIWindow alloc] initWithFrame:frame];
		[self setWindow:window];
		
		FUDirector* director = [FUDirector new];
		[window setRootViewController:director];
		
		FUScene* scene = [FUScene new];
		[director setScene:scene];
		
		FUEntity* entity = [scene createEntity];
		[entity addComponentWithClass:[FUSpriteRenderer class]];
		[[entity transform] setPosition:GLKVector2Make(100, 100)];
		[[entity transform] setRotation:M_PI_4];
		[[entity transform] setScale:GLKVector2Make(0.8, 1.2)];
	}
	
	return _window;
}

#pragma mark - UIApplicationDelegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[self window] makeKeyAndVisible];
	return YES;
}

@end
