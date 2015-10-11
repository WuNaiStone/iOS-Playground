//
//  ViewController.swift
//  DemoNSTimer
//
//  Created by zj－db0465 on 15/10/11.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var btn: UIButton!
    var lb: UILabel!
    
    var timer: NSTimer!
    let countTimer: Int = 5
    var countdown: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btn = UIButton(frame: CGRectMake(0, 500, self.view.frame.width, 50))
        btn.setTitle("demoNSTimer", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.blueColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: "demoNSTimer", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        lb = UILabel(frame: CGRectMake(self.view.frame.width / 2 - 100, 100, 200, 200))
        lb.textAlignment = NSTextAlignment.Center
        lb.font = UIFont.systemFontOfSize(70.0)
        lb.textColor = UIColor.grayColor()
        lb.text = "\(countTimer)"
        self.view.addSubview(lb)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func demoNSTimer() {
        btn.userInteractionEnabled = !btn.userInteractionEnabled
        countdown = countTimer
        if (timer != nil) {
            timer.invalidate()
            timer = nil
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "actionNSTimer", userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func actionNSTimer() {
        if (countdown < 1) {
            if (timer != nil) {
                countdown = countTimer
                timer.invalidate()
                timer = nil
                lb.text = "\(countdown)"
                lb.alpha = 1.0
            }
            return;
        }
        lb.text = "\(countdown)"
        lb.transform = CGAffineTransformMakeScale(1.0, 1.0)
        lb.alpha = 1.0
        countdown = countdown - 1
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.lb.transform = CGAffineTransformMakeScale(2.0, 2.0)
            self.lb.alpha = 0.0
            }) { (Bool) -> Void in
                if (self.countdown == 0) {
                    self.btn.userInteractionEnabled = true
                }
        }
    }
}

