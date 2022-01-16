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
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routeToSecondAndThridQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        sut.start()
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        router.answerCallBack("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routesToEmptyResult() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        
        XCTAssertEqual(router.routedResult, [:])
    }
    
    func test_startAndAnswer_withOneQuestions_routeToOneResult() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        router.answerCallBack("A1")
        
        XCTAssertEqual(router.routedResult!, ["Q1": "A1"])
    }
    
    func test_startAndAnswer_withTwoQuestions_routeToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        
        XCTAssertEqual(router.routedResult, ["Q1": "A1", "Q2": "A2"])
    }
    
    
    
    // MARK: - helpers
    
    @discardableResult
    func makeSUT(questions: [String]) -> Flow {
        Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var routedResult: [String: String]? = nil
        var answerCallBack: Router.AnswerCallBack = { _ in }
        
        func routeTo(question: String, answerCallBack: @escaping Router.AnswerCallBack) {
            routedQuestions.append(question)
            self.answerCallBack = answerCallBack
        }
        
        func routeTo(result: [String : String]) {
            routedResult = result
        }
    }
}
