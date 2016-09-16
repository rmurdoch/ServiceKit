//
//  Protocols.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import Foundation

// Read/Write Protocols
// =====================================
public protocol JSONInitializable {
    init(_ JSON: AnyObject)
    func classNameForArray(_ name: String) -> AnyClass?
}

public protocol JSONRepresentable: Wrapping { }


public protocol JSONObject: JSONInitializable, JSONRepresentable { }

