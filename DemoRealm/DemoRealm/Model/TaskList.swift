//
//  TaskList.swift
//  DemoRealm
//
//  Created by Chris Hu on 16/5/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import Foundation
import RealmSwift

// 用于存储Task.
class TaskList: Object {
    
    dynamic var name = ""
    dynamic var createAt = NSDate()
    let tasks = List<Task>()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
