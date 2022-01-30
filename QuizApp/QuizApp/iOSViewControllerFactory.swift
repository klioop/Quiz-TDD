//  Created by Lee Sam on 2022/01/22.

import Foundation
import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    let questions: [Question<String>]
    let options: [Question<String>: [String]]
    let correctAnswers: [Question<String>: [String]]
    
    init(questions: [Question<String>], options: [Question<String>: [String]], correctAnswers: [Question<String>: [String]]) {
        self.options = options
        self.questions = questions
        self.correctAnswers = correctAnswers
    }
    
    func questionViewController(for question: Question<String>, answerCallBack: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = options[question] else {
            fatalError("Could not find options for question: \(question)")
        }
        return questionViewController(for: question, options: options, answerCallBack: answerCallBack)
    }
    
    func resultViewController(for result: ResultOfQuiz<Question<String>, [String]>) -> UIViewController {
        let presenter = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        return ResultViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
    }
    
    private func questionViewController(for question: Question<String>, options: [String], answerCallBack: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return questionViewController(for: question, value: value, options: options, allowsMultipleSelection: false, answerCallBack: answerCallBack)
        case .multipleAnswers(let value):
            let controller = questionViewController(for: question, value: value, options: options, allowsMultipleSelection: true, answerCallBack: answerCallBack)
            controller.loadView()
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, options: [String], allowsMultipleSelection: Bool, answerCallBack: @escaping ([String]) -> Void) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, selection: answerCallBack)
        controller.title = presenter.title
        
        return controller
    }
    
}
