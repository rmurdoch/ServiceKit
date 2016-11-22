//
//  Service.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

public enum ResponseCompletion {
    case success(Response)
    case error(NSError)
}


//Tests by: https://JSONplaceholder.typicode.com

internal final class Service: NSObject {
    
    let serverURL = "http://digihdapp.devhd.office:8002/"// "http://10.120.240.181:8001"
    
    static let sharedInstance = Service()
    
    func send<T:Request>(_ request:T, completion: @escaping (ResponseCompletion) -> ()) {
        
        URLSession.shared.dataTask(with: request.generateRequest()) { (data, urlResponse, responseError) -> Void in
            
            DispatchQueue.main.async {
                if let error = responseError {
                    completion(.error(error as NSError))
                } else if let data = data {
                    if let JSON = data.JSON {
                        
                        let response = T.ResponseType(JSON)
                        
                        if let isSuccess = response.responseHeader.isSuccess {
                            if isSuccess.boolValue {
                                completion(.success(response))
                            } else {
                                completion(.error(self.responseHeaderError(response.responseHeader)))
                            }
                        } else {
                            completion(.success(response))
                        }
                    } else {
                        completion(.error(self.JSONError))
                    }
                } else {
                    completion(.error(self.unknownError))
                }
            }
        }.resume()
    }
    
    private var unknownError: NSError {
        return NSError(domain: "UNKNOWN ERROR", code: NSURLErrorUnknown, userInfo: nil)
    }
    
    private var JSONError: NSError {
        return NSError(domain: "JSON ERROR", code: NSURLErrorUnknown, userInfo: nil)
    }
    
    private func responseHeaderError(_ header: ResponseHeader) -> NSError {
        return NSError(domain: header.errorDescription!, code: Int(header.errorCode!), userInfo: nil)
    }
}
