//
//  MyProgressHUD.swift
//  DemoPKHUD
//
//  Created by Chris Hu on 16/11/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class MyProgressHUD: UIView {

    private var _isRemovedAfterFinish = true
    
    var progressValue: Float = 0.0 {
        didSet {
            let path = UIBezierPath()
            path.move(to: radiusCenter)
            path.addArc(withCenter: radiusCenter, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(M_PI) * CGFloat(progressValue), clockwise: true)
            path.addLine(to: radiusCenter)
            
            innershapeLayer.path = path.cgPath
            
            if _isRemovedAfterFinish && progressValue == 1.0 {
                self.removeFromSuperview()
            }
        }
    }
    
    private var outShapeLayer: CAShapeLayer!
    private var innershapeLayer: CAShapeLayer!
    
    private var radiusCenter: CGPoint!
    private var radius: CGFloat!
    
    private let offset = CGFloat(2.0)
    
    convenience init(frame: CGRect, isRemovedAfterFinish: Bool) {
        self.init(frame: frame)
        
        _isRemovedAfterFinish = isRemovedAfterFinish
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        layer.contentsScale = UIScreen.main.scale
        backgroundColor = UIColor.clear
        transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        
        addOutCircle()
        
        addInnershapeLayer()
    }
    
    private func addOutCircle() {
        outShapeLayer = CAShapeLayer()
        outShapeLayer.frame = bounds
        
        let path = UIBezierPath(ovalIn: outShapeLayer.bounds)
        outShapeLayer.path = path.cgPath
        outShapeLayer.lineWidth = 1.5
        outShapeLayer.lineCap = kCALineCapRound
        outShapeLayer.strokeColor = UIColor.white.cgColor
        outShapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(outShapeLayer)
        
        outShapeLayer.strokeStart = 0
        outShapeLayer.strokeEnd = 1
    }
    
    private func addInnershapeLayer() {
        innershapeLayer = CAShapeLayer()
        innershapeLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width - offset * 2, height: bounds.size.height - offset * 2)
        radiusCenter = CGPoint(x: innershapeLayer.frame.size.width / 2, y: innershapeLayer.frame.size.height / 2)
        innershapeLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        radius = (innershapeLayer.bounds.size.width - offset) / 2
        
        let path = UIBezierPath()
        path.move(to: radiusCenter)
        path.addArc(withCenter: radiusCenter, radius: radius, startAngle: 0, endAngle: 0, clockwise: true)
        path.addLine(to: radiusCenter)
        
        innershapeLayer.path = path.cgPath
        innershapeLayer.strokeColor = UIColor.clear.cgColor
        innershapeLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(innershapeLayer)
    }
}
