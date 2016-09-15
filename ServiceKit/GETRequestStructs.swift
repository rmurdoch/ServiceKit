//
//  GETRequestStructs.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/15/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import UIKit

//Tests by: https://jsonplaceholder.typicode.com



//MARK: Get Request 1 returning Get Objects
public struct GetRequestStruct1 { }

extension GetRequestStruct1: GetRequest {
    public var endPoint: String {
        return "/posts"
    }
    
    public typealias ResponseType = GetResponseStruct1
}


//MARK: Get Response 1
public struct GetResponseStruct1: Response {
    
    public var items: [GetStruct]
    
    //MARK Response Protocols
    public init(_ json: AnyObject) {
        self.items = (json as! Array).flatMap{ GetStruct.init($0) }
    }
    

    public func classNameForArray(_ name: String) -> AnyClass? {
        return nil
    }
}



//MARK: Get Object Returned for KVC
public struct GetStruct: JsonObject {
    
    var userId: NSNumber!
    var id: NSNumber!
    var title: NSString!
    var body: NSString!
    
    public init(_ json: AnyObject) {

        if let userId = json["userId"] {
            self.userId = userId as! NSNumber!
        }
        
        if let id = json["id"] {
            self.id = id as! NSNumber!
        }
        
        if let title = json["title"] {
            self.title = title as! NSString!
        }
        
        if let body = json["body"] {
            self.body = body as! NSString!
        }
    }
    
    
    public func classNameForArray(_ name: String) -> AnyClass? {
        return nil
    }
}
