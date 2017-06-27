//
//  ArticleBrowserViewController.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import WebKit
import ArtikoloKit

private var titleContext = 0

extension WKWebView {
    
    @objc
    dynamic class func keyPathsForValuesAffectingDisplayTitle() -> NSSet {
        return NSSet(array: [
            #keyPath(WKWebView.title),
            #keyPath(WKWebView.url)
        ])
    }
    
    dynamic var displayTitle: String {
        if let title = title, !title.isEmpty {
            return title
        }
        else if let url = url {
            return url.absoluteString
        }
        else {
            return NSLocalizedString("Loading...", comment: "Displayed when a website is loading.")
        }
    }
    
}

class ArticleBrowserViewController: UIViewController {
    
    private var webView: WKWebView!
    let article: Article
    
    init(article: Article) {
        self.article = article
        
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.displayTitle))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.displayTitle), options: [.initial], context: &titleContext)
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: webView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let urlRequest = URLRequest(url: article.url)
        webView.load(urlRequest)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &titleContext {
            title = webView.displayTitle
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}
