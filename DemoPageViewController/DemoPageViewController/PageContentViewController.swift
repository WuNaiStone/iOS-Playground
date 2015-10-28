//
//  PageContentViewController.swift
//  DemoPageViewController
//
//  Created by zj－db0465 on 15/10/28.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    var pageIndex: Int!
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pageTitle.text = "Page \(pageIndex) Title"
        pageContent.text = "Page \(pageIndex) Content"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
