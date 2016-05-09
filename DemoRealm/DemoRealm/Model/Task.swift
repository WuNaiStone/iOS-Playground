//
//  Task.swift
//  DemoRealm
//
//  Created by Chris Hu on 16/5/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    // 加了dynamic, 属性可以被数据库读写.
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    dynamic var notes = ""
    dynamic var isCompleted = false
   
    // 声明让realm忽略的属性, 将不持有这些属性
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
