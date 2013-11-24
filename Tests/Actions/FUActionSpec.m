//
//  FUActionSpec.m
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <objc/runtime.h>


SPEC_BEGIN(FUAction)

describe(@"An action", ^{
	it(@"can be copied", ^{
		expect(protocol_conformsToProtocol(objc_getProtocol("FUAction"), objc_getProtocol("NSCopying"))).to.beTruthy();
	});
});

SPEC_END
