//  Created by Lee Sam on 2022/01/23.
//

import Foundation
import QuizEngine

struct ResultPresenter {
    let result: ResultOfQuiz<Question<String>, [String]>
    let questions: [Question<String>]
    let correctAnswers: Dictionary<Question<String>, [String]>
    
    var summary: String {
        "You got \(result.score)/\(result.answers.count) answer"
    }
    var presentableAnswers: [PresentableAnswer] {
        return questions.map { (question) in
            guard
                let correctAnswer = correctAnswers[question],
                let userAnswers = result.answers[question]
            else {
                fatalError("Couldn't find correct answer for question, \(question)")
            }
            return presentalbeAnswer(question, userAnswer: userAnswers, correctAnswer: correctAnswer)
        }
    }
    
    private func presentalbeAnswer(
        _ question: Question<String>,
        userAnswer: [String],
        correctAnswer: [String]
    ) -> PresentableAnswer {
        switch question {
        case let .singleAnswer(value), let .multipleAnswers(value):
            return PresentableAnswer(
                question: value,
                answer: formattedAnswer(correctAnswer),
                wrongAnswer: wrongAnswer(correctAnswer, userAnswer)
            )
        }
    }
    
    private func formattedAnswer(_ answers: [String]) -> String {
        return answers.joined(separator: ", ")
    }
    
    private func wrongAnswer(_ correctAnswer: [String], _ userAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }
}
