//: Playground - noun: a place where people can play

import UIKit

// MARK - String
var str = "Hello, playground"
str += " how are you"
print(str)
print("\(str) how are you again")

let age = 20
String(age) + "岁"
"\(age)岁"
"明年：\(age + 1)岁"

str.characters
for index in str.characters {
    print(index)
}

// MARK - Array

var array = Array<Int>()
array = [1,3,5,7,9,11]
for index in array {
    print(index)
}

for index in array.enumerated() {
    print(index)
}

array.append(13)
array[0...3]
array = [2,4,6,8,10]
for _ in 1...10 {
    print("say hello")
}

array = array.filter { (index) -> Bool in
            index % 4 == 0
        }
print(array)

array = [2,4,6,8,10,1,5,11,20]
array.sort() // 默认排序
print(array)

array = [2,4,6,8,10,1,5,11,20]
array.sort { (x, y) -> Bool in
    x > y
}
print(array)

array = [2,4,6,8,10,1,5,11,20]
array = array.sorted()
print(array)

array = [2,4,6,8,10,1,5,11,20]
array = array.sorted(by: { (x, y) -> Bool in
    x > y
})
print(array)

array = [2,4,6,8,10,1,5,11,20]
array = array.sorted(by: {
    $0 > $1
})
print(array)

[100, 1, -5, 9, -20].sorted { (x, y) -> Bool in
    x*x < y*y
}


// MARK - Dictionary
var dict = Dictionary<String, String>()
dict["fff"] = "abc"
dict.updateValue("fff", forKey: "fff")
print(dict)
dict = ["a": "b", "c": "d", "e": "f"]
dict.updateValue("g", forKey: "h")
dict
for (key, value) in dict {
    print(key)
    print(value)
}
for (key, value) in dict.enumerated() {
    print(key)
    print(value)
}

Array(dict.keys)
Array(dict.values)
for key in dict.keys {
    print(key)
}
for value in dict.values {
    print(value)
}

var dictColor = Dictionary<String, UIColor>()
dictColor["red"] = UIColor.red
dictColor


// Enum
enum EnumName {
    case EA
    case EB
    case EC
    
    static var name = "name"
    
    static func enumFunc() {
        print("static enum func")
    }
}
EnumName.name
EnumName.enumFunc()

var enumName = EnumName.EA
enumName = .EC
switch enumName {
case .EA:
    print(enumName)
case .EB:
    print(enumName)
case .EC:
    print(enumName)
}


// MARK - Tuple

var tp = ("a", "1")

func returnTp() -> (String, Int, String) {
    return ("name", 18, "city")
}
var t = returnTp()
t.0
t.1
t.2


// Switch
var httpStatus = (200, "OK")
switch httpStatus {
case (200, "OK"):
    print(httpStatus)
case (403, "Not Found"):
    print(httpStatus)
default:
    print("unknown status")
}

var twoNumber = (100, 200)
switch twoNumber {
case let (x, y) where x < y:
    print(twoNumber)
case let (x, y) where x > y:
    print(twoNumber)
default:
    print("unknown")
}


// MARK - Func
func funcName1(index: Int) -> String {
    print(index)
    return "number : \(index)"
}
funcName1(index: 11)
funcName1(index: 22)


func funcName2(name: String) -> String {
    func addAge(age: Int) -> Int {
        return age + 2
    }
    
    func addCity(city: String) -> String {
        return "\(city) City"
    }
    
    var age = 0
    var city = ""
    
    if name == "My Name" {
        age = 18
        city = "XM"
    } else {
        age = 19
        city = "SH"
    }
    
    return "Name: \(name). Age: \(addAge(age: age)). City: \(addCity(city: city)))"
}
funcName2(name: "My Name")
funcName2(name: "My Name 2")


// inout
func increaseInt(index: inout Int) -> Int {
    index += 1
    return index
}
var i = 1
increaseInt(index: &i)
i


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


// Closure
func closureFunc(index: Int, closure: (Int) -> Int) {
    print("index : \(index)")
    print("closure: \(closure(index))")
}

closureFunc(index: 3) { (index) -> Int in
    index * index
}

closureFunc(index: 3) {
    $0 * 10
}

func closureFunc2(closure: () -> String) {
    closure()
}
closureFunc2 { () -> String in
    return "closureFunc2"
}


let peoples = [
    "a": 10,
    "b": 20,
    "c": 30,
]
let ret1 = peoples.map { (name, age) -> String in
    var ret = "\(name) : \(age + 1)"
    return ret
}
ret1

let ret2 = peoples.map { (name, age) -> String in
    if age > 20 {
        return "\(name)"
    }
    return ""
}
ret2


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





