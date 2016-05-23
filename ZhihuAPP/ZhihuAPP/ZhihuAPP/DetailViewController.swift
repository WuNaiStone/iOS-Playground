//
//  DetailViewController.swift
//  ZhihuAPP
//
//  Created by Chris on 14/12/25.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    var selectedStoryItem: StoryItem!
    var urlPrefix = "http://news-at.zhihu.com/api/3/news/"
    
    var imageCache: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDetailVC()
    }
    
    func updateDetailVC() {
        titleTextView.text = selectedStoryItem.title
        
        var contentUrl = "\(urlPrefix)\(selectedStoryItem.id)"
        var content = NSString(contentsOfURL: NSURL(string: contentUrl)!,
            encoding: NSUTF8StringEncoding, error: nil)!
        
        textField.text = content
        
        imageView.image = imageCache
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}