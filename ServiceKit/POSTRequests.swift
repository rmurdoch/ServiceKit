//
//  POSTRequests.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/15/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import UIKit

//MARK: Post Request 1 returning Post Objects
public class PostRequestObject1: NSObject { }

extension PostRequestObject1: PostRequest {
    public var endPoint: String {
        return "/posts"
    }
    
    public typealias ResponseType = PostResponseObject1
}


//MARK: Obj-C Service Calls
// Use the method below to be used for Obj-C classes
public extension PostRequestObject1 {
    public func sendRequest(completionHandler: @escaping (_ error: NSError?,_ resposne: PostResponseObject1?) -> ()) {
        self.send { (completion) in
            switch completion {
            case.Error(let error):
                completionHandler(error, nil)
            case .Success(let response):
                completionHandler(nil, response as? PostResponseObject1)
            }
        }
    }
}



//MARK: Post Response 1
public class PostResponseObject1: NSObject, Response {
    
    var id: NSNumber!

    
    //MARK Response Protocols
    required public init(_ json: AnyObject) {
        super.init()
        self.parse(json)
    }
    
    public func classNameForArray(_ name: String) -> AnyClass? {
        return nil
    }
}
