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
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options, selection: answerCallBack)
        default:
            return UIViewController()
        }
    }
    
    func resultViewController(for result: ResultOfQuiz<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
    
    
}
