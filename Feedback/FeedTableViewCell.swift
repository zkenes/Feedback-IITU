//
//  FeedTableViewCell.swift
//  Feedback
//
//  Created by Zhanserik on 4/20/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Cartography
import HCSStarRatingView


class FeedTableViewCell: UITableViewCell {
    
    
    
    let ratingView: HCSStarRatingView = HCSStarRatingView().then {
        $0.maximumValue = 5
        $0.minimumValue = 0
        $0.tintColor = UIColor.carrotColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    func setupViews(){
        imageView?.contentMode = .ScaleAspectFit
        imageView?.layer.cornerRadius = 30
        imageView?.clipsToBounds = true
        detailTextLabel?.numberOfLines = 0
        contentView.addSubview(ratingView)
        updateViewConstraints()
    }
    func updateViewConstraints(){
        constrain(ratingView){
            $0.height == 20
            $0.width == 80
            $0.top == $0.superview!.top + 10
            $0.right == $0.superview!.right - 10
        }
        constrain(imageView!) {
            $0.height == 60
            $0.width == 60
            $0.leftMargin == $0.superview!.left + 20
            $0.top == $0.superview!.top + 10
        }
        constrain(textLabel!, imageView!, ratingView) {
            $0.height == 20
            $0.top == $0.superview!.top + 10
            $0.left == $1.right + 10
            $0.right == $2.left
        }
        constrain(detailTextLabel!, textLabel!, imageView!){
            $0.top == $1.bottom + 10
            $0.bottom == $0.superview!.bottom - 10
            $0.left == $2.right + 10
            $0.right == $0.superview!.right - 10
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
}
