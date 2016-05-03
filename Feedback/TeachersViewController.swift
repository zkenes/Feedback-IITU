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
    var teacherList:[User] = []
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
        segmentedControl.addTarget(self, action: #selector(TeachersViewController.segmentedControlDidChange(_:)), forControlEvents: .ValueChanged)
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
        User.fetchTeachers { (teachers, error) in
            guard let teachers = teachers else {return}
            self.teacherList = teachers.sort(){$0.name < $1.name}
            self.tableView.reloadData()
        }
    }
    func segmentedControlDidChange(segmentedControl: UISegmentedControl){
        let index = segmentedControl.selectedSegmentIndex
        switch index {
        case 0:
            teacherList.sortInPlace(){$0.name < $1.name}
            break
        case 1:
            teacherList.sortInPlace(){$0.rating < $1.rating}
            break
        default: break
        }
    }
}
extension TeachersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellIdentifer"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? TeacherTableViewCell
        if cell == nil {
            cell = TeacherTableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        let teacher = teacherList[indexPath.row]
        cell?.textLabel?.text = teacher.name + " " + teacher.surname
        cell?.imageView?.image = UIImage(named: "user\(indexPath.row % 6 + 1)")
        teacher.profileImage.getDataInBackgroundWithBlock { (imageData, error) in
            if let imageData = imageData {
                cell?.imageView?.image = UIImage(data: imageData)
            }
        }
        Favourite.checkTeacher(teacher) { (flag) in
            cell?.favouriteButton.selected = flag
        }
        cell?.delegate = self
        cell?.detailTextLabel?.text = teacher.bio
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
extension TeachersViewController: TeacherTableViewCellDelegate {
    func favouriteButtonDidPress(cell: TeacherTableViewCell, button: UIButton) {
        let indexPath = tableView.indexPathForCell(cell)
        if button.selected {
            Favourite.removeFromFavourites(forUser: teacherList[indexPath!.row], closure: { finished in
                button.selected = !finished
            })
        }
        else{
            let favourite = Favourite()
            favourite.subscriber = User.currentUser()!
            favourite.user = teacherList[indexPath!.row]
            favourite.saveInBackgroundWithBlock({ (finished, error) in
                button.selected = finished
            })
        }
    }
}