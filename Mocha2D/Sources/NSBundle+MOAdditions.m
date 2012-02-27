//
//  NSBundle+MOAdditions.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOViewController.h"
#import "UIDevice+MOAdditions.h"
#import "UIScreen+MOAdditions.h"
#import "MOMacros.h"


@implementation NSBundle (MOAdditions)

+ (NSBundle*)currentBundle
{
	static NSBundle* sCurrentBundle = nil;
	
	if (sCurrentBundle == nil)
	{
		sCurrentBundle = [NSBundle bundleForClass:[MOViewController class]];
	}
	
	return sCurrentBundle;
}

- (NSString*)platformPathForResource:(NSString*)name ofType:(NSString*)extension
{
	NSString* platformSuffix = [[UIDevice currentDevice] platformSuffix];
	NSString* scaleSuffix = [[UIScreen mainScreen] scaleSuffix];
	BOOL hasScaleSuffix = MOStringIsValid(scaleSuffix);
	
	NSString* nameWithSuffix = nil;
	NSString* path = nil;
	
	if (hasScaleSuffix)
	{
		nameWithSuffix = [NSString stringWithFormat:@"%@%@%@", name, scaleSuffix, platformSuffix];
		path = [self pathForResource:nameWithSuffix ofType:extension];
		if (path != nil) return path;
	}
	
	nameWithSuffix = [NSString stringWithFormat:@"%@%@", name, platformSuffix];
	path = [self pathForResource:nameWithSuffix ofType:extension];
	if (path != nil) return path;
	
	if (hasScaleSuffix)
	{
		nameWithSuffix = [NSString stringWithFormat:@"%@%@", name, scaleSuffix];
		path = [self pathForResource:nameWithSuffix ofType:extension];
		if (path != nil) return path;
	}
	
	return [self pathForResource:name ofType:extension];
}

@end
