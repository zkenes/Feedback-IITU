//
//  ProfileViewController.swift
//  Feedback
//
//  Created by Zhanserik on 4/19/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Then
import Cartography
import SwiftRandom

class ProfileViewController: UIViewController {

    var user: User?
    var feedbackList: [Feedback]?
    
    let tableView = UITableView().then { _ in
        
    }
    let headerView = UIView().then {
        $0.backgroundColor = .whiteColor()
    }
    let profileImageView = UIImageView().then {
        $0.contentMode = .ScaleAspectFill
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 40
        $0.image = UIImage(named:"user3")
    }
    let titleLabel = UILabel().then {
        $0.font = UIFont.avenirBold(fontSize: 18)
        $0.textColor = UIColor.darkGrayColor()
        $0.text = Randoms.randomFakeName()
    }
    let infoView = UIView().then {
        $0.backgroundColor = .whiteColor()
    }
    let feedbackInfoView = InfoView().then {
        $0.titleLabel.text = "23"
        $0.subtitleLabel.text = "Feedbacks"
    }
    let favouritesInfoView = InfoView().then {
        $0.titleLabel.text = "10"
        $0.subtitleLabel.text = "Favourites"
    }
    let anyInfoView = InfoView().then {
        $0.titleLabel.text = "10"
        $0.subtitleLabel.text = "Info"
    }
    let editButton = UIButton().then{
        $0.setTitle("Edit Profile", forState: .Normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1/UIScreen.mainScreen().scale
        $0.layer.borderColor = UIColor.appGreenColor().CGColor
        $0.setTitleColor(.appGreenColor(), forState: .Normal)
    }
    func setupViews(){
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
        tableView.tableHeaderView = headerView
        headerView.addSubview(profileImageView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(infoView)
        infoView.addSubview(feedbackInfoView)
        infoView.addSubview(favouritesInfoView)
        infoView.addSubview(anyInfoView)
        headerView.addSubview(editButton)
        title = "Profile"
    }
    
    func updateConstraints(){
        
        constrain(tableView){
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height - 44
            $0.top == $0.superview!.top
        }
        constrain(profileImageView){
            $0.width == 80
            $0.height == 80
            $0.top == $0.superview!.top + 10
            $0.left == $0.superview!.left + 10
        }
        constrain(titleLabel, profileImageView){
            $0.top == $1.bottom + 5
            $0.left == $0.superview!.left + 10
        }
        constrain(infoView, profileImageView){
            $0.left == $1.right + 30
            $0.top == $0.superview!.top + 10
            $0.right == $0.superview!.right - 10
            $0.height == 40
        }
        constrain(feedbackInfoView){
            $0.top == $0.superview!.top
            $0.bottom == $0.superview!.bottom
            $0.width == $0.superview!.width * 0.33
            $0.left == $0.superview!.left
        }
        constrain(favouritesInfoView){
            $0.top == $0.superview!.top
            $0.bottom == $0.superview!.bottom
            $0.width == $0.superview!.width * 0.33
            $0.right == $0.superview!.right
        }
        constrain(anyInfoView){
            $0.top == $0.superview!.top
            $0.bottom == $0.superview!.bottom
            $0.width == $0.superview!.width * 0.33
            $0.center == $0.superview!.center
        }
        constrain(editButton, infoView){
            $0.top == $1.bottom
            $0.height == 29
            $0.width == $1.width
            $0.centerX == $1.centerX
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateConstraints()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = user {
            print(user.username)
            editButton.hidden = true
        }
        else{
            user = User.currentUser()
        }
        guard let user = user else {return}
        user.fetchInBackgroundWithBlock { (fetchedUser, error) in
            guard let user = fetchedUser as? User else {return}
            user.profileImage.getDataInBackgroundWithBlock { (imageData, error) in
                if let imageData = imageData {
                    self.profileImageView.image = UIImage(data: imageData)
                }
            }
            self.titleLabel.text = user.name + " " + user.surname
            print(user.name + "- " + user.surname)
            if user.status == UserStatus.Student.rawValue{
                Feedback.fetchFeedback(forStudent: user, closure: { (feedbacks, error) in
                    guard let feedbacks = feedbacks else {return}
                    self.feedbackList = feedbacks
                    self.tableView.reloadData()
                })
            }
            else{
                Feedback.fetchFeedback(forTeacher: user, closure: { (feedbacks, error) in
                    guard let feedbacks = feedbacks else {return}
                    self.feedbackList = feedbacks
                    self.tableView.reloadData()
                })
            }
        }
    }
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellIdentifer"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? FeedTableViewCell
        if cell == nil {
            cell = FeedTableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        let feedback = feedbackList![indexPath.row]
        cell?.textLabel?.text = feedback.teacher.name + " " + feedback.teacher.surname//Randoms.randomFakeNameAndEnglishHonorific()
        cell?.imageView?.image = UIImage(named: "user\(indexPath.row % 6 + 1)")
        feedback.teacher.profileImage.getDataInBackgroundWithBlock { (imageData, error) in
            if let imageData = imageData {
                cell?.imageView?.image = UIImage(data: imageData)
            }
        }
        cell?.detailTextLabel?.text = feedback.text//Randoms.randomFakeConversation() + " \n" + Randoms.randomFakeConversation()
        cell?.ratingView.value = CGFloat(feedback.rating)//Randoms.randomCGFloat(0, 5)
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let feedbackList = feedbackList else {return 0}
        return feedbackList.count
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
