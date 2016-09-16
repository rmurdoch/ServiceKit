//
//  ServiceKitTests.swift
//  ServiceKitTests
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import XCTest
@testable import ServiceKit

class ServiceKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
//MARK: Test Get Request Object1
    func testGetRequestObject1() {
        
        self.executeAsyncBlock { (stop) in
            
            GetRequestObject1().send(completion: { (completion) in
                
                switch completion {
                case .error(let error):
                    XCTAssertNil(error)
                case .success(let response):
                    let myresponse = response as! GetResponseObject1
                    XCTAssertNotNil(myresponse)
                }
                stop!()
            })
        }
    }
    
    
//MARK: Test Get Request Struct1
    func testGetRequestStructt1() {
        
        self.executeAsyncBlock { (stop) in
            
            GetRequestStruct1().send(completion: { (completion) in
                
                switch completion {
                case .error(let error):
                    XCTAssertNil(error)
                case .success(let response):
                    let myresponse = response as! GetResponseStruct1
                    XCTAssertNotNil(myresponse.items.count)
                }
                stop!()
            })
        }
    }
    
    
    
    
//MARK: Test Post Request Struct1
    func testPostRequestStructt1() {
        
        self.executeAsyncBlock { (stop) in
            
            PostRequestObject1().send(completion: { (completion) in
                
                switch completion {
                case .error(let error):
                    XCTAssertNil(error)
                case .success(let response):
                    let myresponse = response as! PostResponseObject1
                    XCTAssertNotNil(myresponse)
                }
                stop!()
            })
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
