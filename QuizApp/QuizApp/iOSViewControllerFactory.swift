//  Created by Lee Sam on 2022/01/22.

import Foundation
import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    let options: [Question<String>: [String]]
    
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallBack: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = options[question] else {
            fatalError("Could not find options for question: \(question)")
        }
        return questionViewController(for: question, options: options, answerCallBack: answerCallBack)
    }
    
    func resultViewController(for result: ResultOfQuiz<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
    
    private func questionViewController(for question: Question<String>, options: [String], answerCallBack: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options, selection: answerCallBack)
        case .multipleAnswers(let question):
            let controller = QuestionViewController(question: question, options: options, selection: answerCallBack)
            controller.loadView()
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }
    
}
