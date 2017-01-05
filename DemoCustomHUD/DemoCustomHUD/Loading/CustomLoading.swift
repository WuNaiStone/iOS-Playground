//
//  CustomLoading.swift
//  DemoCustomHUD
//
//  Created by Chris Hu on 17/1/5.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import Foundation

class CustomLoading {
    
    static var images: [UIImage]!
    static var imageView: UIImageView!
    static var maskView: UIView!
    
    class func start() {
        if images == nil { images = [UIImage]() }
        if images.isEmpty {
            for idx in 1...6 {
                images.append(UIImage(named: "\(idx).png")!)
            }
        }
        
        if maskView == nil {
            guard let keyWindow = UIApplication.shared.keyWindow else { return }
            maskView = UIView(frame: keyWindow.bounds)
            maskView.backgroundColor = UIColor(hexString: 0x0, alpha: 0.4)
            DispatchQueue.main.async {
                keyWindow.addSubview(maskView)
            }
        }
        
        if imageView == nil {
            guard let img = images.first else { return }
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: img.size.width / 2, height: img.size.height / 2))
            DispatchQueue.main.async {
                self.maskView.addSubview(self.imageView)
                self.imageView.center = self.maskView.center
            }
        }
        imageView.animationImages = images
        imageView.animationDuration = 2
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        imageView.startAnimating()
    }
    
    class func stop() {
        imageView.stopAnimating()
        images.removeAll()
        images = nil
        imageView.removeFromSuperview()
        imageView = nil
        maskView.removeFromSuperview()
        maskView = nil
        
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
