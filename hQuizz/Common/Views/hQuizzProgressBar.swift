//
//  hQuizzProgressBar.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class hQuizzProgressBar: UIView {
    
    @IBInspectable var color: UIColor? = .white
    @IBInspectable var cornerRadius: CGFloat = 3.0
    
    @IBInspectable var progress: CGFloat = 0.0 {
        didSet {
            if progress > 1.0 {
                progress = 1.0
            }
            
            if progress < 0 {
                progress = 0.0
            }
            
            setNeedsDisplay()
        }
    }
    
    private let progressLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        layer.mask = backgroundMask
        
        color?.setStroke()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        path.lineWidth = 1.0
        path.stroke()
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = color?.cgColor
    }
}
