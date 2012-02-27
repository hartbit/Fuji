//
//  MOMacros.h
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


// From http://lukeredpath.co.uk/blog/a-note-on-objective-c-singletons.html
#define MO_SINGLETON_WITH_BLOCK(block) \
	static dispatch_once_t predicate = 0; \
	__strong static id _sSharedInstance = nil; \
	dispatch_once(&predicate, ^{ \
		_sSharedInstance = block(); \
	}); \
	return _sSharedInstance;

#define MOStringIsValid(string) ((string) != nil) && ([string length] != 0)
#define MOIsInInterval(value, min, max) ((value) >= (min)) && ((value) <= (max))