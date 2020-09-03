//
//  QuestionsViewModel.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

enum QuestionsStatus {
    case loading
    case error(String)
    case inGame(Question)
    case endOfGame
    case answerCorrect
    case answerInCorrect
}

class QuestionsViewModel {
    
    private var game: Game
    var gameStatusUpdate: ((QuestionsStatus) -> Void)?
    
    init(game: Game) {
        self.game = game
    }
    
    func startGame() {
        if let question = game.nextQuestion() {
            gameStatusUpdate?(.inGame(question))
        } else {
            gameStatusUpdate?(.error("No Questions Found"))
        }
    }
    
    func nextQuestion() {
        gameStatusUpdate?(.loading)
        
        guard let question = game.nextQuestion() else {
            gameStatusUpdate?(.endOfGame)
            return
        }
        
        gameStatusUpdate?(.inGame(question))
    }
    
    func answer(with index: Int) {
        switch game.userAnswer(with: .response(index)) {
        case .correct:
            gameStatusUpdate?(.answerCorrect)
        case .incorrect:
            gameStatusUpdate?(.answerInCorrect)
        case .skipped: ()
            
        }
        
    }
    
    func skipQuestion() {
        game.userAnswer(with: .skip)
        nextQuestion()
    }
    
    var scoreString: String {
        let score = game.score
        
        if score == 0 {
            return "0 Points"
        }
        
        if score == 1 {
            return "+\(score) Point"
        }
        
        if score > 0 {
            return "+\(score) Points"
        }
        
        if score == -1 {
            return "\(score) Point"
        }
        
        return "\(score) Points"
    }
    
    var gameProgress: Float {
        guard game.numQuestions > 0 else {
            return 0.0
        }
        
        let progress = Float(game.currentQuestionIndex) / Float(game.numQuestions)
        return progress
    }
    
    var currentQuestion: Question? {
        return game.currentQuestion
    }
    
    var totalScore: Int {
        return game.score
    }
    
}
