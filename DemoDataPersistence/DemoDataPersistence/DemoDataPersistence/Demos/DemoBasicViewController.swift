//
//  DemoBasicViewController.swift
//  DemoDataPersistence
//
//  Created by Chris Hu on 16/6/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class DemoBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.addBtns()
    }

    func addBtns() {
        let btn = UIButton(frame: CGRectMake(0, 20, 60, 30))
        btn.setTitle("Close", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.redColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(DemoBasicViewController.actionBack(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func actionBack(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
