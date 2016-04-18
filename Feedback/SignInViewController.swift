//
//  SignInViewController.swift
//  Feedback
//
//  Created by Zhanserik on 4/19/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import Then
import Cartography

class SignInViewController: ViewController {
    
    let titleLabel = UILabel().then {
        $0.font = UIFont(name: "AvenirNext-UltraLight", size: 24)
        $0.textAlignment = .Center
        $0.textColor = UIColor.darkTextColor()
        $0.text = "WELCOME"
    }
    let containerView = UIView().then {
        $0.backgroundColor = UIColor.cloudsColor()
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        $0.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).CGColor
    }
    private let borderView = UIView().then {
        $0.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
    }
    let loginTextField = UITextField().then {
        $0.backgroundColor = UIColor.cloudsColor()
        let attr = [NSForegroundColorAttributeName : UIColor(white: 0.8, alpha: 1.0),
                    NSFontAttributeName: UIFont(name: "AvenirNext-UltraLight", size: 12)!]
        $0.attributedPlaceholder = NSAttributedString(string: "Login", attributes: attr)
        $0.font = UIFont(name: "AvenirNext-Medium", size: 14)!
        $0.textColor = UIColor.lightGrayColor()
    }
    let passTextField = UITextField().then {
        $0.backgroundColor = UIColor.cloudsColor()
        let attr = [NSForegroundColorAttributeName : UIColor(white: 0.8, alpha: 1.0),
            NSFontAttributeName: UIFont(name: "AvenirNext-UltraLight", size: 12)!]
        $0.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attr)
        $0.font = UIFont(name: "AvenirNext-Medium", size: 14)!
        $0.textColor = UIColor.lightGrayColor()
    }
    
    let submitButton = UIButton().then {
        $0.backgroundColor = UIColor.turquoiseColor()
        $0.setTitle("SIGN IN", forState: .Normal)
        $0.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
    }
    func setupViews(){
        view.backgroundColor = UIColor.cloudsColor()
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        containerView.addSubview(borderView)
        containerView.addSubview(loginTextField)
        containerView.addSubview(passTextField)
        view.addSubview(submitButton)
    }
    
    func updateConstraints(){
        
        constrain(containerView) {
            $0.height == 100
            $0.width == 300
            $0.top == $0.superview!.top + 200
            $0.centerX == $0.superview!.centerX
        }
        constrain(loginTextField) {
            $0.height == $0.superview!.height / 2 - 1
            $0.width == $0.superview!.width
            $0.top == $0.superview!.top
            $0.leftMargin == $0.superview!.leftMargin + 10
        }
        constrain(passTextField) {
            $0.height == $0.superview!.height / 2
            $0.width == $0.superview!.width
            $0.bottom == $0.superview!.bottom
            $0.leftMargin == $0.superview!.leftMargin + 10
        }
        constrain(borderView, loginTextField, containerView){
            $0.top == $1.bottom
            $0.width == $2.width
            $0.height == 1 / UIScreen.mainScreen().scale
            $0.left == $2.left
        }
        constrain(titleLabel, containerView){
            $0.width == $0.superview!.width
            $0.height == 30
            $0.bottom == $1.top - 20
        }
        constrain(submitButton, containerView) {
            $0.top == $1.bottom + 10
            $0.width == 300
            $0.height == 50
            $0.left == $1.left
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateConstraints()
    }
}
