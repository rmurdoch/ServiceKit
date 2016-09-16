//
//  NSObjectExtension.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/13/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

internal extension NSObject {
    
    //MARK: NSObject to Dictionary
    internal var jsonDictionary: NSDictionary {
        
        let properties = NSMutableDictionary()
        
        for propertyKey in self.propertyNames {
            if let propertyValue = self.value(forKeyPath: propertyKey) {
                if propertyValue is NSArray {
                    properties.setObject(self.jsonArrayFrom(propertyValue as! NSArray), forKey: propertyKey as NSCopying)
                }
                else if propertyValue is JsonRepresentable {
                    properties.setObject((propertyValue as! NSObject).jsonDictionary, forKey: propertyKey as NSCopying)
                }
                else {
                    properties.setObject(propertyValue, forKey: propertyKey as NSCopying)
                }
            } else {
                assert(false, "Error: No Value for Object")
            }
        }
        
        return properties
    }
    
    private var propertyNames: [String] {
        return Mirror(reflecting: self).children.flatMap{ $0.label }
    }
    
    private func jsonArrayFrom(_ array: NSArray) -> NSArray {
        let jsonArray = NSMutableArray()
        
        for object in array {
            if object is JsonRepresentable {
                jsonArray.add((object as! NSObject).jsonDictionary)
            } else {
                jsonArray.add(object)
            }
        }
        
        return jsonArray
    }
    
    internal func contains(_ key: String) -> Bool {
        return propertyNames.contains(key)
    }
}


internal extension NSObject {
    
    internal func parse(_ json: AnyObject) {
        
        if let dictionary = json as? [String : AnyObject]  {
            
            for key in dictionary.keys {
                
                if self.contains(key.lowerCamel) {
                    if let value = dictionary[key] {
                        
                        if value is NSNull {
                            self.setValue(nil, forKeyPath: key.lowerCamel)
                        } else if let obj = value as? NSArray {
                            self.setValue(self.propertiesFromJson(obj, key.lowerCamel), forKeyPath: key.lowerCamel)
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
    
    internal func propertiesFromJson(_ array: NSArray, _ key : String) -> NSArray {
        
        let values = NSMutableArray()
        
        for item in array {
            
            if let classType = (self as? JsonInitializable)?.classNameForArray(key) {

                if classType is JsonInitializable.Type {
                    if let object = self.getObjectFrom(item as! NSDictionary, "\(classType)") {
                        values.add(object)
                    }
                } else if classType is NSNumber.Type || classType is NSString.Type || classType is String.Type {
                    values.add(item)
                }
            } else {
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
            if let classType = classObject as? JsonInitializable.Type {
                let jsonObject = classType.init(dictionary)
                return jsonObject as? NSObject
            }
        }
        
        assert(false, "Error: No Array Class is Defined")
        return nil
    }
    
    
    private func className(_ key : String) -> String? {
        
        let mirror = Mirror(reflecting: self)
        let child = mirror.children.filter{ $0.label == key }.first
        if let child = child {
            let childMirror = Mirror.init(reflecting: child.value)
            let subjectName = "\(childMirror.subjectType)"
            
            let components = subjectName.components(separatedBy: "<")
            
            if components.count > 1 {
                let name = components[1]
                return name.components(separatedBy: ">").first
            } else {
                return subjectName
            }
        } else {
            return nil
        }
    }
}
