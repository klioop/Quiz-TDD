//
//  Result.swift
//  QuizEngine
//
//  Created by klioop on 2022/01/17.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    var answers: [Question: Answer]
    var score: Int
}
