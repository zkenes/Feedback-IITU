//
//  AppDelegate.swift
//  Feedback
//
//  Created by Zhanserik on 4/16/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        loadLoginPages()
        return true
    }

    
    func loadLoginPages() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        window?.rootViewController = SignInViewController()
    }
    
    func loadMainPages() {
    }
}

