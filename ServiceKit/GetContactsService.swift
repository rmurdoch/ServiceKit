//
//  GetContactsService.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/17/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

public class GetContactRequest: NSObject, PostRequest {
    
    public var deviceId: String!
    public var clientVersion: String!
    public var propertyCode: String?
    
    public var endPoint: String {
        return "/ConnectService/json/GetContact"
    }
    
    public typealias ResponseType = GetContactResponse
}


public class GetContactResponse: Response {
    
    var contacts: [GuestProfile]?
}
