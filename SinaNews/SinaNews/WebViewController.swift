//
//  WebViewController.swift
//  SinaNews
//
//  Created by Chris on 14/12/16.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

import Foundation
import UIKit
import Social


class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var webView2: UIWebView?
    var prefixURL = "http://qingbin.sinaapp.com/api/html/"
    var newsId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = prefixURL + newsId + ".html"
        
        // method 1: use the storyboard to add the webview
        loadWebView(url)
        
        // method 2: use the code to add the webview
//        webView2 = UIWebView()
//        webView2!.frame = self.view.frame
//        webView2!.backgroundColor = UIColor.grayColor()
//        self.view.addSubview(webView2!)
//        var urlRequest = NSURLRequest(URL: NSURL(string: url)!)
//        webView2!.loadRequest(urlRequest)
    }
    
    func loadWebView(url: String) {
        println("loadWebView: \(url)")
        webView.frame = self.view.frame
        webView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(webView)
        
        var urlRequest = NSURLRequest(URL: NSURL(string: url)!)
        webView.loadRequest(urlRequest)
    
    }
    
    @IBAction func shareTapped(sender: UIBarButtonItem) {
        var controller: SLComposeViewController = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        controller.setInitialText("分享的内容 + 链接")
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}