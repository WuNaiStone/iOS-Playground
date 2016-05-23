//
//  HttpController.swift
//  ZhihuAPP
//
//  Created by Chris on 14/12/25.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

import Foundation

protocol HttpProtocol {

    func parseReceiveResults(json: NSDictionary)
    
}

class HttpController: NSObject {

    var delegate: HttpProtocol?
    
    func onHttpRequest(url: String) {
        println("onHttpRequest : \(url)")
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!)
                -> Void in
                if error == nil {
                    let jsonResults = NSJSONSerialization.JSONObjectWithData(data,
                        options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//                    println(jsonResults)
                    self.delegate?.parseReceiveResults(jsonResults)
                } else {
                    println("onHttpRequest failed due to network issue")
                }
        })
    }
}
