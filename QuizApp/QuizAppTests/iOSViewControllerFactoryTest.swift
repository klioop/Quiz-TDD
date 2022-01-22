//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Lee Sam on 2022/01/22.
//

import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    func test_factory_createQuestionViewController() {
        let sut = iOSViewControllerFactory()
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallBack: { _ in }) as? QuestionViewController
        XCTAssertNotNil(controller)
    }
    
}
