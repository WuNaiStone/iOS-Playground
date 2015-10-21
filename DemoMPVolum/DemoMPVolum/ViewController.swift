//
//  ViewController.swift
//  DemoMPVolum
//
//  Created by zj－db0465 on 15/10/14.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    var mpVolumeView: MPVolumeView!
    var volumeSlider: UISlider!
    var volumeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn: UIButton = UIButton(frame: CGRectMake(0, 200, self.view.frame.width, 50))
        btn.setTitle("Volume View", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.redColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: Selector("actionVolumPlus"), forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionVolumPlus() {
        if (mpVolumeView == nil) {
            volumeLabel = UILabel(frame: CGRectMake(0, 100, self.view.frame.width, 30))
            volumeLabel.textAlignment = NSTextAlignment.Center
            self.view.addSubview(volumeLabel)
            
            mpVolumeView = MPVolumeView(frame: CGRectMake(20, 150, self.view.frame.width - 40, 30))
            self.view.addSubview(mpVolumeView)
            
            for var view: UIView in mpVolumeView.subviews {
                if (NSStringFromClass(view.classForCoder) == "MPVolumeSlider") {
                    volumeSlider = view as! UISlider;
                    volumeSlider.sendActionsForControlEvents(.TouchUpInside)
                    
                    volumeLabel.text = "\(volumeSlider.value)"
                }
            }
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("volumeChanged:"), name: "AVSystemController_SystemVolumeDidChangeNotification", object: nil)
        }
    }
    
    func volumeChanged(notification: NSNotification) {
        print(notification)
        var userInfo: Dictionary = notification.userInfo! as Dictionary
        print(userInfo)
        print(userInfo.keys)
        print(userInfo.values)
    }
}

