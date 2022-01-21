//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by klioop on 2022/01/19.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallBack: @escaping (String) -> Void) -> UIViewController
    func resultViewController(for result: ResultOfQuiz<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
            
    func routeTo(question: Question<String>, answerCallBack: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallBack: answerCallBack)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(result: ResultOfQuiz<Question<String>, String>) {
        let viewController = factory.resultViewController(for: result)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
