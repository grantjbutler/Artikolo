//
//  Coordinator.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit
import Dip

class Coordinator {
    
    private(set) var children: [Coordinator] = []
    let navigationController: UINavigationController
    let container: DependencyContainer
    
    init(navigationController: UINavigationController, container: DependencyContainer = DependencyContainer()) {
        self.navigationController = navigationController
        self.container = container
        
        self.navigationController.navigationBar.accessibilityIdentifier = "NavigationBar"
    }
    
    func start() {
    
    }
    
    func addChild(_ child: Coordinator) {
        child.start()
        children.append(child)
    }

}
