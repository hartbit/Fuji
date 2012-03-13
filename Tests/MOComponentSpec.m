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
#import "OCMock.h"
#import "Mocha2D.h"
#import "MOComponent-Internal.h"


SPEC_BEGIN(MOComponentSpec)

describe(@"MOComponent", ^{
	context(@"init", ^{
		it(@"should raise when initialized directly", ^{
			STAssertThrows([MOComponent new], nil);
		});
	});
		
	context(@"initWithGameObject:", ^{
		it(@"should return a valid component with the gameObject property set", ^{
			//id mockGameObject = [OCMockObject niceMockForClass:[MOGameObject class]];
			MOGameObject* gameObject = [[MOScene new] addGameObject];
			MOComponent* component = [[MOComponent alloc] initWithGameObject:gameObject];
			expect(component).to.beAnInstanceOf([MOComponent class]);
			expect([component gameObject]).to.beIdenticalTo((__bridge void*)gameObject);
		});
	});
});

SPEC_END
