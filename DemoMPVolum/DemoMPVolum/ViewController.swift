//
//  ViewController.swift
//  DemoMPVolum
//
//  Created by Chris Hu on 15/10/14.
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
        
        let btn: UIButton = UIButton(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 50))
        btn.setTitle("Volume View", for: UIControlState())
        btn.setTitleColor(UIColor.blue, for: UIControlState())
        btn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: #selector(ViewController.actionVolumPlus), for: UIControlEvents.touchUpInside);
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionVolumPlus() {
        if AVAudioSession.sharedInstance().isOtherAudioPlaying {
            do {
                try AVAudioSession.sharedInstance().setActive(false)
            } catch {
            }
        } else {
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
            }
        }

        if (mpVolumeView == nil) {
            volumeLabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 30))
            volumeLabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(volumeLabel)
            
            mpVolumeView = MPVolumeView(frame: CGRect(x: 20, y: 150, width: self.view.frame.width - 40, height: 30))
            self.view.addSubview(mpVolumeView)
            
            for view: UIView in mpVolumeView.subviews {
                if (NSStringFromClass(view.classForCoder) == "MPVolumeSlider") {
                    volumeSlider = view as! UISlider;
                    volumeSlider.sendActions(for: .touchUpInside)
                    volumeSlider.addTarget(self, action: #selector(ViewController.actionSliderChanged(_:)), for: UIControlEvents.allTouchEvents)
                    
                    volumeLabel.text = "\(volumeSlider.value)"
                }
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.volumeChanged(_:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        }
    }
    
    func actionSliderChanged(_ sender: UISlider) {
        volumeLabel.text = "\(volumeSlider.value)"
    }
    
    func volumeChanged(_ notification: Notification) {
        print(notification)
        let userInfo: Dictionary = notification.userInfo! as Dictionary
        print(userInfo)
        print(userInfo.keys)
        print(userInfo.values)
    }
}

