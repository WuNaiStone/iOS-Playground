//
//  ViewController.swift
//  DemoLayout
//
//  Created by zj－db0465 on 15/10/12.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var v: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.demoLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func demoLayout() {
        v = UIView(frame: CGRectMake(0, 0, 100, 100))
        v.backgroundColor = UIColor.redColor()
        self.view.addSubview(v)
        
        let btn: UIButton = UIButton(frame: CGRectMake(0, 200, self.view.frame.width, 50))
        btn.setTitle("center the red square", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.redColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: "actionBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func actionBtnClicked() {
        v.center = self.view.center
    }
}

