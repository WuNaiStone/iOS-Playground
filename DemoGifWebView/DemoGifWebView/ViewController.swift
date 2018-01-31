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
        
        
        let vFilter: UIView = UIView(frame: CGRect(x: 0, y: 44, width: self.view.frame.width, height: self.view.frame.height - 44))
        vFilter.backgroundColor = UIColor.black
        vFilter.alpha = 0.05
        self.view.addSubview(vFilter)
        self.webView = UIWebView(frame: vFilter.frame)
        self.view.addSubview(self.webView)
        
//        self.loadHTML()
//        self.loadURL(url: "https://www.baidu.com")
        self.loadGif()
    }
    
    func loadHTML() {
        self.webView.loadHTMLString("<html><body><p>this is baidu!</p></body></html>", baseURL: URL(string: "https://www.baidu.com"))
    }
    
    func loadGif() {
        guard let gifPath: String = Bundle.main.path(forResource: "demo", ofType: "gif") else {
            return
        }
        
        guard let gifData: Data = try! Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            return
        }

        self.webView.load(gifData, mimeType: "image/gif", textEncodingName: "UTF-8", baseURL: URL(string: "https://www.baidu.com")!)
    }
    
    func loadURL(url: String) {
        self.webView.loadRequest(URLRequest(url: URL(string: url)!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("\(self.webView) : \(#function)")
        
        return true
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        print("\(self.webView) : \(#function)")
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        print("\(self.webView) : \(#function)")
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("\(self.webView) : \(#function)")
    }
}

