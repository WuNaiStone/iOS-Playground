//: Playground - noun: a place where people can play

import UIKit

typealias UsernameAndPassword = [String: String]

var users = UsernameAndPassword()
users = ["123":"123", "abc":"abc"]

enum LoginError: Error {
    case UserNotFound, UserPasswordNotMatch, UsernameEmpty
    
    var localizedDescription: String {
        return "\(self)"
    }
}


func login(user: String, password: String) throws {
    if user.isEmpty {
        throw LoginError.UsernameEmpty
    }

    if !users.keys.contains(user) {
        throw LoginError.UserNotFound
    }
    
    if users[user] != password {
        throw LoginError.UserPasswordNotMatch
    }
    
    print("Login successfully.")
}

do {
    try login(user: "123", password: "123")
} catch LoginError.UserNotFound {
    print("UserNotFound")
} catch LoginError.UserPasswordNotMatch {
    print("UserPasswordNotMatch")
} catch let err where err is LoginError {
    (err as? LoginError)?.localizedDescription
}


do {
    try login(user: "userNotFound", password: "passwd")
} catch LoginError.UserNotFound {
    print("UserNotFound")
} catch LoginError.UserPasswordNotMatch {
    print("UserPasswordNotMatch")
} catch let err where err is LoginError {
    (err as? LoginError)?.localizedDescription
}


do {
    try login(user: "abc", password: "123")
} catch LoginError.UserNotFound {
    print("UserNotFound")
} catch LoginError.UserPasswordNotMatch {
    print("UserPasswordNotMatch")
} catch let err where err is LoginError {
    (err as? LoginError)?.localizedDescription
}
