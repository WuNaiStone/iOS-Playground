//
//  ViewController.swift
//  DemoCSSwiftExtension
//
//  Created by Chris Hu on 16/6/28.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

import CSSwiftExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("abc123".cs_intValue()!)
        print("abc123".cs_stringValue()!)
        
        CSNetworkManager.cs_GET("https://www.baidu.com") { (jsonObject) in
            print(jsonObject)
        }
        
        self.testUIButton()
    }

    func testUIButton() {
        let btn = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50))
        btn.setTitle("UIButton BackgroundColor", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.view.addSubview(btn)
        
        btn.backgroundColor = UIColor.greenColor()
        btn.cs_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        btn.cs_setBackgroundColor(UIColor.blueColor(), forState: .Highlighted)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

