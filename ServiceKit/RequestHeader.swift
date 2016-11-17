//
//  RequestHeader.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/17/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//


class RequestHeader: JSONRepresentable {
    
    var deviceId: String?
    var deviceType: String?
    var shipCode: String?
    var languageCode: String?
    var clientVersion: String?
    var isPreviewMode: NSNumber?
}
