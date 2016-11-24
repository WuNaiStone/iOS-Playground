//: Playground - noun: a place where people can play

import UIKit

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
