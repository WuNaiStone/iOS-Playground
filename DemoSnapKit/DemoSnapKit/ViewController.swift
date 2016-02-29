//
//  ViewController.swift
//  DemoSnapKit
//
//  Created by Chris Hu on 16/2/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.addView1()
        self.addView2()
        self.addView3()
        self.addView4()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addView1() {
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = UIColor.greenColor()
        self.view.addSubview(view1)
        
        let edge = UIEdgeInsetsMake(100, 10, 200, 10)
        
        // 对view1添加约束
        // view1相对于self.view的edges为edge。
        view1.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(edge)
        }
        
//        view1.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(self.view.snp_top).offset(edge.top)
//            make.left.equalTo(self.view.snp_left).offset(edge.left)
//            make.bottom.equalTo(self.view.snp_bottom).offset(-edge.bottom)
//            make.right.equalTo(self.view.snp_right).offset(-edge.right)
//        }
    }

    func addView2() {
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.backgroundColor = UIColor.blueColor()
        self.view.addSubview(view2)
        
        view2.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view1.snp_bottom).multipliedBy(1).offset(10)
            make.left.equalTo(self.view.snp_left).multipliedBy(1).offset(20)
            make.bottom.equalTo(self.view.snp_bottom).multipliedBy(1).offset(-100)
            make.right.equalTo(self.view.snp_right).multipliedBy(1).offset(-20)
        }
    }
    
    func addView3() {
        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.backgroundColor = UIColor.redColor()
        view1.addSubview(view3)
        
        view3.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view1.snp_top).multipliedBy(1).offset(10)
            make.left.equalTo(view1.snp_left).multipliedBy(1).offset(20)
            make.bottom.equalTo(view1.snp_bottom).multipliedBy(1).offset(-30)
            make.right.equalTo(view1.snp_right).multipliedBy(1).offset(-40)
        }
    }
    
    func addView4() {
        view4.translatesAutoresizingMaskIntoConstraints = false
        view4.backgroundColor = UIColor.blackColor()
        view3.addSubview(view4)
        
        view4.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view3)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
}

