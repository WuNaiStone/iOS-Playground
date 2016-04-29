//
//  ViewController.h
//  DemoContainerView
//
//  Created by Chris Hu on 16/4/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)displayContentController: (UIViewController*)content;

- (void)hideContentController: (UIViewController*)content;

@end

