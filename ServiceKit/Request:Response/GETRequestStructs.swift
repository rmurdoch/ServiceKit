//
//  GETRequestStructs.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/15/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

//Tests by: https://JSONplaceholder.typicode.com



//MARK: Get Request 1 returning Get Objects
//public struct GetRequestStruct1 { }
//
//extension GetRequestStruct1: GetRequest {
//    public var endPoint: String {
//        return "/posts"
//    }
//    
//    public typealias ResponseType = GetResponseStruct1
//}


//MARK: Get Response 1
//public struct GetResponseStruct1: Response {
//    
//    public var items: [GetStruct]
//    
//    //MARK Response Protocols
//    public init(_ JSON: AnyObject) {
//        self.items = (JSON as! Array).flatMap{ GetStruct.init($0) }
//    }
//}



//MARK: Get Object Returned for KVC
//public struct GetStruct: JSONObject {
//    
//    var userId: NSNumber!
//    var id: NSNumber!
//    var title: NSString!
//    var body: NSString!
//    
//    public init(_ JSON: AnyObject) {
//
//        if let userId = JSON["userId"] {
//            self.userId = userId as! NSNumber!
//        }
//        
//        if let id = JSON["id"] {
//            self.id = id as! NSNumber!
//        }
//        
//        if let title = JSON["title"] {
//            self.title = title as! NSString!
//        }
//        
//        if let body = JSON["body"] {
//            self.body = body as! NSString!
//        }
//    }
//}
