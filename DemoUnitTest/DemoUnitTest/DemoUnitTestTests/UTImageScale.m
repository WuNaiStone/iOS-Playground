//
//  UTImageScale.m
//  DemoUnitTest
//
//  Created by zj－db0465 on 15/11/25.
//  Copyright © 2015年 icetime17. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UTImageScale : XCTestCase

@end

@implementation UTImageScale

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    UIImage *image = [UIImage imageNamed:@"MVC.png"];
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (NSInteger i=0; i<10000; i++) {
        UIImage *resizedImage = [self imageWithImage:image scaledToSize:CGSizeMake(100, 100)];
        XCTAssertNotNil(resizedImage, @"缩放后图片不应为nil");
        CGFloat resizedWidth = resizedImage.size.width;
        CGFloat resizedHeight = resizedImage.size.height;
        XCTAssertTrue(resizedWidth == 100 && resizedHeight == 100, @"缩放后尺寸");
        }
    }];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
