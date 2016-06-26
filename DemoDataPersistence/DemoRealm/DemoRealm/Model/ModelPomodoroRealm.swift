//
//  ModelPomodoroRealm.swift
//  DemoRealm
//
//  Created by Chris Hu on 16/5/5.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import Foundation
import RealmSwift

class ModelPomodoroRealm: Object {
    
    // 加了dynamic, 属性可以被数据库读写.
    dynamic var createTime = NSDate()
    dynamic var endTime = NSDate()
    dynamic var duration = 0
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
