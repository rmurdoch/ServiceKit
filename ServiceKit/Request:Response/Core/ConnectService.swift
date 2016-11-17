//
//  ConnectService.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/11/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

public class ConnectRequest: NSObject, PostRequest {
    
    public var deviceId: String!
    public var clientVersion: String!
    public var propertyCode: String?
    
    public var endPoint: String {
        return "/ConnectService/json/Connect"
    }
    
    public typealias ResponseType = ConnectResponse
    
    public var requiresRequestHeader: Bool {
        return false
    }
}


//MARK: Obj-C Service Calls
// Use the method below to be used for Obj-C classes
public extension ConnectRequest {
    public func sendRequest(completionHandler: @escaping (_ error: NSError?,_ resposne: ConnectResponse?) -> ()) {
        self.send { (completion) in
            switch completion {
            case.error(let error):
                completionHandler(error, nil)
            case .success(let response):
                completionHandler(nil, response as? ConnectResponse)
            }
        }
    }
}



//MARK: Response
public class ConnectResponse: Response {
    
    var guestId: String?
    var defaultLanguageCode: String?
    var serverVersion: String?
    var chatServerPort: NSNumber?
    var propertyName: String?
    var contentAddress: String?
    var guestDiningText: String?
    var guestIsClassicDining: NSNumber?
    var roomNumber: String?
    var chatServerAddress: String?
    var isRegistered: NSNumber?
    var serviceAddress: String?
    var guestName: String?
    var languagesSupported: [NSString]?
    var guestExtension: String?
}
