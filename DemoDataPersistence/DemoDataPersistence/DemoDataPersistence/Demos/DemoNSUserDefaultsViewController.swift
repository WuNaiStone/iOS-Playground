//
//  DemoNSUserDefaultsViewController.swift
//  DemoDataPersistence
//
//  Created by Chris Hu on 16/6/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class DemoNSUserDefaultsViewController: DemoBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRectMake(0, 200, self.view.frame.size.width, 50))
        label.textAlignment = NSTextAlignment.Center
        label.text = "Please check the Console log..."
        self.view.addSubview(label)
        
        self.demoNSUserDefaults()
    }

    func demoNSUserDefaults() {
        let key1 = "MyUserDefaultsKey_BOOL"
        
        let value11 = NSUserDefaults.standardUserDefaults().boolForKey(key1)
        print(value11)
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: key1)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let value12: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey(key1)!
        print(value12)
        
        
        
        let key2 = "MyUserDefaultsKey_String"
        
        let value21 = NSUserDefaults.standardUserDefaults().valueForKey(key2)
        print(value21)
        
        NSUserDefaults.standardUserDefaults().setValue("MyUserDefaultsKey_String", forKey: key2)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let value22: AnyObject = NSUserDefaults.standardUserDefaults().valueForKey(key2)!
        print(value22)
    }
}
