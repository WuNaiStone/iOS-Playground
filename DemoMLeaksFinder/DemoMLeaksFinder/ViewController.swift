//
//  ViewController.swift
//  DemoMLeaksFinder
//
//  Created by Chris Hu on 16/12/30.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        let btnTest = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        view.addSubview(btnTest)
        btnTest.center = view.center
        btnTest.setTitle("Test", for: .normal)
        btnTest.addTarget(self, action: #selector(ViewController.actionBtnTest), for: .touchUpInside)
    }

    func actionBtnTest() {
        let aVC = AViewController()
        present(aVC, animated: true, completion: nil)
    }
    
}

