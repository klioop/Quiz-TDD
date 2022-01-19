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
    
    func test_routeToQuestion_presentsQuestionViewController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController: navigationController )
        
        sut.routeTo(question: "Q1", answerCallBack: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func test_routeToQuestionTwice_presentsQuestionViewController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController: navigationController )
        
        sut.routeTo(question: "Q1", answerCallBack: { _ in })
        sut.routeTo(question: "Q2", answerCallBack: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
}
