//
//  ViewController.swift
//  DemoShimmer
//
//  Created by zj－db0465 on 15/11/16.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let shimmerView = FBShimmeringView(frame: self.view.frame)
        self.view.addSubview(shimmerView)
        shimmerView.backgroundColor = UIColor.darkGrayColor()
        shimmerView.shimmering = true
        
        let label = UILabel(frame: CGRectMake(0, 200, self.view.frame.size.width, 50))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = "Shimmering Label"
        shimmerView.contentView = label
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

