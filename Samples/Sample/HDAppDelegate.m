//
//  HDAppDelegate.m
//  Sample
//
//  Created by David Hart
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
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
		[director setPreferredFramesPerSecond:60];
		[window setRootViewController:director];
		
		FUScene* scene = [FUScene scene];
		
		for (NSUInteger index = 0; index < 1000; index++)
		{
			FUEntity* entity = [scene createEntity];
			
			FUSpriteRenderer* renderer = [entity addComponentWithClass:[FUSpriteRenderer class]];
			[renderer setTexture:@"Grossini.png"];
			[renderer setColor:FURandomColor()];
			
			FUTransform* transform = [entity transform];
			[transform setPosition:GLKVector2Make(floorf(FURandomDouble(0, 320)), floorf(FURandomDouble(0, 480)))];
		}
		
		[director loadScene:scene];
	}
	
	return _window;
}

#pragma mark - UIApplicationDelegate Methods

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[self window] makeKeyAndVisible];
	return YES;
}

@end
