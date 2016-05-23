//
//  ViewController.swift
//  DemoTestCarrier
//
//  Created by icetime17 on 15/10/16.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit
import CoreTelephony

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn: UIButton = UIButton(frame: CGRectMake(0, 100, self.view.frame.width, 50))
        btn.setTitle("Test Carrier", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.blueColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: "actionTestCarrier", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func actionTestCarrier() {
        var info: CTTelephonyNetworkInfo = CTTelephonyNetworkInfo()
        print(info)
        var carrier: CTCarrier = info.subscriberCellularProvider!
        print(carrier)
        print(info.currentRadioAccessTechnology!)
        print(carrier.carrierName!)
        print(carrier.mobileCountryCode!)
        print(carrier.mobileNetworkCode!)
    }
}

