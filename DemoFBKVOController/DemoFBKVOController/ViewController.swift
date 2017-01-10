//
//  ViewController.swift
//  DemoFBKVOController
//
//  Created by Chris Hu on 17/1/10.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBAction func actionSliderValueChanged(_ sender: UISlider) {
        myObject.value = sender.value
    }
    
    var myObject: MyObject!
    
    private var myContext = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myObject = MyObject()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myObject.addObserver(self, forKeyPath: "value", options: [.new, .old], context: &myContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let change = change, context == &myContext {
            print("observeValue")
            print(change)
            let a = change[NSKeyValueChangeKey.newKey]
            print(a)
        }
    }
    
}

