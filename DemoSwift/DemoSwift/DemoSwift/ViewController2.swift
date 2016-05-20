//
//  ViewController2.swift
//  DemoSwift
//
//  Created by zj－db0465 on 15/11/17.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

typealias MyIntroduce = (String, Int) -> Void

class ViewController2: UIViewController {
    
    var myIntroduce: MyIntroduce!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
        
        let btn = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50))
        btn.setTitle("Go back to ViewController", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.redColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: Selector("actionButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func actionButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.myIntroduce("ViewController2", 2)
        }
    }

}
