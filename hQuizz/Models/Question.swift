//
//  Question.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

struct Question {
    let correctAnswerIndex: Int
    let imageUrl: String
    let standFirst: String
    let storyUrl: String
    let section: String
    let headlines: [String]
    
    var headline0: String {
        return headlines.count > 0 ? headlines[0] : ""
    }
    
    var headline1: String {
        return headlines.count > 1 ? headlines[1] : ""
    }
    
    var headline2: String {
        return headlines.count > 2 ? headlines[2] : ""
    }
    
    var correctHeadline: String {
        
        if correctAnswerIndex >= 0 && correctAnswerIndex < headlines.count {
            return headlines[correctAnswerIndex]
        }
        
        return ""
    }
}

extension Question: Decodable {
    private enum QuestionCodingKeys: String, CodingKey {
        case correctAnswerIndex
        case imageUrl
        case standFirst
        case storyUrl
        case section
        case headlines
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuestionCodingKeys.self)
        correctAnswerIndex = try container.decode(Int.self, forKey: .correctAnswerIndex)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        standFirst = try container.decode(String.self, forKey: .standFirst)
        storyUrl = try container.decode(String.self, forKey: .storyUrl)
        section = try container.decode(String.self, forKey: .section)
        headlines = try container.decode([String].self, forKey: .headlines)
    }
}
