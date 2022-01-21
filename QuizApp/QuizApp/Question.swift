//
//  Question.swift
//  QuizAppTests
//
//  Created by klioop on 2022/01/21.
//

import Foundation

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswers(T)
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        switch (lhs, rhs) {
        case let (.singleAnswer(a), .singleAnswer(b)):
            return a == b
        case let (.multipleAnswers(a), .multipleAnswers(b)):
            return a == b
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .singleAnswer(value):
            hasher.combine(value)
        case let .multipleAnswers(value):
            hasher.combine(value)
        }
    }
    
}
