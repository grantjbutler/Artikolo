//
//  ArticleTableViewController.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    let urls: [URL]
    
    init(urls: [URL]) {
        self.urls = urls
        
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - <UITableViewDataSource>

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let url = urls[indexPath.row]
        cell.textLabel?.text = url.description

        return cell
    }

}
