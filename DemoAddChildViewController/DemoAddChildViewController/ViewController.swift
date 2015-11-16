//
//  ViewController.swift
//  DemoAddChildViewController
//
//  Created by zj－db0465 on 15/11/11.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.label = UILabel(frame: CGRectMake(0, 200, self.view.frame.size.width, 50))
        self.label.textAlignment = NSTextAlignment.Center
        self.label.text = "ViewController"
        self.view.addSubview(self.label)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        sleep(2)
        
        let welcomeVC = WelcomeViewController()
        welcomeVC.view.backgroundColor = UIColor.whiteColor()
        
        let shouldPresentWelcomeVC: Bool = false
        if (shouldPresentWelcomeVC) {
            welcomeVC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            self.presentViewController(welcomeVC, animated: true, completion: nil)
        } else {
            self.view.addSubview(welcomeVC.view)
            self.addChildViewController(welcomeVC)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

