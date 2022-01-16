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
            router.routeTo(question: firstQuestion, answerCallBack: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
        
    }
    
    private func nextCallback(from question: String) -> Router.AnswerCallBack {
        return { [weak self] in self?.routeToNext(question: question, answer: $0) }
    }
    
    private func routeToNext(question: String, answer: String) {
        if let currentQuestionIdx = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIdx = currentQuestionIdx + 1
            if nextQuestionIdx < questions.count {
                let nextQuestion = questions[nextQuestionIdx]
                router.routeTo(question: nextQuestion, answerCallBack: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
        }
    }
}

