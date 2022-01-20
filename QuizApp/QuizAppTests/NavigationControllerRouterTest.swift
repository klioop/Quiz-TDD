//
//  NavigationControllerRouter.swift
//  QuizAppTests
//
//  Created by klioop on 2022/01/19.
//

import UIKit
import XCTest

@testable import QuizApp


class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = UINavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(navigationController: self.navigationController, factory: self.factory )
    }()
    
        
    func test_routeToQuestionTwice_showsQuestionViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
                
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        
        sut.routeTo(question: "Q1", answerCallBack: { _ in })
        sut.routeTo(question: "Q2", answerCallBack: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_presentsQuestionViewControllerWithRightCallBack() {
        var callBackWasFired = false
        
        sut.routeTo(question: "Q1", answerCallBack: { _ in callBackWasFired = true })
        factory.answerCallBack["Q1"]!("Anything")
        
        XCTAssertTrue(callBackWasFired)
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [String: UIViewController]()
        var answerCallBack = [String: (String) -> Void]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallBack: @escaping (String) -> Void) -> UIViewController {
            self.answerCallBack[question] = answerCallBack
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        
    }
}
