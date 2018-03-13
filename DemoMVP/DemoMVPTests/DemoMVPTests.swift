//
//  DemoMVPTests.swift
//  DemoMVPTests
//
//  Created by Chris Hu on 13/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

import XCTest
@testable import DemoMVP

class DemoMVPTests: XCTestCase {
    
    var userPresenter: UserPresenter!
    
    var user: User!
    var myView: MyView!
    
    override func setUp() {
        super.setUp()
        
        user = User(name: "Chris", age: 18, city: "Shanghai")
        myView = MyView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        userPresenter = UserPresenter(user: user, presenter: myView)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        userPresenter.showUserInfo()
        
        let info = "\(user.name), \(user.age), \(user.city)"
        
        XCTAssert(myView.lbInfo.text == info, "myView中展示信息正确")
        
        user = User(name: "Chris", age: 20, city: "Shanghai")
        userPresenter = UserPresenter(user: user, presenter: myView)
        userPresenter.showUserInfo()
        XCTAssert(myView.lbInfo.text != info, "myView中展示信息正确")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
