//
//  FUAssert.h
//  Fuji
//
//  Created by David Hart on 5/30/12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


#define _FUThrow(name, format, ...) @throw [NSException exceptionWithName:(name) reason:[NSString stringWithFormat:(format), ##__VA_ARGS__] userInfo:nil]
#define FUThrow(format, ...) _FUThrow(NSInternalInconsistencyException, format, ##__VA_ARGS__)

#ifndef NS_BLOCK_ASSERTIONS

#define _FUAssert(condition, name, reason, ...) do { \
	if (!(condition)) { \
		_FUThrow(name, reason, ##__VA_ARGS__); \
	} \
} while(0)

#define FUCheck(condition, reason, ...) _FUAssert(condition, NSInvalidArgumentException, reason, ##__VA_ARGS__)
#define FUAssert(condition, reason, ...) _FUAssert(condition, NSInternalInconsistencyException, reason, ##__VA_ARGS__) 

#define FUCheckOGLError() do { \
	GLenum __error = glGetError(); \
	if (__error) { \
		NSLog(@"OpenGL Error: 0x%04X in %s %d", __error, __FUNCTION__, __LINE__); \
	} \
} while (0)

#else

#define _FUAssert(condition, reason, ...)
#define FUCheck(condition, reason, ...)
#define FUAssert(condition, reason, ...)
#define FUCheckOGLError()

#endif


id FUValueForKey(id object, NSString* key);

static OBJC_INLINE BOOL FUStringIsValid(NSString* string)
{
	return (string != nil) && ([string length] != 0);
}