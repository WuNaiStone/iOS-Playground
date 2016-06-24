//
//  ViewController.swift
//  DemoDataPersistence
//
//  Created by Chris Hu on 16/3/18.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    var items = ["Plist and Sandbox files",
                 "NSUserDefaults",
                 "NSKeyedArchiver",
                 "CoreData",
                 "SQLite",
                 "FMDB",
                 "Realm",
                 "Keychain",
                 "iCloud"]
    
    let CellReuseIdentifier = "CellReuseIdentifier"
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: view.frame, style: .Plain)
        tableView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(tableView)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - UITableViewDataSource
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var vc: UIViewController!
        
        switch indexPath.row {
        case 0:
            vc = DemoFileViewController()
        default:
            vc = DemoNSUserDefaultsViewController()
        }
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}
