//: Playground - noun: a place where people can play

import UIKit
import Foundation

// MARK - String
var str = "Hello, playground"
str += " How are you"
print(str)
print("\(str) How are you again")

let age = 20
// age + "岁"
String(age) + "岁"
"\(age)岁"
"明年：\(age + 1)岁"

str.characters
for index in str.characters {
    print(index)
}



// MARK - Array

var array = Array<Int>()
array = [1, 3, 5, 7, 9, 11]
for index in array {
    print(index)
}

for index in array.enumerate() {
    print(index)
}
array.append(13)
array[0...3]
array = [2, 4, 6, 8, 10]
for _ in 1...10 {
    print("say hello")
}
array.filter { (index) -> Bool in
    index % 4 == 0
}
array.sort { (i, j) -> Bool in
    i > j
}



// MARK - Dictionary
var dict = Dictionary<String, String>()
dict["fff"] = "abc"
dict.updateValue("fff", forKey: "fff")
dict = ["a": "b", "c": "d", "e": "f"]
dict.updateValue("g", forKey: "h")
dict
for (key, value) in dict.enumerate() {
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


var dict2 = Dictionary<String, UIColor>()
dict2["red"] = UIColor.redColor()
dict2

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
        print("EA")
    case .EB:
        print("EB")
    case .EC:
        print("EC")
    default:
        print("EA")
}


// MARK - Tuple

var tp = ("a", "1")

func returnTp() -> (String, Int, String) {
    return ("name", 18, "city")
}
var t = returnTp()
t.0
t.1



// Switch
var httpStatus = (200, "OK")
switch httpStatus {
    case (200, "OK"):
        print(httpStatus)
    case (403, "NotFound"):
        print(httpStatus)
    default:
        print("Unknown Status")
}

var twoNumber = (100, 200)
switch twoNumber {
    case let (x, y) where x < y:
        print("\(x) < \(y)")
    case let (x, y) where x > y:
        print("\(x) > \(y)")
    case let (x, y) where x == y:
        print("\(x) == \(y)")
    default:
        print("unknown")
}



// MARK - Function
func funcName1(index: Int) -> String {
    print(index)
    return "\(index)"
}
funcName1(11)
funcName1(12)


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
    
    return "Name: \(name). Age: \(addAge(age)). City: \(addCity(city))"
}
funcName2("My Name")
funcName2("My Name 2")

// inout
func increaseInt(inout index: Int) -> Int {
    return ++index
}
var i = 1
increaseInt(&i)
i


// Struct
struct MyStruct {
    var name = "name"
    
    static var StructName = "Struct Name"

    func myFunc() {
        print("My Func")
    }
    
    static func StructFunc() {
        print("Struct Func")
    }
}

MyStruct.StructName
MyStruct.StructFunc()

var myStruct = MyStruct()
myStruct.name
myStruct.myFunc()


// Closure

func closureFunc(index: Int, closure: (Int) -> Int) {
    print("index : \(index)")
    print("closure: \(closure(index))")
}

closureFunc(3) { (index) -> Int in
    return index * 10
}

closureFunc(3) {
    return $0 * 10
}


func closureFunc2(closure:()->String) {
    closure()
}

closureFunc2 { () -> String in
    print("closure func 1")
    return "closure func 1"
}

closureFunc2 { () -> String in
    print("closure func 3")
    return "closure func 3"
}



let peoples = [
    "a": 10,
    "b": 20,
    "c": 30,
]
peoples.map { (name, age) -> String in
    var ret = "\(name) : \(age + 1)"
    print(ret)
    return ret
}

peoples.map { (name, age) -> String in
    if age > 20 {
        return "\(name)"
    }
    return ""
}

[100, 1, -5, 9, -20].sort { (a, b) -> Bool in
    return a*a < b*b
}




// MARK - Class

class MyClass: NSObject {
    
    var name: String = ""
    var nameOptional: String?
    var nameOptional2: String! // 隐式拆包，即强制拆包
    var age: Int?
    
    // 静态属性和方法
    static var className = "Class Name"
    class func classDescription() {
        print("This is class method.")
    }
    
    func myDescription() {
        print(name)
        print(age)
    }
}
MyClass.className
MyClass.classDescription()

var myclass = MyClass()
myclass.myDescription()
myclass.name = "name"
print(myclass.name)
if (myclass.name != "") {
    myclass.name.capitalizedString
}
myclass.nameOptional = "nameOptional"
print(myclass.nameOptional)
myclass.nameOptional?.capitalizedString

// 隐式拆包，即一定不为nil
myclass.nameOptional2 = "nameOptional2"
myclass.nameOptional2
//if nil != myclass.nameOptional2 {
    print(myclass.nameOptional2)
    myclass.nameOptional2.capitalizedString
//} else {
//    print("123")
//}


class MyClass1: NSObject {
    var name = "My Class 1"
    
    private var privateName = "Private Name"
    
    
    
    func myFunc() {
        print("myFunc")
    }
}

class MyClass2: MyClass1 {
    
}


var myClass1 = MyClass1()
myClass1.name
myClass1.privateName
myClass1.myFunc()

var myClass2 = MyClass2()
myClass2.name
myClass2.privateName
myClass2.myFunc()


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
myClass3[0]
myClass3[4] = "d"
myClass3.classes



// Class与Protocol

protocol AnimalProtocol {
    var nameAnimal: String { get }
    
    func sleepAnimal() -> String
}

class Cat: NSObject, AnimalProtocol {
    var name: String!
    
    var nicknameHasValue: Bool = false
    var nickname: String {
        get {
            return "My Cat"
        }
        set {
            nicknameHasValue = true
            print(nicknameHasValue)
        }
    }
    
    // AnimalProtocol
    
    var nameAnimal: String {
        get {
            return "nameAnimal"
        }
    }
    func sleepAnimal() -> String {
        return "sleepAnimal"
    }
}
var cat = Cat()
cat.nicknameHasValue
cat.name = "MyName"
cat.name
cat.nickname = "iphone"
cat.nickname
cat.nicknameHasValue
cat.nameAnimal
cat.sleepAnimal()

// 协议作为变量（继承了该协议的类）
var myCat: AnimalProtocol = Cat()


// Struct与Protocol

protocol Named {
    var name: String {get}
}
protocol Aged {
    var age: Int {get}
}
struct StructPerson: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(who: protocol<Named, Aged>) {
    print("Happy birthday to \(who.name). You're \(who.age) years old.")
}
let person = StructPerson(name: "haha", age: 18)
wishHappyBirthday(person)



// 泛型
func swap(inout a: Int, inout b: Int) {
    let temp = a
    a = b
    b = temp
}
var aInt = 3
var bInt = 107
print("aInt is now \(aInt), and bInt is now \(bInt)")
swap(&aInt, &bInt)
print("aInt is now \(aInt), and bInt is now \(bInt)")


func swapT<T>(inout a: T, inout b: T) {
    let temp = a
    a = b
    b = temp
}
var aString = "hello"
var bString = "world"
print("aString is now \(aString), and bString is now \(bString)")
swap(&aString, &bString)
print("aString is now \(aString), and bString is now \(bString)")



// Stack
// 值类型struct, 在实例方法中修改属性要加mutating关键字
struct Stack<T> {
    var items = Array<T>()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
var intStack = Stack(items: [1,3,5,7,9])
intStack.items
intStack.push(11)
intStack.items
intStack.pop()
intStack.items


var stringStack = Stack(items: ["a", "b", "c"])
stringStack.items
stringStack.push("d")
stringStack.items
stringStack.pop()
stringStack.items



//使用tuple
func swapTuple<T>(inout a: T, inout b: T) {
    (a,b) = (b,a)
}
print("aString is now \(aString), and bString is now \(bString)")
swapTuple(&aString, b: &bString)
print("aString is now \(aString), and bString is now \(bString)")


// MARK - Others
var btn = UIButton(frame: CGRectMake(0,0,100,50))
btn.setTitle("button", forState: UIControlState.Normal)
btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
btn.layer.borderColor = UIColor.blueColor().CGColor
btn.layer.borderWidth = 2.0
btn.layer.cornerRadius = 10.0
btn
btn is UIButton
btn is UILabel


UIColor.redColor()
NSURL(string: "http://www.baidu.com")
var url = NSURL(string: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=4201714548,3253979110&fm=80")
UIImage(data: NSData(contentsOfURL: url!)!)


// MARK - 运算符重载

// 中间：计算平方和，左结合，优先级255
infix operator +++ {associativity left precedence 255}

func +++(left: Double, right: Double) -> Double {
    return left*left + right*right
}

print(1+++3)

