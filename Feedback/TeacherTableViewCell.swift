//
//  TeacherTableViewCell.swift
//  Feedback
//
//  Created by Zhanserik on 4/30/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Cartography

protocol TeacherTableViewCellDelegate {
    func favouriteButtonDidPress(cell: TeacherTableViewCell, button: UIButton)
}


class TeacherTableViewCell: UITableViewCell {

    var delegate:TeacherTableViewCellDelegate?
    
    let favouriteButton = UIButton().then {
        $0.backgroundColor = .whiteColor()
        $0.setImage(UIImage(named: "star_empty"), forState: .Normal)
        $0.setImage(UIImage(named: "star_full"), forState: .Selected)
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
        contentView.addSubview(favouriteButton)
        favouriteButton.addTarget(self, action: #selector(TeacherTableViewCell.favouriteButtonDidPress(_:)), forControlEvents: .TouchUpInside)
        updateViewConstraints()
    }
    func updateViewConstraints(){
        constrain(favouriteButton){
            $0.height == 30
            $0.width == 30
            $0.centerY == $0.superview!.centerY
            $0.right == $0.superview!.right - 10
        }
        constrain(imageView!) {
            $0.height == 60
            $0.width == 60
            $0.leftMargin == $0.superview!.left + 20
            $0.top == $0.superview!.top + 10
        }
        constrain(textLabel!, imageView!, favouriteButton) {
            $0.height == 20
            $0.top == $0.superview!.top + 10
            $0.left == $1.right + 10
            $0.right == $2.left - 10
        }
        constrain(detailTextLabel!, textLabel!, imageView!, favouriteButton){
            $0.top == $1.bottom + 10
            $0.bottom == $0.superview!.bottom - 10
            $0.left == $2.right + 10
            $0.right == $3.left - 10
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
    func favouriteButtonDidPress(sender: UIButton){
//        sender.selected = !sender.selected
        guard let delegate = delegate else {return}
        delegate.favouriteButtonDidPress(self, button: sender)
    }
}
