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
    
    private func configureButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward.2"),
            style: .plain, target: self,
            action: #selector(didTapBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(didTapRefresh))
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc private func didTapBack() {
        webView.goBack()
    }
    @objc private func didTapRefresh() {
        loadWebView()
    }
    
}

// MARK:  WKNavigationDelegate

extension WebViewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let host = navigationResponse.response.url?.host {
            if host.contains("google.com") {
                decisionHandler(.allow)
                return
            }
        }
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
