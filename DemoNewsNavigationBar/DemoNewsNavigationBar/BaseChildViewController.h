//
//  BaseChildViewController.h
//  DemoNewsNavigationBar
//
//  Created by Chris Hu on 16/7/26.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseChildViewControllerDelegate <NSObject>

- (void)actionSwipeGesture:(UISwipeGestureRecognizer *)sender;

@end


@interface BaseChildViewController : UIViewController

@property (nonatomic, weak) id<BaseChildViewControllerDelegate> delegate;

@end
