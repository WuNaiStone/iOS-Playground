//
//  HttpController.swift
//  DBFM
//
//  Created by Chris Hu on 14-7-26.
//  Copyright (c) 2014年 edu.self. All rights reserved.
//

import UIKit

//此处声明一个方法，在ViewController.swift会定义其实体。
protocol HttpProtocol {
    
    func didReceiveResults(results: NSDictionary)

}

class HttpController: NSObject {
    var delegate: HttpProtocol?
    
    //在ViewController.swift中会调用onRequest，起一个异步的NSURLConnection，
    //该异步NSURLConnection中会获取json数据，然后调用didReceiveResults方法。
    //而该didReceiveResults方法是在ViewController.swift中定义的，即属于ViewController.swift。HttpController的对象不能调用。
    //所以，只能通过deledate的方式，delegate?即为ViewController.swift,可以调用didReceiveResults方法。
    //那如果不采用delegate呢？将didReceiveResults的函数实体直接放到HttpController.swift中也可以。
    //但didReceiveResults 方法接收的参数是 onRequest 生成的.且我们获取到的数据要直接往 ViewController 中填充会比较方便.
    //所以使用 delegate 方便.
    func onRequest(url: String){
        println("HttpController : onRequest : \(url)")
        var request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
            completionHandler:{(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            self.delegate?.didReceiveResults(jsonResult)
//            self.didReceiveResults2(jsonResult)
            })
    }

/*
    func didReceiveResults2(results:NSDictionary){
        println("didReceiveResults2")
        println(results)
    }
*/
    
}

