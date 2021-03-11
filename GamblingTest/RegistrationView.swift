//
//  RegistrationView.swift
//  GamblingTest
//
//  Created by Oksana Fedorchuk on 10.03.2021.
//

import UIKit
import FBSDKLoginKit


class RegistrationView: UIViewController, LoginButtonDelegate {
    
    let registerLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Register to get 5,000 bonuses!"
        label.textColor = .yellow
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        label.numberOfLines = 0
        return label
    }()
    
    let loggedInLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Registeres as: "
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
    
    override func viewDidLoad() {
        loginButton.delegate = self
        labelVstack = makeLabelVStack()
        view.addSubview(labelVstack)
        labelVstack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelVstack.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelVstack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            //            labelVstack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            labelVstack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        checkRegistration()
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
    
    func checkRegistration() {
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields" : "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start { connection, result, error in
                if let result = result as? [String:String],
                   let name: String = result["name"] {
                    self.registerLabel.text = "You Are Logged In!"
                    self.loggedInLabel.text = "Name: \(name)"
                }
            }
        } else {
            //User logged out
            registerLabel.text = "Register to get 5,000 bonuses!"
        }
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        checkRegistration()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        registerLabel.text = "Register to get 5,000 bonuses!"
        loggedInLabel.text = ""
    }
    
}
