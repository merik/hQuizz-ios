//
//  ApiRepository.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

class ApiRepository: Repository {
    func loadGame(completion: @escaping (Result<[Question], DataStoreError>) -> Void) {
        hQuizzApiService.shared.getGameData(with: .game, completion: {(data, error) in
            if let error = error {
                let errorMessage = (error as NSError).userInfo["errorMessage"] as? String ?? "Error Occurred"
                completion(.failure(DataStoreError(message: errorMessage)))
                return
            }
            
            guard let data = data else {
                completion(.failure(DataStoreError(message: "Invalid Data Response")))
                return
            }
            
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(GameApiResponse.self, from: data) else {
                completion(.failure(DataStoreError(message: "Invalid Data Response")))
                return
            }
            
            completion(.success(response.questions))
        })
    }
}

enum hQuizzApiResources: String {
    case game = "game.json"
}

struct hQuizzApiService {
    
    static let shared = hQuizzApiService()
    
    private let urlSession = URLSession.shared
    
    private init() {
        
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "firebasestorage.googleapis.com"
        return components
    }
    
    func getGameData(with resources: hQuizzApiResources, completion: @escaping(Data?, Error?) -> Void) {
        //https://firebasestorage.googleapis.com/v0/b/nca-dna-apps-dev.appspot.com/o/game.json?alt=media&token=e36c1a14-25d9-4467-8383-a53f57ba6bfe
        fetch(with: resources, parameters: [
                "alt": "media",
                "token": "e36c1a14-25d9-4467-8383-a53f57ba6bfe"
        ], completion: completion)
    }
    
    private func fetch(with resources: hQuizzApiResources, parameters: [String: String], completion: @escaping(Data?, Error?) -> Void) {
        
        var urlComponents = self.urlComponents
        urlComponents.path = "/v0/b/nca-dna-apps-dev.appspot.com/o/\(resources.rawValue)"
        urlComponents.setQueryItems(with: parameters)
        
        guard let url = urlComponents.url else {
            completion(nil, NSError(domain: "", code: 100, userInfo: ["errorMessage": "Invalid Url"]))
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NSError(domain: "", code: 100, userInfo: ["errorMessage": "Invalid Response"]))
                return
                
            }
                
            switch response.statusCode {
                case 200...299:
                    completion(data, error)
                
                // Error
                case 401...500: fallthrough
                case 501...599: fallthrough
                default:
                    guard let data = data else {
                        completion(nil, NSError(domain: "", code: 100, userInfo: ["errorMessage": "Invalid Response"]))
                        return
                    }
                    
                    completion(data, NSError(domain: "", code: response.statusCode, userInfo: ["errorMessage": String(data: data, encoding: .utf8) as Any]))
                    
            }
           
        }.resume()
    }
    
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

