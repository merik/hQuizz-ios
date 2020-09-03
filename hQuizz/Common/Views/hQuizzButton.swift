//
//  hQuizzButton.swift
//  hQuizz
//
//  Created by Erik Mai on 2/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class hQuizzButton: UIButton {
    
    @IBInspectable var active: Bool = true {
        didSet {
            self.backgroundColor = active ? UIColor(hQuizz: .primary) : UIColor(hQuizz: .disabled)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = active ? UIColor(hQuizz: .primary) : UIColor(hQuizz: .disabled)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = active ? UIColor(hQuizz: .primary) : UIColor(hQuizz: .disabled)
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var isCircular: Bool = false {
        didSet {
            if isCircular {
                cornerRadius = self.bounds.height / 2
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        layer.mask = backgroundMask
        
    }
    
}
