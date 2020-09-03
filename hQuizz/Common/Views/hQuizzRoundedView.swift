//
//  hQuizzRoundedView.swift
//  hQuizz
//
//  Created by Erik Mai on 3/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

@IBDesignable
class hQuizzRoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func layoutSubviews() {
         self.layer.cornerRadius = cornerRadius
    }
    
    private func configure() {
        self.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        layer.mask = backgroundMask
    }
    
}
