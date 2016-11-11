//
//  Response.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

//public protocol Response: JSONInitializable { }

public class Response: NSObject, JSONInitializable {
    
    var responseHeader: ResponseHeader!
    
    public required init(_ JSON: AnyObject) {
        super.init()
        self.parse(JSON)
    }
}
