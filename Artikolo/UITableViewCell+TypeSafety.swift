//
//  UITableViewCell+TypeSafety.swift
//  Artikolo
//
//  Created by Grant Butler on 5/1/17.
//  Copyright © 2017 Grant Butler. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var ReuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableView {
    
    func register(cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.ReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.ReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue cell at index path \(indexPath) and cast to type \(Cell.self).")
        }
        return cell
    }
    
}
