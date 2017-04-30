//
//  Coordinator.swift
//  Artikolo
//
//  Created by Grant Butler on 4/30/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation

class Coordinator {
    
    private(set) var children: [Coordinator] = []
    
    func start() {
    
    }
    
    func addChild(_ child: Coordinator) {
        child.start()
        children.append(child)
    }

}
