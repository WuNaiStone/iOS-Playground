//
//  DemoFileViewController.swift
//  DemoDataPersistence
//
//  Created by Chris Hu on 16/6/12.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class DemoFileViewController: DemoBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoPath: String = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") as String!
        print("infoPath : \(infoPath)")
        let infos: NSMutableDictionary = NSMutableDictionary(contentsOfFile: infoPath) as NSMutableDictionary!
        print("infos : \(infos)")
    }
}
