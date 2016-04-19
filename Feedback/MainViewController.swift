//
//  MainViewController.swift
//  Feedback
//
//  Created by Zhanserik on 4/19/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [UINavigationController(rootViewController:FeedViewController()),
                           UINavigationController(rootViewController:TeachersViewController()),
                            UINavigationController(rootViewController:ProfileViewController())
                            ]
        setupTabBars()
    }
    func setupTabBars() {
        tabBar.tintColor = UIColor.appGreenColor()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        
        let imageList = ["feed", "list", "person"]
        let titleList = ["Feed", "Teachers", "Profile"]
        let itemList = tabBar.items
        
        for (index, tab) in itemList!.enumerate(){
            let size = CGSize(width: 25, height: 25)
            tab.image = UIImage(named: imageList[index])?.scale(size)
            tab.title = titleList[index]
            
        }

    }

}
