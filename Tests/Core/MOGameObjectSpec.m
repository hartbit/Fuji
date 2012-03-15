//
//  FUGameObjectSpec.m
//  Fuji
//
//  Created by Hart David on 24.02.12.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//

#include "Prefix.pch"
#import "FujiCore.h"
#import "FUGameObject-Internal.h"
#import "FUComponent-Internal.h"


SPEC_BEGIN(FUGameObjectSpec)

describe(@"A game object", ^{
	context(@"initialized with init", ^{
#ifdef DEBUG
		it(@"throws an exception", ^{
			STAssertThrows([FUGameObject new], nil);
		});
#else
		it(@"returns nil", ^{
			expect([FUGameObject new]).to.beNil();
		});
#endif
	});
	
	context(@"initialized with a nil scene", ^{
#ifdef DEBUG
		it(@"throws an exception", ^{
			STAssertThrows(((void)[[FUGameObject alloc] initWithScene:nil]), nil);
		});
#else
		it(@"returns nil", ^{
			expect([[FUGameObject alloc] initWithScene:nil]).to.beNil();
		});
#endif
	});
	
	context(@"initialized with a valid scene", ^{
		__block FUScene* scene = nil;
		__block FUGameObject* gameObject = nil;
		
		beforeEach(^{
			scene = mock([FUScene class]);
			gameObject = [[FUGameObject alloc] initWithScene:scene];
		});
		
		it(@"is not nil", ^{
			expect(gameObject).toNot.beNil();
		});
		
		it(@"has the scene property set", ^{
			expect([gameObject scene]).to.beIdenticalTo((__bridge void*)scene);
		});
		
		context(@"adding a component with a NULL class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:NULL], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject addComponentWithClass:NULL]).to.beNil();
			});
#endif
		});
		
		context(@"adding a component with a class that does not subclass FUComponent", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[NSString class]], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject addComponentWithClass:[NSString class]]).to.beNil();
			});
#endif
		});
		
		context(@"adding a component with the FUComponent class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject addComponentWithClass:[FUComponent class]], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject addComponentWithClass:[FUComponent class]]).to.beNil();
			});
#endif
		});
		
		context(@"getting a component with a NULL class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject componentWithClass:NULL], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject componentWithClass:NULL]).to.beNil();
			});
#endif
		});
		
		context(@"adding a component with the FUComponent class", ^{
#ifdef DEBUG
			it(@"throws an exception", ^{
				STAssertThrows([gameObject componentWithClass:[FUComponent class]], nil);
			});
#else
			it(@"returns nil", ^{
				expect([gameObject componentWithClass:[FUComponent class]]).to.beNil();
			});
#endif
		});
		
		context(@"added a component with a class that subclasses FUComponent", ^{
			__block FUComponent* componentMock = nil;
			__block FUComponent* component = nil;
			
			beforeEach(^{
				id componentSubclass = mockClass([FUComponent class]);
				componentMock = mock([FUComponent class]);
				[given([componentSubclass isSubclassOfClass:[FUComponent class]]) willReturnBool:YES];
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
