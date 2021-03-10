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
    
    // MARK:  Methods
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(webView)
        guard let url = URL(string: "https://www.google.com") else {
            return }
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
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
    }
}
