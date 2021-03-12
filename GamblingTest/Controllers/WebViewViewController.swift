//
//  WebViewViewController.swift
//  GamblingTest
//
//  Created by Oksana Fedorchuk on 10.03.2021.
//

import WebKit
import UIKit

class WebViewViewController: UIViewController {
    
    // MARK:  Properties
    
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    private var url = URL(string: "https://www.google.com")
    
    // MARK:  Methods
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(webView)
        loadWebView()
        configureButtons()
        webView.navigationDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    private func loadWebView() {
        guard let url = url else {
            return }
        webView.load(URLRequest(url: url))
    }
    
    // MARK:  Bar buttons
    
    private func configureButtons() {
        //left button to go back
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward.2"),
            style: .plain, target: self,
            action: #selector(didTapBack))
        
        //right buttons to login and refresh
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(didTapRefresh))
        
        let loginButton = UIBarButtonItem(
            image: UIImage(systemName: "person.fill"),
            style: .plain, target: self,
            action: #selector(didTapLogin))
        navigationItem.rightBarButtonItems = [loginButton, refreshButton]
        
        //make buttons white
        loginButton.tintColor = .white
        refreshButton.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    // MARK:  Web View Navigation
    
    @objc private func didTapBack() {
        webView.goBack()
    }
    @objc private func didTapRefresh() {
        loadWebView()
    }
    @objc private func didTapLogin() {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
}

// MARK:  WKNavigationDelegate

extension WebViewViewController: WKNavigationDelegate {
    
    //check if incoming url is valid
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let host = navigationResponse.response.url?.host {
            if host.contains("google.com") {
                decisionHandler(.allow)
                return
            }
        }
        //cancel request loading and show empty page
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        view.layoutIfNeeded()
    }
}
