//
//  ImageLoader.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ urlString: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: ["errorMessage": "Invalid Url"])))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            defer {
                self.runningRequests.removeValue(forKey: uuid)
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
                return
            }
            
            guard let error = error else {
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
