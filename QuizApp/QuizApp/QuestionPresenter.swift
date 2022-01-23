//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by klioop on 2022/01/23.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String> // current question
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }
        return "Question #\(index + 1)"
    }
}
