//
//  ViewController.h
//  DemoBlock
//
//  Created by zj－db0465 on 15/9/17.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// 方法调用的参数
- (int)method2TakeBlock:(int (^) (int a, int b))block;

@end

