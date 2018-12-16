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
@property (nonatomic, strong) ModelUserInfo *model;

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
    
    _model = [ModelUserInfo new];
    _model.name = @"initial name";
    _model.age = 1;
    _model.city = @"initial city";
    [self.viewModel bindWithModel:_model];
    
    [self.viewModel updateModelFromMockWeb];
    
    XCTAssert([self.viewModel.name isEqualToString:@"ViewModel's Chris 1"], "name等于ViewModel's Chris 1");
    XCTAssert(self.viewModel.age == 1, "age等于1");
    XCTAssert([self.viewModel.city isEqualToString:@"ViewModel's Shanghai 1"], "city等于ViewModel's Shanghai 1");
    
    sleep(4);
    XCTAssert([self.viewModel.name isEqualToString:@"ViewModel's Chris 18"], "name等于ViewModel's Chris 18");
    XCTAssert(self.viewModel.age == 18, "age等于18");
    XCTAssert([self.viewModel.city isEqualToString:@"ViewModel's Shanghai 18"], "city等于ViewModel's Shanghai 18");
    
    sleep(6);
    XCTAssert([self.viewModel.name isEqualToString:@"ViewModel's Chris 28"], "name等于ViewModel's Chris 28");
    XCTAssert(self.viewModel.age == 28, "age等于28");
    XCTAssert([self.viewModel.city isEqualToString:@"ViewModel's iloveShanghai 28"], "city等于ViewModel's iloveShanghai 28");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
