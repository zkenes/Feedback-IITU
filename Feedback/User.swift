//
//  User.swift
//  Feedback
//
//  Created by Zhanserik on 4/20/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import Foundation
import Parse

class User: PFUser {
    
    @NSManaged var rating: CGFloat
    @NSManaged var profileImage: PFFile
    @NSManaged var status: String
    @NSManaged var reviews: Int
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
}