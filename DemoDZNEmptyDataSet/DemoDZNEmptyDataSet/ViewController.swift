//
//  ViewController.swift
//  DemoDZNEmptyDataSet
//
//  Created by Chris Hu on 16/12/6.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class ViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView = UITableView(frame: view.frame, style: .plain)
        view.addSubview(tableView)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.backgroundColor = UIColor.red
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "None.png")
    }
}

extension ViewController: DZNEmptyDataSetDelegate {

}
