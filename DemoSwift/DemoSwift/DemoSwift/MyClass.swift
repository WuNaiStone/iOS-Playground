//
//  MyClass.swift
//  DemoSwift
//
//  Created by zj－db0465 on 15/11/17.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

typealias MyClosure = (String, Int) -> String

class MyClass: NSObject {

    var name = "My Class"
    var age = 10
    
    private var privateName = "Private Name"
    
    internal var internalName = "Internal Name"
    
    var myClosure = MyClosure?()
    
    func myFunc() {
        print("My Func")
    }
    
    func myPrivate() {
        print(self.privateName)
    }
    
    func myClosureFunc(closure: MyClosure) -> String {
        return closure(name, age)
    }
    
    
    var mySchool: String {
        get {
            return "SJTU"
        }
        
        set {
            print("mySchool set method")
        }
    }
    
}
