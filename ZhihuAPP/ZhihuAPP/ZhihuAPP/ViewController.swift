//
//  ViewController.swift
//  ZhihuAPP
//
//  Created by Chris on 14/12/25.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    HttpProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var newsList = "http://news-at.zhihu.com/api/3/news/latest"
    var dataSource = NSMutableArray()
    var httpCtl: HttpController = HttpController()
    var selectedStoryItem: StoryItem!
    
    var imageCaches = Dictionary<String, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        httpCtl.delegate = self
        httpCtl.onHttpRequest(newsList)
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
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "myCell")
        let rowData = dataSource[indexPath.row] as StoryItem
        cell.textLabel?.text = rowData.title
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.imageView?.image = UIImage(named: "default.jpg")
        
        // 缓存图片
        let imageUrl = rowData.image as String
        let image = imageCaches[imageUrl] as UIImage!
        if image == nil {
            let request = NSURLRequest(URL: NSURL(string: imageUrl)!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                    var img = UIImage(data: data)
                    cell.imageView?.image = img
                    self.imageCaches[imageUrl] = img
            })
        } else {
            cell.imageView?.image = image
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedStoryItem = dataSource[indexPath.row] as StoryItem
        self.performSegueWithIdentifier("detail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            var detailVC = segue.destinationViewController as DetailViewController
            detailVC.selectedStoryItem = selectedStoryItem
            detailVC.imageCache = imageCaches[selectedStoryItem.image]
        }
    }
    
    func parseReceiveResults(json: NSDictionary) {
        let rawTopStoriesDataSource = json["top_stories"] as NSArray
        let rawStoriesDataSource = json["stories"] as NSArray
        var rawDataSource = NSMutableArray()
        
        for rawTopStory in rawTopStoriesDataSource {
            let story: StoryItem  = StoryItem()
            story.title = rawTopStory["title"] as String
            story.ga_prefix = rawTopStory["ga_prefix"] as String
            story.image = rawTopStory["image"] as String
            story.type = rawTopStory["type"] as Int
            story.id = rawTopStory["id"] as Int
            rawDataSource.addObject(story)
        }
        
        for rawStory in rawStoriesDataSource {
            let story: StoryItem  = StoryItem()
            story.title = rawStory["title"] as String
            story.ga_prefix = rawStory["ga_prefix"] as String
            let images = rawStory["images"] as NSArray
            story.image = images[0] as String
            story.type = rawStory["type"] as Int
            story.id = rawStory["id"] as Int
            rawDataSource.addObject(story)
        }
        
        dataSource = rawDataSource
        tableView.reloadData()
    }
    
}

