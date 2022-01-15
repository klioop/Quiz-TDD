//
//  Flow.swift
//  QuizEngine
//
//  Created by Lee Sam on 2022/01/15.
//

import Foundation


protocol Router {
    func routeTo(question: String, answerCallBack: @escaping (String) -> Void)
}


class Flow {
    
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let self = self else { return }
                let firstQuestionIdx = self.questions.firstIndex(of: firstQuestion)!
                let nextQuestionIdx = firstQuestionIdx + 1
                let nextQuestion = self.questions[nextQuestionIdx]
                self.router.routeTo(question: nextQuestion) { _ in
                    
                }
            }
        }
    }
}
