//
//  Router.swift
//  QuizEngine
//
//  Created by klioop on 2022/01/17.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, answerCallBack: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
