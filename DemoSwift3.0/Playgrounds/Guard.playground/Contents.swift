//: Playground - noun: a place where people can play

import UIKit

// ["app"]["name"]["swift"]["age"]

// v1.0 : if let - else
func handleJSON_v1(data: [String:[String: String]]) -> String? {
    if let item = data["app"] {
        if let name = item["name"] {
            if name == "swift" {
                if let age = item["age"] {
                    return age
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }else {
            return nil
        }
    }else {
        return nil
    }
}


// v2.0 : gurad let
func handleJSON_v2(data: [String:[String: String]]) -> String? {
    guard let item = data["app"] else { return nil }
    guard let name = item["name"] else { return nil }
    if name == "swift" {
        guard let age = item["age"] else { return nil }
        return age
    } else {
        return nil
    }
}


// v3.0 : guard let + where
func handleJSON_v3(data: [String:[String: String]]) -> String? {
    guard let item = data["app"], let name = item["name"], name == "swift" else { return nil }
    return name["age"]
}

