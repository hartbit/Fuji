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
		[[scene graphics] setBackgroundColor:FUColorBlue];
		[director setScene:scene];
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
