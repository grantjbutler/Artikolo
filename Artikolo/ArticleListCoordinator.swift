//
//  ArticleListCoordinator.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation

class ArticleListCoordinator: Coordinator {
    
    override func start() {
        let viewController = ArticleTableViewController(dataManager: try! container.resolve())
        navigationController.pushViewController(viewController, animated: false)
    }
    
}
