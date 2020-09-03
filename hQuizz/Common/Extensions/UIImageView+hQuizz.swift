//
//  UIImageView+hQuizz.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(at url: String, completion: @escaping(UIImage?) -> Void) {
        UIImageLoader.shared.load(url, for: self, completion: completion)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
