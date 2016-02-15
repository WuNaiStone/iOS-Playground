//
//  ViewController.swift
//  DemoMaterial
//
//  Created by icetime17 on 16/2/15.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import Material

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextField()
        
        addFlatButton()
        addRaisedButton()
        addFabButton()
        
        
    }
    
    func addTextField() {
        let textField: TextField = TextField(frame: CGRectMake(57, 100, 300, 24))
        textField.placeholder = "First Name"
        textField.font = RobotoFont.regularWithSize(20)
        textField.textColor = MaterialColor.black
        
        textField.titleLabel = UILabel()
        textField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        textField.titleLabelColor = MaterialColor.grey.lighten1
        textField.titleLabelActiveColor = MaterialColor.blue.accent3
        textField.clearButtonMode = .WhileEditing
        
        view.addSubview(textField)
    }

    func addFlatButton() {
        let button: FlatButton = FlatButton(frame: CGRectMake(10, 150, 150, 50))
        button.setTitle("Flat", forState: .Normal)
        button.titleLabel!.font = RobotoFont.mediumWithSize(32)
        button.addTarget(self, action: Selector("actionButton:"), forControlEvents: .TouchUpInside);
        view.addSubview(button)
    }
    
    func addRaisedButton() {
        let button: RaisedButton = RaisedButton(frame: CGRectMake(200, 150, 150, 50))
        button.setTitle("Raised", forState: .Normal)
        button.titleLabel!.font = RobotoFont.mediumWithSize(32)
        button.addTarget(self, action: Selector("actionButton:"), forControlEvents: .TouchUpInside);
        view.addSubview(button)
    }
    
    func addFabButton() {
        let button: FabButton = FabButton(frame: CGRectMake(107, 200, 100, 100))
        button.setTitle("Fab", forState: .Normal)
        button.titleLabel!.font = RobotoFont.mediumWithSize(32)
        button.addTarget(self, action: Selector("actionButton:"), forControlEvents: .TouchUpInside);
        view.addSubview(button)
    }
    
    func actionButton(sender: UIButton) {
        print("actionButton")
    }
}

