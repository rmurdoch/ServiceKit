//
//  Wrapping.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import UIKit

extension JsonRepresentable {
    
    var asJson: AnyObject {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String : AnyObject]()
        
        //MARK: For NSObject classes using KVC
        if mirror.superclassMirror?.subjectType == NSObject.self {
            if (self as! NSObject).responds(to: #selector(getter: NSObject.jsonDictionary)) {
                return (self as! NSObject).jsonDictionary
            } else {
                assert(false, "Error: Not JsonRepresentable Object")
            }
        } else {
            //MARK: For Structs Wrapping in custom KVC
            for (labelMaybe, valueMaybe) in mirror.children {
                
                guard let label = labelMaybe else {
                    continue
                }
                
                if let value = valueMaybe as? Wrapping {
                    if let wrapValue = value.wrap() {
                        dictionary[label] = wrapValue
                    } else {
                        assert(false, "Error: No Wrapping Value Returned")
                    }
                } else {
                    assert(false, "Error: Not a wrapping object")
                }
            }
            return dictionary as AnyObject
        }
    }
}


//MARK: Wrapping Protocol
public protocol Wrapping {
    func wrap() -> AnyObject?
}


//MARK: Wrapping Extension for Arrays
extension Wrapping {
    func wrapArray(from wrapArray: [AnyObject]) -> AnyObject {
        
        var array = [AnyObject]()
        for item in wrapArray {
            if item is JsonRepresentable {
                let wrapItem = (item as! JsonRepresentable).wrap()
                array.append(wrapItem as AnyObject)
            } else {
                array.append(item as AnyObject)
            }
        }
        
        return array as AnyObject
    }
}


//MARK: Extensions for objetcs that need to be wrapped
extension String: Wrapping {
    public func wrap() -> AnyObject? {
        return self as AnyObject
    }
}

extension NSString: Wrapping {
    public func wrap() -> AnyObject? {
        return self as AnyObject
    }
}

extension NSNumber: Wrapping {
    public func wrap() -> AnyObject? {
        return self as AnyObject
    }
}

extension Int: Wrapping {
    public func wrap() -> AnyObject? {
        return self as AnyObject
    }
}

extension Float: Wrapping {
    public func wrap() -> AnyObject? {
        return self as AnyObject
    }
}

extension Bool: Wrapping {
    public func wrap() -> AnyObject? {
        return self as AnyObject
    }
}

extension Array: Wrapping {
    public func wrap() -> AnyObject? {
        if self.count > 0 {
            return self.wrapArray(from: self as [AnyObject])
        } else {
            return nil
        }
    }
}

extension NSArray: Wrapping {
    public func wrap() -> AnyObject? {
        
        if self.count > 0 {
            return self.wrapArray(from: self as [AnyObject])
        } else {
            return nil
        }
    }
}

extension JsonRepresentable where Self: Wrapping {
    public func wrap() -> AnyObject? {
        return self.asJson
    }
}
