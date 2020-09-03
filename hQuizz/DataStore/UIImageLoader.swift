//
//  UIImageLoader.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import UIKit

class UIImageLoader {
    
    static let shared = UIImageLoader()
    private let imageLoader: ImageLoader
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {
        imageLoader = ImageLoader()
    }
    
    func load(_ url: String, for imageView: UIImageView, completion: @escaping(UIImage?) -> Void) {
        let token = imageLoader.loadImage(url) { result in
            defer {
                self.uuidMap.removeValue(forKey: imageView)
            }
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
                completion(image)
            } catch {
            
            }
        }

        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
    
}
