//
//  AppDelegate.swift
//  Feedback
//
//  Created by Zhanserik on 4/16/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId(ParseConstant.Identifier, clientKey: ParseConstant.ClientKey)
        setupNavigationBarAppearance()
        
        if let user = User.currentUser() {
            print("\(#function) - Username[\(user.username)]")
            loadMainPages()
        }
        else{
            loadLoginPages()
        }
        
        return true
    }

    
    func loadLoginPages() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        window?.rootViewController = SignInViewController()
    }
    
    func loadMainPages() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
    }
    
    func setupNavigationBarAppearance() {
        
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = UIColor.appGreenColor()
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [ NSFontAttributeName: UIFont.avenirBold(fontSize: 22), NSForegroundColorAttributeName: UIColor.whiteColor() ]
    }
    
    func setupBarButtonItemAppearance() {
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes([ NSFontAttributeName: UIFont.avenirBold(fontSize: 14)], forState: .Normal)
        appearance.tintColor = UIColor.whiteColor()
    }
    
    func setupSegmentedControlAppearance() {
        let attributes = [NSFontAttributeName: UIFont.avenirBold(fontSize: 12)]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, forState: .Normal)
    }

}

