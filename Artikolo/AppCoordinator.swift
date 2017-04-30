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
    
    override func start() {
        container.register(.singleton) { DataManager(backend: CoreDataDataManagerBackend(containerName: "Artikolo")) }
    }
    
}
