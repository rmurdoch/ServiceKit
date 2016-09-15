//
//  GETRequests.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/15/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import UIKit

//MARK: Get Request 1 returning Get Objects
public class GetRequestObject1: NSObject {
}

extension GetRequestObject1: GetRequest {
    public var endPoint: String {
        return "/posts"
    }
    
    public typealias ResponseType = GetResponseObject1
}

//MARK: Obj-C Service Calls
// Use the method below to be used for Obj-C classes
public extension GetRequestObject1 {
    public func sendRequest(completionHandler: @escaping (_ error: NSError?,_ resposne: GetResponseObject1?) -> ()) {
        self.send { (completion) in
            switch completion {
            case.Error(let error):
                completionHandler(error, nil)
            case .Success(let response):
                completionHandler(nil, response as? GetResponseObject1)
            }
        }
    }
}




//MARK: Get Response 1
public class GetResponseObject1: NSObject, Response {
    //MARK Response Protocols
    required public init(_ json: AnyObject) {
        super.init()
        self.parse(json)
    }
    
    public func classNameForArray(_ name: String) -> AnyClass? {
        return GetObject.classForCoder()
    }
}



//MARK: Get Object Returned for KVC
public class GetObject: NSObject, JsonObject {
    
    var userId: NSNumber!
    var id: NSNumber!
    var title: NSString!
    var body: NSString!
    
    required public init(_ json: AnyObject) {
        super.init()
        self.parse(json)
    }
    
    public func classNameForArray(_ name: String) -> AnyClass? {
        return nil
    }
}
