//: Playground - noun: a place where people can play

import UIKit

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

