//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by klioop on 2022/01/17.
//

import XCTest
import QuizEngine

class GameTest: XCTestCase {
    var game: Game<String, String, RouterSpy>!
    let router = RouterSpy()
    
    override func setUp() {
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_gameStart_zeroCorrectOutOfTwo_scores0() {
        router.answerCallBack("WrongAnswer")
        router.answerCallBack("WrongAnswer")
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_gameStart_correctOneOutOfTwo_scoresOne() {
        router.answerCallBack("A1")
        router.answerCallBack("WrongAnswer")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_gameStart_correctTwoOutOfTwo_scoresTwo() {
        router.answerCallBack("A1")
        router.answerCallBack("A2")
        
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
}

