//
//  Favourite.swift
//  Feedback
//
//  Created by Zhanserik on 5/4/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import Foundation
import Parse

class Favourite: PFObject {
    @NSManaged var user: User
    @NSManaged var subscriber: User
}
extension Favourite: PFSubclassing{
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    static func parseClassName() -> String {
        return ParseClass.Favourite
    }
    
}
extension Favourite{
    static func fetchFavourites(closure: ([Favourite]?, NSError?) -> Void){
        let query = PFQuery(className: ParseClass.Favourite)
        query.whereKey("subscriber", equalTo: User.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (favourites, error) in
            closure(favourites as? [Favourite], error)
        }
    }
    static func checkTeacher(teacher: User, closure: Bool -> Void){
        let query = PFQuery(className: ParseClass.Favourite)
        query.whereKey("user", equalTo: teacher)
        query.whereKey("subscriber", equalTo: User.currentUser()!)
        query.countObjectsInBackgroundWithBlock { (count, error) in
            closure(count>0)
        }
    }
    static func removeFromFavourites(forUser user: User, closure: Bool -> Void){
        let query = PFQuery(className: ParseClass.Favourite)
        query.whereKey("user", equalTo: user)
        query.whereKey("subscriber", equalTo: User.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (favourites, error) in
            guard let favourites = favourites else {
                closure(false)
                return
            }
            PFObject.deleteAllInBackground(favourites, block: { (finished, error) in
                closure(finished)
            })
        }
    }
}