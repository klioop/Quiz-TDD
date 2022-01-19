//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by klioop on 2022/01/19.
//

import UIKit
import QuizEngine


class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
            
    func routeTo(question: String, answerCallBack: @escaping (String) -> Void) {
        self.navigationController.pushViewController(UIViewController(), animated: false)
    }
    
    func routeTo(result: Result<String, String>) {
        
    }
}
