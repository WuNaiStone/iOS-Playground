//
//  ViewController.swift
//  DemoMotionScrollView
//
//  Created by Chris Hu on 17/1/16.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let motionScrollView = MotionScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), image: UIImage(named: "image.png")!)
        let motionScrollView = MotionScrollView(frame: view.bounds)
        view.addSubview(motionScrollView)
        motionScrollView.center = view.center
        
        motionScrollView.setupImage(UIImage(named: "image.png")!)
        motionScrollView.setMotionEnabled(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

