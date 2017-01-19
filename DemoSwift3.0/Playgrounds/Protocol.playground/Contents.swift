//: Playground - noun: a place where people can play

import UIKit

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



// Swift实现OC中的NSCopying
protocol Copyable {
    func copy() -> Copyable
}
class Person0: Copyable {
    var name = ""
    var age = 0
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func copy() -> Copyable {
        return Person0(name: self.name, age: self.age)
    }
}
let p1 = Person0(name: "cc", age: 18)
p1.name
p1.age
let p2 = p1.copy() as! Person0
p2.name
p2.age


//
protocol Greetable {
    var name: String { get }
    func greet()
    func greet1()
}
// 通过协议扩展来指定默认的实现方法
extension Greetable {
    func greet() {
        print("Greetable")
    }
}

struct Person1: Greetable {
    let name: String
    func greet() {
        print("Person1")
    }
    func greet1() {
        
    }
}
Person1(name: "chris").greet()

struct Person2: Greetable {
    let name: String
//    func greet() {
//        print("Person2")
//    }
    func greet1() {
        
    }
}

let arr: [Greetable] = [
    Person1(name: "chris"),
    Person2(name: "nobody")
]
for greet in arr {
    greet.greet()
}


// 协议属性
protocol FullyNamed {
    var fullName: String { get }
}
struct Person3: FullyNamed {
    // 如果是let，则Person3的初始化方法不能指定fullName。
    // 如果是var，则可以选择是否指定fullName
    var fullName: String = "chris"
}
let person3 = Person3(fullName: "chris")
person3.fullName
struct Person4: FullyNamed {
    var fullName: String {
        return "this is chris"
    }
}
let person4 = Person4()
person4.fullName


// 协议仅仅规定方法
// https://www.cnswift.org/protocols
// 要求实现该协议的类型都必须有random方法返回一个Double值，而具体random的实现不关心。
protocol RandomNumberGenerator {
    func random() -> Double
}
// Linear Congruential Generator
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        // %用于浮点数已经取消了
        lastRandom = ((lastRandom * a + c) / m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
generator.random()

// 协议作为类型
class Dice {
    // class中的属性如果不使用!或赋初值，则在init方法中初始化也可以。否则会报错
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
// generator属性是继承子RandomNumberGenerator协议的一个对象而已。
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

