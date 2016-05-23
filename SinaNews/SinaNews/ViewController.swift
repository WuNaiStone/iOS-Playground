//
//  ViewController.swift
//  SinaNews
//
//  Created by Chris on 14/12/15.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    HttpProtocol {
    
    @IBOutlet weak var dataTV: UITableView!
    var refreshCtl = UIRefreshControl()
    
    var dataSource = NSMutableArray()
    var thumbQueue = NSOperationQueue()
    let newsApi = "http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo=1&pagePer=10&list.htm"
    
    var imageCache = Dictionary<String, UIImage>()
    var httpCtl: HttpController = HttpController()
    var selectedUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshCtl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshCtl.addTarget(self, action: "refreshDateSource", forControlEvents: UIControlEvents.ValueChanged)
        dataTV.addSubview(refreshCtl)
        
        httpCtl.delegate = self
        refreshDateSource()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "default")
        let rowData = dataSource[indexPath.row] as NewsItem
        cell.textLabel?.text = rowData.newsTitle
        cell.imageView?.image = UIImage(named: "default.jpg")
        
        // 图片缓存到imageCache数组中.
        let url = rowData.newsThumb as String
        let image = imageCache[url] as UIImage!
        if image == nil {
            let imgURL: NSURL = NSURL(string: url)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var img = UIImage(data: data)
                cell.imageView?.image = img
                self.imageCache[url] = img
            })
        } else {
            cell.imageView?.image = image
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var data = dataSource[indexPath.row] as NewsItem
        selectedUrl = data.newsId
        
        // method 1: use the storyboard to add the webview
        self.performSegueWithIdentifier("web", sender: self)
        
        // method 2: use the code to add the webview
//        var webView2 = WebViewController()
//        webView2.newsId = data.newsId
//        self.navigationController?.pushViewController(webView2, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "web" {
//            println("prepareForSegue")
            var vc = segue.destinationViewController as WebViewController
            vc.newsId = selectedUrl!
        }
    }
    
    func refreshDateSource() {
        refreshCtl.beginRefreshing()
        httpCtl.onHttpRequest(newsApi)
        refreshCtl.endRefreshing()
    }
    
    func parseReceiveResults(json: NSDictionary) {
        let rawNewsDataSource = json["item"] as NSArray
        var newsDataSource = NSMutableArray()
        for rawNews in rawNewsDataSource {
            let news: NewsItem = NewsItem()
            news.newsTitle = rawNews["title"] as String
            news.newsThumb = rawNews["thumb"] as String
            news.newsId = rawNews["id"] as String
            newsDataSource.addObject(news)
    //                println("\(news.newsTitle), \(news.newsThumb), \(news.newsId)")
        }
        // 在闭包中一定要加上self
        dataSource = newsDataSource
        dataTV.reloadData()
    }
}





















