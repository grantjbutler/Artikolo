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
        
        setupForRunning()
        
        let articleListCoordinator = ArticleListCoordinator(navigationController: navigationController, container: container)
        addChild(articleListCoordinator)
    }
    
    private var commands: [String: Command]{
        return [
            "ResetDatabase": Command.basic(self.resetDatabase),
        ]
    }
    
    func setupForRunning() {
        let regularExpression = try! NSRegularExpression(pattern: "-([A-Za-z]+)(=(.*))?", options: [])
        CommandLine.arguments.forEach { (argument) in
            guard let match = regularExpression.firstMatch(in: argument, options: [], range: NSMakeRange(0, argument.utf16.count)) else { return }
            
            let commandRange = match.rangeAt(0)
            let commandName = (argument as NSString).substring(with: commandRange)
            guard let command = commands[commandName] else { return }
            
            let hasInput = match.numberOfRanges > 1
            
            switch (command, hasInput) {
            case (let .basic(action), _): action()
            case (let .input(action), true):
                let metadataRange = match.rangeAt(2)
                let metadata = (argument as NSString).substring(with: metadataRange)
                action(metadata)
            
            case (.input, false): fatalError("Command wants input, but no input provided.")
            }
        }
    }
    
    private func resetDatabase() {
        let dataManager = try! container.resolve() as DataManager
        try! dataManager.reset()
    }
    
}
