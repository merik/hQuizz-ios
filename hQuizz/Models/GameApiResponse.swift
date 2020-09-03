//
//  GameApiResponse.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

struct GameApiResponse {
    let questions: [Question]
}

extension GameApiResponse: Decodable {
    private enum GameApiResponseCodingKeys: String, CodingKey {
        case questions = "items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GameApiResponseCodingKeys.self)
        questions = try container.decode([Question].self, forKey: .questions)
    }
}
