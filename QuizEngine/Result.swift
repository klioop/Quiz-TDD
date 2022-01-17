//
//  Result.swift
//  QuizEngine
//
//  Created by klioop on 2022/01/17.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
