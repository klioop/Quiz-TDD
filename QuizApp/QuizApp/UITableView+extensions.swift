//
//  UITableView+extensions.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit

extension UITableView {
    func register(type: UITableViewCell.Type) {
        let className = type.reuseIdentifier
        register(type, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T? {
        let className = type.reuseIdentifier
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
