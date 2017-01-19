//
//  ViewController.swift
//  DemoShimmer
//
//  Created by Chris Hu on 15/11/16.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let shimmerView = FBShimmeringView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        shimmerView.center = self.view.center
        self.view.addSubview(shimmerView)
        shimmerView.backgroundColor = UIColor.black
        shimmerView.isShimmering = true
        
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 50))
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.text = ">>>  Slide to unlock"
        shimmerView.contentView = label
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.unlock(_:)))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.right
        shimmerView.addGestureRecognizer(swipeGesture)
    }
    
    func unlock(_ sender: UISwipeGestureRecognizer) {
        print(sender)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

