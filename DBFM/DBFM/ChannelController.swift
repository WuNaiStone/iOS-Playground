//
//  ChannelController.swift
//  DBFM
//
//  Created by Chris Hu on 14-7-22.
//  Copyright (c) 2014年 edu.self. All rights reserved.
//

//import Foundation
import UIKit
import QuartzCore

protocol ChannelProtocol{
    
    func onChangeChannel(channel: String)
    
}

class ChannelController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tv : UITableView!
    
    //由 ViewController 的 prepareForSegue 中传递进来 channels, delegate
    var channels: NSArray = NSArray()
    var delegate: ChannelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return channels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        //在该tableView里边添加Table View Cell的时候，会指定其Identifier
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:"channel")
        let rowData: NSDictionary = channels[indexPath.row] as! NSDictionary
        cell.textLabel?.text = rowData["name"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var rowData: NSDictionary = channels[indexPath.row] as! NSDictionary
        let channel_id: AnyObject = rowData["channel_id"] as AnyObject!
        let channel: String = "channel=\(channel_id)"
        delegate?.onChangeChannel(channel)

        //dismiss 该view，即回退至上一个view
        //因为,从主界面切换到 channel 界面,是采用 model 方式的 segue来实现的.
        //然后再切换回主界面要使用的,如果再次使用 model 方式的 segue 就会再次生成界面,则界面会越来越多.
        //最好采用 navigation controller 实现.
//        dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
}