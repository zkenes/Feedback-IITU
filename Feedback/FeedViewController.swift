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

class FeedViewController: UIViewController {

    let tableView = UITableView().then { _ in
        
    }
    var feedbackList: [Feedback]
    
    func setupViews(){
        tableView.dataSource = self
        tableView.delegate = self
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
        
        Feedback.fetchFeedback(0, limit: 50) { (list, error) in
            guard let feedbackList = list else {return}
            self.feedbackList = feedbackList
            self.tableView.reloadData()
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cellIdentifer"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier)
        }
        
        let feedback = feedbackList[indexPath.row]
        
        cell?.textLabel?.text = "\(feedback.text)"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}