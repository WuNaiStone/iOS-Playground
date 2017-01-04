//
//  AViewController.swift
//  DemoHero
//
//  Created by Chris Hu on 17/1/4.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import Hero
import Kingfisher

class AViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let urlString = "http://httpbin.org/image/jpeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cache = KingfisherManager.shared.cache
        
        print(cache.isImageCached(forKey: urlString))
        
        let url = URL(string: self.urlString)
        imageView.kf.setImage(with: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionBtnBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
