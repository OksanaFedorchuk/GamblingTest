//
//  LoginVStackView.swift
//  GamblingTest
//
//  Created by Oksana Fedorchuk on 12.03.2021.
//

import UIKit
import FBSDKLoginKit

class LoginVStackView: UIView {
    
    // MARK:  Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK:  Subviews
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        label.numberOfLines = 0
        return label
    }()
    
    let loggedInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
        return label
    }()
    
    let loginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.heightAnchor.constraint(equalToConstant: 40)
        button.permissions = ["public_profile", "email"]
        return button
    }()
    
    var labelVstack = UIStackView()
    
    // MARK:  Setup subviews
    
    func setupViews() {
        labelVstack = makeLabelVStack()
        addSubview(labelVstack)
        makeAutoLayout()
    }
    func makeLabelVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.backgroundColor = .none
        stack.spacing = 20
        
        //make vstack
        [registerLabel, loggedInLabel, loginButton].forEach { stack.addArrangedSubview($0) }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    // MARK:  Setup Autolayout
    
    func makeAutoLayout() {
        labelVstack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //pin vstack to parent view
            labelVstack.topAnchor.constraint(equalTo: topAnchor),
            labelVstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelVstack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
