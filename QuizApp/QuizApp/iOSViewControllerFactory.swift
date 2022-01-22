//  Created by Lee Sam on 2022/01/22.

import Foundation
import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallBack: @escaping (String) -> Void) -> UIViewController {
        return QuestionViewController()
    }
    
    func resultViewController(for result: ResultOfQuiz<Question<String>, String>) -> UIViewController {
        UIViewController()
    }
    
    
}
