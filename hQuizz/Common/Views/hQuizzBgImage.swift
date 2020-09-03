//
//  hQuizzBgImage.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class hQuizzBgImage: UIView {
    private var imageView: UIImageView!
    private var filteredView: UIView!
    
    @IBInspectable var image: UIImage? = nil {
        didSet {
            imageView.image = image
            filteredView.backgroundColor = UIColor.black.withAlphaComponent(alphaRatio)
        }
    }
    
    @IBInspectable var alphaRatio: CGFloat = 0.9 {
        didSet {
            filteredView.backgroundColor = UIColor.black.withAlphaComponent(alphaRatio)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        let filteredView = UIView()
        filteredView.translatesAutoresizingMaskIntoConstraints = false
        filteredView.backgroundColor = UIColor.black.withAlphaComponent(alphaRatio)
        self.filteredView = filteredView
        
        self.addSubview(imageView)
        self.addSubview(filteredView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints = [
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            filteredView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filteredView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filteredView.topAnchor.constraint(equalTo: topAnchor),
            filteredView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
