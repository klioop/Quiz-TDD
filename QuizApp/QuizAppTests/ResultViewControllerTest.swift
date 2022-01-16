//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by klioop on 2022/01/16.
//

import Foundation
import XCTest

@testable import QuizApp


class ResultViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersSummary() {
        XCTAssertEqual(makeSUT(summary: "A summary").headerLabel.text, "A summary")
    }
   
    func test_viewDidLoad_renderAnswers() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_rensersAnswerText() {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_rensersAnswerText() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
    
    // MARK: - helpers
    
    func makeSUT(
        summary: String = "",
        answers: [PresentableAnswer] = []
    ) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        sut.loadViewIfNeeded()

        return sut
    }
    
    func makeAnswer(
        question: String = "",
        answer: String = "",
        wrongAnswer: String? = nil
    ) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
    
}
