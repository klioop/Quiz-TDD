//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by klioop on 2022/01/19.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallBack: @escaping (String) -> Void) -> UIViewController
}


class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
            
    func routeTo(question: String, answerCallBack: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallBack: answerCallBack)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func routeTo(result: Result<String, String>) {
        
    }
}
