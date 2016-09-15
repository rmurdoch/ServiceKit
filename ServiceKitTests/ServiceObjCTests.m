//
//  ServiceObjCTests.m
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/15/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

#import "ServiceObjCTests.h"
#import "XCTestCase+Async.h"
@import ServiceKit;


@implementation ServiceObjCTests

- (void)testGetRequest1 {
    
    [self executeAsyncBlock:^(DSStopExecution stop) {
        GetRequestObject1 *request = [[GetRequestObject1 alloc] init];
        [request sendRequestWithCompletionHandler:^(NSError * error, GetResponseObject1 * response) {
            XCTAssertNil(error);
            XCTAssertTrue([response isKindOfClass:[GetResponseObject1 class]]);
            stop();
        }];
    }];
}


- (void)testPostRequest1 {
    
    [self executeAsyncBlock:^(DSStopExecution stop) {
        PostRequestObject1 *request = [[PostRequestObject1 alloc] init];
        [request sendRequestWithCompletionHandler:^(NSError * error, PostResponseObject1 * response) {
            XCTAssertNil(error);
            XCTAssertTrue([response isKindOfClass:[PostResponseObject1 class]]);
            stop();
        }];
    }];
}

@end
