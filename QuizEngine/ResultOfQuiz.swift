//
//  Result.swift
//  QuizEngine
//
//  Created by klioop on 2022/01/17.
//

import Foundation

public struct ResultOfQuiz<Question: Hashable, Answer> {
    public var answers: [Question: Answer]
    public var score: Int
    
    init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
