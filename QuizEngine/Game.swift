//
//  Game.swift
//  QuizEngine
//
//  Created by klioop on 2022/01/17.
//

import Foundation


// Only dealing with game state
public class Game<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

// We need a strong hold onto flow, otherwise it will disappear after calling start method
public func startGame<Question: Hashable, Answer, R: Router>(
    questions: [Question],
    router: R,
    correctAnswers: [Question: Answer]
) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer  {
    let flow = Flow(questions: questions, router: router, scoring: { _ in 1 } )
    flow.start()
    
    return Game(flow: flow)
}
