//
//  TestViewController.h
//  DemoBlock
//
//  Created by zj－db0465 on 15/9/17.
//  Copyright (c) 2015年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController

typedef void(^BlockUpdateBtnTitle)(NSString *);
@property (nonatomic, copy) BlockUpdateBtnTitle blockUpdateBtnTitle;

@end
