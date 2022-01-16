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
    
    func test_optionSelected_notifiesDelegate() {
        var receivedAnser = ""
        let sut = makeSUT(options: ["A1"]) {
            receivedAnser = $0
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(receivedAnser, "A1")
        
    }
    
    // MARK: - helpers
    
    func makeSUT(
        question: String = "",
        options: [String] = [],
        selection: @escaping (String) -> Void = { _ in }
    ) -> QuestionViewController {
        let sut = QuestionViewController(
            question: question,
            options: options,
            selection: selection
        )
        sut.loadViewIfNeeded()
        return sut
    }

}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
