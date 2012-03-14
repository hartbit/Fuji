//
//  MOComponentSpec.m
//  Mocha2D
//
//  Created by David Hart on 01.03.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#define MOCKITO_SHORTHAND
#import "OCMockito.h"
#import "Mocha2D.h"
#import "MOComponent-Internal.h"


SPEC_BEGIN(MOComponentSpec)

describe(@"A component object", ^{
	context(@"when initialized with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([MOComponent new], nil);
		});
	});
		
	context(@"when initialized with initWithGameObject:", ^{
		__block MOGameObject* gameObject = nil;
		__block MOComponent* component = nil;
		
		beforeEach(^{
			gameObject = mock([MOGameObject class]);
			component = [[MOComponent alloc] initWithGameObject:gameObject];
		});
		
		it(@"is not nil", ^{
			expect(component).toNot.beNil();
		});
		
		it(@"has the gameObject property set", ^{
			expect([component gameObject]).to.beIdenticalTo((__bridge void*)gameObject);
		});
	});
});

SPEC_END
