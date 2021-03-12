//
//  RegistrationViewController.swift
//  GamblingTest
//
//  Created by Oksana Fedorchuk on 10.03.2021.
//

import UIKit
import FBSDKLoginKit


class RegistrationViewController: UIViewController {
    
    let loginVstack = LoginVStackView()
    
    override func viewDidLoad() {
        loginVstack.loginButton.delegate = self
        view.addSubview(loginVstack)
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
        //    stack constraints
        loginVstack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginVstack.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            loginVstack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginVstack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginVstack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 200)
        ])
        checkRegistration()
    }
    
    //check if user is registered via facebook
    func checkRegistration() {
        if let token = AccessToken.current,
           !token.isExpired {
            // User logged in
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields" : "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start { connection, result, error in
                if let result = result as? [String:String],
                   let name: String = result["name"] {
                    self.loginVstack.registerLabel.text = "You Are Logged In!"
                    self.loginVstack.loggedInLabel.text = "Name: \(name)"
                }
            }
        } else {
            //User logged out
            loginVstack.registerLabel.text = "Register to get 5,000 bonuses!"
        }
    }
}

// MARK:  Facebook LoginButtonDelegate

extension RegistrationViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        checkRegistration()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        loginVstack.registerLabel.text = "Register to get 5,000 bonuses!"
        loginVstack.loggedInLabel.text = ""
    }
}
