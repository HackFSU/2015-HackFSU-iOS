//
//  HFCountdownView.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/15/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFCountdownView: UIView {
    
    var lineWidth: CGFloat = 10.0
    
    private let scsLayer: CAShapeLayer = CAShapeLayer()
    private let mnsLayer: CAShapeLayer = CAShapeLayer()
    private let hrsLayer: CAShapeLayer = CAShapeLayer()
    private let ttlLayer: CAShapeLayer = CAShapeLayer()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        var rad = CGRectGetWidth(frame)/2 - 30.0
        let c = CGFloat(2)
        
        createProgressLayer(ttlLayer, radius: rad, color: UIColor.redColor())
        rad -= (lineWidth + c)
        createProgressLayer(hrsLayer, radius: rad, color: UIColor.yellowColor())
        rad -= (lineWidth + c)
        createProgressLayer(mnsLayer, radius: rad, color: UIColor.greenColor())
        rad -= (lineWidth + c)
        createProgressLayer(scsLayer, radius: rad, color: UIColor.blueColor())
    }
 
    private func createProgressLayer(progressLayer: CAShapeLayer, radius: CGFloat, color: UIColor) {
        
        let startAngle = CGFloat(M_PI_2)
        let endAngle = CGFloat(M_PI * 2 + M_PI_2)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        var gradientMaskLayer = gradientMask(color, bottomColor: color)
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: radius, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        layer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = color.CGColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    private func gradientMask(topColor: UIColor, bottomColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [topColor.CGColor, bottomColor.CGColor]
        
        return gradientLayer
    }
    
    //MARK: - Animations
    
    func hideProgressView() {
        scsLayer.strokeEnd = 0.0
        scsLayer.removeAllAnimations()
        
        mnsLayer.strokeEnd = 0.0
        mnsLayer.removeAllAnimations()
        
        hrsLayer.strokeEnd = 0.0
        hrsLayer.removeAllAnimations()
        
        ttlLayer.strokeEnd = 0.0
        ttlLayer.removeAllAnimations()
    }
    
    func animateProgressView() {
        
        let c = Float(4)
        
        let animation1 = CABasicAnimation(keyPath: "strokeEnd")
        animation1.fromValue = CGFloat(0.0)
        animation1.toValue = CGFloat(1.0)
        animation1.duration = 1.0 * CFTimeInterval(c)
        animation1.delegate = self
        animation1.removedOnCompletion = false
        animation1.additive = true
        animation1.fillMode = kCAFillModeForwards
        animation1.repeatCount = 8 //* c
        
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        animation2.fromValue = CGFloat(0.0)
        animation2.toValue = CGFloat(1.0)
        animation2.duration = 2.0 * CFTimeInterval(c)
        animation2.delegate = self
        animation2.removedOnCompletion = false
        animation2.additive = true
        animation2.fillMode = kCAFillModeForwards
        animation2.repeatCount = 4// * c
        
        let animation3 = CABasicAnimation(keyPath: "strokeEnd")
        animation3.fromValue = CGFloat(0.0)
        animation3.toValue = CGFloat(1.0)
        animation3.duration = 4.0 * CFTimeInterval(c)
        animation3.delegate = self
        animation3.removedOnCompletion = false
        animation3.additive = true
        animation3.fillMode = kCAFillModeForwards
        animation3.repeatCount = 2 //* c
        
        let animation4 = CABasicAnimation(keyPath: "strokeEnd")
        animation4.fromValue = CGFloat(0.0)
        animation4.toValue = CGFloat(1.0)
        animation4.duration = 8.0 * CFTimeInterval(c)
        animation4.delegate = self
        animation4.removedOnCompletion = false
        animation4.additive = true
        animation4.fillMode = kCAFillModeForwards
//        animation4.repeatCount = c
        
//        let clear = CABasicAnimation(keyPath: "strokeEnd")
//        clear.fromValue = CGFloat(1.0)
//        clear.toValue = CGFloat(0.0)
//        clear.duration = 0.0
//        clear.delegate = self
//        clear.removedOnCompletion = false
//        clear.additive = true
//        clear.fillMode = kCAFillModeForwards
        
        var animGroup = CAAnimationGroup()
        animGroup.animations = [animation1]
        animGroup.repeatCount = 5
        
//        scsLayer.addAnimation(animation1, forKey: "strokeEnd")
        mnsLayer.addAnimation(animation2, forKey: "strokeEnd")
        hrsLayer.addAnimation(animation3, forKey: "strokeEnd")
        ttlLayer.addAnimation(animation4, forKey: "strokeEnd")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        // TODO
    }
}