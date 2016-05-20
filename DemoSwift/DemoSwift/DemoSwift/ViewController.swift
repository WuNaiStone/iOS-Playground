//
//  ViewController.swift
//  DemoSwift
//
//  Created by zj－db0465 on 15/11/11.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(testVar)
        
        self.addLabel()
        
        
        var myClass = MyClass()
        print(myClass.name)
        print(myClass.internalName)
        
        myClass.myFunc()
        myClass.myPrivate()
        
        myClass.mySchool = "HUST"
        print(myClass.mySchool)
        myClass.mySchool = "SJTU"
        print(myClass.mySchool)
        
        var myClass1 = MyClass1()
        print(myClass1.name)
        print(myClass1.internalName)
        myClass1.myFunc()
        myClass1.myPrivate()
        
        
        // 使用closure在VC之间传值
        var closure: (String, Int) -> String = { (name, age) -> String in
            return "My name is \(name), and I'm \(age) years old."
        }
        print(myClass.myClosureFunc(closure))
        
        
        // 添加OC bridging header文件
        self.addShimmerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var testVar = 123
    var label: UILabel!
    func addLabel() {
        label = UILabel(frame: CGRectMake(0, 100, self.view.frame.size.width, 50))
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        
        label.text = "\(testVar)"
    }

    @IBOutlet weak var btn: UIButton!
    @IBAction func actionBtn(sender: UIButton) {
        label.text = "button \(label.text!)"
    }
    
    @IBAction func actionBtn2(sender: UIButton) {
        let vc2 = ViewController2()
        //类似OC中的block
        let introduce: (String, Int) -> Void = { (name, age) -> Void in
            self.label.text = "My name is \(name), and I'm \(age) years old."
        }
        vc2.myIntroduce = introduce
        self.presentViewController(vc2, animated: true) { () -> Void in
            
        }
    }
    
    
    
    @IBAction func actionDemoOpenGL(sender: UIButton) {
        let vc = OpenGLViewController()
        self.presentViewController(vc, animated: false) { () -> Void in
            
        }
    }
    
    func addShimmerView() {
        let shimmerView = FBShimmeringView(frame: CGRectMake(0, self.view.frame.height - 100, self.view.frame.size.width, 50))
        self.view.addSubview(shimmerView)
        shimmerView.backgroundColor = UIColor.darkGrayColor()
        shimmerView.shimmering = true
        
        let label = UILabel(frame: CGRectMake(0, 0, shimmerView.frame.size.width, 50))
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = ">>>  Slide to unlock"
        shimmerView.contentView = label
    }
    
}

