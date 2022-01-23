//  Created by Lee Sam on 2022/01/22.
//

import Foundation
import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
        
    let singleQuestion = Question.singleAnswer("Q1")
    let multipleQuestion = Question.multipleAnswers("Q1")
    let options = ["A1", "A2"]
    
    func test_questionViewController_singleAnswer_createControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleQuestion, multipleQuestion], question: singleQuestion)
        XCTAssertEqual(makeQuestionController(question: singleQuestion).title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: singleQuestion).question, "Q1")
    }
    
    func test_questionViewController_sinlgeAnswer_createControllerWithOptions() {
        XCTAssertEqual(makeQuestionController().options, options)
    }
    
    func test_questionViewController_sinlgeAnswer_createControllerWithSingleSelection() {
        let controller = makeQuestionController()
        
        controller.loadViewIfNeeded()
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipeAnswers_createControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleQuestion, multipleQuestion], question: multipleQuestion)
        XCTAssertEqual(makeQuestionController(question: multipleQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipeAnswers_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: singleQuestion).question, "Q1")
    }
    
    func test_questionViewController_multipeAnswers_createControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleQuestion).options, options)
    }
     
    func test_questionViewController_multipeAnswers_createControllerWithSingleSelection() {
        let controller = makeQuestionController(question: multipleQuestion)
        
        controller.loadViewIfNeeded()
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: helpers
    
    func makeSUT(options: [Question<String>: [String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleQuestion, multipleQuestion], options: options)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallBack: { _ in }) as! QuestionViewController
    }
 
    // Protocol lives in the same module with the implemetation, which does not make sense.
    
}
