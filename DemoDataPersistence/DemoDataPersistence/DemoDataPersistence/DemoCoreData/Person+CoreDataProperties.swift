//
//  Person+CoreDataProperties.swift
//  DemoDataPersistence
//
//  Created by Chris Hu on 16/6/23.
//  Copyright © 2016年 icetime17. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var name: String?
    @NSManaged var age: NSNumber?
    @NSManaged var height: NSNumber?
    @NSManaged var marriage: NSNumber?

}
