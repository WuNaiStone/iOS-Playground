//
//  ViewController.swift
//  DemoCornerRadius
//
//  Created by zj－db0465 on 16/3/3.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!
    var btn: UIButton!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.btn = UIButton(frame: CGRectMake(50, self.view.frame.size.height - 100, self.view.frame.size.width - 100, 50))
        self.btn.setTitle("Demo", forState: UIControlState.Normal)
        self.btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        self.btn.layer.borderColor = UIColor.redColor().CGColor
        self.btn.layer.cornerRadius = 5.0
        self.btn.layer.borderWidth = 2.0
        self.btn.addTarget(self, action: Selector("actionBtn"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.btn)
        
        
        self.label = UILabel(frame: CGRectMake(50, self.view.frame.size.height - 200, self.view.frame.size.width - 100, 50))
        self.label.backgroundColor = UIColor.grayColor()
        self.label.textAlignment = NSTextAlignment.Center
        self.label.layer.cornerRadius = 5.0
        /**
         cornerRadius默认只会影响到View的背景颜色和border
         UILabel/UIImageView这样内部还有子视图的不行，要设置masksToBounds属性为true
        */
        self.label.layer.masksToBounds = true
        self.label.text = "label"
        self.view.addSubview(self.label)

        
        self.imageView = UIImageView(frame: CGRectMake(100, 50, self.view.frame.size.width - 200, 200))
        self.imageView.image = UIImage(named: "Model.png")
        self.imageView.layer.cornerRadius = 10.0
        self.imageView.layer.masksToBounds = true
        self.view.addSubview(self.imageView)
    }

    func actionBtn(sender: UIButton) {
    
    }
    
}

