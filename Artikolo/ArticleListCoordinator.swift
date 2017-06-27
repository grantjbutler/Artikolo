//
//  ArticleListCoordinator.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ArtikoloKit

class ArticleListCoordinator: Coordinator {
    
    let disposeBag = DisposeBag()
    
    override func start() {
        let dataManager: DataManager = try! container.resolve()
        
        let viewController = ArticleTableViewController(articles: dataManager.articles)
        viewController.title = "Articles"
        viewController.tableView.rx.modelSelected(Article.self)
            .subscribe(onNext: self.show(article:))
            .addDisposableTo(disposeBag)
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ArticleListCoordinator.askForURL))
        addBarButtonItem.accessibilityIdentifier = "AddArticleButton"
        viewController.navigationItem.rightBarButtonItem = addBarButtonItem
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    @objc
    func askForURL() {
        let alertController = UIAlertController(title: "Add URL", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "https://"
            textField.keyboardType = .URL
            textField.accessibilityIdentifier = "URLInputTextField"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alertController] (action) in
            guard let textField = alertController?.textFields?.first else { return }
            guard let urlString = textField.text else { return }
            guard let url = URL(string: urlString) else { return }
            
            let article = Article(url: url, addedOn: Date(), createdOn: Date(), tags: [])
            
            let dataManager: DataManager = try! self.container.resolve()
            dataManager.save(article: article)
        }))
        
        navigationController.present(alertController, animated: true, completion: nil)
    }
    
    func show(article: Article) {
        let articleBrowserCoordinator = ArticleBrowserCoordinator(navigationController: navigationController, container: container, article: article)
        addChild(articleBrowserCoordinator)
    }
    
}
