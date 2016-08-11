//
//  ViewController.swift
//  DemoGifWebView
//
//  Created by Chris Hu on 15/10/23.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let vFilter: UIView = UIView(frame: CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.height - 44))
        vFilter.backgroundColor = UIColor.blackColor()
        vFilter.alpha = 0.05
        self.view.addSubview(vFilter)
        self.webView = UIWebView(frame: vFilter.frame)
        self.view.addSubview(self.webView)
        
//        self.loadHTML()
//        self.loadURL("http://www.baidu.com")
        self.loadGif()        
    }
    
    func loadHTML() {
        self.webView.loadHTMLString("<html><body><p>this is baidu!</p></body></html>", baseURL: NSURL(string: "http://www.baidu.com")!)
    }
    
    func loadGif() {
        let gifPath: String = NSBundle.mainBundle().pathForResource("demo", ofType: "gif")!
        let gifData: NSData = NSData(contentsOfFile: gifPath)!

        self.webView.loadData(gifData, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        self.webView.userInteractionEnabled = false
    }
    
    func loadURL(url: String) {
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidStartLoad(webView: UIWebView) {
        print("\(self.webView) : \(__FUNCTION__)")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("\(self.webView) : \(__FUNCTION__)")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("\(self.webView) : \(__FUNCTION__)")
        return true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("\(self.webView) : \(__FUNCTION__)")
    }
}

