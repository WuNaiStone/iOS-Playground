//
//  DemoViewControllerTransitionViewController.h
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/16.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DemoViewControllerTransitionType) {
    DemoViewControllerTransitionTypeBubble = 0,
    
};

@interface DemoViewControllerTransitionViewController : UIViewController

@property (nonatomic, assign) DemoViewControllerTransitionType demoType;

@end
