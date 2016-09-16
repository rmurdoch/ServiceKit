//
//  Extensions.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

internal extension NSDictionary {
    internal var jsonData: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            assert(false, "Error JSONSerialization.data: \(error)")
        }
        return nil
    }
}


internal extension Data {
    internal var json: AnyObject? {
        
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: self, options: []) as? [String:AnyObject] {
                return jsonResult as AnyObject
            }
        }  catch {
            assert(false, "Error JSONSerialization.jsonObject: \(error)")
        }
        
        
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: self, options: []) as? [[String:AnyObject]] {
                return jsonResult as AnyObject
            }
        }  catch {
            assert(false, "Error JSONSerialization.jsonObject: \(error)")
        }
        
        return nil
    }
}
