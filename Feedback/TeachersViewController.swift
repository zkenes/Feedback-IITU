//
//  TeachersViewController.swift
//  Feedback
//
//  Created by Zhanserik on 4/19/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Then
import Cartography
import SwiftRandom

class TeachersViewController: UIViewController {
    
    let tableView = UITableView().then { _ in
        
    }
    let headerView = UIView().then {
        $0.backgroundColor = .whiteColor()
    }
    let segmentedControl = UISegmentedControl().then {
        $0.tintColor = UIColor.appGreenColor()
        $0.insertSegmentWithTitle("A-Z", atIndex: 0, animated: false)
        $0.insertSegmentWithTitle("Rating", atIndex: 1, animated: false)
        $0.selectedSegmentIndex = 0
    }
    
    func setupViews(){
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        headerView.addSubview(segmentedControl)
        tableView.tableHeaderView = headerView
        title = "Teachers"
    }
    
    func updateConstraints(){
        
        constrain(tableView){
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height - 44
            $0.top == $0.superview!.top
        }
        constrain(segmentedControl){
            $0.width == 140
            $0.height == 29
            $0.center == $0.superview!.center
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateConstraints()
    }

}
extension TeachersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellIdentifer"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? TeacherTableViewCell
        if cell == nil {
            cell = TeacherTableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
   
        cell?.textLabel?.text = Randoms.randomFakeNameAndEnglishHonorific()
        cell?.imageView?.image = UIImage(named: "user\(indexPath.row % 6 + 1)")
        cell?.detailTextLabel?.text = "Cryptography/Introduction to Computer Science"

        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}