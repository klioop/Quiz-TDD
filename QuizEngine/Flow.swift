//
//  Flow.swift
//  QuizEngine
//
//  Created by Lee Sam on 2022/01/15.
//

import Foundation


protocol Router {
    typealias AnswerCallBack = (String) -> Void
    func routeTo(question: String, answerCallBack: @escaping AnswerCallBack)
}


class Flow {
    
    private let router: Router
    private let questions: [String]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallBack: routeToNext(from: firstQuestion))
        }
    }
    
    private func routeToNext(from question: String) -> Router.AnswerCallBack {
        return { [weak self] _ in
            guard let self = self else { return }
            if let currentQuestionIdx = self.questions.firstIndex(of: question) {
                if currentQuestionIdx + 1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIdx + 1]
                    self.router.routeTo(question: nextQuestion, answerCallBack: self.routeToNext(from: nextQuestion))
                }
            }
        }
    }
}
