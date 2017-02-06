//
//  CustomLoading2.swift
//  DemoCustomHUD
//
//  Created by Chris Hu on 17/2/6.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import Foundation

class CustomLoading2 {
    
    private static var imageView: UIImageView!
    private static var maskView: UIView!
    
    private static var displayLink: CADisplayLink!

    private static var rotationAngle: CGFloat = 0.0
    
    class func start() {
        guard let image = UIImage(named: "1.png") else { return }
        
        if maskView == nil {
            guard let keyWindow = UIApplication.shared.keyWindow else { return }
            DispatchQueue.main.async {
                maskView = UIView(frame: keyWindow.bounds)
                maskView.backgroundColor = UIColor(hexString: 0x0, alpha: 0.4)
                keyWindow.addSubview(maskView)
            }
        }
        
        if imageView == nil {
            DispatchQueue.main.async {
                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width / 2, height: image.size.height / 2))
                imageView.image = image
                self.maskView.addSubview(self.imageView)
                self.imageView.center = self.maskView.center
            }
        }
        
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(updateAction))
            displayLink.add(to: RunLoop.current, forMode: .commonModes)
        }
        
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    @objc private class func updateAction() {
        rotationAngle += 0.075
        let transform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
        imageView.layer.transform = transform
    }
    
    class func stop() {
        displayLink.invalidate()
        displayLink = nil
        rotationAngle = 0
        
        imageView.removeFromSuperview()
        imageView = nil
        maskView.removeFromSuperview()
        maskView = nil
        
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
