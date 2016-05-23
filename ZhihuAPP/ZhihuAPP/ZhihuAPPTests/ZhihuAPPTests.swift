//
//  ZhihuAPPTests.swift
//  ZhihuAPPTests
//
//  Created by Chris on 14/12/25.
//  Copyright (c) 2014年 Chris. All rights reserved.
//

import UIKit
import XCTest

class ZhihuAPPTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        println("setUp")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        println("tearDown")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        println("testExample")
    }

    func testExample1() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        println("testExample1")
    }
    
    func testExample2() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        println("testExample2")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
        println("testPerformanceExample")
    }
    
}
