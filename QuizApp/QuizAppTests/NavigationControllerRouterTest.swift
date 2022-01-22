//
//  NavigationControllerRouter.swift
//  QuizAppTests
//
//  Created by klioop on 2022/01/19.
//

import UIKit
import XCTest

@testable import QuizEngine
@testable import QuizApp


class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(navigationController: self.navigationController, factory: self.factory )
    }()
    
        
    func test_routeToQuestionTwice_showsQuestionViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
                
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: secondViewController)
        
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallBack: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallBack: { _ in })
        
        // navigationController.viewControllers is only updated after the animation finishes - asynchronous behavior
        // animation will take 0.3 seconds
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_presentsQuestionViewControllerWithRightCallBack() {
        var callBackWasFired = false
        
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallBack: { _ in callBackWasFired = true })
        factory.answerCallBack[Question.singleAnswer("Q1")]!("Anything")
        
        XCTAssertTrue(callBackWasFired)
    }
    
    func test_routeToResult_presentsResultViewController() {
        let result = ResultOfQuiz<Question<String>, String>(answers: [Question.singleAnswer("Q1"): "A1"], score: 10)
        let secondResult = ResultOfQuiz<Question<String>, String>(answers: [Question.singleAnswer("Q2"): "A2"], score: 20)
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        
        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)
        
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    // Fake to deal with navigationController's animation asyncronocity
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResult = [ResultOfQuiz<Question<String>, String>: UIViewController]()
        var answerCallBack = [Question<String>: (String) -> Void]()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(result: ResultOfQuiz<Question<String>, String>, with viewController: UIViewController) {
            stubbedResult[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallBack: @escaping (String) -> Void) -> UIViewController {
            self.answerCallBack[question] = answerCallBack
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(for result: ResultOfQuiz<Question<String>, String>) -> UIViewController {
            return stubbedResult[result] ?? UIViewController()
        }
    }
}

extension ResultOfQuiz: Hashable {
    
    public static func ==(lhs: ResultOfQuiz<Question, Answer>, rhs: ResultOfQuiz<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(score)
    }
}
