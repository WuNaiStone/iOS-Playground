//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var arr = str.components(separatedBy: "Hello")
print(arr.count)
arr[0]
arr[1]


str = "0de5fc94d0ba53fc7a44f0f136e82fbb/6FA6D213-6FD3-460C-A403-885C536DADD0"
str.replacingOccurrences(of: "0de5fc94d0ba53fc7a44f0f136e82fbb/", with: "")


arr = str.components(separatedBy: "0de5fc94d0ba53fc7a44f0f136e82fbb/")
arr[1]


var index = str.index(str.startIndex, offsetBy: "Hello".characters.count)
str.substring(to: index)


let strlength:Int = str.characters.count - 10

index = str.index(str.startIndex, offsetBy: strlength)
str.substring(to: index)
str.substring(from: index)

let start = str.index(str.startIndex, offsetBy: 5)
let end = str.index(str.endIndex, offsetBy: 0)
let range = start..<end

str.substring(with: range)

//str.range(of: "Hello")
//
//str.index(str.startIndex, offsetBy: 2)



// MARK - String
str = "Hello, playground"
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
