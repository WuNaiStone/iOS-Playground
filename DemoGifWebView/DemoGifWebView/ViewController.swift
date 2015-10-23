//
//  ViewController.swift
//  DemoGifWebView
//
//  Created by zj－db0465 on 15/10/23.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gifPath: String = NSBundle.mainBundle().pathForResource("railway", ofType: "gif")!
        let gifData: NSData = NSData(contentsOfFile: gifPath)!
        
        let webView = UIWebView(frame: self.view.frame)
        webView.loadData(gifData, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webView.userInteractionEnabled = false
        self.view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

