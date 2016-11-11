//
//  Request.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

// Request Protocols
// =====================================
public enum RequestMethod: String {
    case POST, GET, PUT, DELETE, PATCH
}

public protocol Request: JSONRepresentable {
    
    //End point of URL request
    var endPoint: String { get }
    
    //Service Method Type
    var method: RequestMethod { get }
    
    //Request Headers
    var headers: [String: String] { get }
    
    //Request Timeouts
    var timeout: TimeInterval { get }
    
    //Creating URLREquest
    func generateRequest() -> URLRequest
    
    
    //Response Type from Request
    associatedtype ResponseType: Response
}



// Request Type Extensions Protocols
// =====================================

public protocol GetRequest: Request  { }
public protocol PostRequest: Request, JSONRepresentable { }
public protocol DeleteRequest: Request { }
public protocol PutRequest: Request, JSONRepresentable { }
public protocol PatchRequest: Request, JSONRepresentable { }

extension GetRequest {
    public var method: RequestMethod { return .GET }
}

extension PostRequest {
    public var method: RequestMethod { return .POST }
}

extension DeleteRequest {
    public var method: RequestMethod { return .DELETE }
}

extension PutRequest {
    public var method: RequestMethod { return .PUT }
}

extension PatchRequest {
    public var method: RequestMethod { return .PATCH }
}


// Request Extension Builders
// =====================================
extension Request {
    //other than generate request this extension would be writting your application layer not in the service layer
    public func generateRequest() -> URLRequest {
        
        var connectRequest = URLRequest(url: self.urlForService, cachePolicy: .useProtocolCachePolicy, timeoutInterval: self.timeout)
        connectRequest.httpMethod = method.rawValue
        
        if (self.asJSON as! NSDictionary).allValues.count > 0 {
            connectRequest.httpBody = self.data
        }
        
        if (self.headers as NSDictionary).allValues.count > 0 {
            connectRequest.allHTTPHeaderFields = self.headers
        }
        
        return connectRequest
    }
    
    //MARK: Headers for allHTTPHeaderFields: Below is blank for override
    public var headers: [String: String] {
        
        return ["Content-Type":"application/json",
                "Accept":"text/html",
                "Cache-Control":"no-cache",
                "Pragma":"no-cache",
                "Connection":"close"]
    }
    
    internal var urlForService: URL {
        let urlString = "\(Service.sharedInstance.serverURL)" + "\(self.endPoint)"
        return URL(string: urlString)!
    }
    
    public var timeout: TimeInterval {
        return 10
    }
    
    internal var data: Data {
        let dictionary = NSDictionary(dictionary: self.asJSON as! NSDictionary)
        return dictionary.JSONData!
    }
    
    public func send(completion: @escaping (_ completion: ResponseCompletion) -> ()) {
        Service.sharedInstance.send(self, completion: completion)
    }
}



//Want to generate request based on if Request is JSONRepresentable. For example POST or PUT
// This gives an implementation to request when its a JSONRepresentable
extension JSONRepresentable where Self: Request {
    func generateRequest() -> URLRequest {
        
        var connectRequest = URLRequest(url: self.urlForService, cachePolicy: .useProtocolCachePolicy, timeoutInterval: self.timeout)
        connectRequest.httpMethod = method.rawValue
        return connectRequest
    }
}
