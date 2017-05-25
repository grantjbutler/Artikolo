//
//  AppCoordinator.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import Dip

private enum Command {
    
    case basic(() -> Void)
    case input((String) -> Void)
    
}

class AppCoordinator: Coordinator {
    
    override func start() {
        container.register(.singleton) { DataManager(backend: CoreDataDataManagerBackend(containerName: "Artikolo")) }
        
#if DEBUG
        setupForRunning()
#endif
        
        let articleListCoordinator = ArticleListCoordinator(navigationController: navigationController, container: container)
        addChild(articleListCoordinator)
    }

}

#if DEBUG

extension AppCoordinator {

    func setupForRunning() {
        let registry = CommandRegistry()
        registry.register("ResetDatabase",  .basic(resetDatabase))
        registry.register("AddArticle",     .input(addArticle))
        try! registry.handle(arguments: CommandLine.arguments)
    }
    
    private func resetDatabase() {
        let dataManager = try! container.resolve() as DataManager
        try! dataManager.reset()
    }
    
    private func addArticle(articleJSON: String) {
        let JSON = try! JSONSerialization.jsonObject(with: articleJSON.data(using: .utf8)!, options: []) as! [String: Any]
        let article = try! Article.parse(JSON: JSON)
        
        let dataManager = try! container.resolve() as DataManager
        dataManager.save(article: article)
    }
    
}

#endif
