//
//  MOGameObjectSpec.m
//  Mocha2D
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#define SPT_CEDAR_SYNTAX
#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "OCMockito.h"
#import "Mocha2D.h"
#import "MOGameObject-Internal.h"
#import "MOComponent-Internal.h


SPEC_BEGIN(MOGameObjectSpec)

describe(@"A game object", ^{
	context(@"initialized with init", ^{
		it(@"throws an exception", ^{
			STAssertThrows([MOGameObject new], nil);
		});
	});
	
	context(@"initialized with a nil scene", ^{
		it(@"throws an exception", ^{
			STAssertThrows(((void)[[MOGameObject alloc] initWithScene:nil]), nil);
		});
	});
	
	context(@"initialized with a valid scene", ^{
		__block MOScene* scene = nil;
		__block MOGameObject* gameObject = nil;
		
		beforeEach(^{
			scene = mock([MOScene class]);
			gameObject = [[MOGameObject alloc] initWithScene:scene];
		});
		
		it(@"is not nil", ^{
			expect(gameObject).toNot.beNil();
		});
		
		it(@"has the scene property set", ^{
			expect([gameObject scene]).to.beIdenticalTo((__bridge void*)scene);
		});
		
		context(@"added a component with a NULL class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:NULL], nil);
			});
		});
		
		context(@"added a component with a class that does not subclass MOComponent", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[NSString class]], nil);
			});
		});
		
		context(@"added a component with the MOComponent class", ^{
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[MOComponent class]], nil);
			});
		});
		
		context(@"added a component with a class that subclasses MOComponent", ^{
			__block MOComponent* componentMock = nil;
			__block MOComponent* component = nil;
			
			beforeEach(^{
				id componentSubclass = mockClass([MOComponent class]);
				componentMock = mock([MOComponent class]);
				[given([componentSubclass isSubclassOfClass:[MOComponent class]]) willReturnBool:YES];
				[given([componentSubclass alloc]) willReturn:componentMock];
				[given([componentMock initWithGameObject:gameObject]) willReturn:componentMock];
				component = [gameObject addComponentWithClass:componentSubclass];
			});
			
			it(@"initializes a component and returns it", ^{
				[verify(componentMock) initWithGameObject:gameObject];
				[verify(componentMock) awake];
				expect(component).to.beIdenticalTo((__bridge void*)componentMock);
			});
		});
	});
});

SPEC_END
