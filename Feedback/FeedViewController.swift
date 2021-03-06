//
//  FeedViewController.swift
//  Feedback
//
//  Created by Zhanserik on 4/19/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Then
import Cartography
import SwiftRandom

class FeedViewController: UIViewController {

    let tableView = UITableView().then { _ in
        
    }
    var feedbackList: [Feedback] = []
    
    func setupViews(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsetsZero
        view.addSubview(tableView)
        title = "Feed"
    }
    
    func updateConstraints(){
        
        constrain(tableView){
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height - 44
            $0.top == $0.superview!.top
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateConstraints()
//        
//        Feedback.fetchFeedback(0, limit: 50) { (list, error) in
//            guard let feedbackList = list else {return}
//            self.feedbackList = feedbackList
//            self.tableView.reloadData()
//        }
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Favourite.fetchFavourites { (favourites, error) in
            guard let favourites = favourites else {return}
            var teacherList: [User] = []
            for favourite in favourites {
                let teacher = favourite.user
                teacherList.append(teacher)
            }
            Feedback.fetchFeedbacks(teacherList, closure: { (feedbacks, error) in
                guard let feedbacks = feedbacks else {return}
                self.feedbackList = feedbacks
                self.tableView.reloadData()
            })
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellIdentifer"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? FeedTableViewCell
        if cell == nil {
            cell = FeedTableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        
//        let feedback = feedbackList[indexPath.row]
        
//        cell?.textLabel?.text = Randoms.randomFakeNameAndEnglishHonorific()
//        cell?.imageView?.image = UIImage(named: "user\(indexPath.row % 6 + 1)")
//        cell?.detailTextLabel?.text = Randoms.randomFakeConversation() + " \n" + Randoms.randomFakeConversation()
//        cell?.ratingView.value = Randoms.randomCGFloat(0, 5)
        let feedback = feedbackList[indexPath.row]
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
        return feedbackList.count
//        return feedbackList.count
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