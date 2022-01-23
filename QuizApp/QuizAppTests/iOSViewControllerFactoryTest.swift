//  Created by Lee Sam on 2022/01/22.
//

import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
        
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_sinlgeAnswer_createControllerWithOptions() {
        XCTAssertEqual(makeQuestionController().options, options)
    }
    
    func test_questionViewController_sinlgeAnswer_createControllerWithSingleSelection() {
        let controller = makeQuestionController()
        
        controller.loadViewIfNeeded()
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipeAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).question, "Q1")
    }
    
    func test_questionViewController_multipeAnswer_createControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: .multipleAnswers("Q1")).options, options)
    }
     
    func test_questionViewController_multipeAnswer_createControllerWithSingleSelection() {
        let controller = makeQuestionController(question: .multipleAnswers("Q1"))
        
        controller.loadViewIfNeeded()
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: helpers
    
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallBack: { _ in }) as! QuestionViewController
    }
 
    
}
