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
    
    func test_viewDidLoad_withOptions_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
        XCTAssertEqual(makeSUT(options: ["A1", "A2", "A3"]).tableView.title(at: 2), "A3")
    }
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeSelected_withSingleSelection_DoesNotNotifiesDelegateWithEmptySelection() {
        var callBackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) { _ in  callBackCount += 1 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callBackCount, 1)
        
        sut.tableView.deSelect(row: 0)
        XCTAssertEqual(callBackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) { receivedAnswer = $0 }

        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])

        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionDeSelected_withMultipleSelectionEnabled_notifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], allowsMultipleSelection: true) { receivedAnswer = $0 }

        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])

        sut.tableView.deSelect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    
    
    // MARK: - helpers
    
    func makeSUT(
        question: String = "",
        options: [String] = [],
        allowsMultipleSelection: Bool = false,
        selection: @escaping ([String]) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(
            question: question,
            options: options,
            allowsMultipleSelection: allowsMultipleSelection,
            selection: selection
        )
        sut.loadViewIfNeeded()
        
        return sut
    }

}

