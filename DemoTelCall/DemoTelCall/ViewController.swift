//
//  ViewController.swift
//  DemoTelCall
//
//  Created by zj－db0465 on 15/10/10.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.call10086()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.call10086()
    }
    
    func call10086() {
        let number: String = "10086"
        let url: NSURL = NSURL(string: "tel://\(number)")!
        // let url: NSURL = NSURL(string: "telprompt://\(number)")!
        if (UIApplication.sharedApplication().canOpenURL(url)) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}

