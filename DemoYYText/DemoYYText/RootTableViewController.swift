//
//  RootTableViewController.swift
//  DemoYYText
//
//  Created by zj－db0465 on 15/11/16.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class RootTableViewController: UITableViewController {

    var examples = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "YYText Examples"
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ReuseCellIdentifier")
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.examples = [
            "Markdown",
            "Attribute",
            "Tag",
            "",
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - TableView related

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examples.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReuseCellIdentifier", forIndexPath: indexPath)

        cell.textLabel?.text = self.examples[indexPath.row] as? String

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var exampleVC: UIViewController!
        
        switch indexPath.row {
        case 0:
            exampleVC = MarkDownExampleViewController()
            break;
        default:
            exampleVC = AttributeExampleViewController()
            break
        }
        
        self.navigationController?.pushViewController(exampleVC, animated: true)
    }

}
