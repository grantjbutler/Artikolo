//
//  ArticleBrowserCoordinator.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import Dip
import ArtikoloKit

class ArticleBrowserCoordinator: Coordinator {
    
    let article: Article
    
    init(navigationController: UINavigationController, container: DependencyContainer, article: Article) {
        self.article = article
        
        super.init(navigationController: navigationController, container: container)
    }
    
    override func start() {
        let viewController = ArticleBrowserViewController(article: article)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
