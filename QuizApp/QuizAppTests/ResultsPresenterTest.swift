//  Created by Lee Sam on 2022/01/23.
//

import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTest: XCTestCase {
    
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers: [Question<String>: [String]] = [.singleAnswer("Q1"): ["A1"], .multipleAnswers("Q2"): ["A1", "A2"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 1)
        let sut = ResultPresenter(result: result, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 answer")
    }
    
    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answers =  Dictionary<Question<String>, [String]>()
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: [:])
        
        XCTAssertEqual(sut.presentableAnswers.count, 0)
    }
    
    func test_presentableAnswers_withOneWrongAnswer_mapsAnswer() {
        let answers: [Question<String>: [String]] = [.singleAnswer("Q1"): ["A1"]]
        let correctAnswers: [Question<String>: [String]] = [.singleAnswer("Q1"): ["A2"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withMultipleWrongAnswers_mapsAnswer() {
        let answers: [Question<String>: [String]] = [.multipleAnswers("Q1"): ["A1", "A3"]]
        let correctAnswers: [Question<String>: [String]] = [.multipleAnswers("Q1"): ["A2", "A3"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A3")
    }
    
    func test_presentableAnswers_withOneRightAnswer_mapsAnswer() {
        let answers: [Question<String>: [String]] = [.singleAnswer("Q1"): ["A1"]]
        let correctAnswers: [Question<String>: [String]] = [.singleAnswer("Q1"): ["A1"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
    }
    
    func test_presentableAnswers_withMultipleRightAnswers_mapsAnswer() {
        let answers: [Question<String>: [String]] = [.multipleAnswers("Q1"): ["A1", "A3"]]
        let correctAnswers: [Question<String>: [String]] = [.multipleAnswers("Q1"): ["A1", "A3"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
    }
}
