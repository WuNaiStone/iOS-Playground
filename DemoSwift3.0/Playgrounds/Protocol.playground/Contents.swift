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

