//  Created by Lee Sam on 2022/01/22.
//

import Foundation
import XCTest
import QuizEngine
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
        XCTAssertFalse(makeQuestionController().tableView.allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswers_createControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleQuestion, multipleQuestion], question: multipleQuestion)
        XCTAssertEqual(makeQuestionController(question: multipleQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswers_createControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: singleQuestion).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswers_createControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleQuestion).options, options)
    }
     
    func test_questionViewController_multipleAnswers_createControllerWithMultipleSelection() {
        XCTAssertTrue(makeQuestionController(question: multipleQuestion).tableView.allowsMultipleSelection)
    }
    
    func test_resultViewController_createResultViewController_withSummary() {
        let tuple = makeControllerAndPresenter()
        
        XCTAssertEqual(tuple.controller!.summary, tuple.presenter.summary)
    }
    
    func test_resultViewController_createResultViewController_withPresentableAnswers() {
        let tuple = makeControllerAndPresenter()
        
        XCTAssertEqual(tuple.controller!.answers.count, tuple.presenter.presentableAnswers.count)
    }
    
    // MARK: helpers
    
    func makeSUT(options: [Question<String>: [String]] = [:], correctAnswers: [Question<String>: [String]] = [:] ) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleQuestion, multipleQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallBack: { _ in }) as! QuestionViewController
    }
    
    func makeControllerAndPresenter() -> (controller: ResultViewController?, presenter: ResultPresenter) {
        let questions = [singleQuestion, multipleQuestion]
        let userAnswers = [singleQuestion: ["A1"], multipleQuestion: ["A1", "A3"]]
        let correctAnswers = [singleQuestion: ["A1"], multipleQuestion: ["A1", "A3"]]
        let result = ResultOfQuiz(answers: userAnswers, score: 2)
        let sut = makeSUT(correctAnswers: correctAnswers)
        let presenter = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let controller = sut.resultViewController(for: result) as? ResultViewController
        
        return (controller, presenter)
    }
 
    // Protocol lives in the same module with the implemetation, which does not make sense.
    
}
