//
//  JSONError.swift
//  Artikolo
//
//  Created by Grant Butler on 5/13/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

enum JSONError: Error {
    
    case invalidValue(keypath: String)
    case incorrectType(keyPath: String)
    
}
