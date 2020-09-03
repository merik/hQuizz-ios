//
//  Repository.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

struct DataStoreError: Error {
    let message: String
}

protocol Repository {
    func loadGame(completion: @escaping(Result<[Question], DataStoreError>) -> Void)
}
