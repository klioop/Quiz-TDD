
//  Created by Lee Sam on 2022/01/22.

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallBack: @escaping (String) -> Void) -> UIViewController
    func resultViewController(for result: ResultOfQuiz<Question<String>, String>) -> UIViewController
}
