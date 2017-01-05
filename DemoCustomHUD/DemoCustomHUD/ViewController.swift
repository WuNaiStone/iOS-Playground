//
//  ViewController.swift
//  DemoCustomHUD
//
//  Created by Chris Hu on 17/1/5.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnTest = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        btnTest.center = view.center
        btnTest.backgroundColor = UIColor.gray
        btnTest.setTitleColor(UIColor.white, for: .normal)
        btnTest.setTitle("Loading", for: .normal)
        view.addSubview(btnTest)
        
        btnTest.addTarget(self, action: #selector(ViewController.actionBtnTest), for: .touchUpInside)
    }
    
    func actionBtnTest() {
        CustomLoading.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { 
            CustomLoading.stop()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

