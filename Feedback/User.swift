//
//  User.swift
//  Feedback
//
//  Created by Zhanserik on 4/20/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import Foundation
import Parse

enum UserStatus: String{
    case Student = "student"
    case Teacher = "teacher"
}

class User: PFUser {
    
    @NSManaged var rating: CGFloat
    @NSManaged var profileImage: PFFile
    @NSManaged var status: String
    @NSManaged var reviews: Int
    @NSManaged var feedbacks: Int
    @NSManaged var name: String
    @NSManaged var surname: String
    @NSManaged var bio: String
    
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
}
extension User{
    static func fetchTeachers(closure: ([User]?, NSError?) -> Void) {
        let query = PFQuery(className: ParseClass.User)
        query.whereKey("status", equalTo: "teacher")
        query.findObjectsInBackgroundWithBlock { (teachers, error) in
            closure(teachers as? [User], error)
        }
    }
    
}