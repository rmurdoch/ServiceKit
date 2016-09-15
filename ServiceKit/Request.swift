//
//  Request.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import UIKit

// Request Protocols
// =====================================
public enum RequestMethod: String {
    case POST, GET, PUT, DELETE
}

public protocol Request: JsonReadable {
    
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
public protocol PostRequest: Request, JsonReadable { }
public protocol DeleteRequest: Request { }
public protocol PutRequest: Request, JsonReadable { }

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




// Request Extension Builders
// =====================================
extension Request {
    //other than generate request this extension would be writting your application layer not in the service layer
    public func generateRequest() -> URLRequest {
        
        var connectRequest = URLRequest(url: self.urlForService, cachePolicy: .useProtocolCachePolicy, timeoutInterval: self.timeout)
        connectRequest.httpMethod = method.rawValue
        
        
        if (self.asJson as! NSDictionary).allValues.count > 0 {
            connectRequest.httpBody = self.data
        }
        
        connectRequest.allHTTPHeaderFields = self.headers
        
        return connectRequest
    }
    
    //MARK: Headers for allHTTPHeaderFields: Below is blank for override
    public var headers: [String: String] { return [:] }
    
    
    internal var urlForService: URL {
        let urlString = "\(Service.sharedInstance.serverURL)" + "\(self.endPoint)"
        return URL(string: urlString)!
    }
    
    public var timeout: TimeInterval {
        return 10
    }
    
    
    internal var data: Data {
        let dictionary = NSDictionary(dictionary: self.asJson as! NSDictionary)
        return dictionary.jsonData!
    }
    
    public func send(completion: @escaping (_ completion: ResponseCompletion) -> ()) {
        Service.sharedInstance.send(self, completion: completion)
    }
}



//Want to generate request based on if Request is JsonReadable. For example POST or PUT
//// this gives an implementation to request when its a JsonReadable
extension JsonReadable where Self: Request {
    func generateRequest() -> URLRequest {
        
        var connectRequest = URLRequest(url: self.urlForService, cachePolicy: .useProtocolCachePolicy, timeoutInterval: self.timeout)
        connectRequest.httpMethod = method.rawValue
        return connectRequest
    }
}
