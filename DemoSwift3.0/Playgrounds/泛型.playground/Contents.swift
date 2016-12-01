//: Playground - noun: a place where people can play

import UIKit

// 泛型
func aSwap(_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}
var aInt = 3
var bInt = 107
print("aInt is now \(aInt), and bInt is now \(bInt)")
aSwap(&aInt, &bInt)
print("aInt is now \(aInt), and bInt is now \(bInt)")


func aSwapT<T>(_ a: inout T, _ b: inout T) {
    let tmp = a
    a = b
    b = tmp
}
var aStr = "hello"
var bStr = "world"
print("aString is now \(aStr), and bString is now \(bStr)")
aSwapT(&aStr, &bStr)
print("aString is now \(aStr), and bString is now \(bStr)")


// Tuple
func swapTuple<T>(_ a: inout T, _ b: inout T) {
    (a,b)=(b,a)
}
print("aString is now \(aStr), and bString is now \(bStr)")
swapTuple(&aStr, &bStr)
print("aString is now \(aStr), and bString is now \(bStr)")

// Array
func swapArray<T>(_ arr: inout [T], _ a: Int, _ b: Int) {
    let tmp = arr[a]
    arr[a] = arr[b]
    arr[b] = tmp
}
var arrInt = [1,2,3]
swapArray(&arrInt, 1, 2)
var arrStr = ["a", "b", "c"]
swapArray(&arrStr, 1, 2)
var arrTuple = [(200, "ok"), (404, "not found"), (500, "error")]
swapArray(&arrTuple, 1, 2)


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



//func isExist<T: Equatable>(value: T, forKey key: String) -> Bool {
//    return (UserDefaults.standard.array(forKey: key) as? [T] ?? []).filter({ (aValue: T) -> Bool in
//        return aValue = value
//    }).count > 0
//}

//func models<T: FMDBTable>(withId id: String, cls: T.Type) -> [T] {
//    return SQLManager.manager.selectModels(type: cls, key: "id", value: id).first as? [T] ?? []
//}

