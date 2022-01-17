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
        
        XCTAssertEqual(router.routedResult!.answers, [:])
    }
    
    func test_start_withNoQuestions_doesNotRouteToResult() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerOneQuestions_withTwoQuestions_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        router.answerCallBack("A1")
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswer_withTwoQuestions_routeToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        
        XCTAssertEqual(router.routedResult!.answers, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startAndAnswer_withTwoQuestions_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 10 })
        
        sut.start()
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        
        XCTAssertEqual(router.routedResult!.score, 10)
    }
    
    func test_startAndAnswer_withTwoQuestions_scoresWithRightAnswer() {
        var receivedAnswers = [String: String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        
        sut.start()
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        
        XCTAssertEqual(receivedAnswers, ["Q1": "A1", "Q2": "A2"])
    }
    
    
    
    // MARK: - helpers
    
    @discardableResult
    func makeSUT(
        questions: [String],
        scoring: @escaping ([String: String]) -> Int = { _ in 0 }
    ) -> Flow<String, String, RouterSpy> {
        Flow(questions: questions, router: router, scoring: scoring)
    }
    
    
}
