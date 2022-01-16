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
    func routeTo(result: [String: String])
}


class Flow {
    
    private let router: Router
    private let questions: [String]
    
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallBack: routeToNext(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func routeToNext(from question: String) -> Router.AnswerCallBack {
        return { [weak self] answer in
            guard let self = self else { return }
            if let currentQuestionIdx = self.questions.firstIndex(of: question) {
                self.result[question] = answer
                if currentQuestionIdx + 1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIdx + 1]
                    self.router.routeTo(question: nextQuestion, answerCallBack: self.routeToNext(from: nextQuestion))
                } else {
                    self.router.routeTo(result: self.result)
                }
                
            }
        }
    }
}
