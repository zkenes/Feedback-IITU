//
//  InfoView.swift
//  Feedback
//
//  Created by Zhanserik on 4/30/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Cartography

final class InfoView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGrayColor()
        label.font = UIFont.avenirBold(fontSize: 22.5)
        label.textAlignment = .Center
        label.numberOfLines = 0
        return label
    }()
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrayColor()
        label.font = UIFont.avenirBold(fontSize: 12.5)
        label.textAlignment = .Center
        label.numberOfLines = 0
        label.alpha = 0.5
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [titleLabel, subtitleLabel].forEach { self.addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        [titleLabel, subtitleLabel].forEach { self.addSubview($0) }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayouts()
    }
    
    // MARK: - Private
    
    private func setupLayouts() {
        constrain(subtitleLabel){
            $0.height == 20
            $0.bottom == $0.superview!.bottom
            $0.left == $0.superview!.left
            $0.right == $0.superview!.right
        }
        constrain(titleLabel, subtitleLabel){
            $0.bottom == $1.top
            $0.left == $0.superview!.left
            $0.right == $0.superview!.right
            $0.top == $0.superview!.top
        }
    }
}