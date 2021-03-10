////
////  RegistrationView.swift
////  GamblingTest
////
////  Created by Oksana Fedorchuk on 10.03.2021.
////
//
//import UIKit
//import FBSDKLoginKit
//
//
//class RegistrationView: UIView, LoginButtonDelegate {
//
//
////        if let token = AccessToken.current,
////           !token.isExpired {
////            // User is logged in, do work such as go to next view controller.
////            let token = token.tokenString
////
////            let request = FBSDKLoginKit.GraphRequest(graphPath: "user",
////                                                    parameters: ["fields" : "email, name"],
////                                                    tokenString: token,
////                                                    version: nil,
////                                                    httpMethod: .get)
////            request.start { connection, result, error in
////                print("\(result)")
////            }
////        } else {
//        let loginButton = FBLoginButton()
////            loginButton.center = view.center
//        loginButton.delegate = self
//        loginButton.permissions = ["public_profile", "email"]
//        view.addSubview(loginButton)
//    loginButton.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
////            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
//        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//    ])
//
//    //        }
//    
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        let token = result?.token?.tokenString
//        
//        let request = FBSDKLoginKit.GraphRequest(graphPath: "user",
//                                                parameters: ["fields" : "email, name"],
//                                                tokenString: token,
//                                                version: nil,
//                                                httpMethod: .get)
//        request.start { connection, result, error in
//            print("\(result)")
//        }
//    }
//    
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        
//    }
//
//}
