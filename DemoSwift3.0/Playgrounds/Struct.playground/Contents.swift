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




struct PersonStruct {
    let name: String
    let age: Int
    var city: String
}
// struct如果没有自定义init，则只有一个默认的成员初始化器。一旦有自定义的，默认的就不能用了。
// 而class默认的初始化器仅仅是init(),属性是声明的时候即指定的初始值。
PersonStruct(name: "name", age: 18, city: "city")



class PersonClass {
    var name: String = ""
    var age: Int = 0
    init(name: String) {
        self.name = name
    }
    init(age: Int) {
        self.age = age
    }
}
PersonClass(name: "cc")
PersonClass(age: 18)



struct Question {
    var number = 0
    let view: UIView?
    init(view: UIView?) {
        self.view = view
    }
}
let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
let view = UIView(frame: frame)
var aQuestion = Question(view: view)
var bQuestion = aQuestion
print(aQuestion)
print(bQuestion)
bQuestion.number = 100
bQuestion.view?.frame.origin.y = 200
bQuestion.view?.frame.size.height = 200
print(aQuestion)
print(bQuestion)


