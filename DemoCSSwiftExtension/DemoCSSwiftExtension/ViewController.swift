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
        
        print("abc123".cs_intValue!)
        print("abc123".cs_stringValue!)
        
        "hello".cs_length
        var array = ["a", "b", "c", "a"]
        array.cs_removeDuplicates()
        " hello ".cs_trimmed
        "hello".cs_utf8String
        
        testBlurImageView()
        testAnotherImageView()
    }
    
    private func testBlurImageView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500), blurEffectStyle: .light)
        imageView.backgroundColor = UIColor(hexString: 0x123456, alpha: 0.5)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.image = UIImage(named: "Model.jpg")
    }
    
    private func testAnotherImageView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        imageView.backgroundColor = UIColor(hexString: 0x123456, alpha: 0.5)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.center = view.center
        imageView.image = UIImage(named: "Model.jpg")?.cs_imageMirrored
        imageView.alpha = 0.5
    }

}

