//
//  GuestProfile.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/17/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

public class GuestProfile: JSONObject {
    
    public var guestProfileId: NSNumber?
    public var guestId: NSNumber?
    public var name: NSString?
   
    public var checkOutDate: NSString?
    public var checkOutDateIso: NSString?
    public var extensionString: NSString?

    public var isStaff: NSNumber?
    public var optedIn: NSNumber?
    public var doNotDisturb: NSNumber?
    public var banned: NSNumber?
    public var isBlocked: NSNumber?
    public var isLoaded: NSNumber?
    
    
//    @property (nonatomic, strong) NSArray *attributes;
//    @property (nonatomic, strong) NSArray *extensions;
//    @property (nonatomic, strong) GraphicInfo *photo;

}
