//
//  MOTestMacros.h
//  Mocha2D
//
//  Created by Hart David on 26.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


#define MO_WAIT_FOR_FLAG(flag, timeout) { \
	NSDate* timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout]; \
	while (!flag && [timeoutDate timeIntervalSinceNow] > 0) { \
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate]; \
	} \
}