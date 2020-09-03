//
//  Game.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

enum GameStatus {
    case error(String)
    case ready
}

enum UserResponse {
    case skip
    case response(Int)
}

enum AnswerValue {
    case correct
    case incorrect
    case skipped
}

class Game {
    
    private let correctAnswerPoints = 2
    private let incorrectAnswerPoints = -1
    private let skipAnswerPoints = 0
    
    private var questions = [Question]()
    var currentQuestionIndex = -1
    
    var responses = [UserResponse]()
    var score = 0
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        resetGame()
    }
    
    private func resetGame() {
        questions.removeAll()
        responses.removeAll()
        currentQuestionIndex = -1
        score = 0
    }
    
    func newGame(completion: @escaping(GameStatus) -> Void) {
        resetGame()
        repository.loadGame(completion: {[weak self] result in
            switch result {
            case .failure(let error):
                completion(.error(error.message))
            case .success(let questions):
                self?.questions = questions
                completion(.ready)
            }
        })
    }
    
    var currentQuestion: Question? {
        if currentQuestionIndex >= 0 && currentQuestionIndex < questions.count {
            return questions[currentQuestionIndex]
        }
        return nil
    }
    
    func nextQuestion() -> Question? {
        currentQuestionIndex += 1
        if currentQuestionIndex >= 0 && currentQuestionIndex < questions.count {
            return questions[currentQuestionIndex]
        }
        return nil
    }
    
    var numQuestions: Int {
        return questions.count
    }
    
    var endOfGame: Bool {
        return currentQuestionIndex >= numQuestions
    }
    
    func userAnswer(with response: UserResponse) -> AnswerValue {
        responses.append(response)
        switch response {
        case .response(let index):
            if questions[currentQuestionIndex].correctAnswerIndex == index {
                score += correctAnswerPoints
                return .correct
            } else {
                score += incorrectAnswerPoints
                return .incorrect
            }
        case .skip:
            score += skipAnswerPoints
            return .skipped
        }
        
    }
    
}
