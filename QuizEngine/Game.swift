//
//  Game.swift
//  QuizEngine
//
//  Created by klioop on 2022/01/17.
//

import Foundation


// Only dealing with game state
public class Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

// We need a strong hold onto flow, otherwise it will disappear after calling start method
public func startGame<Question: Hashable, Answer: Equatable, R: Router>(
    questions: [Question],
    router: R,
    correctAnswers: [Question: Answer]
) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer  {
    let flow = Flow(
        questions: questions,
        router: router,
        scoring: { scoring($0, correctAnswers: correctAnswers) }
    )
    flow.start()
    
    return Game(flow: flow)
}

private func scoring<Question: Hashable, Answer: Equatable>(
    _ answers: [Question: Answer],
    correctAnswers: [Question: Answer]
) -> Int {
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
