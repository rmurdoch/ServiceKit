//
//  GuestProfile.swift
//  ServiceKit
//
//  Created by Andrew Murdoch on 11/17/16.
//  Copyright © 2016 Andrew Murdoch. All rights reserved.
//

public class GuestProfile: JSONObject {
    
    var guestProfileId: NSNumber?
    var guestId: NSNumber?
    var name: NSString?
   
    var checkOutDate: NSString?
    var checkOutDateIso: NSString?
    var extensionString: NSString?

    var isStaff: NSNumber?
    var optedIn: NSNumber?
    var doNotDisturb: NSNumber?
    var banned: NSNumber?
    var isBlocked: NSNumber?
    var isLoaded: NSNumber?
    
    
//    @property (nonatomic, strong) NSArray *attributes;
//    @property (nonatomic, strong) NSArray *extensions;
//    @property (nonatomic, strong) GraphicInfo *photo;

}
