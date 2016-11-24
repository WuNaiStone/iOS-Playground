//: Playground - noun: a place where people can play

import UIKit

// Struct
struct MyStruct {
    var name = "name"
    
    static var structName = "struct name"
    
    func myFunc() {
        print("myFunc")
    }
    
    static func structFunc() {
        print("structFunc")
    }
}
MyStruct.structName
MyStruct.structFunc()

var mystruct = MyStruct()
mystruct.name
mystruct.myFunc()
