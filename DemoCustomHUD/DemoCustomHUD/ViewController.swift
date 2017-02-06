//
//  ViewController.swift
//  DemoCustomHUD
//
//  Created by Chris Hu on 17/1/5.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: "1.png")
        imageView.center = view.center
        view.addSubview(imageView)
        
        let btnTest = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        btnTest.center = CGPoint(x: imageView.center.x, y: imageView.center.y + imageView.frame.height/2 + 100)
        btnTest.backgroundColor = UIColor.gray
        btnTest.setTitleColor(UIColor.white, for: .normal)
        btnTest.setTitle("Loading", for: .normal)
        view.addSubview(btnTest)
        
        btnTest.addTarget(self, action: #selector(ViewController.actionBtnTest), for: .touchUpInside)
    }
    
    func actionBtnTest() {
        CustomLoading2.start()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            CustomLoading2.stop()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

