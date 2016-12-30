//
//  ViewController.swift
//  DemoSwifterSwift
//
//  Created by Chris Hu on 16/12/30.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit
import SwifterSwift
import CSSwiftExtension


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        var array = [1,2,3,1,3]
        array.removeDuplicates()
        print(array)
        
        let strArr = "hello world".splited(by: " ")
        print(strArr)
        
        let strTrimed = " hello world ".cs_trim()
        print(strTrimed!)
    }

}

