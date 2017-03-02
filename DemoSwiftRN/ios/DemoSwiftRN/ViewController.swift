//
//  ViewController.swift
//  DemoSwiftRN
//
//  Created by zj－db0465 on 17/3/2.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import React

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsCodeLocation:URL = URL.init(string: "http://localhost:8081/index.ios.bundle?platform=ios")!
        
        
        let rootView:RCTRootView = RCTRootView.init(bundleURL: jsCodeLocation, moduleName: "DemoSwiftRN", initialProperties: ["scores":[["name":"Alex","value":"42"],["name":"Joel","value":"10"]]], launchOptions: nil)
        self.view = rootView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

