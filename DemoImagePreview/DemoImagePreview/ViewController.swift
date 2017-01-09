//
//  ViewController.swift
//  DemoImagePreview
//
//  Created by Chris Hu on 17/1/9.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollview = MyZoomScrollView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        scrollview.center = view.center
        view.addSubview(scrollview)
        scrollview.image = UIImage(named: "Model.jpg")!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

