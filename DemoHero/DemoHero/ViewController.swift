//
//  ViewController.swift
//  DemoHero
//
//  Created by Chris Hu on 17/1/4.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let urlString = "http://httpbin.org/image/jpeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: self.urlString)
        ImagePrefetcher(resources: [url!]).start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let url = URL(string: self.urlString)
        self.imageView.kf.setImage(with: url)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

