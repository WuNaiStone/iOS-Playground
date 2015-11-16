//
//  WelcomeViewController.swift
//  DemoAddChildViewController
//
//  Created by zj－db0465 on 15/11/11.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.label = UILabel(frame: CGRectMake(0, 200, self.view.frame.size.width, 50))
        self.label.textAlignment = NSTextAlignment.Center
        self.label.text = "Welcome ViewController"
        self.view.addSubview(self.label)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
