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
    
    private let urls: Observable<[URL]>
    private let disposeBag = DisposeBag()
    
    init(urls: Observable<[URL]>) {
        self.urls = urls
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(cellClass: UITableViewCell.self)
        
        urls.bind(to: tableView.rx.items(cellIdentifier: UITableViewCell.ReuseIdentifier)) { index, model, cell in
            cell.textLabel?.text = model.description
        }
        .addDisposableTo(disposeBag)
    }

}
