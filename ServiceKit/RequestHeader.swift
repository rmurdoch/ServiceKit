//
//  RequestHeader.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/17/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//


public class RequestHeader: NSObject, JSONRepresentable {
    
    convenience init(_ dictionary : [String : AnyObject]) {
        
         let dictionary = ["clientVersion" : "16.2", "deviceId" : "7EBA751D-4DF9-4A47-929A-2BB0CDBA0B8F", "deviceTypeCode" : "IPHONE", "languageCode" : "ENG", "propertyCode" : "Breakaway", "previewMode" : 0] as [String : Any]
        
        self.init()

        if let clientVersion = dictionary["clientVersion"] {
            self.clientVersion = clientVersion as? String
        }

        if let deviceId = dictionary["deviceId"] {
            self.deviceId = deviceId as? String
        }
        
        if let deviceTypeCode = dictionary["deviceTypeCode"] {
            self.deviceTypeCode = deviceTypeCode as? String
        }
        
        if let languageCode = dictionary["languageCode"] {
            self.languageCode = languageCode as? String
        }
        
        if let propertyCode = dictionary["propertyCode"] {
            self.propertyCode = propertyCode as? String
        }
        
        if let previewMode = dictionary["previewMode"] {
            self.previewMode = previewMode as? NSNumber
        }
    }
    
    public var clientVersion: String!
    public var deviceId: String!
    public var deviceTypeCode: String!
    public var languageCode: String!
    public var propertyCode: String!
    public var previewMode: NSNumber?
}
