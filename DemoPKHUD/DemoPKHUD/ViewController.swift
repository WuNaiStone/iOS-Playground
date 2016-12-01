//
//  ViewController.swift
//  DemoPKHUD
//
//  Created by Chris Hu on 16/11/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {

    var myProgressHUD: MyProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        
        let btn = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 30))
        view.addSubview(btn)
        
        btn.setTitle("Toast", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: .actionBtn, for: .touchUpInside)
        
        
        let slider = UISlider(frame: CGRect(x: 50, y: 300, width: 300, height: 30))
        view.addSubview(slider)
        slider.addTarget(self, action: .actionSlider, for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}

private extension Selector {
    static let actionBtn = #selector(ViewController.actionBtn(_:))
    static let actionSlider = #selector(ViewController.actionSlider(_:))
}

extension ViewController {
    func actionBtn(_ sender: UIButton) {
        
        /*
        HUD.flash(.label("稍等"), delay: 1.0) { finished in
            // Completion Handler
            print("label")
        }
        */
        
        /*
        HUD.flash(.success, delay: 1.0) { finished in
            // Completion Handler
            print("success")
        }
        */
        
        /*
        HUD.flash(.error, delay: 1.0) { (finished) in
            // Completion Handler
            print("error")
        }
        */
        
        /*
        HUD.flash(.progress, delay: 2.0) { (finished) in
            // Completion Handler
            print("progress")
        }
        */
        
        
//        MyCustomHUD.toastWithText("单行Tip")
//        MyCustomHUD.toastWithLongText("多行Tip\n多行Tip")
//        MyCustomHUD.toastWithLongText("016-11-29 14:13:39.333449 DemoPKHUD[70557:21873862] subsystem: com.apple.UIKit, category: Touch, enable_level: 0, persist_level: 0, default_ttl: 1, info_ttl: 0, debug_ttl: 0, generate_symptoms: 0, enable_oversize: 1, privacy_setting: 2, enable_private_data: 0")
  
        
//        MyCustomHUD.execute({
//            print("1")
//            sleep(5)
//            print("2")
//            }, executionText: "Loading", finishText: nil)
        
        
//        MyCustomHUD.execute({
//            print("1")
//            sleep(5)
//            print("2")
//            }, executionText: "Loading", finishText: "Finished")
        
        
//        MyCustomHUD.execute({
//            print("1")
//            sleep(5)
//            print("2")
//            }, executionText: "Loading", finishLongText: "tegory: Touch, enable_level: 0, persist_level: 0, default_ttl")
        
    }
}

extension ViewController {
    func actionSlider(_ sender: UISlider) {
        if myProgressHUD == nil {
            myProgressHUD = MyProgressHUD(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
//            myProgressHUD = MyProgressHUD(frame: CGRect(x: 200, y: 200, width: 100, height: 100), isRemovedAfterFinish: false)
            view.addSubview(myProgressHUD)
        }
        
        myProgressHUD.progressValue = sender.value
    }
}
