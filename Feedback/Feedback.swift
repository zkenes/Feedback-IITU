//
//  Feedback.swift
//  Feedback
//
//  Created by Zhanserik on 4/20/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import Foundation
import Parse

class Feedback: PFObject {
    @NSManaged var student: User
    @NSManaged var teacher: User
    @NSManaged var rating: Int
    @NSManaged var text: String
}

extension Feedback: PFSubclassing{
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return ParseClass.Feedback
    }
    
}
extension Feedback {
    
    static func fetchFeedback(offset: Int, limit: Int, closure:([Feedback]?, NSError?) -> Void){
        let query = PFQuery(className: ParseClass.Feedback)
        query.skip = offset
        query.limit = limit
        query.includeKey("teacher")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            closure(objects as? [Feedback], error)
        }
    }
    
}
