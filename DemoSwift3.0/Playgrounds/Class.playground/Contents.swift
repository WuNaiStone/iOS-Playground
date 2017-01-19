//: Playground - noun: a place where people can play

import UIKit

// MARK - Class

class MyClass {
    var name = ""
    var nameOptional1: String?
    var nameOptional2: String!
    var age: Int?
    
    func myFunc() {
        print("myFunc")
    }
    
    static var className = "className"
    static func classFunc() {
        print("classFunc")
    }
    class func classFunc2() {
        print("classFunc")
    }
}
MyClass.className
MyClass.classFunc()
MyClass.classFunc2()

var myClass = MyClass()
myClass.myFunc()
myClass.name = "name"
myClass.name.capitalized
myClass.nameOptional1 = "nameOptional1"
myClass.nameOptional1
myClass.nameOptional1?.capitalized

myClass.nameOptional2 = "nameOptional2"
myClass.nameOptional2
myClass.nameOptional2.capitalized


class MyClass1 {
    var name = "MyClass1"
    
    fileprivate var fileprivateName = "fileprivateName"
    private var privateName = "privateName"
    
}
var myClass1 = MyClass1()
myClass1.name
myClass1.fileprivateName
//myClass1.privateName

class MyClass3 {
    var classes = Array<String>()
    subscript(index: Int) -> String {
        get {
            return classes[index]
        }
        set {
            if index < classes.count {
                classes[index] = newValue
            } else {
                classes.append(newValue)
            }
        }
    }
}

var myClass3 = MyClass3()
myClass3.classes = ["a", "b", "c"]
myClass3.classes
myClass3.classes[0]
myClass3.classes[0] = "A"
//myClass3.classes[3] = "d"
//myClass3.classes
// 通过subscript来指定下标
myClass3[0]
myClass3[2]
