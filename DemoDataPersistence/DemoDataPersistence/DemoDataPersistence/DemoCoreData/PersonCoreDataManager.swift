//
//  PersonCoreDataManager.swift
//  DemoDataPersistence
//
//  Created by Chris Hu on 16/6/23.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import CoreData

class PersonCoreDataManager: NSObject {

    var context: NSManagedObjectContext!
    
    func add() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.context = appDelegate.managedObjectContext
    }
    
    func insertPerson() {
        let person = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Person
        person.name = "myname"
        person.age = 18
        person.height = 175
        person.marriage = true
        do {
            try self.context.save()
        } catch {
        
        }
    }
 /*
    func queryPerson() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest(entityName: "Person")
        let fetchedResults: [AnyObject]
        do {
            fetchedResults = try self.context.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        } catch {
        
        }
        
        return fetchedResults
    }
    */
}
