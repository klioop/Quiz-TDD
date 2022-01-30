//  Created by Lee Sam on 2022/01/23.
//

import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTest: XCTestCase {
    
    let singleQuestoin = Question.singleAnswer("Q1")
    let multipleQuestion = Question.multipleAnswers("Q2")
    
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers: [Question<String>: [String]] = [singleQuestoin: ["A1"], multipleQuestion: ["A1", "A2"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 1)
        let sut = ResultPresenter(result: result, questions: [singleQuestoin, multipleQuestion], correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 answer")
    }
    
    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answers =  Dictionary<Question<String>, [String]>()
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, questions: [],  correctAnswers: [:])
        
        XCTAssertEqual(sut.presentableAnswers.count, 0)
    }
    
    func test_presentableAnswers_withOneWrongAnswer_mapsAnswer() {
        let answers: [Question<String>: [String]] = [singleQuestoin: ["A1"]]
        let correctAnswers: [Question<String>: [String]] = [singleQuestoin: ["A2"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, questions: [singleQuestoin], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withMultipleWrongAnswers_mapsAnswer() {
        let answers: [Question<String>: [String]] = [multipleQuestion: ["A1", "A3"]]
        let correctAnswers: [Question<String>: [String]] = [multipleQuestion: ["A2", "A3"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, questions: [multipleQuestion], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A3")
    }
    
    func test_presentableAnswers_withOneRightAnswer_mapsAnswer() {
        let answers: [Question<String>: [String]] = [singleQuestoin: ["A1"]]
        let correctAnswers: [Question<String>: [String]] = [singleQuestoin: ["A1"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, questions: [singleQuestoin], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
    }
    
    func test_presentableAnswers_withMultipleRightAnswers_mapsAnswer() {
        let answers: [Question<String>: [String]] = [multipleQuestion: ["A1", "A3"]]
        let correctAnswers: [Question<String>: [String]] = [multipleQuestion: ["A1", "A3"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: answers , score: 0)
        let sut = ResultPresenter(result: result, questions: [multipleQuestion], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswers() {
        let questions = [singleQuestoin, multipleQuestion]
        let usersAnswers: [Question<String>: [String]] = [multipleQuestion: ["A1", "A3"], singleQuestoin: ["A1"]]
        let correctAnswers: [Question<String>: [String]] = [multipleQuestion: ["A1", "A3"], singleQuestoin: ["A1"]]
        let result: ResultOfQuiz<Question<String>, [String]> = .init(
            answers: usersAnswers , score: 2)
        let sut = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1, A3")
        XCTAssertEqual(sut.presentableAnswers.last!.wrongAnswer, nil)
    }
}
