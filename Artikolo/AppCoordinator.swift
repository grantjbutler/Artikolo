//
//  AppCoordinator.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import Dip

class AppCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    let container = DependencyContainer()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        container.register(.singleton) { DataManager(backend: CoreDataDataManagerBackend(containerName: "Artikolo")) }
    }
    
}