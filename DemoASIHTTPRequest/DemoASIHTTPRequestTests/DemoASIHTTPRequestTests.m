//
//  DemoASIHTTPRequestTests.m
//  DemoASIHTTPRequestTests
//
//  Created by zj－db0465 on 16/1/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface DemoASIHTTPRequestTests : XCTestCase

@end

@implementation DemoASIHTTPRequestTests {

    ViewController *_vc;

    
    XCTestExpectation *expection;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _vc = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    expection = [self expectationWithDescription:@"ASIHTTPRequest"];
    
    CompletionBlock completionBlock = ^(NSData *data) {
        [expection fulfill];
        
        NSLog(@"test completionBlock");
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"data : %@", dataString);

        XCTAssert(data, @"data非空");
        XCTAssert(dataString, @"dataString非空");
    };

    [_vc getBaidu:completionBlock];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        
    }];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
