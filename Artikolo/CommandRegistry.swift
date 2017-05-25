//
//  CommandRegistry.swift
//  Artikolo
//
//  Created by Grant Butler on 5/24/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import Foundation

final class CommandRegistry {
    
    enum Command {
    
        case basic(() -> Void)
        case input((String) -> Void)
        
    }
    
    enum Error: Swift.Error {
        
        case missingInput
        
    }
    
    private var registry: [String: Command] = [:]
    
    func register(_ name: String, _ command: Command) {
        registry[name] = command
    }
    
    func handle(arguments: [String]) throws {
        let regularExpression = try! NSRegularExpression(pattern: "^-([A-Za-z]+)(=(.*))?$", options: [])
        try arguments.forEach { (argument) in
            guard let match = regularExpression.firstMatch(in: argument, options: [], range: NSMakeRange(0, argument.utf16.count)) else { return }
            
            let commandRange = match.rangeAt(1)
            let commandName = (argument as NSString).substring(with: commandRange)
            guard let command = registry[commandName] else { return }
            
            switch command {
            case let .basic(action): action()
            case let .input(action):
                let metadataRange = match.rangeAt(3)
                guard metadataRange.location != NSNotFound else {
                    throw CommandRegistry.Error.missingInput
                }
                
                let metadata = (argument as NSString).substring(with: metadataRange)
                action(metadata)
            }
        }
    }
    
}
