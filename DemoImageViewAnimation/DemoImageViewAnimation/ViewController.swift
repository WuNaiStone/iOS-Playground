//
//  ViewController.swift
//  DemoImageViewAnimation
//
//  Created by zj－db0465 on 15/10/27.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.imageViewAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imageViewAnimation() {
        var images: Array = Array<UIImage>()
        for var i in 1...10 {
            images.append(UIImage(named: "\(i).jpg")!)
        }
        images = images.reverse()
        imageView.animationImages = images
        imageView.animationRepeatCount = 0
        imageView.animationDuration = 10
        imageView.startAnimating()
    }
}

