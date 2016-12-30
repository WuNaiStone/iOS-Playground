//
//  AViewController.swift
//  DemoMLeaksFinder
//
//  Created by Chris Hu on 16/12/30.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        let btnTest = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        view.addSubview(btnTest)
        btnTest.center = view.center
        btnTest.setTitle("Timer", for: .normal)
        btnTest.addTarget(self, action: #selector(AViewController.actionBtnTest), for: .touchUpInside)
        
        let btnBack = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 30))
        view.addSubview(btnBack)
        btnBack.setTitle("Back", for: .normal)
        btnBack.addTarget(self, action: #selector(AViewController.actionBtnBack), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 如果不释放timer，则会触发Memory警告
        timer.invalidate()
        timer = nil
    }
    
    func actionBtnTest() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AViewController.actionTimer), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func actionBtnBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func actionTimer() {
        print("timer running")
    }
    
}
