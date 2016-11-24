//: Playground - noun: a place where people can play

import UIKit

"B" > "A"
"A" > "B"

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

[1,2,3,4,5].reduce(0) { (result, element) -> Int in
    return result + element
}
[1,2,3,4,5].reduce(100) { (result, element) -> Int in
    return result + element
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



// Class与Protocol

protocol AnimalProtocol {
    var animalName: String { get }
    func animalSleep() -> String
}

class Cat : AnimalProtocol {
    var name: String!
    
    var hasNickname: Bool = false
    var nickname: String {
        get {
            return "my cat"
        }
        set {
            hasNickname = true
            print(hasNickname)
        }
    }
    
    func sleep() -> String {
        return "cat sleep"
    }
    
    // AnimalProtocol
    var animalName: String {
        get {
            return "animal"
        }
    }
    
    func animalSleep() -> String {
        return "animal sleep"
    }
}

var cat = Cat()
cat.name
cat.hasNickname
cat.nickname
cat.hasNickname
cat.nickname = "your cat"
cat.hasNickname
cat.nickname

cat.sleep()
cat.animalSleep()

// 协议作为变量(继承了该协议的类)
var cat2: AnimalProtocol = Cat()
cat2.animalName
cat2.animalSleep()


// Struct与Protocol
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct StructPerson: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(who: Named & Aged) {
    print("Happy birthday to \(who.name). You're \(who.age) years old.")
}
let person = StructPerson(name: "Chris", age: 18)
wishHappyBirthday(who: person)



// 泛型
func aSwap(a: inout Int, b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}
var aInt = 3
var bInt = 107
print("aInt is now \(aInt), and bInt is now \(bInt)")
aSwap(a: &aInt, b: &bInt)
print("aInt is now \(aInt), and bInt is now \(bInt)")


func aSwapT<T>(a: inout T, b: inout T) {
    let tmp = a
    a = b
    b = tmp
}
var aStr = "hello"
var bStr = "world"
print("aString is now \(aStr), and bString is now \(bStr)")
aSwapT(a: &aStr, b: &bStr)
print("aString is now \(aStr), and bString is now \(bStr)")


// Tuple
func swapTuple<T>(a: inout T, b: inout T) {
    (a,b)=(b,a)
}
print("aString is now \(aStr), and bString is now \(bStr)")
swapTuple(a: &aStr, b: &bStr)
print("aString is now \(aStr), and bString is now \(bStr)")

// Array
func swapArray<T>(arr: inout [T], _ a: Int, _ b: Int) {
    let tmp = arr[a]
    arr[a] = arr[b]
    arr[b] = tmp
}
var arrInt = [1,2,3]
swapArray(arr: &arrInt, 1, 2)
var arrStr = ["a", "b", "c"]
swapArray(arr: &arrStr, 1, 2)
var arrTuple = [(200, "ok"), (404, "not found"), (500, "error")]
swapArray(arr: &arrTuple, 1, 2)


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
intStack.push(item: 11)
intStack.items
intStack.pop()
intStack.items

var strStack = Stack(items: ["a", "b", "c"])
strStack.items
strStack.push(item: "d")
strStack.items
strStack.pop()
strStack.items


// MARK - Other
var btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
btn.setTitle("Button", for: .normal)
btn.setTitleColor(UIColor.red, for: .normal)
btn.layer.borderColor = UIColor.blue.cgColor
btn.layer.borderWidth = 2.0
btn.layer.cornerRadius = 10.0
btn
btn is UIButton
btn is UILabel


UIColor.red
NSURL(string: "https://www.dianping.com")
var url = NSURL(string: "https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=4201714548,3253979110&fm=80")
UIImage(data: NSData(contentsOf: url as! URL) as! Data)


// MARK - 运算符重载
// 中间：计算平方和，左结合，优先级255
infix operator +++ {associativity left precedence 255}

func +++(left: Double, right: Double) -> Double {
    return left*left + right*right
}

print(1+++3)



