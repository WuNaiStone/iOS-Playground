//
//  UTViewController2.m
//  DemoUnitTest
//
//  Created by zj－db0465 on 15/11/25.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#define PerformanceTesting(filterId) [self measureBlock:^{NSLog(@"filterId : %@", filterId);}]

#define TestFilterPerformance(filterId) - (void)testFilterPerformance_##filterId { \
    [self measureBlock:^{ \
        NSLog(@"TestFilterPerformance : %d", filterId); \
    }]; \
}

#import <XCTest/XCTest.h>
#import "ViewController2.h"

@interface UTViewController2 : XCTestCase

@end

@implementation UTViewController2 {
    ViewController2 *viewController2;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    viewController2 = [[ViewController2 alloc] init];
    [viewController2 view];
    XCTAssertNotNil(viewController2.view, @"view未成功加载出来");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssertTrue([viewController2.btnBack.titleLabel.text isEqualToString:@"Go to ViewController"], @"Button Title");
}

// 单元测试样例不能加参数
- (void)testPerformanceExample:(NSString *)filterId {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testFilter1 { PerformanceTesting(@"123"); }

- (void)testFilter2 { PerformanceTesting(@"456"); }

TestFilterPerformance(100)

TestFilterPerformance(101)

TestFilterPerformance(102)

@end
