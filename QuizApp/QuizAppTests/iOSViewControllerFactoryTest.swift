//  Created by Lee Sam on 2022/01/22.
//

import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
        
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: "Q1").question, "Q1")
    }
    
    func test_questionViewController_sinlgeAnswer_createControllerWithOptions() {
        XCTAssertEqual(makeQuestionController().options, options)
    }
    
    func test_questionViewController_sinlgeAnswer_createControllerWithSingleSelection() {
        let controller = makeQuestionController()
        
        controller.loadViewIfNeeded()
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: helpers
    
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionController(question: String = "") -> QuestionViewController {
        let q = Question.singleAnswer(question)
        return makeSUT(options: [q: options]).questionViewController(for: q, answerCallBack: { _ in }) as! QuestionViewController
    }

    
}
