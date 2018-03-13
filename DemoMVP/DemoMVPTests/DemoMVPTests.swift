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
    
    var myView: MyView!
    
    var presenter: Presenter!
    
    var user: User!
    var dog: Dog!
    
    override func setUp() {
        super.setUp()
        
        myView = MyView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        user = User(name: "Chris", age: 18, city: "Shanghai")
        dog = Dog(name: "Doggee", age: 2, owner: "Chris")
        
        presenter = Presenter(presentable: user)
        
        myView.presenter = presenter
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        myView.present()
        
        var info = "\(user.name), \(user.age), \(user.city)"
        
        XCTAssert(myView.lbInfo.text == info, "myView中展示user信息")
        
        user = User(name: "Chris", age: 20, city: "Shanghai")
        presenter = Presenter(presentable: user)
        myView.presenter = presenter
        myView.present()
        XCTAssert(myView.lbInfo.text != info, "myView中展示信息已修改")
        
        info = "\(dog.name), \(dog.age), \(dog.owner)"
        presenter = Presenter(presentable: dog)
        myView.presenter = presenter
        myView.present()
        XCTAssert(myView.lbInfo.text == info, "myView中展示dog信息")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
