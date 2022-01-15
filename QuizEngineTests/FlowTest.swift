//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Lee Sam on 2022/01/15.
//

import Foundation
import XCTest


@testable import QuizEngine


class Flowtest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: [])
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestions_routeToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routeToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routeToCorrectQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routeToCorrectQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routeToSecondQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        router.answerCallBack("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    // MARK: - helpers
    
    @discardableResult
    func makeSUT(questions: [String]) -> Flow {
        Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var answerCallBack: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, answerCallBack: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallBack = answerCallBack
        }
    }
}
