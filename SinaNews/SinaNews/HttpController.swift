//
//  HttpController.swift
//  SinaNews
//
//  Created by Chris on 14/12/15.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

import Foundation


protocol HttpProtocol {

    func parseReceiveResults(json: NSDictionary)
    
}

class HttpController: NSObject {
    var delegate: HttpProtocol?
    
    func onHttpRequest(url: String) {
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let jsonResults = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            //            println(json)
            self.delegate?.parseReceiveResults(jsonResults)
        })
    }

}
