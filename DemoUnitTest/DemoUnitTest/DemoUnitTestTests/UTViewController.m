//
//  DemoUnitTestTests.m
//  DemoUnitTestTests
//
//  Created by zj－db0465 on 15/11/23.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewController2.h"

@interface UTViewController : XCTestCase

@end

@implementation UTViewController {
    AppDelegate *appDelegate;
    ViewController *appViewController;
    UIView *appView;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    appDelegate = [UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    appViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    appView = [appViewController view];
    XCTAssertNotNil(appView, @"ViewController应该有一个view");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLabels {
    XCTAssertTrue([appViewController.label1.text isEqualToString:@"Label1"], @"Label1");
    XCTAssertTrue([appViewController.label2.text isEqualToString:@"Label2"], @"Label2");
    
    XCTAssertTrue([appViewController.button1.titleLabel.text isEqualToString:@"Go to ViewController2"], @"Button Title");
    
    [appViewController actionButton1:appViewController.button1];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"testExample");
}

- (void)testGivenWhenThen {
    // given
    
    // when
    
    // then
}

// 异步测试
- (void)testAsynchronousURLConnection {
    NSLog(@"testAsynchronousURLConnection");
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Baidu"];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"data : %@", data);
        // XCTestExpectation条件已满足，接下来的测试代码可以开始执行了。
        [expectation fulfill];
        XCTAssertNotNil(data, @"返回数据不应非nil");
        XCTAssertNil(error, @"error应该为nil");
        if (nil != response) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            XCTAssertEqual(httpResponse.statusCode, 200, @"HTTPResponse的状态码应该是200");
            XCTAssertEqual(httpResponse.URL.absoluteString, url.absoluteString, @"HTTPResponse的URL应该与请求的URL一致");
//            XCTAssertEqual(httpResponse.MIMEType, @"text/html", @"HTTPResponse的内容应该是text/html");
        } else {
            XCTFail(@"返回内容不是NSHTTPURLResponse类型");
        }
    }];
    [task resume];
    
    // 超时后执行
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        [task cancel];
    }];
}


- (void)testPerformanceExample {
    NSLog(@"testPerformanceExample");
    // This is an example of a performance test case.
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    NSDate *date = [[NSDate alloc] init];
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSString *string = [dateFormatter stringFromDate:date];
        NSLog(@"string : %@", string);
    }];
}

@end
