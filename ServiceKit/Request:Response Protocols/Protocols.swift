//
//  Protocols.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 9/7/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

import UIKit

// Read/Write Protocols
// =====================================
public protocol JsonInitializable {
    init(_ json: AnyObject)
    func classNameForArray(_ name: String) -> AnyClass?
}

public protocol JsonRepresentable: Wrapping { }


public protocol JsonObject: JsonInitializable, JsonRepresentable { }

