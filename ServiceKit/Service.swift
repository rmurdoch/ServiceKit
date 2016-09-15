//
//  Service.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import UIKit

public enum ResponseCompletion {
    case Success(Response)
    case Error(NSError)
}


//Tests by: https://jsonplaceholder.typicode.com

internal final class Service: NSObject {
    
    internal let serverURL = "http://jsonplaceholder.typicode.com"
    
    internal static let sharedInstance = Service()
    
    internal func send<T:Request>(_ request:T, completion: @escaping (ResponseCompletion) -> ()) {
        
        URLSession.shared.dataTask(with: request.generateRequest()) { (data, response, responseError) -> Void in
            
            DispatchQueue.main.async {
                if let error = responseError {
                    completion(.Error(error as NSError))
                } else if let data = data {
                    if let json = data.json {
                        let response = T.ResponseType(json)
                        completion(.Success(response))
                    } else {
                        completion(.Error(self.jsonError))
                    }
                } else {
                    completion(.Error(self.unknownError))
                }
            }
        }.resume()
    }
    
    private var unknownError: NSError {
        return NSError(domain: "UNKNOWN ERROR", code: NSURLErrorUnknown, userInfo: nil)
    }
    
    private var jsonError: NSError {
        return NSError(domain: "JSON ERROR", code: NSURLErrorUnknown, userInfo: nil)
    }
}
