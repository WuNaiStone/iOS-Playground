//: Playground - noun: a place where people can play

import UIKit

// MARK - Tuple

var tp = ("a", "1")

func returnTp() -> (String, Int, String) {
    return ("name", 18, "city")
}
var t = returnTp()
t.0
t.1
t.2
