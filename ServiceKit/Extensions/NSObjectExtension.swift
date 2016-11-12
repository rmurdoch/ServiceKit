//
//  NSObjectExtension.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/13/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation


//MARK: Request Parsing
internal extension NSObject {
    
    //MARK: NSObject to Dictionary
    internal var JSONDictionary: NSDictionary {
        
        let properties = NSMutableDictionary()
        
        for propertyKey in self.propertyNames {
            if let propertyValue = self.value(forKeyPath: propertyKey) {
                if propertyValue is NSArray {
                    properties.setObject(self.JSONArrayFrom(propertyValue as! NSArray), forKey: propertyKey.upperCamel as NSCopying)
                }
                else if propertyValue is JSONRepresentable {
                    properties.setObject((propertyValue as! NSObject).JSONDictionary, forKey: propertyKey.upperCamel as NSCopying)
                }
                else {
                    properties.setObject(propertyValue, forKey: propertyKey.upperCamel as NSCopying)
                }
            } else {
//                assert(false, "Error: No Value for Object")
            }
        }
        
        return properties
    }
    
    private var propertyNames: [String] {
        let mirror = Mirror(reflecting: self)
        var original = mirror.children.flatMap{ $0.label }
        
        if let parent = mirror.superclassMirror {
            original.append(contentsOf: parent.children.flatMap{ $0.label })
        }
        
        return original
    }
    
    private func JSONArrayFrom(_ array: NSArray) -> NSArray {
        let JSONArray = NSMutableArray()
        
        for object in array {
            if object is JSONRepresentable {
                JSONArray.add((object as! NSObject).JSONDictionary)
            } else {
                JSONArray.add(object)
            }
        }
        
        return JSONArray
    }
    
    internal func contains(_ key: String) -> Bool {
        return propertyNames.contains(key)
    }
}


//MARK: Response Parsing
internal extension NSObject {
    
    internal func parse(_ JSON: AnyObject) {
        
        if let dictionary = JSON as? [String : AnyObject]  {
            
            for key in dictionary.keys {
                
                if self.contains(key.lowerCamel) {
                    if let value = dictionary[key] {
                        
                        if value is NSNull {
                            self.setValue(nil, forKeyPath: key.lowerCamel)
                        } else if let obj = value as? NSArray {
                            self.setValue(self.propertiesFromJSON(obj, key.lowerCamel), forKeyPath: key.lowerCamel)
                        } else if let obj = value as? NSDictionary {
                            self.setValue(self.get(obj, key.lowerCamel), forKeyPath: key.lowerCamel)
                        } else {
                            self.setValue(value, forKeyPath: key.lowerCamel)
                        }
                    } else {
                        self.setValue(nil, forKeyPath: key.lowerCamel)
                    }
                } else {
                    assert(false, "Error: Key is not in object \(key)")
                }
            }
        }
    }
    
    internal func propertiesFromJSON(_ array: NSArray, _ key : String) -> NSArray {
        
        let values = NSMutableArray()
        
        for item in array {
            
            guard let className = self.className(key) else {
                continue
            }
            
            if let classType = NSClassFromString("ServiceKit.\(className)") {

                if classType is JSONInitializable.Type {
                    if let object = self.getObjectFrom(item as! NSDictionary, "\(classType)") {
                        values.add(object)
                    }
                }
            } else if let classType = NSClassFromString(className) {
                
                if classType is NSNumber.Type || classType is NSString.Type || classType is String.Type {
                    values.add(item)
                }
            }
            else {
                assert(false, "Error: No Array Class is Defined")
            }
        }
        
        return values
    }
    
    
    private func get(_ dictionary: NSDictionary, _ key : String) -> NSObject? {
        
        if let className = self.className(key) {
            if let dictionaryFromKey = self.getObjectFrom(dictionary, className) {
                return dictionaryFromKey
            }
        }
        
        return dictionary
    }
    
    private func getObjectFrom(_ dictionary: NSDictionary,_ className: String) -> NSObject? {
        
        if let classObject = NSClassFromString("ServiceKit.\(className)") {
            if let classType = classObject as? JSONInitializable.Type {
                let JSONObject = classType.init(dictionary)
                return JSONObject as? NSObject
            }
        }
        
        assert(false, "Error: No Array Class is Defined")
        return nil
    }
    
    
    private func className(_ key : String) -> String? {
        
        let mirror = Mirror(reflecting: self)
        var child = mirror.children.filter{ $0.label == key }.first
        
        if child == nil {
            if let parent = mirror.superclassMirror {
                child = parent.children.filter{ $0.label == key }.first
            }
        }
        
        if let child = child {
            let childMirror = Mirror.init(reflecting: child.value)
            let subjectName = "\(childMirror.subjectType)"
            
            let components = subjectName.components(separatedBy: "<")
            
            if components.count > 1 {
                let name = components.last
                return name?.components(separatedBy: ">").first
            } else {
                return subjectName
            }
        } else {
            return nil
        }
    }
}
