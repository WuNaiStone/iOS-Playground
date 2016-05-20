//
//  DemoUnitTestSwiftTests.swift
//  DemoUnitTestSwiftTests
//
//  Created by zj－db0465 on 15/11/26.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import XCTest
import CoreData
@testable import DemoUnitTestSwift


class DemoUnitTestSwiftTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        viewController = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        viewController.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLabels() {
        XCTAssert(viewController.label1.text == "Label1", "Label1")
        XCTAssert(viewController.label2.text == "Label2", "Label2")
        XCTAssert(viewController.button1.titleLabel?.text == "Button1", "Button1")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
 
    
    func testFetchRequestWithMockedManagedObjectContext() {
        class MockNSManagedObjectContext: NSManagedObjectContext {
            override func executeFetchRequest(request: NSFetchRequest) throws -> [AnyObject] {
                return [["name": "Johnny Appleseed", "email": "johnny@apple.com"]]
            }
        }
        
        let mockContext = MockNSManagedObjectContext()
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email ENDSWITH[cd] %@", "@apple.com")
        fetchRequest.resultType = .DictionaryResultType
        
        do {
            let fetchResults = try mockContext.executeFetchRequest(fetchRequest) as? [AnyObject]
            print("fetchResults : \(fetchResults)")
            
            if let results = fetchResults {
                XCTAssertEqual(results.count, 1, "fetch request should only return 1 result")
                
                let result = results[0] as? [String: String]
                print("result : \(result)")
                XCTAssertEqual((result!["name"])! as String, "Johnny Appleseed", "name should be Johnny Appleseed")
                XCTAssertEqual((result!["email"]!) as String, "johnny@apple.com", "email should be johnny@apple.com")
            }
        } catch {
        
        }
    }
    
}
