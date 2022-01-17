//
//  Flow.swift
//  QuizEngine
//
//  Created by Lee Sam on 2022/01/15.
//

import Foundation


class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.router = router
        self.questions = questions
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallBack: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result())
        }
        
    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] in self?.routeToNext(question: question, answer: $0) }
    }
    
    private func routeToNext(question: Question, answer: Answer) {
        if let currentQuestionIdx = questions.firstIndex(of: question) {
            answers[question] = answer
            let nextQuestionIdx = currentQuestionIdx + 1
            if nextQuestionIdx < questions.count {
                let nextQuestion = questions[nextQuestionIdx]
                router.routeTo(question: nextQuestion, answerCallBack: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result())
            }
        }
    }
    
    private func result() -> Result<Question, Answer> {
        return Result(answers: answers, score: scoring(answers))
    }
}

