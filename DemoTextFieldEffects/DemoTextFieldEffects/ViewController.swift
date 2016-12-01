//
//  ViewController.swift
//  DemoTextFieldEffects
//
//  Created by Chris Hu on 16/12/1.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField1 = MadokaTextField(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        view.addSubview(textField1)
        
        textField1.placeholderColor = UIColor.darkGray
        textField1.borderColor =  UIColor.green
        textField1.placeholder = "username"
        
        
        let textField2 = MadokaTextField(frame: CGRect(x: 50, y: 110, width: 200, height: 50))
        view.addSubview(textField2)
        
        textField2.placeholderColor = UIColor.darkGray
        textField2.borderColor =  UIColor.green
        textField2.placeholder = "passwd"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

