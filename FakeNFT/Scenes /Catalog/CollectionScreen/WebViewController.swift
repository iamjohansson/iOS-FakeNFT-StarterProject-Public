//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 31.01.24.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    private var webView = WKWebView()
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc private func didTapBackButton() {
        webView.stopLoading()
        navigationController?.popViewController(animated: true)
    }
}

