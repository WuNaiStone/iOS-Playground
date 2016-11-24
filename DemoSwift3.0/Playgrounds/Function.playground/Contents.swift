//: Playground - noun: a place where people can play

import UIKit

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
