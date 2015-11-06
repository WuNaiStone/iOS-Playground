//
//  GesturesViewController.swift
//  DemoGestureRecognizer
//
//  Created by zj－db0465 on 15/11/4.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class GesturesViewController: UITableViewController {

    var gestures = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestures = ["UITapGestureRecognizer", "UIPinchGestureRecognizer",
                    "UISwipeGestureRecognizer", "UIPanGestureRecognizer",
                    "UIRotationGestureRecognizer", "UILongPressGestureRecognizer",
                    "UIScreenEdgePanGestureRecognizer", "CustomGestureRecognizer"
        ]
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gestures.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = gestures[indexPath.row]

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SegueGesture", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueGesture" {
            let itemVC = segue.destinationViewController as! ItemViewController
            let gesture = gestures[(self.tableView.indexPathForSelectedRow?.row)!]
            itemVC.title = gesture
        }
    }

}
