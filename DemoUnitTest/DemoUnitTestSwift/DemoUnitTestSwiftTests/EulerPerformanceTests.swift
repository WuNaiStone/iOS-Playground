//
//  EulerPerformanceTests.swift
//  DemoUnitTestSwift
//
//  Created by zj－db0465 on 15/11/30.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import XCTest

class Euler {
    var maxNumber: Int!
    
    // 构造器不是方法！
    init(number: Int) {
        maxNumber = number
    }
    
    func eulerSum1() -> Int {
        var ret = 0
        for (var i = 0; i < maxNumber; i++) {
            if i % 3 == 0 || i % 5 == 0 {
                ret += i
            }
        }
        print("eulerSum1 : \(ret)")
        return ret
    }
    
    func eulerSum2() -> Int {
        var ret = 0
        for (var i = 3; i < maxNumber; i += 3) {
            ret += i
        }
        for (var i = 5; i < maxNumber; i += 5) {
            if i % 3 == 0 {
                continue
            }
            ret += i
        }
        print("eulerSum2 : \(ret)")
        return ret
    }
}


class EulerPerformanceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceEulerSum1() {
        // This is an example of a performance test case.
        let euler = Euler(number: 100000000)
        
        self.measureBlock {
            // Put the code you want to measure the time of here.
            euler.eulerSum1()
        }
    }
    
    func testPerformanceEulerSum2() {
        // This is an example of a performance test case.
        let euler = Euler(number: 100000000)
        
        self.measureBlock {
            // Put the code you want to measure the time of here.
            euler.eulerSum2()
        }
    }
    
}
