//
//  ArticleTableViewController.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ArticleTableViewController: UITableViewController {
    
    private let articles: Observable<[Article]>
    private let disposeBag = DisposeBag()
    
    init(articles: Observable<[Article]>) {
        self.articles = articles
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(cellClass: UITableViewCell.self)
        
        articles.bind(to: tableView.rx.items(cellIdentifier: UITableViewCell.ReuseIdentifier)) { index, article, cell in
            cell.textLabel?.text = article.url.description
        }
        .addDisposableTo(disposeBag)
    }

}
