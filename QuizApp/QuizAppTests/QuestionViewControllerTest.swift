//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by klioop on 2022/01/16.
//

import Foundation
import XCTest

@testable import QuizApp


class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeader() {
        let sut = makeSUT(question: "Q1")
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOptionText() {
        let sut = makeSUT(options: ["A1"])
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)

        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
    
    // MARK: - helpers
    
    func makeSUT(question: String = "", options: [String] = []) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options)
        sut.loadViewIfNeeded()
        return sut
    }

}
