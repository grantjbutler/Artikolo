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
import RxCocoa

protocol ArticleTableViewControllerDelegate: class {
    
    func userDidTap(article: Article, in: ArticleTableViewController)
    
}

class ArticleTableViewController: UITableViewController {
    
    private let articles: Observable<[Article]>
    private let disposeBag = DisposeBag()
    private weak var delegate: ArticleTableViewControllerDelegate?
    
//    private var itemSelectionObservable: Observable<Article>!
    
    init(articles: Observable<[Article]>, delegate: ArticleTableViewControllerDelegate) {
        self.articles = articles
        self.delegate = delegate
        
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
        
        Observable.combineLatest(articles, tableView.rx.itemSelected, resultSelector: { (allArticles, indexPath) -> Article in
            return allArticles[indexPath.row]
        })
        .subscribe(onNext: { [weak self] (article) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.userDidTap(article: article, in: strongSelf)
        })
        .addDisposableTo(disposeBag)
    }

}
