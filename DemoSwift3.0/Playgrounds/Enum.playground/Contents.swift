//: Playground - noun: a place where people can play

import UIKit

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





