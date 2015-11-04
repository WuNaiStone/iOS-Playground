//
//  CustomGestureRecognizer.swift
//  DemoGestureRecognizer
//
//  Created by zj－db0465 on 15/11/4.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

// 添加一个从左上角滑到右下角的滑动手势
class CustomGestureRecognizer: UIGestureRecognizer {
    var leftTop = false
    var rightDown = false
    
    var offset: CGFloat = 30
    
    override init(target: AnyObject?, action: Selector) {
        super.init(target: target, action: action)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        var touch = touches.first! as UITouch
        var location = touch.locationInView(self.view)
        if (location.x < offset && location.y < offset) {
            leftTop = true
        }
        
        if ((location.x + offset) > self.view?.bounds.width && (location.y + offset) > self.view?.bounds.height) {
            rightDown = true
        }
        
        if (leftTop && rightDown) {
            self.state = UIGestureRecognizerState.Ended
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
    }
}
