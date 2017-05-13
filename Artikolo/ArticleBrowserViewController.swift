//
//  ArticleBrowserViewController.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import WebKit

class ArticleBrowserViewController: UIViewController {
    
    private var webView: WKWebView!
    let article: Article
    
    init(article: Article) {
        self.article = article
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
