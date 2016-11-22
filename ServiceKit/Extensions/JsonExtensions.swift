//
//  Extensions.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

internal extension NSDictionary {
    internal var JSONData: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            assert(false, "Error JSONSerialization.data: \(error)")
        }
        return nil
    }
}


internal extension Data {
    internal var JSON: AnyObject? {
        
        do {
            if let JSONResult = try JSONSerialization.jsonObject(with: self, options: []) as? [String:AnyObject] {
                return JSONResult as AnyObject
            }
        }  catch {
//            assert(false, "Error JSONSerialization.JSONObject: \(error)")
        }
        
        
        do {
            if let JSONResult = try JSONSerialization.jsonObject(with: self, options: []) as? [[String:AnyObject]] {
                return JSONResult as AnyObject
            }
        }  catch {
//            assert(false, "Error JSONSerialization.JSONObject: \(error)")
        }
        
        return nil
    }
}
