//
//  Flow.swift
//  QuizEngine
//
//  Created by Lee Sam on 2022/01/15.
//

import Foundation


protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, answerCallBack: @escaping (Answer) -> Void)
    func routeTo(result: [Question: Answer])
}


class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    
    private var result: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
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
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] in self?.routeToNext(question: question, answer: $0) }
    }
    
    private func routeToNext(question: Question, answer: Answer) {
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

