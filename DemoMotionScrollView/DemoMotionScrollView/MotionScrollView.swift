//
//  MotionScrollView.swift
//  DemoMotionScrollView
//
//  Created by Chris Hu on 17/1/16.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import CoreMotion


class MotionScrollView: UIScrollView {

    fileprivate var motionEnabled = false
    fileprivate var motionManager: CMMotionManager!
    
    
    fileprivate var image: UIImage!
    fileprivate var imageView: UIImageView!
    
    
    fileprivate var motionRate: CGFloat!
    fileprivate var minimumOffset: CGFloat!
    fileprivate var maximumOffset: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        
        commonInit()
        
        setupImage(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.red
        
        bounces = false
        showsHorizontalScrollIndicator = false
        contentOffset = CGPoint.zero
        delegate = self
        
        imageView = UIImageView()
        addSubview(imageView)
    }
    
    func setupImage(_ image: UIImage) {
        self.image = image
        
        let height = frame.height
        var width = image.size.width / image.size.height * height
        if width < frame.width {
            width = frame.width
        }
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        contentSize = imageView.frame.size
        
        initMotion()
    }
    
}


fileprivate let DTSMotionViewRotationMinimumTreshold: CGFloat = 0.1;
fileprivate let DTSMotionGyroUpdateInterval: CGFloat = 1 / 100;
fileprivate let DTSMotionViewRotationFactor: CGFloat = 4.0;

extension MotionScrollView {
    
    fileprivate func initMotion() {
        minimumOffset = 0.0
        maximumOffset = contentSize.width - frame.width
        let screenWidth = (UIScreen.main.currentMode?.size.width)!
        if maximumOffset > screenWidth + frame.width {
            maximumOffset = screenWidth + frame.width
        }
        
        motionRate = image.size.width / frame.width * DTSMotionViewRotationFactor
        
        motionEnabled = true
    }
    
    func setMotionEnabled(_ enabled: Bool) {
        motionEnabled = enabled
        
        if motionEnabled {
            startMonitoring()
        } else {
            stopMonitoring()
        }
    }
    
    fileprivate func startMonitoring() {
        if motionManager == nil {
            motionManager = CMMotionManager()
            motionManager.gyroUpdateInterval = TimeInterval(DTSMotionGyroUpdateInterval)
        }
        
        if motionManager.isGyroAvailable {
            motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: { (gyroData, error) in
                let rotationRate = gyroData?.rotationRate.y
                if fabs(rotationRate!) >= Double(DTSMotionViewRotationMinimumTreshold) {
                    var offsetX = self.contentOffset.x - CGFloat(rotationRate!) * self.motionRate
                    if offsetX > self.maximumOffset {
                        offsetX = self.maximumOffset
                    } else if offsetX < self.minimumOffset {
                        offsetX = self.minimumOffset
                    }
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseOut], animations: { 
                        self.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
                    }, completion: nil)
                }
            })
        } else {
            print("There is no available gyro yet.")
        }
    }
    
    fileprivate func stopMonitoring() {
        motionManager.stopGyroUpdates()
    }
}

extension MotionScrollView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
    
}


