//
//  MOComponentSpec.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//


SPEC_BEGIN(MOComponentSpec)

describe(@"MOComponent", ^{
	it(@"should raise when initialized directly", ^{
		STAssertThrows([MOComponent new], nil);
	});
});

SPEC_END
