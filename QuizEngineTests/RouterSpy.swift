//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by klioop on 2022/01/17.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    
    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallBack: (String) -> Void = { _ in }
    
    func routeTo(question: String, answerCallBack: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallBack = answerCallBack
    }
    
    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
