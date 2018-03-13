//
//  DemoMVVMTests.m
//  DemoMVVMTests
//
//  Created by Chris Hu on 13/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewModelUserInfo.h"

@interface DemoMVVMTests : XCTestCase

@property (nonatomic, strong) ViewModelUserInfo *viewModel;

@end

@implementation DemoMVVMTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.viewModel = [[ViewModelUserInfo alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self.viewModel updateModelFromMockWeb];
    
    XCTAssert([self.viewModel.modelUserInfo.name isEqualToString:@"Chris1"], "name等于Chris1");
    XCTAssert(self.viewModel.modelUserInfo.age == 1, "age等于1");
    XCTAssert([self.viewModel.modelUserInfo.city isEqualToString:@"Shanghai1"], "city等于Shanghai1");
    
    sleep(4);
    XCTAssert([self.viewModel.modelUserInfo.name isEqualToString:@"Chris18"], "name等于Chris18");
    XCTAssert(self.viewModel.modelUserInfo.age == 18, "age等于18");
    XCTAssert([self.viewModel.modelUserInfo.city isEqualToString:@"Shanghai18"], "city等于Shanghai18");
    
    sleep(6);
    XCTAssert([self.viewModel.modelUserInfo.name isEqualToString:@"Chris28"], "name等于Chris28");
    XCTAssert(self.viewModel.modelUserInfo.age == 28, "age等于28");
    XCTAssert([self.viewModel.modelUserInfo.city isEqualToString:@"iloveShanghai28"], "city等于iloveShanghai28");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
