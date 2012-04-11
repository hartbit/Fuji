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
		[director setPreferredFramesPerSecond:60];
		[window setRootViewController:director];
		
		FUScene* scene = [FUScene new];
		[director setScene:scene];
		
		for (NSUInteger index = 0; index < 1000; index++)
		{
			FUEntity* entity = [scene createEntity];
			FUSpriteRenderer* renderer = [entity addComponentWithClass:[FUSpriteRenderer class]];
			[renderer setColor:GLKVector4Make(FURandomUnit(), FURandomUnit(), FURandomUnit(), 1)];
			FUTransform* transform = [entity transform];
			[transform setScale:GLKVector2Make(52, 139)];
			[transform setPosition:GLKVector2Make(floorf(FURandomDouble(0, 320)), floorf(FURandomDouble(0, 480)))];
		}
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
