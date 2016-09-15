//
//  XCTestCase+Async.m
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

#import "XCTestCase+Async.h"

@implementation XCTestCase (Async)

- (void)executeAsyncBlock:(void (^)(DSStopExecution stop))block
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    block(^{
        dispatch_semaphore_signal(semaphore);
    });
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:60]];
}

@end
