//
//  StringExtension.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/9/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

internal extension String {
    var upperCamel: String {
        guard case let c = self.characters,
            let c1 = c.first else { return self }
        return String(c1).uppercased() + String(c.dropFirst())
    }
    
    var lowerCamel: String {
        guard case let c = self.characters,
            let c1 = c.first else { return self }
        return String(c1).lowercased() + String(c.dropFirst())
    }
}

internal extension NSString {
    var lowerCamel: NSString {
        return self.replacingCharacters(in: NSMakeRange(0, 1), with: self.substring(to: 1).lowercased()) as NSString
    }
    
    var upperCamel: NSString {
        return self.replacingCharacters(in: NSMakeRange(0, 1), with: self.substring(to: 1).uppercased()) as NSString
    }
}
