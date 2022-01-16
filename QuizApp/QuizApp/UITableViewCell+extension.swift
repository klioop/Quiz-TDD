//
//  UITableViewCell+extension.swift
//  QuizApp
//
//  Created by klioop on 2022/01/16.
//

import UIKit


extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

