//
//  CoreServiceTests.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/11/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import XCTest
@testable import ServiceKit

class CoreServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
    //MARK: Test Get Request Object1
    func testConnectRequest() {
        
        self.executeAsyncBlock { (stop) in
            
            let request = ConnectRequest()
            request.clientVersion = "16.2"
            request.deviceId = UUID().uuidString
            
            request.send(completion: { (completion) in
                
                switch completion {
                case .error(let error):
                    XCTAssertNil(error)
                case .success(let response):
                    let myresponse = response as! ConnectResponse
                    XCTAssertNotNil(myresponse)
                }
                stop!()
            })
        }
    }
}
