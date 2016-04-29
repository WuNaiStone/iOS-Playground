//
//  ContainerViewController.h
//  DemoContainerView
//
//  Created by Chris Hu on 16/4/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"


@interface ContainerViewController : UIViewController

@property (nonatomic, weak) ViewController *parentVC;

@end

