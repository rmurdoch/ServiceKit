//
//  XCTestCase+Async.h
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface XCTestCase (Async)

typedef void(^DSStopExecution)();

- (void)executeAsyncBlock:(void (^)(DSStopExecution stop))block;

@end
