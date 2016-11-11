//
//  ResponseHeader.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/11/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//


public class ResponseHeader: NSObject {
    
    var isSuccess:          NSNumber?
    var errorDescription:   String?
    var innerError:         String?
    var propertyCode:       String?
    var errorCode:          NSNumber?
}
