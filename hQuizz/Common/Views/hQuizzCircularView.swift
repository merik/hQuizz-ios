//
//  hQuizzCircularView.swift
//  hQuizz
//
//  Created by Erik Mai on 3/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

@IBDesignable
class hQuizzCircularView: UIView {
    
    @IBInspectable var color: UIColor? = UIColor(hQuizz: .primary) {
        didSet {
            self.backgroundColor = color
        }
    }
    
    @IBInspectable var circleColor: UIColor? = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var circleBorderWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var circleEdgeOffset: CGFloat = 6 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func layoutSubviews() {
         self.layer.cornerRadius = self.bounds.width / 2
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
        let cornerRadius = self.bounds.width / 2
        
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        layer.mask = backgroundMask
        
        circleColor?.setStroke()
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2), radius: rect.width / 2 - circleEdgeOffset / 2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        path.lineWidth = circleBorderWidth
        path.stroke()
        
    }
    
}
