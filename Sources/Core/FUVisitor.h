//
//  FUVisitor.h
//  Fuji
//
//  Created by David Hart.
//  Copyright (c) 2012 hart[dev]. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>


/** `FUVisitor` is the scene visitor of the [visitor design pattern](http://en.wikipedia.org/wiki/Visitor_pattern). It can be visited by any instance of `<FUSceneObject>` and it's subclasses. It does not define any visit methods because those are called dynamically. The naming convention for those methods is `visit<className>:`. So for example, the visit method of a `<FUComponent>` is `visitFUComponent:`.
 *
 * When visiting a scene, the visitor will climb the inheritance hierarchy until it finds a method to call. For example, with an instance of `<FUTransform>`, which is a subclass of `<FUComponent>`, itself a subclass of `<FUSceneObject>`, the visitor will first check for a method called `-visitFUTransform:`. If it exists, it will call it. In the contrary, it will look for `-visitFUComponent:`, and only then `visitFUSceneObject:`. If none of these methods are defined, nothing is done. */
@interface FUVisitor : NSObject

@end
