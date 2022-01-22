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
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
            
    func routeTo(question: Question<String>, answerCallBack: @escaping (String) -> Void) {
        show(factory.questionViewController(for: question, answerCallBack: answerCallBack))
    }
    
    func routeTo(result: ResultOfQuiz<Question<String>, String>) {
        show(factory.resultViewController(for: result))
    }
    
    func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
