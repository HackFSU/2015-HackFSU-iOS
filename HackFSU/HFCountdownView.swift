//
//  HFCountdownView.swift
//  HackFSU
//
//  Created by Logan Isitt on 2/15/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class HFCountdownView: UIView {
    
    private let progressLayer: CAShapeLayer = CAShapeLayer()
    
    var startHeader: UILabel!
    var startTime: UILabel!
    
    var progressLabel: UILabel!
    
    var endHeader: UILabel!
    var endTime: UILabel!
    
    var startDate: NSDate!
    var endDate: NSDate!
    
    var timer: NSTimer!
    var destinationDate: NSDate!
    
    var formatter = NSDateFormatter()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        startDate = NSDate()
        endDate = NSDate(timeIntervalSinceNow: 100)
        
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        formatter.doesRelativeDateFormatting = true
        
        createProgressLayer()

        startHeader     = UILabel(frame: CGRectMake(0.0, 20.0, CGRectGetWidth(frame), 30.0))
        startTime       = UILabel(frame: CGRectMake(0.0, 50.0, CGRectGetWidth(frame), 20.0))
        progressLabel   = UILabel(frame: CGRectMake(0.0, CGRectGetHeight(frame) / 15.0, CGRectGetWidth(frame), 30.0))
        endHeader       = UILabel(frame: CGRectMake(0.0, CGRectGetHeight(frame) - 70.0, CGRectGetWidth(frame), 30.0))
        endTime         = UILabel(frame: CGRectMake(0.0, CGRectGetHeight(frame) - 40.0, CGRectGetWidth(frame), 20.0))
        
        startHeader.textColor   = .whiteColor()
        startTime.textColor     = .whiteColor()
        progressLabel.textColor = .whiteColor()
        endHeader.textColor     = .whiteColor()
        endTime.textColor       = .whiteColor()
        
        startHeader.textAlignment   = .Center
        startTime.textAlignment     = .Center
        progressLabel.textAlignment = .Center
        endHeader.textAlignment     = .Center
        endTime.textAlignment       = .Center

        startHeader.font    = UIFont.HFFont.H3
        startTime.font      = UIFont.HFFont.H3
        progressLabel.font  = UIFont.HFFont.H3
        endHeader.font      = UIFont.HFFont.H3
        endTime.font        = UIFont.HFFont.H3
        
        startHeader.setTranslatesAutoresizingMaskIntoConstraints(false)
        startTime.setTranslatesAutoresizingMaskIntoConstraints(false)
        progressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        endHeader.setTranslatesAutoresizingMaskIntoConstraints(false)
        endTime.setTranslatesAutoresizingMaskIntoConstraints(false)

        startHeader.text    = "Hacking Begins"
        startTime.text      = "March 20, 2015 12:00AM"
        progressLabel.text  = "30:00:00"
        endHeader.text      = "Hacking Ends"
        endTime.text        = "March 22, 2015 5:00AM"
        
        addSubview(startHeader)
        addSubview(startTime)
        addSubview(progressLabel)
        addSubview(endHeader)
        addSubview(endTime)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "countdownUpdate", userInfo: nil, repeats: true)
    }
    
    func update() {
        startHeader.frame   = CGRectMake(0.0, 40.0, CGRectGetWidth(frame), 30.0)
        startTime.frame     = CGRectMake(0.0, 70.0, CGRectGetWidth(frame), 30.0)
        progressLabel.frame = CGRectMake(0.0, (CGRectGetHeight(frame) / 2.0) - 15.0, CGRectGetWidth(frame), 30.0)
        endHeader.frame     = CGRectMake(0.0, CGRectGetHeight(frame) - 80.0, CGRectGetWidth(frame), 30.0)
        endTime.frame       = CGRectMake(0.0, CGRectGetHeight(frame) - 50.0, CGRectGetWidth(frame), 30.0)
        
        startHeader.text    = "Hacking Begins"
        startTime.text      = formatter.stringFromDate(startDate)
        endHeader.text      = "Hacking Ends"
        endTime.text        = formatter.stringFromDate(endDate)
        
        let startAngle = CGFloat(M_PI * 3 + M_PI_2)
        let endAngle = CGFloat(M_PI * 5 + M_PI_2)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 25.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
    }
    
    func countdownUpdate() {
        
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)

        var units = NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitNanosecond
        
        var difComponents = calendar?.components(units, fromDate: NSDate(), toDate: endDate, options: NSCalendarOptions.MatchFirst)
        
        let h = difComponents!.hour as Int
        let m = difComponents!.minute as Int
        let s = difComponents!.second as Int
        let n = "\(difComponents!.nanosecond as Int)"
        
        self.progressLabel.text = NSString(format: "%d hrs %d mins %d secs", h, m, s) as String
    }

    private func createProgressLayer() {
        let startAngle = CGFloat(M_PI * 2 + M_PI_2)
        let endAngle = CGFloat(M_PI * 5 + M_PI_2)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        var gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.blackColor().CGColor
        progressLayer.lineWidth = 10.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.0, 1.0]
        
        let colorTop: AnyObject = UIColor.HFColor.White.CGColor // UIColor(red: 255.0/255.0, green: 213.0/255.0, blue: 63.0/255.0, alpha: 1.0).CGColor
        let colorBottom: AnyObject = UIColor.HFColor.White.CGColor // UIColor(red: 255.0/255.0, green: 198.0/255.0, blue: 5.0/255.0, alpha: 1.0).CGColor
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    func hideProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
        progressLabel.text = "Load content"
    }
    
    func animateProgressView() {
        
        var max = CGFloat(endDate.timeIntervalSince1970)
        var cur = CGFloat(NSDate().timeIntervalSince1970)
        var min = CGFloat(startDate.timeIntervalSince1970)
        
        progressLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat((cur - min) / (max - min))
        animation.toValue = CGFloat(1.0)
        animation.duration = CFTimeInterval(max) - CFTimeInterval(cur)
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = true
        animation.fillMode = kCAFillModeForwards
        progressLayer.addAnimation(animation, forKey: "strokeEnd")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        progressLabel.text = "Done"
        timer.invalidate()
    }
}