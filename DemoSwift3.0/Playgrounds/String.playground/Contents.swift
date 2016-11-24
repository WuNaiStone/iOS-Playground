//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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
